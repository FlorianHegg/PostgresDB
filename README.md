# PostgresDB Docker Image

Das Image basiert auf der aktuellsten Postgres Version (aktuell 16.1)
https://hub.docker.com/_/postgres


Fertiges Container Image verwenden:
```
docker run -d --name postgresdb -p 5432:5432 ghcr.io/florianhegg/postgres:latest
```

### DB-User

| User | Passwort |
| --- | --- |
| postgres | root |

### Zusammenfassung

Ich habe die Testdaten der Oracle Datenbank angepasst damit sie in Postgres verwendet werden können.
Die Files werden in den Ordner /docker-entrypoint-initdb.d/ kopiert damit sie beim Start des dockers ausgeführt werden.

Die Vereinsdaten werden komplett in die neue Datenbank übertragen. Es ist also möglich alle im Kurs vorhandenen Aufgaben durchzuführen.

Für die Verwendung der Datenbank habe ich mich für eine der beliebtesten Open Source Tools für PostgresSQL entschieden. https://www.pgadmin.org/

