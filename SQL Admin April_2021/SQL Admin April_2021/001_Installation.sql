

	/*

Installation

Instanzen:

eine Instanz ist komplette eigenständig und autark.
Eig Prozeß, eig Datenbanken, eigener CPU und RAM Bedarf, eig Security, eig Backup
und Wartungsjobs


Servicekonten:
NT Service sind lokale Konten. Windows übernimmt autom. Kennwortänderungen..cool
aber nur per Computerkonto kann auf externe Ressourcen zugegriffen werden

Stattdessen sind auch Domänen(Benutzer)-konten möglichen. 
Keine besondere Rechte vorher zu vergeben

Fragen des Setup

Gemischte oder reine Windows Auth.
Im Fall der gemischten Auth: SA komplexes Kennwort vergeben. 
Der SA hat maximale Rechte
Windows Admins sind nicht mehr autom. SQL Admins

Pfade: Installationspfad der Binädateien: egal ;-)

Log und Daten auf getrennte Laufwerke als goldene Regel
Trenne Lesen von Schreiben

Tempdb eig Datenträger


viele der weiteren Einstellungen des Setup=best practice

Datenträgervolumewartungstask
SQL darf seine Dateien selber vergrößern ohne vorher ausgenullt zu bekommen

MAXDOP = Anzahl der Kerne , max 8
RAM: Gesamt - Grundlast des OS als Empfehlung 4500MB in OS 2300MB) 2200MB
Idee:lass für das OS was übrig

Filestreaming.. Filetables: Dateien per Freigabe hochladen, 
aber per TSQL als Tabelle zur Verfügung














*/




















Security
Dateien undf Optimerung
Monitoring
Edition  Version: 2016 SP1  Std..

Einstieg
Überblick
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









































