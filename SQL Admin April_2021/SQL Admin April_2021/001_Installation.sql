

	/*

Installation

Instanzen:

eine Instanz ist komplette eigenst�ndig und autark.
Eig Proze�, eig Datenbanken, eigener CPU und RAM Bedarf, eig Security, eig Backup
und Wartungsjobs


Servicekonten:
NT Service sind lokale Konten. Windows �bernimmt autom. Kennwort�nderungen..cool
aber nur per Computerkonto kann auf externe Ressourcen zugegriffen werden

Stattdessen sind auch Dom�nen(Benutzer)-konten m�glichen. 
Keine besondere Rechte vorher zu vergeben

Fragen des Setup

Gemischte oder reine Windows Auth.
Im Fall der gemischten Auth: SA komplexes Kennwort vergeben. 
Der SA hat maximale Rechte
Windows Admins sind nicht mehr autom. SQL Admins

Pfade: Installationspfad der Bin�dateien: egal ;-)

Log und Daten auf getrennte Laufwerke als goldene Regel
Trenne Lesen von Schreiben

Tempdb eig Datentr�ger


viele der weiteren Einstellungen des Setup=best practice

Datentr�gervolumewartungstask
SQL darf seine Dateien selber vergr��ern ohne vorher ausgenullt zu bekommen

MAXDOP = Anzahl der Kerne , max 8
RAM: Gesamt - Grundlast des OS als Empfehlung 4500MB in OS 2300MB) 2200MB
Idee:lass f�r das OS was �brig

Filestreaming.. Filetables: Dateien per Freigabe hochladen, 
aber per TSQL als Tabelle zur Verf�gung














*/




















Security
Dateien undf Optimerung
Monitoring
Edition  Version: 2016 SP1  Std..

Einstieg
�berblick
Monitoring (TSQL Statements)

Installation
Verschieben von SQL Server / DB auf and. SQL Server
Backup/Restore
OnPrem Azure
Vokabeltraining

2014 


SQL Express SQL 2016 Sp1 0 Euro
kein Agent

App legt SQL lahm...









































