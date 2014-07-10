
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

* CSS Stylesheet (Zeile 4-62) 
* Formular inkl. Javascript-Komfortfunktionen (Zeile 67-141)

Die Html Seite hat keinerlei externe Abhängigkeiten auf CSS oder Javascript Bibliotheken. 

![Eingebettete Login-Box von EUROPACE2](partner_login_box.png?raw=true)


### Einloggen per HTTP POST Request

Eine durch den Partners bereitgestelltes Login-Formular muss zur Authentiﬁzierung an 
Europace 2 folgenden Request absenden.

Request

````
POST https://www.europace2.de/partnermanagement/login.do?redirectTo=%2FvorgangsManagementFrontend
---
Header:
Content-type: application/x-www-form-urlencoded;charset=UTF-8
---
Body (Form Data URL encoded):
username=Mustermann@beispiel.de&password=4711

````

Der URL Parameter ''redirectTo'' ist optional. Dieser kann benutzt werden,
um die Zieladresse nach erfolgreichem Login festzulegen.

Response (korrekte Anmeldedaten):

````
HTTP/1.1 200 OK
Content-Type: text/plain
Set-Cookie: sessionId=3f8a86fa02128b5265de9f1ec4b3c4be; Path=/
````

Response (fehlerhafte Anmeldedaten):

````
HTTP/1.1 401 Unauthorized
````


Eine manuelle Überprüfung ist z.B. mittels des Kommandozeilen-Programmes "curl" möglich:

````
curl -v --insecure --header "Content-type: application/x-www-form-urlencoded;charset=UTF-8" --data "username=Mustermann@beispiel.de&password=4711" https://www.europace2.de/partnermanagement/login.do
````

### Ausloggen

Der Logout kann ebenenfalls über einen HTTP POST Request erfolgen. 
Dabei muss der nach der Authentifizierung gelieferte Cookie  
"sessionId" übertragen werden.  

Request

````
POST https://www.europace2.de/partnermanagement/logout 

Header:
Cookie: sessionId=EineLangeSessionId
````

Response

````
HTTP/1.1 302 Found
````

Manuelle Überprüfung mittels "curl":

````
curl -v --insecure -X POST --cookie "sessionId=3f8a86fa02128b5265de9f1ec4b3c4be" https://www.europace2.de/partnermanagement/logout
````