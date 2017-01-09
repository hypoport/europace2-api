
BaufiSmart - Vorgang Anlegen Schnittstelle - Version 13
=========================================================

Die BEX API wird durch die Datei [bex-v13-VorgangAnlegen.wsdl](bex-v13-VorgangAnlegen.wsdl)
vollständig beschrieben. Die Datei [bex-v13-VorgangAnlegen.xsd](bex-v13-VorgangAnlegen.xsd)
kann genutzt werden, um mit eigenen Programmen/Werkzeugen
die Anfragen zu validieren.


Beispiele
----------

In dem Ordner ''Beispiele'' beschreiben XML-Dateien Anfragen und Antworten
an den BEX SOAP Service. für eine bessere Lesbarkeit ist
der SOAP-Envelope und SOAP-Body nicht dargestellt,
sondern nur der Inhalt 
der [Vorgang.xml](Beispiele/bex-v13-Vorgang.xml) (Anfrage)
und der [VorgangMetadaten.xml](Beispiele/bex-v13-VorgangMetadaten.xml) (Antwort).

Code-Generierung für Client-Stubs
----------------------------------

Aus der WSDL-Beschreibung kann automatisch Code generiert werden.

#### Beispiel für Java

````bash
wsimport -keep -extension bex-v13-VorgangAnlegen.wsdl
````

Inkompatible Änderungen zu BEX v12
----------------------------------

- Im Element *nutzungsDetailsBeiVermietung* wurde das Feld *vermieteteWohnflaecheBeiTeilvermietung* umbenannt in *vermieteteFlaecheBeiTeilvermietung*
