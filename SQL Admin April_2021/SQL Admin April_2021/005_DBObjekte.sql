/*
DB Design: 

Beziehungen 1:n.. ein PK Wert kann nur gel�scht werden, wenn kein nfacher Wert mewhr als FK exisitiert
PK Eindeutigkeit eines DS -- Fremdschl�ssel

Normalisierung
Idee : Redundanz vermeiden

1.NF.. atomar: jede Zelle hat nur einen Wert.. super!!
2:NF.. jeder DS hat einen PK
3.NF ..alle Werte ausserhalb des PK haben keine direkte relation mehr

Redundanz ist schnell
Normalisierung ist vern�nftig macht aber langsam

Datentypen

"TEXT" -- OTTO ..maximale L�nge = 8000  oder 2 GB
nvarchar(max).. 2GB
nvarchar(40)     max 40 Zeichen, aber UNICODE    'otto'   4 * 2   8
varchar(40)     ..max 40 Zeichen..... 'otto'					  4 
nchar(40)       ..max 40...  'otto         '       40*2          80
char(40)        -- hat 40 Zeichen .. 'Otto                   '   40 


Merke: die Daten werden von HDD 1zu1 in RAM abgelegt


Datum

date  time
datetime auf ms genau .. nur dann wenn auch zu Datum Zeit wichtig ist
datetime2 auf ns genau
datetimeoffset.. auf ms genau plus Zeitzone
smalldatetime auf Sek

GebDatum auf ms???



Sichten:
Eine benannte Abfrage kann wie eine Tabelle verwendet werden
Sichten verahlten sich wie Tabellen
also auch: Sortieren, DEL, INS, UP.. nur nicht immer...
auch Security Gr�nden.. rechte vergabe wie auf Tabellen

Sicht enth�lt null Daten

create view vname
as
select * from tabelle..

*/


--Kompilierund Analysephase
select * from KundeEinkaufUK --alle Kunden aus UK und was sie gekauft haben

--im Prinzip dassselbe
select * from (select * from orders) o

--Einsatzort der Sicht:
--bestimmte Dinge ausblenden und vor allem komplexe statements nur einmal schreiben m�ssen


--Prozedur

create procedure gpdemo @Land varchar(50) --Parameter m�ssen nicht sein
as
select * from customers where country like @Land
--INSERT
--UPDATE
--DELETE
GO


--Prozedur wird im Gegnsatz zur Sicht "ausgef�hrt"

exec gpdemo 'UK'

--Einsatz: Proz enth�lt kein Daten, aber evtl Paramwter
--         zahlreichen verschied. SQL Anweisungen bestehen
--         also eher im Sinne einer Batchanweisung


--Function

create function fdemo(@par int) returns table
as
begin
return (select * from....)
end


select * from dbo.fdemo(125)

--Welches ist das schnellste und welches das langsamste

--a) adhoc 
--b) Sicht
--c) Proz
--d) F()

----langsam----------------------------------schnell----
--   Sicht/adhoc  	proz           		f()

--Realit�t
--f()-----------------Sicht/adhoc------------proz

--wenn es bl�d l�uft

--Proz-------f() ---adhoc/sicht

--Vorteil der Prz ist, dass der Plan einmal generiert wird und dann immer zur Verf�gung steht


select * from kunden where name like 'mai%'

select * from kunden where left(name,3) = 'mai' ---..jede Zeil durchgehen, F() werden nie mehr als 1 CPUs


















--Diagramm


select * from northwind..customers

M�nchen 8000

M�nchen 80252






Tabellen






*/