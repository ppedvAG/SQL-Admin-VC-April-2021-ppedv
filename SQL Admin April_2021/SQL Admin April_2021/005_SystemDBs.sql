select * from sysdatabases
select * from sysfiles

/* TDE --Dateien
master
	Konfig. des SQL Server
	Databases
	Logins

	Muss man die master sichern? ... Ja 

model
  Vorlage f�r neue DB
  create database testdb
  --- Wiederherstellungsmodel

  Muss man die Model sichern? 
  --wenn sie ge�ndert wurden...
	Einstellungen oder Tabellen

msdb..f�r den Agent  !!!
	speichert Jobs, Zeitpl�ne, Wartungspl�ne, Emailsystem

	Muss man die msdb sichern? ..jupp....auf jeden Fall



tempdb..mag nur schnell sein
  Zeilenversionen
  #tab ##tab.. tempor�re Tabellen-- Developer
  pro Instanz nur eine!
  IX Wartung
  Auslagerungsdaten

  Muss die tempdb gesichert werden? Neee geht gar nicht

 evtl distribution , bei Replikation

Fazit...mach jeden Tag einen Sicherung mind... 


Wartungsplan

t�glich... einmal pro Tag.. ausser Wochenende
alle SystemDBs
Backupverzeichnis mit Unterverzeichnis pro DB
Kompression, Pr�fsumme, Integrit�t, bei Fehler fortsetzen
Bericht entweder Logfile (Agent braucht Schreibrechte auf Ordner)
oder per Email (..muss erst eingerichtet werden...)







*/