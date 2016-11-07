# Auslesen API
API Definition zum Auslesen aller Anträge und Vorgänge.

**Hinweis:** Es handelt sich hierbei um eine noch recht frühe Version und es werden noch Veränderungen an der API vorgenommen, die nicht abwärtskompatibel sein könnten. Dies bedeutet, dass gegen diese Version programmierte Clients später noch einmal angepasst werden müssten.

## Swagger Spezifikationen
Die API ist vollständig in Swagger definiert. Die Swagger Definitionen werden sowohl im JSON- als auch im YAML-Format zur Verfügung gestellt.

Aus diesen Dateien können mit Hilfe von [Swagger Codegen](https://github.com/swagger-api/swagger-codegen) Clients in verschiedenen Sprachen generiert werden.

**Hinweis:** Einige wichtige Basistypen, wie zum Beispiel `Euro`, sind in der Swagger Spezifikation bisher lediglich als `number` deklariert. Hier wird die Spezifikation in Zukunft noch erweitert, um die Basistypen noch besser zu dokumentieren.

## Hilfsdateien zum Festhalten eigener Mappings
Zur Unterstützung für das Mapping werden folgende Dateien bereit gestellt:
  - [statische HTML Seite](Dokumentation/index.html)
  - [CSV Datei](definitions.csv)
  - [Excel Datei](definitions.xls)
