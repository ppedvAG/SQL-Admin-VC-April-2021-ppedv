/*
Indizes

ähnlich einem Verzeichnis in einem Buch


3 Sorten 
Gruppierter IX - Clustered
Nicht gruppierter IX  - non cl IX

Columnstore IX (PowerPivot) eigtl Ent Feature bis: 
--SQL 2016 STD mit Sp1
--Wunderindex


Indizes machen Abfragen deutlich schneller
aber evtl langsamer :-(
und sind für vieles verantwortlich: 
	Niveau der Sperren
	Anzahl HDD Zgriffe
	RAM Auslastung
	CPU Verbrauch

----Nicht gruppierter IX..

1) neue Tabelle: HEAP
	null Ahnung wo ein DS sein soll
	Suchvorgang,der alles durchsuchen muss : SCAN
	SCAN , .. sollte aber schneller gehen (SEEK)
	
2) Anlegen eines nicht gr auf eine best Spalte (where)
	wie Telefonbuch
	es wird eine Kopie der Daten in Sort Form erzeugt
	Eine Art Baumstruktur findet sehr schnell den Datensatz und
	kann mit Hilfe mit Sprungadresse: 1:205:03 (datei1:Seite:Slot)
	zum eigtl Datensatz im Heap springen
3) Jede Suche, die der IX nicht beantowrten kann muss eine
	Nachschlagevorgang auslösen (lookup)
	das würde man gerne vermeiden-- IX Optimierung

Gruppierter IX

1) HEAP ..unsortierter Sauhaufen an Daten
2) CL IX--Daten werden sortiert neu abegelegt (nach Spalte)
3) Auf die Daten eine Art Baumstruktur
4) CL ist die tabelle in sortierter Form Jede Suche führt zum Datensatz
	es gibt keinen Lookup Vorgang
   Aber! CL IX kann es nur einmal geben pro Tabelle


CL IX besonders gut bei Bereichsabfrage
where mit <  between  = like A%
nur 1 mal pro Tabelle

NCL IX ist gut rel geringer Ergebnismenge
zB: ID PK  (1% 10%)
ca 1000 mal pro tabelle

Vorsicht: PK macht gerne ID Spalten zu CL IX
was oft eine große Verschwendung darstellt...

--SCAN!   SEEK
--warum: der PK!!!!
--nie wieder gute Seek Abfragen auf GebDAt oder PLZ

--PK muss aber kein CL IX sein


--nur die IX, die man wirklich braucht!!
--alle die man nie verwendet od überflüsssig kosten Performance
*/

select * into o1 from orders


select * from o1

--PKT1: Such dir die Spalte aus, auf die ein CL IX gelegt werden soll

--Orderdate

--Suche nach Stadt: nur noch NCL IX

--Wie finde ich überflüssige IX und fehlnde IX raus..?


--DMVs.. Data management Views

select * from sys.dm_db_index_usage_stats
--Was ist besser? SCAN oder SEEK

--O = HEAP
--1 = CL IX
-- über 1 = N CL IX

*/

/*
INDIZES müssen gewartet werden


über 30 % dann Rebuild --kompletter Baum wird verdichtet 
über 10 % dann wird Reorg -- nur der Teil mit den Sprungadressen wird verdichtet
unter 10% nichts tun 

--Tool für Wartung: Wartungsplan.. aber erst ab SQL 2016 brauchbar

----Unter SQL 2016: Tipp Ola Hallengren mal suchen
--- Maintenance Plan.. Script zur Wartung von DBs
---sehr einfach im Umgang















*/