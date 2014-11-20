# ---*DRAFT*---


# PEX API
Über die PEX API können Daten zu bestehenden Partnern in EUROPACE 2 via HTTP abgerufen und modifiziert sowie neue Partner angelegt werden.

### Url

Die HTTP Schnittstelle der PEX-API ist unter der Url
```
https://www.europace2.de/partnermanagement/partner/
```
erreichbar.


### Authentifizierung

Für jeden Request ist eine Authentifizierung erforderlich. Die Authentifizierung erfolgt über HTTP Header.

Header Parameter | Beschreibung
-----------------|-------------
X-ApiKey         | ApiKey des Benutzers / der Organisation
X-PartnerId      | PartnerId des Benutzers

Schlägt die Authentifizierung fehl, erhält der Aufrufer eine HTTP Response mit Statuscode **401 UNAUTHORIZED**.


### TraceId zur Nachverfolgbarkeit von Requests

Für jeden Request sollte eine eindeutige id (TraceId) generiert werden, die den Request im EUROPACE 2 System nachverfolgbar macht und so bei etwaigen Problemen oder Fehlern die Analyse erleichtert.
Die Übermittlung der TraceId erfolgt über einen HTTP Header. Und wird als solcher auch in der Response zurückgeliefert.

Header Parameter | Beschreibung
-----------------|-------------
X-TraceId        | eindeutige Id für jeden Request

### Content-Type

Die Schnittstelle liefert Daten auschließlich mit Content-Type "application/json". Entsprechend muß im Request der Accept-Header gesetzt werden:

Header name | Header value
------------|-------------
Accept      | application/json


## JSON Repräsentation der Partner Stammdaten

Die PEX API stellt die Partner Stammdaten als JSON Dokument bereit. Für das Anlegen oder Modifizieren von Partnern wird ebenfalls dieses Format verwendet.

- Die Attributbezeichner sind case-sensitive.
- Gültige Werte für das Attribut "anrede" sind "HERR" und "FRAU".
- Gültige Werte für das Attribut "typ" sind "PERSON" und "ORGANISATION".
- "email" muß eine Email Adresse in gültigem Format enthalten.
- "geburtsdatum" muß im Format ISO-8601 extended(YYYY-MM-DD) vorliegen.
- Zeilenumbrüche in "fusszeileFuerAussenauftritt" können durch "\n" erreicht werden.
- Die Reihenfolge der Attribute spielt keine Rolle.
- Stammdaten werden ohne geerbte Werte ausgeliefert.

Als Partner können sowohl Personen als auch Organisationen angelegt werden. Dies wird über das Attribut "typ" beim Anlegen festgelegt. Der Default für "typ" ist "PERSON". **Der Typ eines Partners kann im nachhinein nicht mehr geändert werden.**

Die Datenhaushalte für Personen und Organisationen sind unterschiedlich.

### Datenhaushalt einer Person
```
{
  "id":"...",                 // EUROPACE 2 PartnerId
  "typ": "PERSON",            
  "anrede" : "HERR",          
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
  "externePartnerId" : "...",
  "faxnummer" : "...",
  "firmenname" : "...",
  "firmennameZusatz" : "...",
  "fusszeileFuerAussenauftritt" : "...", 		// mit \n  als Zeilentrenner
  "geburtsdatum" : "1970-01-01",      	  		// ISO-8601 Calender extended(YYYY-MM-DD) format.
  "gesperrt": false,            	      		// default: false 
  "gesperrtTransitiv": false,	          
  "mobilnummer" : "...",
  "nachname" : "...",
  "rechtDarfEinstellungenOeffnen" : false, 	// default false
  "rechtDarfPartnerAnlegen" : false, 			// default false
  "rechtEchtgeschaeftErlaubt" : true, 			// default false
  "titelFunktion" : "...",
  "telefonnummer" : "...",
  "vorname" : "...",
  "webseiteUrl" : "..."
}
```

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
  "externePartnerId" : "...",
  "faxnummer" : "...",
  "firmenname" : "...",
  "firmennameZusatz" : "...",
  "fusszeileFuerAussenauftritt" : "...", 		// mit \n  als Zeilentrenner
  "gesperrt": false,            	      		// default: false 
  "gesperrtTransitiv": false,	          
  "id":"...",                 					// EUROPACE 2 PartnerId
  "telefonnummer" : "...",
  "typ": "ORGANISATION",            
  "webseiteUrl" : "..."
}
```

## Abruf von Partner Stammdaten

Die Stammdaten eines Partners können mittels HTTP-GET Methode abgerufen werden. Sie werden als JSON Dokument zurückgeliefert.
Das Url-Template für den Abfruf lautet:
```
https://www.europace2.de/partnermanagement/partner/{PartnerId}
```

Ein erfolgreicher Aufruf resultiert in einer Response mit dem HTTP Statuscode **200 OK**. 

Der Body der Response enthält die aktuellen Stammdaten im JSON Format.
Attribute, die nicht gesetzt sind, sind in der Response nicht enthalten.


### Beispiel: HTTP GET Request und Response
```
REQUEST:
GET https://www.europace2.de/partnermanagement/partner/4712
X-ApiKey: xxxxxx
X-PartnerId: ABC987
X-TraceId: request-2014-10-01-07-59
Accept: application/json
Content-Type: application/json;charset=utf-8
```
```
RESPONSE:
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

## Anlegen eines neuen Partners

Partner können per HTTP POST angelegt werden.
Für das Anlegen eines neuen Partners erfolgt immer unterhalb eines bestehenden Partners. 
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
- "id" ist nicht änderbar und wird deshalb ignoriert.
- Rechte werden für Personen -sofern nicht angegeben- mit "false" belegt.

Ein erfolgreicher Aufruf resultiert in einer Response mit dem HTTP Statuscode **201 CREATED**.

Der Body der Response enthält die aktuellen Stammdaten im JSON Format. 
Dies kann zur Erfolgskontrolle genutzt werden. Attribute, die serverseitig gesetzt werden bzw. für die es Defaultwerte gibt, sind dabei immer enthalten. 

Im HTTP Header "Location" befindet sich die Url des neu angelegten Partners.


### Beispiel: HTTP POST Request und Response
```
REQUEST

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
```
RESPONSE

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

## Modifizieren eines Partners

Attribute eines Partners können mittels HTTP PATCH modifiziert werden.
Dabei werden **ausschließlich** diejenigen Attribute überschrieben, die im PATCH Request enthalten sind. Alle anderen Attribute werden nicht geändert.

Hintergrund: Der Datenhaushalt der API ist kleiner als der eines Partners. Auch der Datenhaushalt externer Client-Systeme ist i.d.R. geringer als die API. Damit über die Oberfläche "per Hand" eingetragene Werte nicht durch (fehlende) Attribute eines API Aufrufs verloren gehen, nutzen wir die PATCH Semantik.

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

Ein erfolgreicher Aufruf resultiert in einer Response mit dem HTTP Statuscode **200 OK**.

Der Body der Response enthält die aktuellen Stammdaten im JSON Format.
Dies kann zur Erfolgskontrolle genutzt werden. Attribute, die bereits gesetzt waren bzw. für die es Default Werte gibt, sind dabei immer enthalten.

### Beispiel: HTTP PATCH Request und Response
```
PATCH https://www.europace2.de/partnermanagement/partner/4712
X-ApiKey: xxxxxxx
X-ApiKey: ABC987
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


## Validierungen:

Folgende Attribute werden validiert:
- "typ" gültige Werte: "PERSON", "ORGANISATION"
- "anrede" gültige Werte: "HERR", "FRAU"
- "geburtsdatum" gültige Formate "YYYYMMDD", "YYYY-MM-DD" 

Schlägt eine dieser Validierungen fehl, erhält der Aufrufer eine HTTP Response mit Statuscode **400 BAD REQUEST**. Im Response Body befinden sich Details zur fehlgeschlagenen Validierung.

### Beispiel fehlgeschlagene Validierung
```
400 BAD REQUEST
X-TraceId : ff-request-2014-10-01-07-55
Content-Type: application/json

{
  "message" : "Enum literal für 'anrede' muss FRAU oder HERR sein.: Unbestimmt",
  "traceId" : " ff-request-2014-10-01-07-55"
}
```
