# Auslesen API
API Definition zum Auslesen aller Anträge und Vorgänge.

**Hinweis:** Es handelt sich hierbei um eine noch recht frühe Version und es werden noch Veränderungen an der API vorgenommen, die nicht abwärtskompatibel sind. Dies bedeutet, dass gegen diese Version programmierte Clients später noch einmal angepasst werden müssen.

## Swagger Spezifikationen
Die API ist vollständig in Swagger definiert. Die Swagger Definitionen werden sowohl im JSON- als auch im YAML-Format zur Verfügung gestellt.

Aus diesen Dateien können mit Hilfe von [Swagger Codegen](https://github.com/swagger-api/swagger-codegen) Clients in verschiedenen Sprachen generiert werden.

**Hinweis:** Einige wichtige Basistypen, wie zum Beispiel `Euro`, sind in der Swagger Spezifikation bisher lediglich als `number` deklariert. Hier wird die Spezifikation in Zukunft noch erweitert, um die Basistypen noch besser zu dokumentieren.

## Hilfsdateien zum Festhalten eigener Mappings
Die Swagger Spezifikationen enthalten eine Vielzahl von in API verwendeten Definitionen. Sollen die Daten in einem eigenen System gespeichert werden, müssen die Definitionen und deren Felder auf die im eigenen System verwendeten Datentypen abgebildet werden. Um diese Abbildungen festzuhalten und gegebenenfalls einem IT-Dienstleister zu übergeben, stellen wir alle Definitionen auch in strukturierter Form als CSV und als XLS (Excel) Dateien zur Verfügung.
