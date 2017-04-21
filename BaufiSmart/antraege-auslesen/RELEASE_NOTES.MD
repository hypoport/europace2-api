## Release Notes

Informationen zu den Änderungen in den verschiedenen Versionen

#### Version 2.1

* Der Status der Anträge ist jetzt über die API setzbar.

#### Version 2.0

* Die Adressierung der Anträge erfolgt jetzt über die vollständige Antragsnummer `AB1234/1/1`.
* Bankverbindung enthält jetzt nur noch Referenzen auf Kontoinhaber
* Partner und Produktanbieter enthalten optional eine externe PartnerId

#### Version 1.0

* operationId's angepasst
* X-Amzn-Trace-Id entfernt
* `CollectionLinks` in `PaginationLinks` umbenannt

#### Version 0.6

* Header `Authorization` wird jetzt nicht mehr explizit in der Parameterliste der Operationen erwähnt.
* Header `X-Authentication` wird jetzt nicht mehr explizit in der Parameterliste der Operationen erwähnt.
* Bei Collection-Ressourcen sind die `prev`- und `next`-Links explizit spezifizert. 

#### Version 0.5

#### Geänderte QueryParameter

* `antraege?erzeugtSeit` --\> `antraege?angenommenNach`

##### Geänderte Dokumentation / YAML

* Swagger-Datentyp für `Antrag.zeitpunktDerAnnahme` und `AngebotZumAntrag.erzeugtAm` von `date` auf `date-time` geändert 
* `link.href` als String interpretieren
* `link.type` als String interpretieren

#### Version 0.4

##### Neue Felder

* `zugrundeliegendeDaten.vorhaben` mit verwendungszweck, finanzbedarf und externen nachrangigen Darlehen
* `immobilie.gebaeude.hausAnordnung` als Vereinheitlichung von `hausAnordnungMehrfamilienOderZweifamilienhause` und `hausAnordnungReihenhaus`

##### Entfernte Felder

* `antragsteller.beschaeftigung.arbeitgeberNichtInDeutschlandAnsaessigKommentar`
* `bestehendeImmobilie.kommentar`
* `immobilie.erbbaurecht.erbbaurechtVorhanden`
* `finanzierungsObjekt.keineBestehendenDarlehenVorhanden`
* `immobilie.gebaeude.hausAnordnungMehrfamilienOderZweifamilienhause`
* `immobilie.gebaeude.hausAnordnungReihenhaus`

##### Entfernte Werte

* Haustyp kann den Wert 'KEIN_TYP_AUSGEWAEHLT' nicht mehr haben und wird stattdessen weggelassen

#### Version 0.3

##### Neue Felder                                                                                                                  

* antragsteller.schufaErgebnis.inManuellerNachbehandlung
* `antrag.angebot` beinhaltet das Angebot, auf dem der Antrag basiert
* `antrag.angebot.darlehen` Darlehen, aus dem das Angebot besteht
* haus.anzahlDerGewerbeeinheitenBeiMehrfamilienHaus
* `vorhaben.verwendungszweckAbhaengigerFinanzbedarf` hat jetzt zusätzlich ein Feld `finanzbedarfArt`, welches beschreibt was für
  eine Form von Finanzbedarf in dem Vorhaben-JSON-Objekt vorhanden ist.
* HaushaltsPositionen.Postadresse

##### Neue Werte

* Vorhaben.verwendungszweck kann jetzt zusätzlich den Wert 'KAPITALBESCHAFFUNG' haben
* Haustyp kann den Wert 'KEIN_TYP_AUSGEWAEHLT' haben
* angebot.bausparvertraege.id

##### Entfernte Felder
* angebot.id
* angebot.bausparvertraege.provision
* angebot.bausparvertraege.sparPhase.guthabenZins
* angebot.bausparvertraege.tilgungsPhase.darlehensGebuehrEinmalig
* angebot.darlehen.id
* finanzierungsObjekt.keineBestehendenDarlehenVorhanden


##### Breaking Changes

* viele als Enum deklarierte Werte werden jetzt als String deklariert
* Die Knoten des `_embedded` Objects sind hoch in das Angebot verschoben
* Bugfix: Flaechenwerte werden analog Euro und Prozent, wie in Swagger dokumentiert, als Nummern serialisiert

* Antrag
  * Anträge werden jetzt unter dem Pfad `/antraege/antragsNummer` abgerufen, wobei bei der Antragsnummer der Slash '/' durch einen
    Unterstrich '_' zu ersetzen ist.
  * Der Unterpfad `.../zugrundeliegendeDaten` wurde entfernt
  * `voraussichtlicheBearbeitungAm` entfernt
  * `prolongation` entfernt
  * `status` 
    * `antragstellerStatus` -> `antragsteller`
    * `produktAnbieterStatus` -> `produktAnbieter`
    * `antragStatus` entfernt
    * `vertragsBearbeitungsFortschritt` -> `bearbeitungsFortschritt`
  * `istKundenBetreuerVerkaeuferOderMaklerDerImmobilie` ist jetzt vom Typ Boolean
  * `angenommenAm` umbenannt nach `zeitpunktDerAnnahme` und erweitert um Zeitstempel 

* Angebot
  * `rueckdatierungsFristEndeAm` entfernt
  * `angebotsFristEndeAm` entfernt
  * Im Knoten `dokumente` sind jetzt alle Dokumente gesammelt
    * Dokument: `zuordnung` entfernt
  * `bewertungDesAngebots`: Wert `ANGEBOT_ENTSPRICHT_MEINER_EMPFEHLUNG` -> `ANGEBOT_ENTSPRICHT_DER_EMPFEHLUNG_DES_KUNDENBETREUERS`
  * `erzeugtAm`: um Zeitstempel erweitert 
  * `beleihung` -> `beleihungsRechnung`
* Darlehen:
  * `effektivZinsKosten`: `sonstigeKostenErlaeuterung` entfernt 
  * `abzuloesendeAltdarlehen` entfernt 
  * `bestehendesDarlehenDerImmobilieIdsBeiAbloesung` entfernt 
  * `kreditEntscheider` entfernt 
  * `abzuloesendeAltdarlehen` entfernt
  * `restschuldNachZinsBindungsEnde` ist jetzt Attribut am ZinsBindung-Knoten, nicht mehr direkt am Darlehen
  * `forwardDarlehen` Unterknoten entfernt und Werte direkt ans Darlehen verschoben
  * `kfWDarlehen` Unterknoten entfernt und Werte direkt ans Darlehen verschoben
  * `privatDarlehen` Unterknoten entfernt und Werte direkt ans Darlehen verschoben
  * `zwischenFinanzierung` Unterknoten entfernt und Werte direkt ans Darlehen verschoben
  
* BausparAngebot: mehrere Attribute entfernt  

* `zinsBindung` jetzt überall mit großem "B"
* `zinsBindungBis` -> `zinsBindungEndetAm`

* Tilgungsersatz: `type` -> `typ`

* Bankverbindung: 
  * umgezogen von `haushalt` nach `zugrundeliegendeDaten`
  * `kontoinhaber` ist jetzt eine Liste von AntragstellerVerknuepfungen (jeweils mit den Feldern 'id' und 'name')
  * `kontonummer` entfernt
  * `bankleitzahl` entfert

* Antragsteller 
  * `staatsangehoerigkeit` ist jetzt ein komplexes Objekt vom Typ `Staat` (enthält Iso-Code und menschenlesbaren Namen)
  * `beschaeftigung` neu strukturiert 
* `haushalt.einnahmenAusgabenVermoegenVerbindlichkeiten` umbenannt zu `positionen`
  * `ausgabenSonstigeMonatlich` -> `sonstigeAusgaben` 
  * `ehegattenUnterhaltEinnahmenMonatlich` -> `ehegattenUnterhalt` 
  * `einnahmenSonstigeMonatlich` -> `sonstigeEinnahmen` 
  * `lebensUndRentenversicherung` -> `lebensUndRentenVersicherungen` 
  * `privateKrankenversicherungBeitragMonatlich` -> `privateKrankenversicherung` 
  * `ratenkredit` -> `ratenkredite`
  * `unbefristeteZusatzRenteMonatlich` -> `unbefristeteZusatzRenten`
  * `unterhaltsVerpflichtungMonatlich` -> `unterhaltsVerpflichtungen`
  * `variableEinkuenfteMonatlich` -> `variableEinkuenfte`
  * `verbindlichkeitSonstige` -> `sonstigeVerbindlichkeiten`
  * `versicherungsAusgabenSonstigeMonatlich` -> `versicherungsAusgaben`
  * `vermoegenSonstige` -> `sonstigeVermoegen`
  * `bausparvertrag` -> `bausparvertraege`
  * `vermoegenOderVerbindlichkeit` -> `vermoegensTyp`
  * alle Einnahmen und Ausgaben: `zahlungTyp` -> `zahlungsTyp`
  * alle Berechnungshilfen-Knoten entfernt
  * Lebens- und Rentenversicherungen: komplexes Objekt `produktAnbieter` durch einfachen String `versicherungsGesellschaft` ersetzt
* Jahreszahl ist Integer basiert, nicht String basiert

* FinanzierungsObjekt und BestehendeImmobilie neu strukturiert  
* Grundbuch `flurStuecke` -> `flurstuecke`
* Gebäude: `gewerbeflaecheVorhanden` entfernt
* VermietungsInformationen: Umbenennung `vermieteteWohnflaecheBeiTeilvermietung` -> `vermieteteFlaecheBeiTeilvermietung`
  
* Vorhaben entfernt
  
#### Version 0.2


##### Neue Felder

* angebot.beleihung
* angebot.erzeugtAm
* angebot.pruefungsErgebnisse
* antragsteller.beschaeftigung.angestellterOderArbeiterOderBeamter.arbeitgeberNichtInDeutschlandAnsaessigKommentar
* antragsteller.berufsgruppeBeiIngDiba (ING-DiBa-spezifische Ausprägungen der Berufsgruppe)
* antragsteller.brancheBeiIngDiba (ING-DiBa-spezifische Ausprägungen der Branche)
* antragsteller.brancheBeiMhb (MHB-spezifische Ausprägungen der Branche)
* antragsteller.brancheBeiSRating (Sparkassen-spezifische Ausprägungen der Branche)
* antragsteller.schufaErgebnis
* Immobilie.eigentumswohnung.ausstattung (sowohl Finanzierungsobjekt als auch bestehende Immobilien)
* Immobilie.haus.ausstattung (sowohl Finanzierungsobjekt als auch bestehende Immobilien)
* haushalte.anzahlKinderNichtImHaushalt;
* haushalte.anzahlErwachseneImHaushalt;
* haushalte.lebenshaltungsKostenMonatlich;
* haushalte.kfzAnzahl;
* haushalt.bestehendeImmobilie: kommentar
* Dokument: art

##### Breaking Changes

* antragsteller.verheiratetmitWeiteremAntragsteller Renaming zu antragsteller.verheiratetmitAntragsteller. Knoten ist jetzt kein Boolean mehr, sondern eine Verknüpfung zu einem anderen Antragsteller, um mehr als zwei Antragsteller zu unterstützen.
* angebot.meldungen.zuordnung.FINANZIERUNGS_OBJEKT Renaming zu IMMOBILIE 
* provision.produktAnbieterZahltEuropaceMarge entfernt
* provision.europaceMargeAbsolut Renaming zu provision.europaceGebuehren
* provision.provisionKundenbetreuerRelativ entfernt
* provision.vertriebsProvisionGesamtRelativ entfernt
* provision.provisionKundenbetreuerAbsolut Renaming zu provision.kundenbetreuerProvision
* provision.vertriebsProvisionGesamtAbsolut Renaming zu provision.vertriebsProvisionGesamt
* Flächenangaben jetzt direkt als Wert vom Typ 'number' und nicht mehr als extra Object.
* bestehendeImmobilienEinsatz: GAR_NICHT -> KEIN_EINSATZ
* Link / Dokument haben nicht mehr die Attrbute name, type und size

##### Type-Renamings
* `EuropaceBausparAngebot` umbenannt zu `Bausparvertrag`

#### Version 0.1

* Initiale Version 
* Anträge können ausgelesen werden

