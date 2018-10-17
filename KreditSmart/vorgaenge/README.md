# KEX-Vorgang-Import-API 

Die Schnittstelle ermöglicht das automatisierte Anlegen von Vorgängen in **Kredit**Smart.

## Anlegen eines neuen Vorgangs

Neue Vorgänge können per **HTTP POST** angelegt werden.

Die URL für das Anlegen von Echtgeschäftsvorgängen ist:

    https://www.europace2.de/kreditsmart/kex/vorgang?environment=PRODUCTION

Die URL für das Anlegen von Testvorgängen ist:

	https://www.europace2.de/kreditsmart/kex/vorgang
    
Die Daten werden als JSON Dokument im Body des POST Requests übermittelt.

Ein erfolgreicher Aufruf resultiert in einer Response mit dem HTTP Statuscode **201 CREATED**.

## Authentifizierung

Für jeden Request ist eine Authentifizierung erforderlich.

Die Authentifizierung erfolgt über einen HTTP Header.

<table>
<tr>
<th>
Request Header Name</th><th>	Beschreibung</th>
</tr>
<tr>
<td>X-Authentication</td><td>	API JWT der Vertriebsorganisation</td>
</tr>
</table>


Das API JWT (JSON Web Token) erhalten Sie von Ihrem Ansprechpartner im **Kredit**Smart-Team. 

Schlägt die Authentifizierung fehl, erhält der Aufrufer eine HTTP Response mit Statuscode **401 UNAUTHORIZED**.

## TraceId zur Nachverfolgbarkeit von Requests

Für jeden Request soll eine eindeutige ID generiert werden, die den Request im EUROPACE 2 System nachverfolgbar macht und so bei etwaigen Problemen oder Fehlern die systemübergreifende Analyse erleichtert.

Die Übermittlung der X-TraceId erfolgt über einen HTTP Header. Dieser Header ist optional,
wenn er nicht gesetzt ist, wir eine ID vom System generiert.

<table>
<tr>
<th>Request Header Name</th><th>Beschreibung</th><th>Beispiel</th>
<tr>
<td>X-TraceId</td>
<td>eindeutige Id für jeden Request</td>
<td>sys12345678</td>
</tr>
</table>

## Content-Type

Die Schnittstelle akzeptiert Daten mit Content-Type "**application/json**".

Entsprechend muss im Request der Content-Type Header gesetzt werden. Zusätzlich das Encoding, wenn es nicht UTF-8 ist.

<table>
<tr>
<th>
Request Header Name</th><th>	Header Value</th>
</tr>
<tr>
<td>Content-Type</td><td>	application/json</td>
</tr>
</table>

### POST Request Beispiel:

	POST https://www.europace2.de/kreditsmart/kex/vorgang
	X-Authentication: xxxxxxx
	Content-Type: application/json;charset=utf-8
	{
		"kundenbetreuer": {
			partnerId: "TEST"
		},
		"antragsteller1": {
			"personendaten": {
				"vorname": "Max",
				"nachname": "Mustermann"
			}
		}
	}
    
### POST Response Beispiel:

	201 CREATED
	{
		"vorgangsnummer": "AB1234",
		"messages": []
	}

## Fehlercodes

Wenn der Request nicht erfolgreich verarbeitet werden konnte, liefert die Schnittstelle einen Fehlercode, auf den die aufrufende Anwendung reagieren kann, zurück.

Achtung: In diesem Fall wird kein Vorgang in **Kredit**Smart importiert und angelegt.

<table>
<tr><th>Fehlercode</th><th>Nachricht</th><th>	Erklärung</th></tr>
<tr><td>401</td><td>Unauthorized</td><td>Authentifizierung ist fehlgeschlagen</td></tr>
<tr><td>422</td><td>Unprocessable Entity</td><td>Es wurde keine gültige Kundenbetreuer-Partner-ID angegeben</td></tr>
</table>

Weitere Fehlercodes und ihre Bedeutung siehe Wikipedia: [HTTP-Statuscode](https://de.wikipedia.org/wiki/HTTP-Statuscode)

## Request Format

Die Angaben werden als JSON im Body des Requests gesendet.

Für eine bessere Lesbarkeit wird das Gesamtformat in *Typen* aufgebrochen, die an anderer Stelle definiert sind, aber an verwendeter Stelle eingesetzt werden müssen.
Die Attribute innerhalb eines Blocks können in beliebiger Reihenfolge angegeben werden.

Für einen erfolgreichen Request gibt es derzeit nur ein definiertes Pflichtfeld (siehe „Vorgang“).

Alle übermittelten Daten werden in **Kredit**Smart übernommen, mit Ausnahme von:

* Angaben, die aufgrund eines abweichenden Formats nicht verstanden werden (z. B. "1" statt "true", "01.01.2016" statt "2016-01-01"), und 
* Angaben, die aufgrund der Datenkonstellationen überflüssig bzw. unstimmig sind (z. B. Angabe beim 1. Antragsteller zu gemeinsamerHaushalt).


An verschiedenen Stellen im Request ist die Angabe eines Landes oder der Staatsangehörigkeit notwendig:
Die Übermittlung erfolgt im Format [ISO-3166/ALPHA-2](https://de.wikipedia.org/wiki/ISO-3166-1-Kodierliste)

### Vorgang

    {
		"kundenbetreuer": Partner,
		"bearbeiter": Partner,
		"tippgeber": Partner,
		"leadquelle": String,
		"eigeneVorgangsnummer": String,
		"antragsteller1": Antragsteller,
		"antragsteller2": Antragsteller,
		"haushalt": Haushalt,
		"finanzbedarf": Finanzbedarf,
		"kommentare": [ String ]
	}

Das Feld *kundenbetreuer.partnerId* ist ein Pflichtfeld.

### Partner

	{
		"partnerId": String
	}

Die Europace 2 PartnerID ist 5-stellig und hat das Format ABC12. 

#### Antragsteller

    {
		"herkunft": Herkunft,
		"personendaten": Personendaten,
		"wohnsituation": Wohnsituation,
		"beschaeftigung": Beschäftigung
	}

#### Herkunft

    {
		"arbeitserlaubnisVorhanden": true | false,
		"aufenthaltBefristetBis": "YYYY-MM-DD",
		"arbeitserlaubnisBefristetBis": "YYYY-MM-DD",
		"inDeutschlandSeit": "YYYY-MM-DD",
		"staatsangehoerigkeit": "ALPHA-2 Isocode",
		"aufenthaltstitel": "VISUM" | "AUFENTHALTSERLAUBNIS" | "NIEDERLASSUNGSERLAUBNIS" | "ERLAUBNIS_ZUM_DAUERAUFENTHALT_EU",
		"steuerId": String
	}

#### Personendaten

    {
		"titel": [ "DOKTOR" | "PROFESSOR" ]
		"anrede": "FRAU" | "HERR",
		"telefonGeschaeftlich": String,
		"geburtsdatum": "YYYY-MM-DD",
		"telefonPrivat": String,
		"geburtsort": String,
		"vorname": String,
		"geburtsname": String,
		"nachname": String,
		"familienstand": "LEDIG" | "VERHEIRATET" | "GESCHIEDEN" | "VERWITWET" | "GETRENNT_LEBEND" | "EHEAEHNLICHE_LEBENSGEMEINSCHAFT" | "EINGETRAGENE_LEBENSPARTNERSCHAFT",
		"email": String
	}


#### Wohnsituation

	{
		"anschrift": {
			"strasse": String,
			"hausnummer": String,
			"plz": String,
			"ort": String,
			"wohnhaftSeit": "YYYY-MM-DD"
		},
		"gemeinsamerHaushalt": true | false,
		"wohnart": "ZUR_MIETE" | "ZUR_UNTERMIETE" | "IM_EIGENEN_HAUS" | "BEI_DEN_ELTERN",
		"anzahlPersonenImHaushalt": Integer,
		"anzahlPkw": Integer,
		"voranschrift": {
			"strasse": String,
			"hausnummer": String,
			"plz": String,
			"ort": String,
			"wohnhaftSeit": "YYYY-MM-DD"
		}
	}

Die Angabe *gemeinsamerHaushalt* ist nur beim zweiten Antragsteller relevant.

#### Beschäftigung


	{
		"beschaeftigungsart": "ANGESTELLTER" | "ARBEITER" | "ARBEITSLOSER" | "BEAMTER" | "FREIBERUFLER" | "HAUSFRAU" | "RENTNER" | "SELBSTSTAENDIGER",
		"arbeiter": Arbeiter,
		"angestellter": Angestellter,				
		"arbeitsloser": Arbeitsloser,
		"beamter": Beamter,
		"selbststaendiger": Selbstständiger,
		"freiberufler": Freiberufler,
		"hausfrau": Hausfrau,
		"rentner": Rentner
	}

Die zu befüllende Felder zur Beschäftigung ist abhängig von der ausgewählten Beschäftigungsart.<BR>Ist keine Beschäftigungsart gesetzt bzw. andere Felder, die nicht zur Beschäftigungsart passen, befüllt, werden sie ignoriert.
Beispiel: *beschaeftigungsart=ARBEITER*, dann wird der Knoten *arbeiter* berücksichtigt

#### Arbeiter und Angestellter

	{
		"beschaeftigungsverhaeltnis": {
			"berufsbezeichnung": String,
			"nettoeinkommenMonatlich": Decimal,
			"arbeitgeber": Arbeitgeber,
			"beschaeftigtSeit": "YYYY-MM-DD",
			"befristung": "BEFRISTET" | "UNBEFRISTET",
			"befristetBis": "YYYY-MM-DD",
			"inProbezeit": true | false
		},
		"vorherigesBeschaeftigungsverhaeltnis": {
			"arbeitgeber": {
				"name": String,
				"anschrift": {
					"plz": String,
					"ort": String
				}
			},
			"beschaeftigtSeit": "YYYY-MM-DD",
			"beschaeftigtBis": "YYYY-MM-DD"
		}
	}

#### Arbeitsloser und Hausfrau

	{
		"sonstigesEinkommenMonatlich": Decimal
	}


#### Selbstständiger und Freiberufler

	{
		"berufsbezeichnung": String,
		"selbststaendigSeit": "YYYY-MM-DD",
		"firma": {
			"name": String,
			"branche": Branche,
			"anschrift": Anschrift
		},
		"nettoeinkommenJaehrlich": Decimal,
		"bruttoEinkommenLaufendesJahr": Decimal,
  		"einkommenssteuerLaufendesJahr": Decimal,
  		"abschreibungenLaufendesJahr": Decimal,
		"bruttoEinkommenLetztesJahr": Decimal,
		"einkommenssteuerLetztesJahr": Decimal,
		"abschreibungenLetztesJahr": Decimal,
		"einkommenssteuerVor2Jahren": Decimal,
		"bruttoEinkommenVor2Jahren": Decimal,
		"abschreibungenVor2Jahren": Decimal,
		"bruttoEinkommenVor3Jahren": Decimal,
		"einkommenssteuerVor3Jahren": Decimal,
		"abschreibungenVor3Jahren": Decimal
	}

#### Beamter

	{
		"beschaeftigungsverhaeltnis": {
			"berufsbezeichnung": String,
			"inProbezeit": true | false,
			"nettoeinkommenMonatlich": Decimal,
			"verbeamtetSeit": "YYYY-MM-DD",
			"arbeitgeber": 	Arbeitgeber,
			"beschaeftigtSeit": "YYYY-MM-DD"
		},
		"vorherigesBeschaeftigungsverhaeltnis": {
			"arbeitgeber": {
				"name": String,
				"anschrift": {
					"plz": String,
					"ort": String
				}
			},
			"beschaeftigtSeit": "YYYY-MM-DD",
			"beschaeftigtBis": "YYYY-MM-DD"
		}
	}

#### Rentner

	{
		"staatlicheRenteMonatlich": Decimal,
		"rentnerSeit": "YYYY-MM-DD",
		"rentenversicherung": {
			"name": String,
			"anschrift": {
				"strasse": String,
				"hausnummer": String,
				"plz": String,
				"ort": String
			}
		}
	}

#### Arbeitgeber

	{
		"name": String,
		"anschrift": Anschrift,
		"branche": "BAUGEWERBE" | "DIENSTLEISTUNGEN" | "ENERGIE_WASSERVERSORGUNG_BERGBAU" | "ERZIEHUNG_UNTERRICHT" | "GEBIETSKOERPERSCHAFTEN" | "GEMEINNUETZIGE_ORGANISATION" | "GESUNDHEIT_SOZIALWESEN" | "HANDEL" | "HOTEL_GASTRONOMIE" | "INFORMATION_KOMMUNIKATION" | "KREDITINSTITUTE_VERSICHERUNGEN" | "KULTUR_SPORT_UNTERHALTUNG" | "LANDWIRTSCHAFT_FORSTWIRTSCHAFT_FISCHEREI" | "OEFFENTLICHER_DIENST" | "PRIVATE_HAUSHALTE" | "VERARBEITENDES_GEWERBE" | "VERKEHR_LOGISTIK"
	}

#### Anschrift

	{
		"strasse": String,
		"hausnummer": String,
		"plz": String,
		"ort": String,
		"land": "ALPHA-2 Isocode"
	}
    

#### Haushalt

    {
		"verbindlichkeiten": {
			"geschaeftskredite": [ Geschäftskredit ],
			"kontokorrentkredite": [ Kontokorrentkredit ],
			"kreditkarten": [ Kreditkarte ],
			"dispositionskredite": [ Dispositionskredit ],
			"ratenkredite": [ Ratenkredit ],
			"leasings": [ Leasing ],
			"sonstigeVerbindlichkeiten": [ Sonstige Verbindlichkeit ]
		},
		"vermoegen": {
			"depotvermoegen": [ Depotvermögen ],
			"sonstigeVermoegenswerte": [ Sonstiger Vermögenswert ],
			"bankUndSparguthaben": [ Bank- und Sparguthaben ],
			"lebensversicherungen": [ Lebensversicherung ],
			"bausparvertraege": [ Bausparvertrag ]
		},
		"ausgaben": {
			"privateKrankenversicherungen": [ Private Krankenversicherung ],
			"unterhaltsverpflichtungen": [ Unterhaltsverpflichtung ],
			"sonstigeAusgaben": [ Sonstige Ausgabe ],
			"mietausgaben": [ Mietausgabe ],
			"sonstigeVersicherungsausgaben": [ Sonstige Versicherungsausgabe ]
		},
		"einnahmen": {
			"einkuenfteAusNebentaetigkeit": [ Einkunft aus Nebentätigkeit ],
			"ehegattenunterhalt": [ Ehegattenunterhalt ],
			"sonstigeEinnahmen": [ Sonstige Einnahme ],
			"einkuenfteAusKapitalvermoegen": [ Einkunft aus Kapitalvermögen ],
			"unbefristeteZusatzrenten": [ Unbefristete Zusatzrente ]
		},
		"immobilien": [ Immobilie ],
		"kinder": [ kind ],
		"kontoverbindung": {
			"iban": String,
			"bic": String,
			"kreditinstitut": String,
			"gehoertZuAntragsteller": Antragstellerzuordnung
		}
	}

#### Antragstellerzuordnung

	"ANTRAGSTELLER_1" | "ANTRAGSTELLER_2" | "BEIDE"

#### Ratenkredit, Geschäftskredit und Sonstige Verbindlichkeit

	{
		"rateMonatlich": Decimal,
		"schlussrate": Decimal,
		"datumErsteZahlung": "YYYY-MM-DD",
		"datumLetzteRate": "YYYY-MM-DD",
		"restschuld": Decimal,
		"urspruenglicherKreditbetrag": Decimal,
		"glaeubiger": String,
		"gehoertZuAntragsteller": Antragstellerzuordnung,
		"abloesen": true | false,
		"iban": String,
		"bic": String,
		"kreditinstitut": String 
	}

#### Kontokorrentkredit

	{
		"beanspruchterBetrag": Decimal,
		"verfuegungsrahmen": Decimal,
		"glaeubiger": String,
		"zinssatz": Decimal,
		"gehoertZuAntragsteller": Antragstellerzuordnung,
	}			

#### Kreditkarte

	{
		"beanspruchterBetrag": Decimal,
		"verfuegungsrahmen": Decimal,
		"rateMonatlich": Decimal,
		"glaeubiger": String,
		"zinssatz": Decimal,
		"gehoertZuAntragsteller": Antragstellerzuordnung,
		"abloesen": true | false,
		"iban": String,
		"bic": String,
		"kreditinstitut": String 
	}
	
#### Dispositionskredit

	{
		"beanspruchterBetrag": Decimal,
		"verfuegungsrahmen": Decimal,
		"glaeubiger": String,
		"zinssatz": Decimal,
		"gehoertZuAntragsteller": Antragstellerzuordnung,
		"abloesen": true | false,
		"bic": String,
		"iban": String,
		"kreditinstitut": String 
	}			

#### Leasing

	{
		"rateMonatlich": Decimal,
		"schlussrate": Decimal,
		"datumLetzteRate": "YYYY-MM-DD",
		"glaeubiger": String,
		"gehoertZuAntragsteller": Antragstellerzuordnung
	}

#### Depotvermögen


	{
		"betrag": Decimal,
		"gehoertZuAntragsteller": Antragstellerzuordnung
	}
				

#### Sonstiger Vermögenswert


	{
		"betrag": Decimal,
		"gehoertZuAntragsteller": Antragstellerzuordnung
	}
				

#### Bank- und Sparguthaben


	{
		"betrag": Decimal,
		"gehoertZuAntragsteller": Antragstellerzuordnung
	}
				
#### Lebensversicherung


	{
		"rueckkaufswert": Decimal,
		"praemieMonatlich": Decimal,
		"gehoertZuAntragsteller": Antragstellerzuordnung
	}
				
#### Bausparvertrag


	{
		"sparbeitragMonatlich": Decimal,
		"angesparterBetrag": Decimal,
		"gehoertZuAntragsteller": Antragstellerzuordnung
	}							

#### Private Krankenversicherung und Unterhaltsverpflichtung

	{
		"betragMonatlich": Decimal,
		"gehoertZuAntragsteller": "ANTRAGSTELLER_1" | "ANTRAGSTELLER_2"
	}
				
#### Sonstige Ausgabe, Mietausgabe und Sonstige Versicherungsausgabe

	{
		"betragMonatlich": Decimal,
		"gehoertZuAntragsteller": Antragstellerzuordnung
	}
				
#### Einkunft aus Nebentätigkeit

	{
		"betragMonatlich": Decimal,
		"beginnDerTaetigkeit": "YYYY-MM-DD",
		"gehoertZuAntragsteller": "ANTRAGSTELLER_1" | "ANTRAGSTELLER_2"
	}

#### Ehegattenunterhalt, Sonstige Einnahme, Einkunft aus Kapitalvermögen und Unbefristete Zusatzrente

	{
		"betragMonatlich": Decimal,
		"gehoertZuAntragsteller": "ANTRAGSTELLER_1" | "ANTRAGSTELLER_2"
	}


#### Immobilie

	{
		"mieteinnahmenWarmMonatlich": Decimal,
		"vermieteteWohnflaeche": Integer,
		"gehoertZuAntragsteller": Antragstellerzuordnung,
		"nebenkostenMonatlich": Decimal,
		"wert": Decimal,
		"nutzungsart": "EIGENGENUTZT" | "VERMIETET" | "EIGENGENUTZT_UND_VERMIETET",
		"mieteinnahmenKaltMonatlich": Decimal,
		"immobilienart": "EIGENTUMSWOHNUNG" | "EINFAMILIENHAUS" | "MEHRFAMILIENHAUS" | "BUEROGEBAEUDE",
		"bezeichnung": String,
		"wohnflaeche": Integer,
		"darlehen": [
			{
				"restschuld": Decimal,
				"zinsbindungBis": "YYYY-MM-DD",
				"rateMonatlich": Decimal
			}
		]
	}			

#### Kind

	{
		"name": String,
		"kindergeldFuer": "ERSTES_ODER_ZWEITES_KIND" | "DRITTES_KIND" | "AB_VIERTEM_KIND",
		"unterhaltseinnahmenMonatlich": Decimal,
		"gehoertZuAntragsteller": Antragstellerzuordnung
	}	
				

#### Finanzbedarf

    {
		"fahrzeugkauf": Fahrzeugkauf,
		"finanzierungszweck": "UMSCHULDUNG" | "FAHRZEUGKAUF" | "MODERNISIEREN" | "FREIE_VERWENDUNG",
		"finanzierungswunsch": 			{
			"laufzeitInMonaten": Integer,
			"ratenzahlungstermin": "MONATSENDE" | "MONATSMITTE",
			"provisionswunschInProzent": Decimal,
			"kreditbetrag": Decimal,
			"rateMonatlich": Decimal
		},
		"ratenschutz": {
			"versicherteRisikenAntragsteller2": [ "ARBEITSLOSIGKEIT" | "ARBEITSUNFAEHIGKEIT" | "LEBEN" ],
			"versicherteRisikenAntragsteller1": [ "ARBEITSLOSIGKEIT" | "ARBEITSUNFAEHIGKEIT" | "LEBEN" ]
		}
	}

#### Fahrzeugkauf

	{
		"modell": String,
		"marke": String,
		"kaufpreis": Decimal,
		"erstzulassungsdatum": "YYYY-MM-DD",
		"laufleistung": Integer,
		"kw": Integer,
		"beglicheneKosten": Decimal,
		"ps": Integer,
		"anbieter": "HAENDLER" | "PRIVAT"
	}

Fahrzeugkauf wird nur ausgewertet, wenn als Finanzierungszweck "FAHRZEUGKAUF" gesetzt ist.

## Response Format

Die Angaben werden als JSON im Body der Response gesendet.

	{
		"vorgangsnummer": String,
		"messages": [ String ]
	}

In *messages* werden nicht übernommene Angaben und andere Hinweise gesendet.

