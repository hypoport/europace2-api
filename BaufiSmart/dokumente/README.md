BEX-DOC-API
===========

Die BaufiSmart Externe Dokumenten API.

Vorgangsdokument hinzufügen (Multipart Form Upload):
----------------------------------------------------

Diese Schnittstelle ermöglicht es, Dokumente einem Baufi Smart Vorgang hinzuzufügen. 

Ein hochgeladenes Dokument besteht aus binär Daten (z.B. einem PDF oder Bild) und dessen Metadaten. Die Schnittstelle ist streaming fähig. Hochgeladene Dokumente erscheinen wie alle anderen Dokumente in der Dokumenten-Lasche innerhalb eines Baufi Smart Vorgang.

Folgende Request Parameter stehen zur Verfügung:

Request Parameter | Beschreibung
-----|-------------
filename | Dateiname nach Download.
anzeigename | Name zur Anzeige auf der Oberfläche.
teilAntragNummer | Das Dokument wird dem Kreditentscheidungsteilvorgang des Teilantrag zugeordnet.
sichtbarFuerVertrieb | Wenn "true", dann wird das Dokument (auch) dem Beratungsteilvorgang zugeordnet.
vorgangsNummer | Das Dokument wird diesem Vorgang zugeordnet, wenn keine teilantragnummer gegeben.
erstellungsdatum | Datum an welchem das Dokument erstellt wurde.

Die Authentifizierung erfolgt über HTTP Header. Der Benutzer muss Zugriff auf den Vorgang bzw. TeilAntrag haben um Dokumente hinzufügen zu können.

Header Parameter | Beschreibung
-----------------|-------------
X-ApiKey         | API des Benutzers / der Organisationen
X-PartnerId      | PartnerId des Benutzers

Nachfolgendes Beispiel zeigt einen Auschnitt des HTTP Request, welcher die Datei Antrag.pdf in die EUROPACE 2 Plattform importiert und dem Vorgang 123456 zuordnet. Als Antwort wird im Location Header die URI auf das Dokument geliefert.


```
POST https://www.europace2.de/vorgang/dokumente
Content-Type: multipart/form-data
X-ApiKey: 34jklj34h56l
X-PartnerId: 324h6lj21
 
Content-Type: multipart/form-data; boundary=----------------------------b15d48e6d7db

------------------------------b15d48e6d7db
Content-Disposition: form-data; name="sichtbarFuerVertrieb"

true
------------------------------b15d48e6d7db
Content-Disposition: form-data; name="vorgangsNummer"

123456
------------------------------b15d48e6d7db
Content-Disposition: form-data; name="filename"

Antrag.pdf
------------------------------b15d48e6d7db
Content-Disposition: form-data; name="file"; filename="Antrag.pdf"
Content-Type: application/octet-stream

... content hidden for brevity ...


------------------------------b15d48e6d7db-- 

```


```
201 CREATED
Location: https://www.europace2.de/dokumentenverwaltung/v97w3945w045ct3576c4w09rczg4twc0r8563458utmwv49vw8e4p57bz45wiovu6e98457c
```


Ein Beispiel-Request kann mit curl erzeugt werden. Bitte alle grossgeschriebenen Platzhalter ersetzen.

```
curl -v -H "X-PartnerId: PARTNER_ID" -H "X-ApiKey: API_KEY"   -F "vorgangsNummer=V_NR" -F "filename=DATEI_NAME"  -F "file=@DATEI_NAME" -F "sichtbarFuerVertrieb=true" https://www.europace2.de/vorgang/dokumente
```

