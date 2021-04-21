/*
Instanzfunktion
..kann man mehrfach installieren
DB Modul, SSAS, SSIS, ML, SSRS

STD Instanz:  Port: 1433
localhost
(local)
127.0.0.1
----so ist es besser
PC25
192.168.100.17

benannte Instanz
mit SQL Browser Dienst kein Angabe des Ports notwendig

PC25\Instanzname
127.0.0.1\Instanzname

Port: Random(dynamisch).. ist fest einstellbar im SSKM (Schminkkoffer)


Freigegebene Funktion
..nur einmal installieren


--DB Modul (Replikation, Volltextsuche)

Pfade
Programmdateien: c:\programme...

DB Dateien: idR 2 Dateien (mdf / ldf)
Trenne Log und Daten physikalisch (HDDS) pro DB

TempDB: gib der TempDB eig HDDs (log/daten)..
	soviele Daten-Dateien wie Kerne max 8

Backup


Konten
SQL Server        NT Service\MSSQLSERVER
SQL Agent (Jobs)   

NT Service Konten: Lokale Konten (Computerkonto) ..autom. Kennwortänderung
DomänenUser: svcSQL


Authentifizierung:
Gemischt (NT + SQL)
SA ist aktiv-- komplexes kennwort
rein Windows

alle NT Adsmins sind nicht mehr SQL Admin per default

seit 2019: Arbeitsspeicher: Max Ram-- Gesamter Ram - OS
MAXDOP: alle kerne, aber max 8   (früher 0)

Filestreaming:   \\PC25\FE\DB\Ftables

Volumewartungstask: Ausnullen vermeiden... Sicherheitsgrund
-- ein guter Admin sagt: das ist mir wurscht!!
--weil ein guter Admin die Größen der DB überwacht und proaktiv einstellt


--2te Instanz auf HV SQL2
Funktionen: DB Modul+ Replikation+Volltext
Name der Inst: HR 
Achte auf PFade: C:\_INSTDB  C:\_INSTBACKUP
Auth : gemischte Auth.. wir sind Admins.. SA mit Kennwort ppedv2019!
Dienstkonten: schulung\svcSQL (DBModul) schulung\sqlAgent (Agent)
Filestreaming: egal
Volumewartungstask: aktivieren
--best practice Gedanke...
*/
select * from sys.sysservers

select * from sys.dm_os_host_info
select * from sys.dm_os_sys_info


--TempDB verschieben
ALTER DATABASE database_name 
MODIFY FILE ( NAME = logical_name , FILENAME = 'new_path\os_file_name' )

--bspw :
USE master
GO
ALTER DATABASE tempdb MODIFY FILE (NAME = tempdev, FILENAME = 'H:\Daten\tempdb.mdf')
GO
ALTER DATABASE tempdb MODIFY FILE (NAME = templog, FILENAME = 'H:\Daten\templog.ldf')
GO





























































*/