INSERT INTO ScriptDB([ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES('10 - StatoOrdini.Datetime.sql', '2.4.109', CURRENT_TIMESTAMP, 'cambio campo timestamp da smalldatetime a datetime.')
go



/*   lunedì 2 ottobre 2017 22.33.25   User: sa   Server: VMXP-SERVER   Database: SagraVillaorba   Application: MS SQLEM - Data Tools*/BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.StatoOrdini
	DROP CONSTRAINT FK_StatoOrdini_Ordini
GO
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.StatoOrdini
	DROP CONSTRAINT FK_StatoOrdini_Tipologie
GO
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_StatoOrdini
	(
	Id_Sagra char(5) NOT NULL,
	IdOrdine int NOT NULL,
	Stato char(1) NOT NULL,
	IdReparto char(1) NOT NULL,
	DataInizio char(50) NULL,
	OraInizio char(10) NOT NULL,
	DataFine char(10) NULL,
	OraFine char(10) NULL,
	DataFineTimeStamp datetime NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.StatoOrdini)
	 EXEC('INSERT INTO dbo.Tmp_StatoOrdini (Id_Sagra, IdOrdine, Stato, IdReparto, DataInizio, OraInizio, DataFine, OraFine, DataFineTimeStamp)
		SELECT Id_Sagra, IdOrdine, Stato, IdReparto, DataInizio, OraInizio, DataFine, OraFine, DataFineTimeStamp FROM dbo.StatoOrdini (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.StatoOrdini
GO
EXECUTE sp_rename N'dbo.Tmp_StatoOrdini', N'StatoOrdini', 'OBJECT'
GO
ALTER TABLE dbo.StatoOrdini ADD CONSTRAINT
	PK_StatoOrdini PRIMARY KEY NONCLUSTERED 
	(
	Id_Sagra,
	IdOrdine,
	Stato,
	IdReparto
	) WITH FILLFACTOR = 90 ON [PRIMARY]

GO
CREATE NONCLUSTERED INDEX IX_StatoOrdini ON dbo.StatoOrdini
	(
	Id_Sagra,
	Stato,
	DataFineTimeStamp
	) WITH FILLFACTOR = 90 ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_StatoOrdini_1 ON dbo.StatoOrdini
	(
	Id_Sagra,
	IdOrdine
	) WITH FILLFACTOR = 90 ON [PRIMARY]
GO
ALTER TABLE dbo.StatoOrdini WITH NOCHECK ADD CONSTRAINT
	FK_StatoOrdini_Tipologie FOREIGN KEY
	(
	IdReparto
	) REFERENCES dbo.Reparti
	(
	IdReparto
	)
GO
ALTER TABLE dbo.StatoOrdini WITH NOCHECK ADD CONSTRAINT
	FK_StatoOrdini_Ordini FOREIGN KEY
	(
	Id_Sagra,
	IdOrdine
	) REFERENCES dbo.Ordini
	(
	Id_Sagra,
	IDOrdine
	) ON DELETE CASCADE
	 NOT FOR REPLICATION

GO
GRANT SELECT ON dbo.StatoOrdini TO public  AS dbo
GRANT UPDATE ON dbo.StatoOrdini TO public  AS dbo
GRANT INSERT ON dbo.StatoOrdini TO public  AS dbo
GRANT DELETE ON dbo.StatoOrdini TO public  AS dbo
COMMIT
