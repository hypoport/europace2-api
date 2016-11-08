# Auslesen API
API Definition zum Auslesen aller Anträge und Vorgänge.

**Hinweis:** Es handelt sich hierbei um eine noch recht frühe Version und es werden noch Veränderungen an der API vorgenommen, die nicht abwärtskompatibel sein könnten. Dies bedeutet, dass gegen diese Version programmierte Clients später noch einmal angepasst werden müssten.

### Swagger Spezifikationen
Die API ist vollständig in Swagger definiert. Die Swagger Definitionen werden sowohl im JSON- als auch im YAML-Format zur Verfügung gestellt.

Aus diesen Dateien können mit Hilfe von [Swagger Codegen](https://github.com/swagger-api/swagger-codegen) Clients in verschiedenen Sprachen generiert werden.

**Hinweis:** Einige wichtige Basistypen, wie zum Beispiel `Euro`, sind in der Swagger Spezifikation bisher lediglich als `number` deklariert. Hier wird die Spezifikation in Zukunft noch erweitert, um die Basistypen noch besser zu dokumentieren.

### API Doc

Dokumentation der API via API-Doc:
 -  [API Doc v0.1](https://auslesen-api.api-docs.io/0.1/antraege/angebot-des-antrags-abrufen)

### Hilfsdateien zum Festhalten eigener Mappings
Zur Unterstützung für das Mapping werden folgende Dateien bereit gestellt:
  - [statische HTML Seite](http://htmlpreview.github.io?https://raw.githubusercontent.com/hypoport/europace2-api/master/BaufiSmart/auslesen/Dokumentation/index.html)
  - [CSV Datei](https://raw.githubusercontent.com/hypoport/europace2-api/master/BaufiSmart/auslesen/definitions.csv)
  - [Excel Datei](https://raw.githubusercontent.com/hypoport/europace2-api/master/BaufiSmart/auslesen/definitions.xls)
