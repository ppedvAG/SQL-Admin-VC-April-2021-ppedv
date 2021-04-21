drop database  if exists rowlevel
GO
create database rowlevel

Use RowLevel
GO

CREATE USER Manager WITHOUT LOGIN;  
CREATE USER Sales1 WITHOUT LOGIN;  
CREATE USER Sales2 WITHOUT LOGIN;  

CREATE TABLE Sales3 
    (  
    OrderID int,  
    SalesRep sysname,  
    Product varchar(10),  
    Qty int  
    );  
GO

INSERT Sales3 VALUES   
(1, 'Sales1', 'Valve', 5),   
(2, 'Sales1', 'Wheel', 2),   
(3, 'Sales1', 'Valve', 4),  
(4, 'Sales2', 'Bracket', 2),   
(5, 'Sales2', 'Wheel', 5),   
(6, 'Sales2', 'Seat', 5);  
GO


-- View the 6 rows in the table  
SELECT * FROM Sales3;  
GO

CREATE SCHEMA Security;  
GO  

--Funktion gibt nur 1 oder 0 zurück.. 1 = ich darf
  
CREATE FUNCTION Security.fn_securitypredicate(@SalesRep AS sysname)  
    RETURNS TABLE  
WITH SCHEMABINDING  
AS  
    RETURN SELECT 1 AS fn_securitypredicate_result   
		WHERE 
				@SalesRep = USER_NAME() OR 
				USER_NAME() = 'Manager';  

--angemeldeten User auslesen... vergleich mit F() und Tabellenwert--> 1 oder 0


--Richtlinie für F() auf Tabelle legen
CREATE SECURITY POLICY SalesFilter3  
ADD FILTER PREDICATE Security.fn_securitypredicate(SalesRep)   
ON dbo.Sales3  
WITH (STATE = On);  


--USer ohne Login für Test

GRANT SELECT ON Sales3 TO Manager;  
GRANT SELECT ON Sales3 TO Sales1;  
GRANT SELECT ON Sales3 TO Sales2;  


EXECUTE AS USER = 'Sales1';  
SELECT * FROM Sales3;   
REVERT;  
  
EXECUTE AS USER = 'Sales2';  
SELECT * FROM Sales3;   
REVERT;  
  
EXECUTE AS USER = 'Manager';  
SELECT * FROM Sales3;   
REVERT;  

ALTER SECURITY POLICY SalesFilter3
WITH (STATE = OFF);  

--------------