Abruf der Europace2 Reports
---------------------------

Das grundsätzliche Prinzip basiert darauf, dass Sie bei Aufruf der URL
https://www.europace2.de/infrastruktur/reporting/${PARTNER_ID}/report.zip
alle Reports als ZIP-Datei erhalten. 

Notwendig dafür ist Ihre PartnerId und eine gültige Anmeldung
(Login-Session). Wie Sie sich programmatisch anmelden, können Sie in
der Dokumentation der Partnermanagement-API
https://github.com/hypoport/europace2-api/blob/master/Partnermanagement/PEX-Benutzername-Passwort-API.md
nachlesen. Lesen Sie dort den Abschnitt „Einloggen per HTTP POST
Request“ in Kombination mit dem „oeffne“-Parameter.