create database tde

drop master key 
drop certificate TDECerti


use master
	
	create master key
		encryption by password ='ppedvAG01!'
go


create certificate TDEZert
	with subject ='TDE Zerti' 
use tde

create database encryption key
	with algorithm =AES_256
	encryption by server certificate tdeZert
go

alter database tde set encryption on

--Alle Seiten werden in Speicher gelesen und verschlüsselt zurückgeschrieben
ALTER DATABASE tdedemo SET ENCRYPTION SUSPEND;
ALTER DATABASE tdedemo SET ENCRYPTION RESUME


go
select [name],is_encrypted from sys.databases
