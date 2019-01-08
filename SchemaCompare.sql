-- Tables not in target database

SELECT 
	S.TABLE_NAME AS SOURCE_TABLE_NAME
	, T.TABLE_NAME AS TARGET_TABLE_NAME
FROM BLOCK_CHAIN_DEV.INFORMATION_SCHEMA.TABLES S
LEFT JOIN BCMY_DB.INFORMATION_SCHEMA.TABLES T ON S.TABLE_NAME = T.TABLE_NAME
WHERE T.TABLE_NAME IS NULL
ORDER BY S.TABLE_NAME;

-----------------------------------------------------------------------------------------------------------

-- Stored procedures not in target database
 
SELECT 
	S.ROUTINE_NAME AS SOURCE_ROUTINE_NAME
	, T.ROUTINE_NAME AS TARGET_ROUTINE_NAME
FROM BLOCK_CHAIN_DEV.INFORMATION_SCHEMA.ROUTINES S
LEFT JOIN BCMY_DB.INFORMATION_SCHEMA.ROUTINES T ON S.ROUTINE_NAME = T.ROUTINE_NAME
WHERE T.ROUTINE_NAME IS NULL
ORDER BY S.ROUTINE_NAME;

-----------------------------------------------------------------------------------------------------------

-- Columns not in target database

SELECT 
	S.TABLE_NAME AS SOURCE_TABLE_NAME
	, S.COLUMN_NAME AS SOURCE_COLUMN_NAME
	, T.TABLE_NAME AS TARGET_TABLE_NAME
	, T.COLUMN_NAME AS TARGET_COLUMN_NAME
FROM BLOCK_CHAIN_DEV.INFORMATION_SCHEMA.COLUMNS S
LEFT JOIN BCMY_DB.INFORMATION_SCHEMA.COLUMNS T ON S.TABLE_NAME = T.TABLE_NAME AND S.COLUMN_NAME = T.COLUMN_NAME
WHERE T.COLUMN_NAME IS NULL
ORDER BY S.TABLE_NAME
;

-----------------------------------------------------------------------------------------------------------

-- Changes in stored procedures

SELECT 
	S.ROUTINE_NAME AS SOURCE_ROUTINE_NAME
	, S.ROUTINE_DEFINITION AS SOURCE_ROUTINE_DEFINITION
	, T.ROUTINE_NAME AS TARGET_ROUTINE_NAME
	, T.ROUTINE_DEFINITION AS TARGET_ROUTINE_DEFINITION
FROM BLOCK_CHAIN_DEV.INFORMATION_SCHEMA.ROUTINES S
INNER JOIN BCMY_DB.INFORMATION_SCHEMA.ROUTINES T ON S.ROUTINE_NAME = T.ROUTINE_NAME
WHERE S.ROUTINE_DEFINITION <> T.ROUTINE_DEFINITION
ORDER BY S.ROUTINE_NAME;

-----------------------------------------------------------------------------------------------------------

-- Column Changes

SELECT 
	S.TABLE_NAME AS SOURCE_TABLE_NAME
	, S.COLUMN_NAME AS SOURCE_COLUMN_NAME
	, T.TABLE_NAME AS TARGET_TABLE_NAME
	, T.COLUMN_NAME AS TARGET_COLUMN_NAME
FROM BLOCK_CHAIN_DEV.INFORMATION_SCHEMA.COLUMNS S
INNER JOIN BCMY_DB.INFORMATION_SCHEMA.COLUMNS T ON S.TABLE_NAME = T.TABLE_NAME AND S.COLUMN_NAME = T.COLUMN_NAME
WHERE 
	S.COLUMN_DEFAULT <> T.COLUMN_DEFAULT
	OR S.IS_NULLABLE <> T.IS_NULLABLE
	OR S.DATA_TYPE <> T.DATA_TYPE
	OR S.CHARACTER_MAXIMUM_LENGTH <> T.CHARACTER_MAXIMUM_LENGTH
	OR S.NUMERIC_PRECISION <> T.NUMERIC_PRECISION
	OR S.NUMERIC_PRECISION_RADIX <> T.NUMERIC_PRECISION_RADIX
	OR S.NUMERIC_SCALE <> T.NUMERIC_SCALE
	OR S.DATETIME_PRECISION <> T.DATETIME_PRECISION
	OR S.COLLATION_NAME <> S.COLLATION_NAME
ORDER BY S.TABLE_NAME
;

-- Constraints not in target database 

SELECT 
	S.TABLE_NAME AS SOURCE_TABLE_NAME
	, S.CONSTRAINT_NAME AS SOURCE_CONSTRAINT_NAME
	, T.TABLE_NAME AS TARGET_TABLE_NAME
	, T.CONSTRAINT_NAME AS TARGET_CONSTRAINT_NAME
FROM BLOCK_CHAIN_DEV.INFORMATION_SCHEMA.TABLE_CONSTRAINTS S
LEFT JOIN BCMY_DB.INFORMATION_SCHEMA.TABLE_CONSTRAINTS T ON S.TABLE_NAME = T.TABLE_NAME
WHERE T.TABLE_NAME IS NULL
ORDER BY S.TABLE_NAME;

-- Trigger

SELECT 
    sysobjects.name AS trigger_name 
    , USER_NAME(sysobjects.uid) AS trigger_owner 
    , s.name AS table_schema 
    , OBJECT_NAME(parent_obj) AS table_name 
    , OBJECTPROPERTY( id, 'ExecIsUpdateTrigger') AS isupdate 
    , OBJECTPROPERTY( id, 'ExecIsDeleteTrigger') AS isdelete 
    , OBJECTPROPERTY( id, 'ExecIsInsertTrigger') AS isinsert 
    , OBJECTPROPERTY( id, 'ExecIsAfterTrigger') AS isafter 
    , OBJECTPROPERTY( id, 'ExecIsInsteadOfTrigger') AS isinsteadof 
    , OBJECTPROPERTY(id, 'ExecIsTriggerDisabled') AS [disabled] 
FROM sysobjects 
INNER JOIN sysusers ON sysobjects.uid = sysusers.uid 
INNER JOIN sys.tables t ON sysobjects.parent_obj = t.object_id 
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id 
WHERE sysobjects.type = 'TR' 
ORDER BY sysobjects.name
;

SELECT
    ServerName   = @@servername
    , DatabaseName = db_name()
    , SchemaName   = isnull( s.name, '' )
    , TableName    = isnull( o.name, 'DDL Trigger' )
    , TriggerName  = t.name
    , Defininion   = object_definition( t.object_id )
FROM sys.triggers t
LEFT JOIN sys.all_objects o ON t.parent_id = o.object_id
LEFT JOIN sys.schemas s ON s.schema_id = o.schema_id
ORDER BY 
    SchemaName
    , TableName
    , TriggerName
;

