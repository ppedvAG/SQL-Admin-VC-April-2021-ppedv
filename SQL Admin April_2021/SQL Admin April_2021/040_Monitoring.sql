--Monitoring

--TaskManager (Windows)
--evtl Prozesse, die nicht da sein sollten
--AV Software
--SQL Server muss nicht der Schuldige sein
--im Taskmanager versteckt sich auch der Zugriff auf den Ressourcenmonitor
-- der eine noch genauere Übersicht liefert

--Aktivitätsmonitor (sysprocesses)
--der Taskmanager des SQL Server
--alle Prozesse über 50 sind Prozesse der User
--live Ansicht.. hsitorische Werte hier nicht erkennbar
--man findet hier auch auf folgendes:
-- Warteressourcen der letzte Sekunde
--Top Abfragen nach Ressourcenverbrauch
--Sperren

--Evtl muss aber aufgezeichnet werden:
--Profiler (TSQL Statements aufzeichnen)
--Perfom (grafische Analyse von Leistungsindikatoren (Windows auch SQLS erver)

--!! Profiler ist abgekündigt.. Ersatz XEvents.. 

--deutlich genauer und effektiver (spez bei Abfragen)
--Enpässe eruiren. Fortgeschrittenes Thema eher


--Zur Analyse immer auch DMVs. So gut wie alle Auswertungen, Berichte etc im SSMS
--werden durch DMVs erstellt.

--DMV der letzte Schliff der Analyse
--sys.dm_db... Infos aus der DB
--sys.dm_os- ... Infos aus SQL Server


--vereinfachtes Vorgehen bei Fehlersuche
/*
1. Taskmanager, Ressourcenmonitor
2. Live-Problem (a) oder Problem bereits wieder verschwunden (b)

--Live
2 (a) DMVs, Ressourcemonitor, Aktivitätsmonitor, evtl Profiler
--Aufzeichnung
2 (b) XVents, Profiler, DMVs, Perfmon









select * from sys.dm_os_wait_Stats

select * from sys.dm_os_

--server hat viele DMVs zum Messen,
--Aber nach Neustart werden die Messdaten auf NULL zurückgesetzte


--für IX Strategie: eine Sammlung aller Abfragen auf der DB
--repr. Querschnitt

--IX bschleunigen Abfragen
-- machen auch Abfragen langsamer (INS UP DEL)

--wenn kein pass oder fehlender IX...
Begin tran
update tabelle set sp = 1 where ID = 10 --SCAN

--bei SEEK wird nur die Zeile gesperrt

commit

--wartet
select * from tabelle where ID = 19


--wenn man SCAN dann werden mehr Seiten gelesen
--alle Seiten, die wir lesen, kommen 1:1 in RAM


--DMV 
select * from sys.dm_db_
--Werte werden auf NULL restet nach Neustart

select * into IXVerwendung from sys.dm_db_index_usage_stats


--Tools: 
--Aktivitätsmonitor



