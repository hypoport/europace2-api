
EUROPACE 2 - Authentiﬁzierung für Partner
=========================================

Dieses Dokument beschreibt die von Europace2 unterstützten Authentiﬁzierungsarten für 
Partner.


Einloggen
-----------------------------------------
Neben der Standard-Login-Seite, stellt Europace2 seinen Partner zwei weitere Wege 
bereit, sich an Europace2.de zu authentiﬁzieren.


### Einloggen per Html-Login-Box

Unter https://europace2.de/partnermanagement/partner-login-box.html steht eine minimale 
HTML Seite zur Verfügung, welche die Eingabefelder für Benutzer und Passwort sowie 
eine Login-Button enthält. Die Seite enthält zusätzliche Komfort-Funktionen für Benutzer:

* Setzen der Tastatureingabe auf das erste Feld
* Speichern des Benutzernamen

Diese Seite kann mittels iFrame direkt eingebettet werden:

````
<iframe src="https://europace2.de/partnermanagement/partner-login-box.html" 
width="366px" height="250px" style="margin: 0px 0px 0px 0px;"></iframe>
````

Alternativ dient diese Seite als ''Kopiervorlage'' zum direkten Einbetten in die
Partner-Webseite. Folgende Elemente sind zu Kopieren:

* CSS Stylesheet (Zeile 4-62)!
* Formular inkl. Javascript-Komfortfunktionen (Zeile 67-141)

Die Html Seite hat keinerlei externe Abhängigkeiten auf CSS oder Javascript Bibliotheken.!

[BILD]


### Einloggen per HTTP POST Request

Eine durch den Partners bereitgestelltes Login-Formular muss zur Authentiﬁzierung an 
Europace 2 folgenden Request absenden.

