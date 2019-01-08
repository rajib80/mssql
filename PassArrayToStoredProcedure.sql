CREATE TYPE dbo.SettlementFileList
AS TABLE
(
  SettlementFileName VARCHAR(100)
);
GO

CREATE PROCEDURE dbo.DoSomethingWithSettlementFile
  @List AS dbo.SettlementFileList READONLY
AS
BEGIN
  SET NOCOUNT ON;

  SELECT SettlementFileName FROM @List; 
END
GO

DECLARE @RC int
DECLARE @List [dbo].[SettlementFileList]

INSERT INTO @List VALUES ('0001000120000141200140120181218153819');
INSERT INTO @List VALUES ('0001000120000141200140120181218153122');

EXECUTE @RC = [dbo].[DoSomethingWithSettlementFile] 
   @List
GO

