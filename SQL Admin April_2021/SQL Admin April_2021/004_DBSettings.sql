create database testdbx


/*
viele Fehler

Db besteht aus: Logdatei und Datendatei 
.mdf master data file
.ldf Log Data file


Initalgröße 8 MB pro Datei 
64 MB Wachstum

SQL 2014: 5MB Daten 2 MB Log... 1MB Daten Wachstum  10% Logfile


Ziel: Wachstum vermeiden


Wie lange lebt die Db auf dem Server?  3 Jahre
Um wieviel wächst die DB pro Monat?     1 GB

Backup: sichert nur Daten weg...und komprimiert
Fragmentiert nicht mehr

Wachstumrate anpassen auf "gemütlicher" Wert: 1 GB 

Faustregel: Logifle 1/4 der Datendateien
*/

CREATE DATABASE [testdb3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'testdb3', FILENAME = N'D:\_SQLDB\testdb3.mdf' , SIZE = 102400KB , FILEGROWTH = 102400KB )
 LOG ON 
( NAME = N'testdb3_log', FILENAME = N'D:\_SQLDB\testdb3_log.ldf' , SIZE = 30720KB , FILEGROWTH = 65536KB )
GO










*/ 



























