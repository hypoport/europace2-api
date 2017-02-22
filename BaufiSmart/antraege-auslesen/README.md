# Anträge Auslesen API
API Definition zum Auslesen von Anträgen aus der Europace-Plattform aus Sicht eines Produktanbieters.

### Swagger Spezifikationen
Die API ist vollständig in Swagger definiert. Die Swagger Definitionen werden sowohl im JSON- als auch im YAML-Format zur Verfügung gestellt.

Aus diesen Dateien können mit Hilfe von [Swagger Codegen](https://github.com/swagger-api/swagger-codegen) Clients in verschiedenen Sprachen generiert werden.

### API Documentation

 - [RELEASE NOTES](RELEASE_NOTES.MD)
 - [statische HTML Seite](http://htmlpreview.github.io?https://raw.githubusercontent.com/hypoport/europace2-api/master/BaufiSmart/antraege-auslesen/Dokumentation/index.html)

Zur Unterstützung für das Mapping werden folgende Dateien bereit gestellt:
  - [CSV Datei](definitions.csv)
  - [Excel Datei](definitions.xls)

Beispielantworten:
- [Ein Antrag](beispiel-antrag.json)

### Generierung des Clients
#### JAVA mit Retrofit

1. Die aktuelle Swagger Version 2.2.1 downloaden
2. Client mit folgendem Kommando generieren:


```
java -jar swagger-codegen-cli-2.2.1.jar generate -i swagger.yaml -l java -c codegen-config-file.json -o europace-api-client
```

Example **codegen-config-file.json**:

```
{
  "artifactId": "europace-api-client",
  "groupId": "de.europace.api",
  "library": "retrofit2",
  "artifactVersion": "0.1",
  "dateLibrary": "java8"
}

```

### Authentifizierung

Die Authentifizierung läuft über den [OAuth2](https://oauth.net/2/) Flow vom Typ *ressource owner password credentials flow*.
https://tools.ietf.org/html/rfc6749#section-1.3.3


#### Credentials
Um die Credentials zu erhalten, erfagen Sie beim Helpdesk der Plattform die Zugangsdaten zur Auslesen API, bzw. bitten Ihren Auftraggeber dies zu tun.

#### Schritte 
1. Absenden eines POST Requests auf den [Login-Endpunkt](https://htmlpreview.github.io/?https://raw.githubusercontent.com/hypoport/europace2-api/master/BaufiSmart/antraege-auslesen/Dokumentation/index.html#_oauth2) /login mit Username und Password. Der Username entspricht der PartnerId und das Password ist der API-Key. Auf dem Testsystem können diese Werte frei gewählt werden. Alternativ kann ein Login auch über einen GET Aufruf mit HTTP Basic Auth auf den Login-Endpunkt erfolgen.
2. Aus der JSON-Antwort das JWToken (access_token) entnehmen
3. Bei weiteren Requests muss dieses JWToken als Authorization Header mitgeschickt werden.

#### Test mit Mock-Daten
Für die Entwicklung neuer Clients können Sie mit einer Mock-Implementierung arbeiten. Diese ist unter https://baufismart.api.europace.de/mock erreichbar. So kann eine Liste von Anträgen zum Beispiel unter https://baufismart.api.europace.de/mock/antraege abgerufen werden.

Passende Access-Token können über den oben beschriebenen Authentifizierungs-Prozess unter https://api.europace.de/mock/login abgerufen werden.