/*
Agent und Jobs

Auftr�ge habne Zeitpl�ne
Auftr�ge haben einen oder auch mehrere Schritte


Zeitpl�nen k�nnne regelm��ig stattfinden

Tipp: einmalzeitplan zum Testen, wenn der um 16 Uhr klappt, dann klappts auch um 02:39 
		in der nacht

Schritte k�nnen einen logischen Ablauf haben: Schritt 1 bei Fehler gleich zu Schritt 3 zB



---Feature: Wenn Job getan , dann Nachricht an uns
-- H�tten auch gerne dann Nachrichten, wenn es dem SQL Server nicht gut geht...


Agent ist zust�ndig f�r Nachrichten


..Wenn es dem SQL Server nicht gut geht






*/

select * from Bernet --Meldung 208, Ebene 16

select from bernet  --Meldung 156, Ebene 1


--Ebene 15: DAU Fehler.. der User ist Schuld
--Ebene 16: DAU Fehler.. der User ist Schuld
--Ebene 14: Security.. er hat kein Recht drauf
--Ebene 12: DAU ...

--Ebenen bis 10 Inkl. sind keine fehler sondern Infos
--Ebenen von 11 bis 16 inklusive ist in der Regel der Anwender Schuld
--Ebene 17 und aufw�rts.. ohje... wird immer schlimmer
--Bei Ebene 25 (Todesurteil)


--die fehlernummern kommen aus dem hier:

select * from sysmessages where msglangid = 1031

--SQL Server ist ein Mail Client.. braucht einen SMTP Server
--

--eigenen SMTP Server: Server Manager 
	--Feature SMTP Server hinzuf�gen

-- IM IIS 6 Manager eine neue Maildom�ne anlegen
--   sql.local..neue Alias Dom�ne
--Eigenschaften des SMTP Server: 
--	Zugriff: relay: 127.0.0.1 gestatten 



--SQL Server muss noch wissen, wie er Emails verschicken soll...

--DatenbankEmail aktivieren... Profil einrichten (einfachen Namen vergeben)

--SMTP Konto angeben... Systemparameter zb auf 10MB anpassen..

exec msdb..sp_Send_dbmail @query='select * from orders' ,@recipients




