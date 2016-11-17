## Release Notes

Informationen zu den Änderungen in den verschiedenen Versionen

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

