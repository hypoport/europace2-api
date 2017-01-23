## Release Notes

Informationen zu den Änderungen in den verschiedenen Versionen

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

##### Breaking Changes

* viele als Enum deklarierte Werte werden jetzt als String deklariert

* Angebot
  * `rueckdatierungsFristEndeAm` entfernt
  * `angebotsFristEndeAm` entfernt
  * Im Knoten `dokumente` sind jetzt alle Dokumente gesammelt
    * Dokument: `zuordnung` entfernt
  * `bewertungDesAngebots`: Wert `ANGEBOT_ENTSPRICHT_MEINER_EMPFEHLUNG` -> `ANGEBOT_ENTSPRICHT_DER_EMPFEHLUNG_DES_KUNDENBETREUERS`
  * `erzeugtAm`: um Zeitstempel erweitert 
  * `beleihung` -> `beleihungsRechnung`
  
* Tilgungsersatz: `type` -> `typ`
  
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

* Die Knoten des `_embedded` Objects sind hoch in das Angebot verschoben
* Bugfix: Flaechenwerte werden analog Euro und Prozent, wie in Swagger dokumentiert, als Nummern serialisiert
* Bankverbindung: 
  * umgezogen von `haushalt` nach `zugrundeliegendeDaten`
  * `kontoinhaber` ist jetzt eine Liste von AntragstellerVerknuepfungen (jeweils mit den Feldern 'id' und 'name')
  * `kontonummer` entfernt
  * `bankleitzahl` entfert
* `antragsteller.staatsangehoerigkeit` ist jetzt ein komplexes Objekt vom Typ `Staat` (enthält Iso-Code und menschenlesbaren Namen) 
* haushalt.einnahmenAusgabenVermoegenVerbindlichkeiten
  * `lebensUndRentenversicherung` -> `lebensUndRentenversicherungen` 
  * `privateKrankenversicherungBeitragMonatlich` -> `privateKrankenversicherungsBeitraegeMonatlich` 
  * `ratenkredit` -> `ratenkredite`
  * `unbefristeteZusatzRenteMonatlich` -> `unbefristeteZusatzRentenMonatlich`
  * `unterhaltsVerpflichtungMonatlich` -> `unterhaltsVerpflichtungenMonatlich`
  * `verbindlichkeitSonstige` -> `verbindlichkeitenSonstige`
  * `bausparvertrag` -> `bausparvertraege`
  * alle Einnahmen und Ausgaben: `zahlungTyp` -> `zahlungsTyp`
  * alle Berechnungshilfen-Knoten entfernt
* Lebens- und Rentenversicherungen: komplexes Objekt `produktAnbieter` durch einfachen String `versicherungsGesellschaft` ersetzt
* Jahreszahl ist Integer basiert, nicht String basiert
* Kellerausbau umbenannt in ingDibaKellerausbau
* `darlehen.effektivZinsKosten`: `sonstigeKostenErlaeuterung` entfernt 
* `darlehen.abzuloesendeAltdarlehen` entfernt 
* `darlehen.bestehendesDarlehenDerImmobilieIdsBeiAbloesung` entfernt 
* `darlehen.kreditEntscheider` entfernt 
* `darlehen.abzuloesendeAltdarlehen` entfernt
 * Darlehen: restschuldNachZinsBindungsEnde ist jetzt Attribut am ZinsBindung-Knoten, nicht mehr direkt am Darlehen
 
* FinanzierungsObjekt
  * `BestehendesDarlehenDesFinanzierungsObjekts.darlehenArt` -> `darlehensArt`
* BestehendeImmobilie
  * `BestehendesDarlehen.darlehenArt` -> `darlehensArt`
  * `BestehendesDarlehen.hauptKontonummerDslBank` entfernt
  * `BestehendesDarlehen.darlehensKontonummer` entfernt
  * `BestehendesDarlehen.sondertilgungZumZinsBindungsEnde` entfernt
  * `BestehendesDarlehen.darlehensBetrag` entfernt
  * `BestehendesDarlehen.sollZins` entfernt
* NachrangigesExternesDarlehen: `darlehenBetrag` -> `darlehensBetrag`
* VermietungsInformationen: Umbenennung `vermieteteWohnflaecheBeiTeilvermietung` -> `vermieteteFlaecheBeiTeilvermietung`
* BausparAngebot: mehrere Attribute entfernt

* Bausparangebote
  * `sparPhase.guthabenZins` entfernt
  * `tilgungsPhase.darlehensGebuehrEinmalig` entfernt
  
* Vorhaben
  * `externeImmobilienDarlehen` entfernt
  
* ZinsBindung jetzt überall mit großem "B"
* ZinsBindungBis -> ZinsBindungEndetAm

* Grundbuch `flurStuecke` -> `flurstuecke`

* Gebäude: `gewerbeflaecheVorhanden` entfernt
  
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

