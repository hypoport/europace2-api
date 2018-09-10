# KEX-Dokumente-Import-API 

Die Schnittstelle ermöglicht das automatisierte Importieren von Dokumenten in 
einen existierenden  **Kredit**Smart-Vorgang.

## Importieren eines neuen Dokuments

Dokumente können per **HTTP POST** importiert werden.

Die URL ist:

    https://www.europace2.de/kreditsmart/kex/vorgang/{vorgangsnummer}/dokument
    
Die Daten werden als JSON Dokument im Body des POST Requests übermittelt.

Ein erfolgreicher Aufruf resultiert in einer Response mit dem HTTP Statuscode **201 CREATED**.

## Authentifizierung

Für jeden Request ist eine Authentifizierung erforderlich.

Die Authentifizierung erfolgt über einen HTTP Header.

<table>
<tr>
<th>
Request Header Name</th><th>Beschreibung</th>
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
Request Header Name</th><th>Header Value</th>
</tr>
<tr>
<td>Content-Type</td><td>	application/json</td>
</tr>
</table>

## Fehlercodes

Wenn der Request nicht erfolgreich verarbeitet werden konnte, liefert die Schnittstelle einen Fehlercode, auf den die aufrufende Anwendung reagieren kann, zurück.

Achtung: In diesem Fall wird kein Dokument in **Kredit**Smart importiert.

<table>
<tr><th>Fehlercode</th><th>Nachricht</th><th>	Erklärung</th></tr>
<tr><td>400</td><td>Bad Request</td><td>`filename` oder `base64Content` fehlen</td></tr>
<tr><td>401</td><td>Unauthorized</td><td>Authentifizierung ist fehlgeschlagen</td></tr>
<tr><td>403</td><td>Forbidden</td><td>Autorisierung ist fehlgeschlagen</td></tr>
<tr><td>410</td><td>Gone</td><td>Vorgang ist gelöscht</td></tr>
</table>

Weitere Fehlercodes und ihre Bedeutung siehe Wikipedia: [HTTP-Statuscode](https://de.wikipedia.org/wiki/HTTP-Statuscode)

## Request Format

Die Angaben werden als JSON im Body des Requests gesendet.

	{
		"filename": String,
		"base64Content": String
	}

### POST Request Beispiel:

	POST https://www.europace2.de/kreditsmart/kex/vorgang/123456/dokument
	X-Authentication: xxxxxxx
	Content-Type: application/json;charset=utf-8
	{
		"filename": "Test.pdf",
		"base64Content": "JVBERi0xLjMKJcTl8uXrp"
	}
