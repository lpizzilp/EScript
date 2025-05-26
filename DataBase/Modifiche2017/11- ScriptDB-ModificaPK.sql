



/*   lunedì 16 ottobre 2017 7.21.01   User: sa   Server: VMXP-SERVER   Database: Sagra   Application: MS SQLEM - Data Tools*/BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_ScriptDB
	(
	DDLVersion int NOT NULL IDENTITY (1, 1),
	ScriptName varchar(50) NOT NULL,
	SwVersione varchar(20) NOT NULL,
	DataInserimento varchar(20) NOT NULL,
	Note varchar(255) NULL
	)  ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.Tmp_ScriptDB OFF
GO
IF EXISTS(SELECT * FROM dbo.ScriptDB)
	 EXEC('INSERT INTO dbo.Tmp_ScriptDB (ScriptName, SwVersione, DataInserimento, Note)
		SELECT ScriptName, SwVersione, DataInserimento, Note FROM dbo.ScriptDB (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.ScriptDB
GO
EXECUTE sp_rename N'dbo.Tmp_ScriptDB', N'ScriptDB', 'OBJECT'
GO
ALTER TABLE dbo.ScriptDB ADD CONSTRAINT
	PK_ScriptDB PRIMARY KEY CLUSTERED 
	(
	DDLVersion
	) ON [PRIMARY]

GO
COMMIT


/*   lunedì 16 ottobre 2017 7.23.15   User: sa   Server: VMXP-SERVER   Database: Sagra   Application: MS SQLEM - Data Tools*/BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_ScriptDB
	(
	DDLVersion int NOT NULL,
	ScriptName varchar(50) NOT NULL,
	SwVersione varchar(20) NOT NULL,
	DataInserimento varchar(20) NOT NULL,
	Note varchar(255) NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.ScriptDB)
	 EXEC('INSERT INTO dbo.Tmp_ScriptDB (DDLVersion, ScriptName, SwVersione, DataInserimento, Note)
		SELECT DDLVersion, ScriptName, SwVersione, DataInserimento, Note FROM dbo.ScriptDB (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.ScriptDB
GO
EXECUTE sp_rename N'dbo.Tmp_ScriptDB', N'ScriptDB', 'OBJECT'
GO
ALTER TABLE dbo.ScriptDB ADD CONSTRAINT
	PK_ScriptDB PRIMARY KEY CLUSTERED 
	(
	DDLVersion
	) ON [PRIMARY]

GO


GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[ScriptDB]  TO [public]
GO


INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(11,'11- ScriptDB-ModificaPK.sql', '2.4.114', CURRENT_TIMESTAMP, 'Modifico logia tabella. Inserita colonna Kiave con progressivo versione ddl da testare anche a livello software.')
go

INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(12,'LIBERO', '2.4.114', CURRENT_TIMESTAMP, 'Mantenimento progressivo')
go
COMMIT