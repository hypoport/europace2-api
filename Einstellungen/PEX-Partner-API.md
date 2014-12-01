# PEX Partner API

Das Partnermanagment von EUROPACE 2 dient Organisationen zur Abbildung der eigenen Struktur. Hierzu bietet die Weboberfläche des Partnermanagements umfassende Möglichkeiten. Die PEX Partner API erlaubt Fremdsystemen einen automatisierten Zugriff auf die Partner des Partnermanagement via HTTP.

Über die PEX Partner API ist es möglich
- neue Partner anzulegen,
- Daten zu Partnern abzurufen,
- Partner zu modifizieren.


## Inhalt
* [Datenformat der Partner Stammdaten](#datenformat-der-partner-stammdaten)
* [Die HTTP Schnittstelle](#die-http-schnittstelle)
* [Anlegen eines neuen Partners](#anlegen-eines-neuen-partners)
* [Abruf eines Partners](#abruf-eines-partners)
* [Modifizieren eines Partners](#modifizieren-eines-partners)
* [Berechtigungen](#berechtigungen)
* [Validierungen](#validierungen)
* [Hinweise](#hinweise)


## Datenformat der Partner Stammdaten

Die PEX API stellt die Partner Stammdaten als JSON Dokument bereit.

Die aus der Weboberfläche des Partnermanagments bekannte Vererbung von Werten bestimmter Attribute entlang der Hierarchie wird in der API nicht reflektiert. **Geerbte Werte werden also nicht ausgeliefert.**

Als Partner können sowohl Personen als auch Organisationen angelegt werden. Dies wird über das Attribut "typ" beim Anlegen festgelegt. Gültige Werte für das Attribut "typ" sind "PERSON" und "ORGANISATION". Der Default ist "PERSON". **Der Typ eines Partners kann im nachhinein nicht mehr geändert werden.**

Die Datenhaushalte für Personen und Organisationen sind unterschiedlich.

### Datenhaushalt einer Person
```
{
  "anrede" : "HERR",          	// alternativ: FRAU
  "anschrift" : {
    "strasse" : "...",
    "hausnummer" : "...",
    "plz" : "...",
    "ort" : "..."
  },
  "bankverbindung" : {
     "iban" : "...",
     "bic" : "....",
     "kontoinhaber": "...",
     "referenzFeld" : "...."
  },
  "email" : "...",  
  "externePartnerId" : "...", 		// Eine beliebige, extern erzeugte Id. Z.B. SAP oder CRM Nummer.
  "faxnummer" : "...",
  "firmenname" : "...",
  "firmennameZusatz" : "...",
  "fusszeileFuerAussenauftritt" : "...", 	  // mit \n  als Zeilentrenner
  "geburtsdatum" : "1970-01-01",      	  	  // ISO-8601 Calender extended(YYYY-MM-DD) format.
  "gesperrt": false,            	          // default: false 
  "gesperrtTransitiv": false,	          	  // true, wenn ein übergeordneter Partner gesperrt ist. (readonly)
  "id":"...",                 				  // EUROPACE 2 PartnerId (readonly)
  "mobilnummer" : "...",
  "nachname" : "...",
  "rechtDarfEinstellungenOeffnen" : false,   // default false
  "rechtDarfPartnerAnlegen" : false, 		  // default false
  "rechtEchtgeschaeftErlaubt" : true, 		  // default false
  "titelFunktion" : "...",
  "telefonnummer" : "...",
  "typ": "PERSON",            				  
  "vorname" : "...",
  "webseiteUrl" : "..."
}
```

Dabei gilt:
- Die Reihenfolge der Attribute spielt keine Rolle.
- Die Attributbezeichner sind case-sensitive.
- Gültige Werte für das Attribut "anrede" sind "HERR" und "FRAU".
- Zeilenumbrüche in "fusszeileFuerAussenauftritt" können durch '\n' erreicht werden.


### Datenhaushalt einer Organisation
```
{
  "anschrift" : {
    "strasse" : "...",
    "hausnummer" : "...",
    "plz" : "...",
    "ort" : "..."
  },
  "bankverbindung" : {
     "iban" : "...",
     "bic" : "....",
     "kontoinhaber": "...",
     "referenzFeld" : "...."
  },
  "email" : "...",  
  "externePartnerId" : "...", 		// Eine beliebige, extern erzeugte Id. Z.B. SAP oder CRM Nummer.
  "faxnummer" : "...",
  "firmenname" : "...",
  "firmennameZusatz" : "...",
  "fusszeileFuerAussenauftritt" : "...", 		// mit \n  als Zeilentrenner
  "gesperrt": false,            	      		// default: false 
  "gesperrtTransitiv": false,	          		// true, wenn ein übergeordneter Partner gesperrt ist. (readonly)
  "id":"...",                 					// EUROPACE 2 PartnerId (readonly)
  "telefonnummer" : "...",
  "typ": "ORGANISATION",            
  "webseiteUrl" : "..."
}
```
Dabei gilt:
- Die Reihenfolge der Attribute spielt keine Rolle.
- Die Attributbezeichner sind case-sensitive.
- Zeilenumbrüche in "fusszeileFuerAussenauftritt" können durch '\n' erreicht werden.



## Die HTTP Schnittstelle

Die HTTP Schnittstelle der PEX-API ist unter der Basis-Url
```
https://www.europace2.de/partnermanagement/partner/
```
erreichbar.


### Authentifizierung

Für jeden Request ist eine Authentifizierung erforderlich. Die Authentifizierung erfolgt über HTTP Header.

Request Header Name | Beschreibung
-----------------|-------------
X-ApiKey         | API Key des Benutzers / der Organisation
X-PartnerId      | Europace2 PartnerId des Aufrufers

Den API Key erhalten Sie von Ihrem Ansprechpartner bei EUROPACE 2. Die PartnerId finden Sie in den Einstellungen des jeweiligen Partners in der Weboberfläche des Partnermanagements.

Schlägt die Authentifizierung fehl, erhält der Aufrufer eine HTTP Response mit Statuscode **401 UNAUTHORIZED**.


### TraceId zur Nachverfolgbarkeit von Requests

Für jeden Request sollte eine eindeutige id (TraceId) generiert werden, die den Request im EUROPACE 2 System nachverfolgbar macht und so bei etwaigen Problemen oder Fehlern die systemübergreifende Analyse erleichtert.
Die Übermittlung der TraceId erfolgt über einen HTTP Header und wird als solcher auch in der Response zurückgeliefert. Wird keine TraceId übermittelt, enthält die Response eine in EUROPACE 2 automatisch erzeugte TraceId. 

Request / Response Header Name | Beschreibung
-----------------|-------------
X-TraceId        | eindeutige Id für jeden Request

### Content-Type

Die Schnittstelle liefert Daten auschließlich mit Content-Type "application/json". Entsprechend muß im Request der Accept-Header gesetzt werden:

Request Header Name | Header Value
------------|-------------
Accept      | application/json

## Anlegen eines neuen Partners

Partner können per HTTP POST angelegt werden.
Das Anlegen eines neuen Partners erfolgt immer unterhalb eines bestehenden Partners. 
Das Url-Template für das Anlegen eines neuen Partners unterhalb von {PartnerId} lautet:

```
https://www.europace2.de/partnermanagement/partner/{PartnerId}/untergeordnetePartner
```

Die Daten werden als JSON Dokument im Body des POST Requests übermittelt.

Bei der serverseitigen Auswertung gelten folgende Regeln:

- unbekannte Attribute werden ignoriert.
- Für Organisationen werden personenspezifische Attribute ignoriert.
- Für Personen werden organisationenspezifische Attribute ignoriert.
- Leere Attribute bei Strings ("") werden ignoriert.
- "gesperrtTransitiv" ist nicht von aussen änderbar und wird deshalb ignoriert
- "id" ist nicht setzbar und wird deshalb ignoriert.
- Rechte werden für Personen -sofern nicht angegeben- mit "false" belegt.

Ein erfolgreicher Aufruf resultiert in einer Response mit dem HTTP Statuscode **201 CREATED**.

Der Body der Response enthält die aktuellen Stammdaten im JSON Format. 
Dies kann zur Erfolgskontrolle genutzt werden. Attribute, die serverseitig gesetzt werden bzw. für die es Defaultwerte gibt, sind dabei immer enthalten. 

Im HTTP Header "Location" befindet sich die Url des neu angelegten Partners.


### POST Request Beispiel
```
POST https://www.europace2.de/partnermanagement/partner/4711/untergeordnetePartner
X-ApiKey: xxxxxxx
X-PartnerId: ABC987
X-TraceId: ff-request-2014-10-01-07-55
Accept: application/json
Content-Type: application/json;charset=utf-8

{
  "anrede" : "HERR",
  "email" : "max@mustermann.de",  
  "externePartnerId" : "MAK004712",
  "nachname" : "Mustermann",
  "vorname" : "Max"
}
```

### POST Response Beispiele
```
201 CREATED
Location: https://www.europace2.de/partnermanagement/partner/4712
X-TraceId : ff-request-2014-10-01-07-55
Content-Type: application/json;charset=utf-8

{
  "_links" : {
    "self" : "https://www.europace2.de/partnermanagement/partner/4712"
  }
  "id" : "4712"
  "typ": "PERSON",
  "anrede" : "HERR",
  "email" : "max@mustermann.de",  
  "externePartnerId" : "MAK004712",
  "gesperrt": false,
  "gesperrtTransitiv": false,
  "nachname" : "Mustermann",
  "rechtDarfEinstellungenOeffnen" : false,
  "rechtDarfPartnerAnlegen" : false,
  "rechtEchtgeschaeftErlaubt" : false,
  "vorname" : "Max"
}
```


## Abruf eines Partners

Die Stammdaten eines Partners können mittels HTTP-GET Methode abgerufen werden. Sie werden als JSON Dokument zurückgeliefert.
Das Url-Template für den Abfruf lautet:

```
https://www.europace2.de/partnermanagement/partner/{PartnerId}
```

Ein erfolgreicher Aufruf resultiert in einer Response mit dem HTTP Statuscode **200 OK**. 

Der Body der Response enthält die aktuellen Stammdaten im JSON Format.
Attribute, die nicht gesetzt sind, sind in der Response nicht enthalten.


### GET Request Beispiel:
```
GET https://www.europace2.de/partnermanagement/partner/4712
X-ApiKey: xxxxxx
X-PartnerId: ABC987
X-TraceId: request-2014-10-01-07-59
Accept: application/json
```

### GET Response Beispiel:
```
200 OK
X-TraceId: request-2014-10-01-07-59
Content-Type: application/json;charset=utf-8

{
  "_links" : {
    "self" : "https://www.europace2.de/partnermanagement/partner/4712"
  },
  "id":"4712",
  "anrede" : "HERR",
  "externePartnerId" : "123456",
  "geburtsdatum" : "1970-01-01",
  "gesperrt": false,
  "gesperrtTransitiv": false,
  "nachname" : "Mustermann",
  "rechtDarfEinstellungenOeffnen" : true,
  "rechtDarfPartnerAnlegen" : false,
  "rechtEchtgeschaeftErlaubt" : true,
  "vorname" : "Max",
  "telefonnummer" : "030 123456",
  "webseiteUrl" : "https://github.com/hypoport/europace2-api"
}
```


## Modifizieren eines Partners

Attribute eines Partners können mittels HTTP PATCH modifiziert werden.
Dabei werden **ausschließlich** diejenigen Attribute überschrieben, die im PATCH Request enthalten sind. Alle anderen Attribute werden nicht geändert.

Hintergrund: Der Datenhaushalt der API ist kleiner als der eines Partners im EUROPACE 2 Partnermanagement. Zudem ist der Datenhaushalt externer Systeme i.d.R. kleiner als der der API. Damit Werte, die über die Weboberfläche "per Hand" eingetragene wurden, nicht durch (fehlende) Attribute eines API Aufrufs verloren gehen, wird die PATCH Semantik angewandt.

Das Url-Template ist dasselbe wie für den Abruf eines Partners:

```
https://www.europace2.de/partnermanagement/partner/{PartnerId}
```

Die Daten werden als JSON Dokument im Body des PATCH Requests übermittelt.

Bei der serverseitigen Auswertung gelten folgende Regeln:

- **leere Attribute bei Strings ("") löschen den bestehenden Wert.**
- unbekannte Attribute werden ignoriert.
- "gesperrtTransitiv" ist nicht von aussen änderbar werden und wird deshalb ignoriert
- "id" ist nicht änderbar und wird deshalb ignoriert.
- "typ" ist nicht änderbar und wird deshalb ignoriert.

Ein erfolgreicher Aufruf resultiert in einer Response mit dem HTTP Statuscode **200 OK**.

Der Body der Response enthält die aktuellen Stammdaten im JSON Format.
Dies kann zur Erfolgskontrolle genutzt werden. Attribute, die bereits gesetzt waren bzw. für die es Default Werte gibt, sind dabei immer enthalten.

### Beispiel: HTTP PATCH Request und Response
```
PATCH https://www.europace2.de/partnermanagement/partner/4712
X-ApiKey: xxxxxxx
X-PartnerId: ABC987
X-TraceId: ff-request-2014-10-01-07-56
Accept: application/json
Content-Type: application/json;charset=utf-8

{
  "firmenname":"Mustermann AG"
}
```

```
200 OK
X-TraceId: ff-request-2014-10-01-07-56
Content-Type: application/json;charset=utf-8

{
  "_links" : {
    "self" : "https://www.europace2.de/partnermanagement/partner/4712"
  }
  "anrede" : "HERR",
  "email" : "max@mustermann.de",  
  "externePartnerId" : "MAK004712",
  "firmenname":"Mustermann AG",
  "gesperrt": false,
  "id" : "4712",
  "nachname" : "Mustermann",
  "gesperrtTransitiv": false,
  "rechtDarfEinstellungenOeffnen" : false,
  "rechtDarfPartnerAnlegen" : false,
  "rechtEchtgeschaeftErlaubt" : false,
  "typ" : "ORGANISATION",
  "vorname" : "Max" 
}
```

## Berechtigungen

- für den Zugriff auf einen Partner benötigt der Aufrufer grundsätzlich die Berechtigung, diesen zu sehen. Ist sie nicht vorhanden, erhält der Aufrufer eine HTTP Response mit Statuscode **404 NOT FOUND**.
- für Änderungen an einem Partner benötigt der Aufrufer Einstellungsrechte auf diesen. Sind sie nicht vorhanden, erhält der Aufrufer eine HTTP Response mit Statuscode **403 FORBIDDEN**.
- für das Anlegen neuer Partner benötigt der Aufrufer das Recht "Darf Organisationseinheiten anlegen" sowie Einstellungsrechte auf denjenigen Partner, unterhalb dessen der neue Partner angelegt werden soll. Sind diese nicht vorhanden, erhält der Aufrufer eine HTTP Response mit Statuscode **403 FORBIDDEN**.
- Rechte können nur vergeben bzw. geändert werden, wenn der Aufrufer sie selbst besitzt. Ist dies nicht gegeben, erhält der Aufrufer eine HTTP Response mit Statuscode **403 FORBIDDEN**. 


## Validierungen

Folgende Attribute werden validiert:

- "typ" gültige Werte: "PERSON", "ORGANISATION"
- "anrede" gültige Werte: "HERR", "FRAU"
- "geburtsdatum" gültiges Format ISO8601 extended: "YYYY-MM-DD" 


Schlägt eine dieser Validierungen fehl, erhält der Aufrufer eine HTTP Response mit Statuscode **400 BAD REQUEST**. Im Response Body befinden sich Details zur fehlgeschlagenen Validierung.

### Beispiel: fehlgeschlagene Validierung
```
PATCH https://www.europace2.de/partnermanagement/partner/4712
X-ApiKey: xxxxxxx
X-PartnerId: ABC987
X-TraceId: ff-request-2014-10-01-07-55
Accept: application/json
Content-Type: application/json;charset=utf-8

{
  "anrede":"abc"
}
```

```
400 BAD REQUEST
X-TraceId : ff-request-2014-10-01-07-55
Content-Type: application/json

{
  "message" : "Enum literal für 'anrede' muss FRAU oder HERR sein.: abc",
  "traceId" : " ff-request-2014-10-01-07-55"
}
```

## Hinweise

### Anforderungen an die Vollständigkeit für BaufiSmart

Für eine erfolgreiche Angebotsannahme in BaufiSmart ist es für die nachfolgenden Prozesse erforderlich, daß für den Kundenbetreuer des Vorgangs die folgenden Attribute im Partnermanagement gepflegt sind:

- anrede
- vorname
- nachname
- anschrift
- bankverbindung
- email

Eine Angebotsannahme ist andernfalls nicht möglich.

