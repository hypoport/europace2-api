DRAFT

## Anlegen eines neuen Partners

Partner können per HTTP JSON angelegt werden. 

Für alle Requests gilt: 

- Leere Felder bei String ("") sind blank und werden wie null behandelt.
- Dem Server unbekannte Felder werden ignoriert
- Es wird ein (Partner-) Historieneintrag geschrieben im Namen des ApiKeys

Validierungen:

- PartnerId in URL muss durch X-ApiKey administrierbar sein.
- externePartnerId muss "unterhalb" des ApiKey unique sein.
- Validierung der Eindeutigkeit der externenPartnerId beim Create / POST => Fehler Status + Link auf die bestehende resource + Fehlertext
- Rechte dürfen nur vergeben werden, wenn sie beim Vergebenden vorhanden sind (wenn sie am ApiKey vorhanden sind)


```
POST https://www.europace2.de/partnermanagement/partner/4711/untergeordnetePartner
X-ApiKey: ABC987
X-PartnerId: 4710                              // FF Organisation
X-TraceId: ff-request-2014-10-01-07-55 // UID zur Identifikation des requests für support 
Accept: application/json
Content-Type: application/json;charset=utf-8

{
  "anrede" : "HERR",                 // alternativ "FRAU"
  "anschrift" : {
    "strasse" : "...",
    "hausnummer" : "71a",
    "plz" : "...",
    "ort" : "..."
  },
  "avatarUrl" : "...", // e.g. dataUrl oder http://www.gravatar.com/avatar/58032b5606013973d9364775a9c8bc66
  "bankverbindung" : {
     "iban" : "...",
     "bic" : "....",
     "kontoinhaber": "...",
     "referenzFeld" : "...." 
  },
  "email" : "",  
  "externePartnerId" : "MAK004712"
  "faxnummer" : "",
  "firmenname" : null,
  "firmennameZusatz" : "",
  "fusszeileFuerAussenauftritt" : "" //  mit \n  als Zeilentrenner, siehe Kommentar
  "geburtsdatum" : "1970-04-23",  // ISO-8601 Calender Date basic(YYYYMMDD) oder extended(YYYY-MM-DD) format.
  "gesperrt", "false", // default: false
  "mobilnummer" : "",
  "nachname" : "Fiore",
  "newsletterErhalten" : true,
  "rechtDarfEinstellungenOeffnen" : false, // default false
  "rechtDarfOrgaEinheitenAnlegen" : false, // default false
  "rechtEchtgeschaeftErlaubt" : true, // default false
  "titelFunktion" : "Makler",
  "telefonnummer" : "",
  "vorname" : "Marcel",
  "webseiteUrl" : "",
  "zugangWebLogin" : "false",
}
```

```
201 CREATED
Location: https://www.europace2.de/partnermanagement/partner/4712
X-TraceId : ff-request-2014-10-01-07-55

{
  "_links" : {
    "self" : "https://www.europace2.de/partnermanagement/partner/4712"
  }
  "id" : "4712"
}
```

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

## Aktualisieren eines Partners

Logik: Nur die im PATCH request enthaltenen Felder werden in den Stammdaten des Partner überschrieben. Alle weiteren Felder der Stammdaten bleiben erhalten. 

Hintergrund: Der Datenhaushalt der API ist kleiner als der eines Partners. Auch der Datenhaushalt externe Client-Systeme ist i.d.R. geringer als die API. Damit über die Oberfläche "per Hand" eingetragene Werte nicht durch (fehlende) Attribute eines API Aufrufs verloren gehen, nutzen wir die PATCH Semantik.

```
PATCH https://www.europace2.de/partnermanagement/partner/4712
X-ApiKey: ABC987
X-TraceId: ff-request-2014-10-01-07-56
Accept: application/json
Content-Type: application/json;charset=utf-8

... gleiche Felder wie beim POST request möglich ...
```

```
203 NO_CONTENT
X-TraceId: ff-request-2014-10-01-07-56
```

```
400 BAD REQUEST
X-TraceId: ff-request-2014-10-01-07-56
```

## Abruf von Partner Stammdaten


```
GET https://www.europace2.de/partnermanagement/partner/4712
X-ApiKey: ABC987
X-TraceId: ff-request-2014-10-01-07-59
Accept: application/json
Content-Type: application/json;charset=utf-8

200 OK
X-TraceId: ff-request-2014-10-01-07-59
Content-Type: application/json;charset=utf-8

{
  "_links" : {
    "self" : "https://www.europace2.de/partnermanagement/partner/4712"
  },
  "angelegtAm": "... Date .. ",
  "gesperrtTransitiv" : false,
  "id" : "4712",
  "zuletztGeaendertAm": "... Date ....",

  ... gleiche Felder wie beim POST request ...

}
```

### Struktur

Wird über link "up" und "down" navigierbar, wenn es notwendig ist.

### Vererbung

Partnerdaten werden ohne vererbte Werte ausgeliefert. Bei Bedarf sind die Werte mit Vererbung über link erreichbar.


## Benutzer Ent- Sperren

Erfolgt über das Attribut "gesperrt" im POST / PATCH Requests.



