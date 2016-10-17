
BaufiSmart - Vorgang Anlegen Schnittstelle - Version 12
=========================================================

Die BEX API wird durch die Datei [bex-v12-VorgangAnlegen.wsdl](bex-v12-VorgangAnlegen.wsdl)
vollständig beschrieben. Die Datei [bex-v12-VorgangAnlegen.xsd](bex-v12-VorgangAnlegen.xsd)
kann genutzt werden, um mit eigenen Programmen/Werkzeugen
die Anfragen zu validieren.


Beispiele
----------

In dem Ordner ''Beispiele'' beschreiben XML-Dateien Anfragen und Antworten
an den BEX SOAP Service. für eine bessere Lesbarkeit ist
der SOAP-Envelope und SOAP-Body nicht dargestellt,
sondern nur der Inhalt 
der [Vorgang.xml](Beispiele/bex-v12-Vorgang.xml) (Anfrage)
und der [VorgangMetadaten.xml](Beispiele/bex-v12-VorgangMetadaten.xml) (Antwort).


Mappingvorlage
---------------

Bei der Mappingvorlage handelt es sich um eine [Excel-Datei](Mappingvorlage/bex-v12-VorgangAnlegen-Vorgang_MappingVorlage.xlsx),
welche die Struktur des Vorgangs (für die SOAP Anfrage) beschreibt.
Zusätzlich gibt es darin Spalten, in denen sie Felder aus ihrem Datenmodell
eintragen können. So kann diese Mappingvorlage beim fachlichen Erstellen
oder beim Dokumentieren ihre Arbeit unterstützen.


Code-Generierung für Client-Stubs
----------------------------------

Aus der WSDL-Beschreibung kann automatisch Code generiert werden.

#### Beispiel für Java

````bash
wsimport -keep -extension bex-v12-VorgangAnlegen.wsdl
````

