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
ALTER TABLE dbo.StampeReport
	DROP CONSTRAINT FK_StampeReport_TipiStampa
GO
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_IdentReport
	(
	IdReport char(50) NOT NULL,
	DescReport varchar(200) NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.IdentReport)
	 EXEC('INSERT INTO dbo.Tmp_IdentReport (IdReport, DescReport)
		SELECT IdReport, DescReport FROM dbo.IdentReport TABLOCKX')
GO
ALTER TABLE dbo.StampeReport
	DROP CONSTRAINT FK_StampeReport_IdentReport
GO
DROP TABLE dbo.IdentReport
GO
EXECUTE sp_rename N'dbo.Tmp_IdentReport', N'IdentReport', 'OBJECT'
GO
ALTER TABLE dbo.IdentReport ADD CONSTRAINT
	PK_IdentReport PRIMARY KEY CLUSTERED 
	(
	IdReport
	) WITH FILLFACTOR = 90 ON [PRIMARY]

GO
GRANT SELECT ON dbo.IdentReport TO public  AS dbo
GRANT UPDATE ON dbo.IdentReport TO public  AS dbo
GRANT INSERT ON dbo.IdentReport TO public  AS dbo
GRANT DELETE ON dbo.IdentReport TO public  AS dbo
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
ALTER TABLE dbo.StampeReport ADD CONSTRAINT
	PK_StampeReport PRIMARY KEY CLUSTERED 
	(
	IdForm,
	IdStampa
	) WITH FILLFACTOR = 90 ON [PRIMARY]

GO
ALTER TABLE dbo.StampeReport WITH NOCHECK ADD CONSTRAINT
	FK_StampeReport_IdentReport FOREIGN KEY
	(
	IdReport
	) REFERENCES dbo.IdentReport
	(
	IdReport
	) ON UPDATE CASCADE
	 ON DELETE CASCADE
	
GO
ALTER TABLE dbo.StampeReport WITH NOCHECK ADD CONSTRAINT
	FK_StampeReport_TipiStampa FOREIGN KEY
	(
	IdStampa
	) REFERENCES dbo.TipiStampa
	(
	IdStampa
	) ON UPDATE CASCADE
	 ON DELETE CASCADE
	
GO
GRANT SELECT ON dbo.StampeReport TO public  AS dbo
GRANT UPDATE ON dbo.StampeReport TO public  AS dbo
GRANT INSERT ON dbo.StampeReport TO public  AS dbo
GRANT DELETE ON dbo.StampeReport TO public  AS dbo
COMMIT
