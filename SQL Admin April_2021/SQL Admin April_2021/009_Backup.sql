/* BACKUP

F�lle:

Hardware defekt
 --CPU/Mainboard aber HDD ok
 --HDD defekt, der Rest in Ordnung

 DB defekt

 DB ok.. aber Daten verf�lscht oder gel�scht (alle in Berlin)

 Wenn ich weiss, dass gleich was passieren kann
 zB SP einspielen.. mach vorher eine Sicherung


 Wovon h�ngt unserer Sicherungstrategie eigtl ab

 Vorgaben:
 Max Ausfallzeit des Servers/DB
 Datenverlust in Zeit

 Infos:
 Wie gro� ist die DB und wieviel Traffic


 Wohin? 
 lokal/Netzwerk
 und wie: 
 eine Sicherung oder viele Sicherung

 
 Sicherungsvarianten

 Vollsicherung				V
 Differentielle Sicherung   D
 TLogfilesicherung			T

 Wiederherstellungsmodel
 Vollst�ndig
 Massenprotokolliert
 Einfach

 Jede neue DB hat per default Vollst Wiederhestellungsmodel


 Einfach
 -------------------------------
 TX!  TX!  TX!
 -------------------------------
 l�scht best. bzw beendete TX aus dem Logfile
 kein Restore vom Logfile
 kein Backup des Logfile
 INS UP DEL  BULK INSERT SELECT INTO 
 
 verwendet man gerne bei: Tagesgenaue Sicherung, TestDb


 Massenprotokolliert
 INS UP DEL  BULK INSERT SELECT INTO nur rudiment�r (kennt nicht die betroff Datens�tze)
 l�scht keine TX automatisch
 --------------------------
 TX TX TX TX TX TX TX! TX! TX! 
 --------------------------
 ..wird das Logfile wachsen
 man muss das Tlog sichern --- leert das Logfile

 --------------------------
                   TX! TX! TX! 
 --------------------------

 -- TLOG.BAK TX TX TX TX TX TX
 k�nnte theoretisch auf Sekunden restoren, aber nur wenn kein BULK stattfand
 sonst nur der zeitpunkt der Sicherung restorebar



 Vollst�ndige Model

 wie bei Massenprotokoll... aber Massenoperatoionen werden ausf�hrlich protokolliert
 das Log w�chst st�rker
 man muss Logfile sichern

 man kann auf Sekunde restoren...


 ProduktivDbs haben meist Vollst Model


! !V
	T
	XXXXT
	T
D	
	T
	T
	T
D	
	!T
	!T
	!T
	D



 Vollsicherung
 sichert die Dateien weg inkl Pfade (aber ohne "Luft")
 Checkpoint  alle INS UP und DEL Daten werden aus dem Log in die MDF �bertragen
 und k�rzt das Log nicht!!!
 

 Diff
 sichert alle Seiten weg, die sich seit dem letzten V ge�ndert haben
 immer wieder zwischen den Ts einstreuen
 damit der Restore k�rzer und sicherer wird


 TSicherung
  wie ein Makro.. wird alle Statements wieder ausf�hren seit der letzte V oder D Sicherung
  Datenverlust in Zeit regelt die Intervalle der TSicherung

  Was ist der schnellste Restore ? V
  so oft wie m�glich V

  Wie schnell ist der Restore eines T?
  solange wie die TX dauerten , die im T stecken
  Konsequenz: nie viele T restoren m�ssen



  Medium: das BackupDing (Datei, Band), kann mehr Sicherugen enthalten
  Mediensatz : eine Sicherung in ein Medium

 */

--VOll
 BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' 
	WITH NOFORMAT, NOINIT,  
	NAME = N'Northwind-Vollst�ndig', 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Diff
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak'
WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  
NAME = N'Northwind-Diff', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Tlog
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' 
	WITH NOFORMAT, NOINIT,  NAME = N'Northwind-Tlog', 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

-- V TTT D TTT D TTT.. typischer Verlauf





--F�LLE
/*


Hardware defekt
 --CPU/Mainboard aber HDD ok
 --HDD defekt, der Rest in Ordnung

 DB defekt

 DB ok.. aber Daten verf�lscht oder gel�scht (alle in Berlin)
 DB unter anderen Namen restoren



 ohohoh... um 11:23 hab ich versehentlich Daten gel�scht

 Wenn ich weiss, dass gleich was passieren kann
 zB SP einspielen.. mach vorher eine Sicherung


 Wovon h�ngt unserer Sicherungstrategie eigtl ab


Aktuell: 11:55
Meldung: 11:23 Daten verf�lscht
Restore von 11:22
Backup Log bis 11:55


--1100--------1122------1123!------------------1155--------------------
TX TX TX XT XT TX       !TX TX                    TX TX TX           TX

 ! Achtung: es darf oder muss so gut es geht kein Datenverlust entstehen
 Trick: Backup Log von 11:55

 1) Backup Log von 11:55  ist online dauert 10min..Datenverlust: 10min
    User kicken....! von DB trennen
 2) Restore von 11:22



 DB auf Server 1.. Backup ist leider von 10.4
 Server ist ein Haufen Asche.... aber die HDDs sind da.. inkl der Dateien



 DB anf�gen

 1. mdf Datei...und auch das ldf.. jedes Backup ist �lter
 2. wenn ein ldf fehlt, dann ldf entfernen.. weil evtl ein Checkpoint noch nicht 
 alle Daten wegschrieb, kann es zu Dverlust gekommen
 3. Was wenn die mdf Datei weg w�re.... "bl�de Situation".. kaputt

 
 Was w�re, wenn wir w�ssten, dass etwas passiert.. SP CU SU



 DBXY 1000MB (90% voll)

 Sicherung als: DBXY_1410 lauff�hige lesbare DB
 diese DB wird immer nur die Daten von 14:10 haben

 ohohoh.. auf C: ist leider nur noch 500MB frei.. geht!
                                      50MB frei.. geht!
									  5 MB geht!

									  dennoch wir eine Datei mit 1000MB angelegt
									  nur 128kb


--SNAPSHOT
*/

-- =============================================
-- Create Database Snapshot Template
-- =============================================
USE master
GO

-- Create the database snapshot
CREATE DATABASE SN_Nwind_1420 ON
( NAME = Northwind, --logische Name der Datei der OrigDB
FILENAME = 'D:\_SQLDB\SN_Nwind_1420.mdf' )--Pfad zur neuen Datei der SN DB
AS SNAPSHOT OF Northwind;
GO

---kann man mehrere SN machen?
-- JA

--kann man den SN sichern?
--nein

--kann man die Orig DB sichern?
--Ja klar..

--kann man den SN restoren?
--??? n����

--kann man die OrigDB normal restoren?
--leider nein, ausser alle SN wurden vorher gel�scht

--SN macht auf Dauer keinen Sinn

--kann man den SN zum Restoren verwenden
use master

restore database northwind 
from database_snapshot = 'SN_Nwind_1420'

---es darf keiner auf der origDb und auf den SN sein..
--Aktivit�tsmonitor.. Eigenschaften des Servers
select db_id('SN_nwind_1420')
select * from sys.sysprocesses where dbid in(5,9)

kill 82


--Sicherungsstrategie:
--DB: 200GB
--Max Ausfallzeit: 10 Minuten
--Max Datenverlust in Zeit: 0min

Hochverf�gbarkeit



--Arbeitszeit: Mo bis Fr
--              7 Uhr bis 18 Uhr

/*
V.. 20min   Mo bis Fr t�glich um 19 Uhr
D.. alle 4 Ts (alle 20min) ein D  t�glich Mo bis Fr ab 7:23 alle 20 min bis 17:45
T.. alle 5 min  Mo bis Fr t�glich ab 7:05 -- 18:05





*/




















 */