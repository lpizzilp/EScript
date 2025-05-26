/*
   mercoledì 23 settembre 2015 22.25.13
   User: sa
   Server: VMXP-SERVER
   Database: Sagra
   Application: MS SQLEM - Data Tools
*/

BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_StampeReport
	(
	IdForm char(30) NOT NULL,
	IdStampa char(30) NOT NULL,
	IdReport char(50) NOT NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.StampeReport)
	 EXEC('INSERT INTO dbo.Tmp_StampeReport (IdForm, IdStampa, IdReport)
		SELECT IdForm, IdStampa, IdReport FROM dbo.StampeReport TABLOCKX')
GO
DROP TABLE dbo.StampeReport
GO
EXECUTE sp_rename N'dbo.Tmp_StampeReport', N'StampeReport', 'OBJECT'
GO
GRANT SELECT ON dbo.StampeReport TO public  AS dbo
GRANT UPDATE ON dbo.StampeReport TO public  AS dbo
GRANT INSERT ON dbo.StampeReport TO public  AS dbo
GRANT DELETE ON dbo.StampeReport TO public  AS dbo
COMMIT
