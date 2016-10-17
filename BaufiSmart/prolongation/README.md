Prolongation von BaufiSmart Vorgängen
===========

Um einen bestehenden BaufiSmart Vorgang zu prolongieren, muss zunächst ein HTTP POST Request geschickt werden:
 
POST auf https://www.europace2.de/baufiSmart/anschlussfinanzierung/{vorgangId}

```
Response:
200 OK

{
"teilVorgangId":"{teilvorgangId}",
"webUrl":"/baufiSmart/vorgangBearbeiten.html?teilvorgang={teilvorgangId}",
"vorgangsNummer":"{vorgangId}"
}
```

## Fehler
Wenn ein Fehler auftritt, wird die Fehlerseite als Json ausgeliefert.
Mögliche Ursachen können sein:
Der Vorgang ist gesperrt (Statuscode 423),
der Vorgang wurde nicht gefunden (Statuscode 404),
der Vorgang konnte nicht wieder aktiviert werden (Statuscode 502).

## Hinweis
Achtung: Der Vorgang wird für die Prolongation vorbereitet, so dass die Daten entsprechend verändert werden.
Wenn der Vorgang nicht prolongiert werden kann, wird der Datensatz nicht verändert. In diesem Fall wird ein 200 OK und die Json-Response geliefert.
