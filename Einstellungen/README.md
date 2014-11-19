DRAFT

# PEX API
Über die PEX API können Daten zu bestehenden Partnern in EUROPACE 2 via HTTP abgerufen, neue Partner angelegt und bestehende modifiziert werden.

### Basis-Url

Die HTTP Schnittstelle der PEX-API ist unter der Basis-URL
```
https://www.europace2.de/partnermanagement/partner/
```
erreichbar.


### Authentifizierung

Für jeden Request ist eine Authentifizierung erforderlich. Die Authentifizierung erfolgt über HTTP Header.

Header Parameter | Beschreibung
-----------------|-------------
X-ApiKey         | API des Benutzers / der Organisationen
X-PartnerId      | PartnerId des Benutzers

### TraceId und Nachvollziehbarkeit von Requests

Für jeden Request sollte eine eindeutige id (TraceId) generiert werden, die den Request im EUROPACE 2 System nachverfolgbar macht und so bei etwaigen Problemen oder Fehlern die Analyse erleichtert.
Die Übermittlung der TraceId erfolgt über einen HTTP Header.

Header Parameter | Beschreibung
-----------------|-------------
X-TraceId        | Für jeden Request eindeutige Id


### JSON Repräsentation der Partner Stammdaten

Die PEX API stellt die Partner Stammdaten als JSON Dokument bereit. Für das Anlegen oder Modifizieren von Partnern wird ebenfalls dieses Format verwendet.


```
{
  "id":"...",           // EUROPACE 2 PartnerId
  "anrede" : "HERR",          // alternativ "FRAU"
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
  "fusszeileFuerAussenauftritt" : "...", //  mit \n  als Zeilentrenner, siehe Kommentar
  "geburtsdatum" : "1970-01-01",      // ISO-8601 Calender Date basic(YYYYMMDD) oder extended(YYYY-MM-DD) format.
  "gesperrt", false,            // default: false
  "gesperrtTransitiv", false
  "mobilnummer" : "...",
  "nachname" : "...",
  "rechtDarfEinstellungenOeffnen" : false, // default false
  "rechtDarfOrgaEinheitenAnlegen" : false, // default false
  "rechtEchtgeschaeftErlaubt" : true, // default false
  "titelFunktion" : "...",
  "telefonnummer" : "...",
  "vorname" : "...",
  "webseiteUrl" : "..."
}
```


## Abruf von Partner Stammdaten

Die Stammdaten eines Partners können mittels der HTTP-GET Methode abgerufen werden. Sie werden als JSON Dokument zurückgeliefert.
Für den Abruf eines Partners wird die Basis Url um dessen PartnerId erweitert.
```
https://www.europace2.de/partnermanagement/partner/{PartnerId}
```

Felder die nicht gesetzt sind, sind in der Response nicht enthalten.


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
"fusszeileFuerAussenauftritt" : "...",
"geburtsdatum" : "1970-01-01",
"gesperrt", false,
"gesperrtTransitiv", false
"mobilnummer" : "...",
"nachname" : "...",
"rechtDarfEinstellungenOeffnen" : false,
"rechtDarfOrgaEinheitenAnlegen" : false,
"rechtEchtgeschaeftErlaubt" : true,
"titelFunktion" : "...",
"telefonnummer" : "...",
"vorname" : "...",
"webseiteUrl" : "..."
}
```

## Anlegen eines neuen Partners

Partner können per HTTP POST angelegt werden.
Für das Anlegen eines neuen Partners erfolgt immer unterhalb eines bestehenden Partners. Die PartnerId des bestehenden Partners wird deshalb in der Url des Requests angegeben:
```
https://www.europace2.de/partnermanagement/partner/{PartnerId}/untergeordnetePartner
```
Die Daten werden als JSON Dokument im Body des POST Requests übermittelt.

Bei der serverseitigen Auswertung gelten folgende Regeln:
- unbekannte Felder werden ignoriert.
- leere Felder bei Strings ("") werden wie nicht vorhanden (null) behandelt.
- "gesperrtTransitiv" ist nicht von aussen änderbar werden und wird deshalb ignoriert
- "id" ist nicht änderbar und wird deshalb ignoriert.
- Rechte werden sofern nicht angegeben mit dem Default "false" belegt.

In der Response wird der aktuelle Stand der Daten zurückgegeben. Felder die serverseitig gesetzt werden bzw. für die es Default Werte gibt, sind dabei also immer enthalten.


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
  "gesperrt", false, // default: false
  "nachname" : "Mustermann",
  "vorname" : "Max"
}
```
```
RESPONSE

201 CREATED
Location: https://www.europace2.de/partnermanagement/partner/4712
X-TraceId : ff-request-2014-10-01-07-55

{
  "_links" : {
    "self" : "https://www.europace2.de/partnermanagement/partner/4712"
  }
  "id" : "4712"
  "anrede" : "HERR",
  "email" : "max@mustermann.de",  
  "externePartnerId" : "MAK004712",
  "gesperrt", false,
  "nachname" : "Mustermann",
  "vorname" : "Max",
  "gesperrtTransitiv", false,
  "rechtDarfEinstellungenOeffnen" : false,
  "rechtDarfOrgaEinheitenAnlegen" : false,
  "rechtEchtgeschaeftErlaubt" : false
}
```

## Modifizieren eines Partners

Felder eines Partners können mittels HTTP PATCH modifiziert werden.
Dabei werden **ausschließlich** diejenigen Felder überschrieben, die im PATCH Request enthalten sind. Alle anderen Felder werden nicht geändert.

Hintergrund: Der Datenhaushalt der API ist kleiner als der eines Partners. Auch der Datenhaushalt externer Client-Systeme ist i.d.R. geringer als die API. Damit über die Oberfläche "per Hand" eingetragene Werte nicht durch (fehlende) Attribute eines API Aufrufs verloren gehen, nutzen wir die PATCH Semantik.

Die PartnerId des Partners wird in der Url des Requests angegeben:
```
https://www.europace2.de/partnermanagement/partner/{PartnerId}
```
Die Daten werden als JSON Dokument im Body des PATCH Requests übermittelt.

Bei der serverseitigen Auswertung gelten folgende Regeln:
- unbekannte Felder werden ignoriert.
- leere Felder bei Strings ("") löschen den bestehenden Wert.
- "gesperrtTransitiv" ist nicht von aussen änderbar werden und wird deshalb ignoriert
- "id" ist nicht änderbar und wird deshalb ignoriert.

In der Response wird der die gesamte Repräsentation der aktuellen Daten zurückgegeben. Felder, die bereits gesetzt waren bzw. für die es Default Werte gibt, sind dabei also immer enthalten.

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
{
  "_links" : {
    "self" : "https://www.europace2.de/partnermanagement/partner/4712"
  }
  "id" : "4712"
  "anrede" : "HERR",
  "email" : "max@mustermann.de",  
  "externePartnerId" : "MAK004712",
  "gesperrt", false,
  "nachname" : "Mustermann",
  "vorname" : "Max",
  "firmenname":"Mustermann AG"
  "gesperrtTransitiv", false,
  "rechtDarfEinstellungenOeffnen" : false,
  "rechtDarfOrgaEinheitenAnlegen" : false,
  "rechtEchtgeschaeftErlaubt" : false
}

```

### Validierungen:

- für Änderungen an einem Partner muß der Inhaber des Api Key Einstellungsrechte auf diesen besitzen.
- für das Anlegen neuer Partner benötigt der Inhaber des X-ApiKeys das Recht "Darf Organisationseinheiten anlegen" sowie Einstellungsrechte auf denjenigen Partner, unterhalb dessen der neue Partner angelegt werden soll.
- Rechte können nur vergeben oder geändert werden, wenn der Inhaber des Api Keys sie selbst besitzt.



```
400 BAD REQUEST
X-TraceId : ff-request-2014-10-01-07-55
Content-Type: application/json

{
  "message" : "Enum literal für 'anrede' muss FRAU oder HERR sein.: Unbestimmt",
  "traceId" : " ff-request-2014-10-01-07-55"
}
```

```
401 UNAUTHORIZED
```

```
TODO weitere status codes aus Validierungen dokumentieren
```

## Vererbung

Partner Daten werden ohne geerbte Werte ausgeliefert.

## Benutzer Ent- Sperren

Erfolgt über das Attribut "gesperrt" im POST / PATCH Requests.
