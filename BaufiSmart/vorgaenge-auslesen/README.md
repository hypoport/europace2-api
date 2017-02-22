# Vorgänge Auslesen API
API Definition zum Auslesen von Vorgängen aus der Europace-Plattform aus Sicht eines Vertriebes.

**Hinweis:** Es handelt sich hierbei um eine noch recht frühe Version und es werden noch Veränderungen an der API vorgenommen, die nicht abwärtskompatibel sein könnten. Dies bedeutet, dass gegen diese Version programmierte Clients später noch einmal angepasst werden müssten.

**Hinweis:** Bisher sind nur Mock-Daten über die Vorgänge Auslesen API abrufbar.

### Swagger Spezifikationen
Die API ist vollständig in Swagger definiert. Die Swagger Definitionen werden sowohl im JSON- als auch im YAML-Format zur Verfügung gestellt.

Aus diesen Dateien können mit Hilfe von [Swagger Codegen](https://github.com/swagger-api/swagger-codegen) Clients in verschiedenen Sprachen generiert werden.

### Generierung des Clients
#### JAVA mit Retrofit

1. Die aktuelle Swagger Version 2.2.1 downloaden
2. Client mit folgendem Kommando generieren:


```
java -jar swagger-codegen-cli-2.2.1.jar generate -i swagger.yaml -l java -c codegen-config-file.json -o europace-api-client
```

Example **codegen-config-file.json** für Version 0.1:

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
1. Absenden eines POST Requests auf den Login-Endpunkt (https://api.europace.de/mock/login) mit Username und Password. Der Username entspricht der PartnerId und das Password ist der API-Key. Auf dem Testsystem können diese Werte frei gewählt werden. Alternativ kann ein Login auch über einen GET Aufruf mit HTTP Basic Auth auf den Login-Endpunkt erfolgen.
2. Aus der JSON-Antwort das JWToken (access_token) entnehmen
3. Bei weiteren Requests muss dieses JWToken als Authorization Header mitgeschickt werden.

#### Test mit Mock-Daten
Für die Entwicklung neuer Clients können Sie mit einer Mock-Implementierung arbeiten. Diese ist unter https://baufismart.api.europace.de/mock erreichbar. So kann ein Vorgang mit Mock-Daten zum Beispiel unter https://baufismart.api.europace.de/mock/vorgaenge/AB1234 abgerufen werden.

Passende Access-Token können über den oben beschriebenen Authentifizierungs-Prozess unter https://api.europace.de/mock/login abgerufen werden.