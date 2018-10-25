# Europace2 Reporting


Folgende Reports können bezogen werden: Vorgänge, Teilanträge, Bausteine, Provisionen

# Dokumentation

## Report: Vorgänge, Teilanträge, Bausteine, Provisionen


Das grundsätzliche Prinzip basiert darauf, dass Sie bei Aufruf der URL alle Reports als ZIP-Datei erhalten.
```
https://www.europace2.de/infrastruktur/reporting/${PARTNER_ID}/report.zip
```

Mit dem Parameter 'PartnerId' legen sie fest, für wen die Reports erstellt werden sollen.
Für den Abruf müssen sie bereits angemeldet sein. Beim Abruf selbst wird dann sichergestellt,
dass Sie die Berechtigung zum Zugriff auf die Daten besitzen.


## Report: Partner


Die URL zum Abruf des Partner-Reports lautet:
```
https://www.europace2.de/infrastruktur/reporting/${PARTNER_ID}/partner.csv
```

Mit dem Parameter 'PartnerId' legen sie fest, für wen die Reports erstellt werden sollen.
Für den Abruf müssen sie bereits angemeldet sein. Beim Abruf selbst wird dann sichergestellt,
dass Sie die Berechtigung zum Zugriff auf die Daten besitzen.
Es werden alle Daten für den abgerufenen Partner incl. der Untereinheiten bereitgestellt.

## Automatischer Abruf


Sie können mit nur einem Aufrauf sich anmelden und die Reports abrufen.
Die dafür notwendigen Schritte sind in [Partnermanagement-API](../Partnermanagement/PEX-Benutzername-Passwort-API.md)
beschrieben.
Lesen Sie dort den Abschnitt „Einloggen per HTTP POST Request“
in Kombination mit dem „oeffne“-Parameter.
