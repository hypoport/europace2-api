# KEX-Antragsstatus-API

Die Statuswechsel API für **Kredit**Smart-Anträge ist unter folgender URL erreichbar:

```
https://www.europace2.de/kreditsmart/kex/antraege/status
```

## Statuswechsel

Diese Schnittstelle ermöglicht es, den Status eines Antrags zu verändern oder den aktuellen Status um Zusatzinformationen zu ergänzen. Der Service erwartet einen `POST`-Request mit einem JSON-Dokument als Request-Body.

Folgende Properties stehen für den Request-Body zur Verfügung:

Request Parameter            | Beschreibung | Anmerkungen
-----------------------------|--------------|-------
teilantragsnummer            | Kennung des Antrags auf der Europace2-Plattform | Pflichtangabe sofern keine  **produktanbieterantragsnummer** übermittelt wird.
produktanbieterantragsnummer | Kennung des Antrags beim zuständigen Produktanbieter | Pflichtangabe sofern keine **teilantragsnummer** übermittelt wird.
produktanbieterstatus        | Status des Antrags beim Produktanbieter | Optional. Erlaubte Werte sind: <ul><li><code>NICHT_BEARBEITET</code></li><li><code>UNTERSCHRIEBEN</code></li><li><code>ABGELEHNT</code></li><li><code>ZURUECKGESTELLT</code></li></ul>
antragstellerstatus          | Status des Antrags beim Antragsteller | Optional. Erlaubte Werte sind: <ul><li><code>BEANTRAGT</code></li><li><code>UNTERSCHRIEBEN</code></li><li><code>NICHT_ANGENOMMEN</code></li><li><code>WIDERRUFEN</code></li></ul>
kommentar                    | Kommentar zur Anzeige in der Benutzeroberfläche | Optional
hinweise                     | Liste von Hinweistexten zur Anzeige in der Benutzeroberfläche | Optional

Die Authentifizierung erfolgt über einen per HTTP-Header übermittelten JWT-Voucher. Dieser muss berechtigt sein, den betroffenen Antrag zu modifizieren. Einen solchen JWT-Voucher bekommen Schnittstellenpartner von uns ausgestellt.

Folgende HTTP-Header werden erwartet:

Header Parameter | Beschreibung                                               | Anmerkungen
-----------------|------------------------------------------------------------|-------------
X-Authentication | JWT-Voucher mit Zugriffsrechten auf den betroffenen Antrag |
Content-Type     | Content Type des Request Bodies                            | Muss derzeit immer `application/json` sein

Im Erfolgsfall gibt die Schnittstelle HTTP-Status `200` zurück.

### Beispiele

Die hier gezeigten Beispiele können zum Testen per `curl` auf folgende Art nachvollzogen werden:

```sh
curl -v -XPOST https://www.europace2.de/kreditsmart/kex/antraege/status \
	-H 'Accept: application/json' \
	-H 'Content-Type: application/json' \
	-H "X-Authentication: ${JWT_VOUCHER}" \
	-d "${REQUEST_BODY}"
```

#### Produktanbieterstatuswechsel mit Produktanbieterantragsnummer

Der Produktanbieterstatus für einen Antrag mit der Produktanbieterantragsnummer `12919351` kann mit folgendem Request-Body auf `UNTERSCHRIEBEN` gesetzt werden:

```json
{
  "produktanbieterantragsnummer": "12919351",
  "produktanbieterstatus": "UNTERSCHRIEBEN"
}
```

#### Produktanbieterstatuswechsel mit Teilantragsnummer

Alternativ kann statt der Produktanbieterantragsnummer auch die Teilantragsnummer übergeben werden:

```json
{
  "teilantragsnummer": "985132/1/1",
  "produktanbieterstatus": "UNTERSCHRIEBEN"
}
```

#### Statuswechsel mit Kommentar

Der Statuswechsel kann darüber hinaus mit einem Kommentar versehen werden, der den Anwendern von **Kredit**Smart zusätzlich zum eigentlichen Statuswechsel angezeigt wird:

```json
{
  "produktanbieterantragsnummer": "12919351",
  "produktanbieterstatus": "ZURUECKGESTELLT",
  "kommentar": "Bitte noch eine Kopie des Personalausweises nachreichen."
}
```

Sollte der Produktanbieterstatus schon dem aktuellen Status entsprechen, wird der Kommentar dennoch dem Antrag hinzugefügt.

#### Statuswechsel mit Kommentar und Hinweistexten

Es ist außerdem möglich, eine Liste von Hinweistexten hinzuzufügen, welche dann in **Kredit**Smart entsprechend dargestellt wird.

```json
{
  "produktanbieterantragsnummer": "12919351",
  "produktanbieterstatus": "ZURUECKGESTELLT",
  "kommentar": "Bitte reichen Sie noch folgende Dokumente nach:",
  "hinweise": [
  	"Personalausweis",
  	"Geburtsurkunde"
  ]
}
```

#### Antragstellerstatuswechsel

Der Antragstellerstatuswechsel verhält sich analog zum Produktanbieterstatus:

```json
{
  "produktanbieterantragsnummer": "12919351",
  "antragstellerstatus": "UNTERSCHRIEBEN"
}
```

#### Gleichzeitiger Wechsel von Produktanbieter- und Antragstellerstatus

Bei Bedarf können auch beide Status gleichzeitig geändert werden:

```json
{
  "produktanbieterantragsnummer": "12919351",
  "produktanbieterstatus": "UNTERSCHRIEBEN",
  "antragstellerstatus": "UNTERSCHRIEBEN"
}
```
