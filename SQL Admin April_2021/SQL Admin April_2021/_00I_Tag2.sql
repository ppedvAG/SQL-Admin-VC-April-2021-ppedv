--Auf externe Ressourcen greifen immer die Dienstkonten zu..
--ist es ein Job dann Agent
--ohne Job, dann SQL Server

--Ausnahme bilden Proxykonten

--Manueller Restore: SQL Server.Dienstkonto

--1,6 GB in 82 Sek
select 1600/85

--18MB / sek

--1,1 GB in 6 Sek
select 1100/6


--das Logilfe machts aus. Alle TX müssen wieder ausgeführt werden


--DB Whoami
--User ohne Login
--darf nicht ins Haus, aber in die Wohnung ... kein Login aber User...
--Was tun?
--depricated

sp_change_users_login 'Report' --verwaiste user

--wird ein Login mit der SID des Users angelegt
sp_Change_users_login 'Auto_fix', 'JamesBond',NULL, 'ppedv2020!'

--Logins werden dem User gleichgeschaltet


sp_change_users_login 'Update_one', 'JamesBond', 'JamesBond'

--Download von MS
sp_help_revlogin --.. Script bei MS´zum download

--Auf quellserver ausführen. Dadruch bekommen wir ein Script, 
--das Login inkl Passwort und SID anlegen kann...

/*




*/







--183MB /Sek