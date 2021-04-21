/* 
Login: Betreten des SQL Servers
User: Rechte in einer DB

Login und User sind zwei getrennt zu betrachtende Dinge

Innerhalb der DB:

Schema entspricht Ordner
Rollen entspricht Gruppen


Auf Schemas können Rechte vergeben werden wie etwa Select 
damit kann der Benutzer alles Lesen , was innerhalb des Schemas liegt
*/
USE [master]
GO
CREATE LOGIN [Hans] WITH PASSWORD=N'123', 
DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO



USE [Northwind]
GO
CREATE USER [Hans] FOR LOGIN [Hans]
GO


select * from syslogins
select * from sysusers

---weiteres Login für Susi

--Schema wie Ordner

USE [Northwind]
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO

CREATE SCHEMA [MA] AUTHORIZATION [dbo]
GO

use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [Hans]
GO

GRANT SELECT ON SCHEMA::[MA] TO [Susi]


--als Admin:  Error
--Standardschema.. default dbo 

select * from kst

select * from dbo.kst


USE [Northwind]
GO
ALTER USER [Hans] WITH DEFAULT_SCHEMA=[IT]
GO
ALTER USER [SUSI] WITH DEFAULT_SCHEMA=[MA]
GO



/*
natürlich kann auch auf ein einzelnes Objekt ein recht gesetzt werden
*/
use [Northwind]
GO
GRANT SELECT ON [IT].[personal] TO [Susi]
GO

--Vererbte rechte sieht man nicht....Effektive anschauen
/*

Objekte anzulegen bedarf mehrere Rechte:

Recht auf DB: wie tabelle erstellen
und
Recht im Schema das recht ausüben zu dürfen.. wie ALTER
*/

use [Northwind]
GO
GRANT CREATE TABLE TO [Susi]
GO
use [Northwind]
GO
GRANT ALTER ON SCHEMA::[MA] TO [Susi]
GO


DML I U D
DDL CREATE ALTER DROP

/*
Günstigerweise arbeitet man besser mit Rollen
damit wird die Verwatung deutlich einfacher..

Rechte werden dann auf Rollen vergeben, anstatt auf user

*/
USE [Northwind]
GO
CREATE ROLE [ITRolle] AUTHORIZATION [dbo]
GO
USE [Northwind]
GO
ALTER ROLE [ITRolle] ADD MEMBER [Hans]
GO




/*Serverrollen
eigenen sich dazu best Personen Administrationsrechte zu geben...

entweder verwendet man die vorgegebenen Serverrollen
oder man macht eig. Der Vorteil von selbsterstellten Serverrollen ist der, dass man die Rechte einzelen 
konfigurieren kann und nicht gleich zB alle Sicherheitsrechte bekommt..

*/

USE [master]
GO

/****** Object:  ServerRole [KursDBSecurityRolle]    Script Date: 24.02.2021 10:56:54 ******/
CREATE SERVER ROLE [FirstLevelSupport]
GO

ALTER SERVER ROLE [FirstLevelSupport] ADD MEMBER [Klaus]


GRANT ALTER ON LOGIN::[Peter] TO [FirstLevelSupport]

GO





/*

Besitzverkettung

Sichten?
max darf unter it.* lesen

Sichten verhalten sich doch wie Tabellen....

*/

select * from it.kst --darf Max

select * from ma.mitarbeiter --darf max nicht

--max macht folgendes.. die rechte dazu het er bekommen

create view it.mamit
as
select * from ma.mitarbeiter
GO


select * from it.mamit
--klappt


--Nur bei Besitzverkettung funktioniert das,
--dass ein Benutzer Daten lesen kann obwohl er 
--keine rechte auf eigtl Objekt besitzt

--Das ist durchaus sehr nützlich, da man sonst alle Verweise untersuchen

--dbo  dbo    dbo   dbo dbo   dbo
--V5-->v4--->v3-->v2---V1--->T

--SQL Server kontrolliert nur das aufgerufene Objekt
--Aber gebe nie einem User das 
--Recht Sichten, 
--Prozeduren oder 
--Funktionen anlegen zu dürfen


--jeder in der Serverrrolle sysadmin ist in jeder DB auch zugleich der dbo




