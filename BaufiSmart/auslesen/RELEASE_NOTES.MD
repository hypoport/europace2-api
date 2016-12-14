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

##### Neue Werte

* Vorhaben.verwendungszweck kann jetzt zusätzlich den Wert 'KAPITALBESCHAFFUNG' haben
* Haustyp kann den Wert 'KEIN_TYP_AUSGEWAEHLT' haben

##### Breaking Changes

* Die Knoten des `_embedded` Objects sind hoch in das Angebot verschoben
* Im Angebot gibt es einen Knoten `dokumente`, indem alle Dokumente gesammelt sind 
* Bugfix: Flaechenwerte werden analog Euro und Prozent, wie in Swagger dokumentiert, als Nummern serialisiert
* Bankverbindung: Kontoinhaber ist jetzt eine Liste von AntragstellerVerknuepfungen (jeweils mit den Feldern 'id' und 'name')
* Renamings in haushalt.einnahmenAusgabenVermoegenVerbindlichkeiten
  * `lebensUndRentenversicherung` -> `lebensUndRentenversicherungen` 
  * `privateKrankenversicherungBeitragMonatlich` -> `privateKrankenversicherungsBeitraegeMonatlich` 
  * `ratenkredit` -> `ratenkredite`
  * `unbefristeteZusatzRenteMonatlich` -> `unbefristeteZusatzRentenMonatlich`
  * `unterhaltsVerpflichtungMonatlich` -> `unterhaltsVerpflichtungenMonatlich`
  * `verbindlichkeitSonstige` -> `verbindlichkeitenSonstige`
  * `bausparvertrag` -> `bausparvertraege`
* Lebens- und Rentenversicherungen: komplexes Objekt `produktAnbieter` durch einfachen String `versicherungsGesellschaft` ersetzt
* Jahreszahl ist Integer basiert, nicht String basiert
* Kellerausbau umbenannt in ingDibaKellerausbau
  
* FinanzierungsObjekt
  * `BestehendesDarlehenDesFinanzierungsObjekts.darlehenArt` -> `darlehensArt`
* BestehendeImmobilie
  * `BestehendesDarlehen.darlehenArt` -> `darlehensArt`
* NachrangigesExternesDarlehen: `darlehenBetrag` -> `darlehensBetrag`
* VermietungsInformationen: Umbenennung `vermieteteWohnflaecheBeiTeilvermietung` -> `vermieteteFlaecheBeiTeilvermietung`

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

##### Type-Renamings
* `EuropaceBausparAngebot` umbenannt zu `Bausparvertrag`

#### Version 0.1

* Initiale Version 
* Anträge können ausgelesen werden

