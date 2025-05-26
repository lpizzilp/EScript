INSERT INTO ScriptDB([ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES('9 - CassaReparti-RemoveAutoInc.sql', '2.4.109', CURRENT_TIMESTAMP, 'Rimozione auto inc della chiave cassareparti per consentire le operazioni di importazione .')
go

/*   sabato 23 settembre 2017 21.21.43   User: sa   Server: VMXP-SERVER   Database: Sagra   Application: MS SQLEM - Data Tools*/BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.CassaReparti
	DROP CONSTRAINT FK_CassaTipologie_Tipologie
GO
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.CassaReparti
	DROP CONSTRAINT FK_CassaTipologie_TipiCassa
GO
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_CassaReparti
	(
	IdCassaReparti int NOT NULL,
	Id_Sagra char(5) NOT NULL,
	IdCassa char(1) NOT NULL,
	IdReparto char(1) NOT NULL,
	ModoEvasione char(1) NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.CassaReparti)
	 EXEC('INSERT INTO dbo.Tmp_CassaReparti (IdCassaReparti, Id_Sagra, IdCassa, IdReparto, ModoEvasione)
		SELECT IdCassaReparti, Id_Sagra, IdCassa, IdReparto, ModoEvasione FROM dbo.CassaReparti (HOLDLOCK TABLOCKX)')
GO
ALTER TABLE dbo.ExclusionList
	DROP CONSTRAINT FK_ExclusionList_CassaReparti
GO
DROP TABLE dbo.CassaReparti
GO
EXECUTE sp_rename N'dbo.Tmp_CassaReparti', N'CassaReparti', 'OBJECT'
GO
ALTER TABLE dbo.CassaReparti ADD CONSTRAINT
	PK_CassaReparti PRIMARY KEY CLUSTERED 
	(
	IdCassaReparti
	) WITH FILLFACTOR = 90 ON [PRIMARY]

GO
ALTER TABLE dbo.CassaReparti ADD CONSTRAINT
	IX_CassaReparti UNIQUE NONCLUSTERED 
	(
	Id_Sagra,
	IdCassa,
	IdReparto
	) WITH FILLFACTOR = 90 ON [PRIMARY]

GO
CREATE NONCLUSTERED INDEX IX_CassaReparti_1 ON dbo.CassaReparti
	(
	IdReparto
	) WITH FILLFACTOR = 90 ON [PRIMARY]
GO
ALTER TABLE dbo.CassaReparti WITH NOCHECK ADD CONSTRAINT
	FK_CassaTipologie_TipiCassa FOREIGN KEY
	(
	IdCassa
	) REFERENCES dbo.TipiCassa
	(
	IdCassa
	)
GO
ALTER TABLE dbo.CassaReparti WITH NOCHECK ADD CONSTRAINT
	FK_CassaTipologie_Tipologie FOREIGN KEY
	(
	IdReparto
	) REFERENCES dbo.Reparti
	(
	IdReparto
	)
GO
GRANT SELECT ON dbo.CassaReparti TO public  AS dbo
GRANT UPDATE ON dbo.CassaReparti TO public  AS dbo
GRANT INSERT ON dbo.CassaReparti TO public  AS dbo
GRANT DELETE ON dbo.CassaReparti TO public  AS dbo
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.ExclusionList WITH NOCHECK ADD CONSTRAINT
	FK_ExclusionList_CassaReparti FOREIGN KEY
	(
	IdCassaReparti
	) REFERENCES dbo.CassaReparti
	(
	IdCassaReparti
	) ON DELETE CASCADE
	 NOT FOR REPLICATION

GO
COMMIT
