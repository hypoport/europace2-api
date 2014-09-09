BEX-DOC-API
===========

Die BaufiSmart Externe Dokumenten API.

Vorgangsdokument hinzufügen (Multipart Form Upload):
----------------------------------------------------

Diese Schnittstelle ermöglicht es, Dokumente einem Baufi Smart Vorgang hinzuzufügen. 

Ein hochgeladenes Dokument besteht aus binär Daten (z.B. einem PDF oder Bild) und dessen Metadaten. Die Schnittstelle ist streaming fähig. Hochgeladene Dokumente erscheinen wie alle anderen Dokumente in der Dokumenten-Lasche innerhalb eines Baufi Smart Vorgang.

Nachfolgendes Beispiel zeigt einen HTTP Request, welcher ein PDF in die EUROPACE 2 Plattform importiert und dem Vorgang 123456 zuordnet. Als Antwort wird im Location Header die URI auf das Dokument geliefert.


```
POST https://www.europace2.de/vorgang/dokumente
Content-Type: multipart/form-data
X-ApiKey: 34jklj34h56l
X-PartnerId: 324h6lj21
 
Content-Disposition: form-data; name="file"; filename="Antrag.pdf" Content-Type: application/pdf
Content-Disposition: form-data; name="anzeigename" Antrag vom 25.06.2013
Content-Disposition: form-data; name="erstellungsdatum" 2013-06-25T16:22:52.966Z
Content-Disposition: form-data; name="vorgangsNummer" 772138
Content-Disposition: form-data; name="sichtbarFuerVertrieb" true

... multipart binary ...

```


```
201 CREATED
Location: https://www.europace2.de/dokumentenverwaltung/v97w3945w045ct3576c4w09rczg4twc0r8563458utmwv49vw8e4p57bz45wiovu6e98457c
```


Ein Beispiel-Request kann mit curl erzeugt werden. Bitte alle grossgeschriebenen Platzhalter ersetzen.

```
curl -v -H "X-PartnerId: PARTNER_ID" -H "X-ApiKey: API_KEY"   -F "vorgangsNummer=V_NR" -F "filename=README.md"  -F "file=@README.md" -F "sichtbarFuerVertrieb=true" https://www.europace2.de/vorgang/dokumente
```

