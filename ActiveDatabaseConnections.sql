SELECT DB_NAME(dbid) as DBName,
       COUNT(dbid) as NumberOfConnections      
FROM sys.sysprocesses
WHERE dbid > 0
GROUP BY dbid, loginame;

select a.dbid,b.name, count(a.dbid) as TotalConnections
from sys.sysprocesses a
inner join sys.databases b on a.dbid = b.database_id
group by a.dbid, b.name;
