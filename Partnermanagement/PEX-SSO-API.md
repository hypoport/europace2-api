
PEX SSO (Silent Sign On) API
============================

EUROPACE 2 erlaubt es seinen Partnern, Benutzer per _Silent Sign On_ anzumelden. 

_Silent Sign On_ in ein Verfahren, das es ermöglicht, einen Benutzer von einer Webseite zu BaufiSmart weiter zu leiten, ohne das sich dieser erneut anmelden muss.

EUROPACE 2 nutzt dafür den Internet Standard [JWT](http://jwt.io) mit [RSA](http://de.wikipedia.org/wiki/RSA-Kryptosystem) als Signaturverfahren.

Dieses Dokument erläutert Ihnen die verwendeten technischen Standards und welche Schritte zu einer erfolgreichen Anbindung notwendig sind.

Erzeugung der RSA Keys
----------------------

```
openssl genrsa 2048 > rsa.private
openssl pkcs8 -topk8 -inform PEM -outform PEM -in rsa.private  -nocrypt > private-key.pem
openssl rsa -inform PEM -in rsa.private -pubout > public-key.pem
rm rsa.private
```

Hinterlegen des Public RSA Key in EUROPACE 2
--------------------------------------------

Der öffentliche RSA key muss in EUROPACE 2 hinterlegt sein, um die Signatur des JWT zu überprüfen. Der öffentliche Schlüssel kann per HTTP hochgeladen werden:

```
curl -X PUT
     -H "Accept: application/json" 
     -H "X-ApiKey: ${apiKey}" 
     -H "X-PartnerId: ${partnerId}"
     -H "X-TraceId: `date "+%Y-%m-%dT%H:%M:%S-test"`"
     --data @public-key.pem
     https://ep2.mtp.rz-hypoport.local/partnermanagement/partner/${issuerId}/sso-pub-key
```

apiKey und partnerId müssen einer Organisationseinheit identifizieren, die "Einstellungsrechte" auf den _issuerId_ hat.


Erzeugen eines Json Web Tokens (JWT)
-------------------------------------

Für manuelle, explorative Tests der SSO Schnittstelle sowie als "Kopiervorlage" für Java basierte clients steht ein Java basiertes Testprojekt bereit.

Folgende Komponenten müssen installiert sein:

- [Java7](http://www.java.com/en/download/index.jsp)
- [Maven3](http://maven.apache.org/download.cgi)



1) Github Projekt auschecken:

```
git clone https://github.com/hypoport/jwt-toolbox.git
```

2) Projekt kompilieren und all-inclusive JAR erstellen.

```
cd jwt-toolbox
mvn package
```

3) Token erzeugen

```
java -jar target/jwt-toolbox-jar-with-dependencies.jar private-key.pem ${partnerToLogonId} ${issuerId}
```

Einloggen via JWT mit Redirect
------------------------------

Der soeben erzeugte token kann nun zur Anmeldung an EUROPACE 2 verwendet werden. Im Browser oder per curl folgende URL per GET abrufen:

```
https://www.europace2.de/partnermanagement/login?redirectTo=/uebersicht&authentication=${jwt}
```
### Schematischer Ablauf

Das folgende Sequenzdiagramm erläutert das Zusammenspiel der Kollaborateure in der HTTP Netzwerkebene:

![Sequenzdiagramm für die EUROPACE 2 Anmeldung via Silent Sign On](Sequence.png?raw=true)
