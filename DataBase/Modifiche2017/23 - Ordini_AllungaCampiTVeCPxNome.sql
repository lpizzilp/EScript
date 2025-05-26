INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])VALUES(23,'23 - Ordini_AllungaCampiTVeCPxNome.sql', '2.4.114', CURRENT_TIMESTAMP, 'Portati a 20 byte i campi Tavolo e Coperti per permettere l inserimento del nome in fase di battitura cassa')go
/* ORDINI */
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.Ordini
	DROP CONSTRAINT FK_Ordini_Catalogo_Sagre
GO
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.Ordini
	DROP CONSTRAINT FK_Ordini_TipiCassa
GO
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_Ordini
	(
	Id_Sagra char(5) NOT NULL,
	IDOrdine int NOT NULL,
	DataOrdine char(10) NULL,
	OraOrdine char(10) NULL,
	Tavolo varchar(20) NULL,
	Coperti varchar(20) NULL,
	Nominativo varchar(30) NULL,
	NomeComputer varchar(20) NULL,
	Utente varchar(10) NULL,
	TipoOrdine varchar(2) NULL,
	TipoContabilizzazione char(1) NULL,
	DataEvasione char(10) NULL,
	OraEvasione char(10) NULL,
	Note char(200) NULL,
	Priorita char(1) NULL,
	DataContabile char(8) NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.Ordini)
	 EXEC('INSERT INTO dbo.Tmp_Ordini (Id_Sagra, IDOrdine, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer, Utente, TipoOrdine, TipoContabilizzazione, DataEvasione, OraEvasione, Note, Priorita, DataContabile)
		SELECT Id_Sagra, IDOrdine, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer, Utente, TipoOrdine, TipoContabilizzazione, DataEvasione, OraEvasione, Note, Priorita, DataContabile FROM dbo.Ordini (HOLDLOCK TABLOCKX)')
GO
ALTER TABLE dbo.ImportedOrder
	DROP CONSTRAINT FK_ImportedOrder_Ordini
GO
ALTER TABLE dbo.StatoOrdini
	DROP CONSTRAINT FK_StatoOrdini_Ordini
GO
ALTER TABLE dbo.DettaglioOrdini
	DROP CONSTRAINT FK_DettaglioOrdini_Ordini
GO
ALTER TABLE dbo.CodaReparto
	DROP CONSTRAINT FK_CodaReparto_Ordini
GO
DROP TABLE dbo.Ordini
GO
EXECUTE sp_rename N'dbo.Tmp_Ordini', N'Ordini', 'OBJECT'
GO
ALTER TABLE dbo.Ordini ADD CONSTRAINT
	PK_Ordini PRIMARY KEY CLUSTERED 
	(
	Id_Sagra,
	IDOrdine
	) WITH FILLFACTOR = 90 ON [PRIMARY]

GO
CREATE NONCLUSTERED INDEX IX_Ordini ON dbo.Ordini
	(
	DataOrdine
	) WITH FILLFACTOR = 90 ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_Ordini_1 ON dbo.Ordini
	(
	Id_Sagra,
	TipoOrdine
	) WITH FILLFACTOR = 90 ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX IX_Ordini_fk1 ON dbo.Ordini
	(
	TipoOrdine
	) WITH FILLFACTOR = 90 ON [PRIMARY]
GO
ALTER TABLE dbo.Ordini WITH NOCHECK ADD CONSTRAINT
	FK_Ordini_TipiCassa FOREIGN KEY
	(
	TipoOrdine
	) REFERENCES dbo.TipiCassa
	(
	IdCassa
	)
GO
ALTER TABLE dbo.Ordini WITH NOCHECK ADD CONSTRAINT
	FK_Ordini_Catalogo_Sagre FOREIGN KEY
	(
	Id_Sagra
	) REFERENCES dbo.Catalogo_Sagre
	(
	Id_Sagra
	) NOT FOR REPLICATION

GO
GRANT SELECT ON dbo.Ordini TO public  AS dbo
GRANT UPDATE ON dbo.Ordini TO public  AS dbo
GRANT INSERT ON dbo.Ordini TO public  AS dbo
GRANT DELETE ON dbo.Ordini TO public  AS dbo
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.CodaReparto WITH NOCHECK ADD CONSTRAINT
	FK_CodaReparto_Ordini FOREIGN KEY
	(
	Id_Sagra,
	IdOrdine
	) REFERENCES dbo.Ordini
	(
	Id_Sagra,
	IDOrdine
	) ON DELETE CASCADE
	
GO
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.DettaglioOrdini WITH NOCHECK ADD CONSTRAINT
	FK_DettaglioOrdini_Ordini FOREIGN KEY
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
COMMIT
BEGIN TRANSACTION
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
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.ImportedOrder WITH NOCHECK ADD CONSTRAINT
	FK_ImportedOrder_Ordini FOREIGN KEY
	(
	Id_Sagra,
	NewIdOrdine
	) REFERENCES dbo.Ordini
	(
	Id_Sagra,
	IDOrdine
	) ON DELETE CASCADE
	 NOT FOR REPLICATION

GO
COMMIT
/* ORDINIPARK */ BEGIN TRANSACTIONSET QUOTED_IDENTIFIER ONSET ARITHABORT ONSET NUMERIC_ROUNDABORT OFFSET CONCAT_NULL_YIELDS_NULL ONSET ANSI_NULLS ONSET ANSI_PADDING ONSET ANSI_WARNINGS ONCOMMITBEGIN TRANSACTIONCREATE TABLE dbo.Tmp_OrdiniPark	(	Id_Sagra char(5) NOT NULL,	IDOrdine int NOT NULL,	DataOrdine char(10) NULL,	OraOrdine char(10) NULL,	Tavolo varchar(20) NULL,	Coperti varchar(20) NULL,	Nominativo varchar(30) NULL,	NomeComputer varchar(20) NULL,	Utente varchar(10) NULL,	TipoOrdine varchar(2) NULL,	TipoContabilizzazione char(1) NULL,	DataEvasione char(10) NULL,	OraEvasione char(10) NULL,	Note char(200) NULL,	Priorita char(1) NULL,	DataContabile char(8) NULL,	Idkey varchar(20) NULL	)  ON [PRIMARY]GOIF EXISTS(SELECT * FROM dbo.OrdiniPark)	 EXEC('INSERT INTO dbo.Tmp_OrdiniPark (Id_Sagra, IDOrdine, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer, Utente, TipoOrdine, TipoContabilizzazione, DataEvasione, OraEvasione, Note, Priorita, DataContabile, Idkey)		SELECT Id_Sagra, IDOrdine, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer, Utente, TipoOrdine, TipoContabilizzazione, DataEvasione, OraEvasione, Note, Priorita, DataContabile, Idkey FROM dbo.OrdiniPark (HOLDLOCK TABLOCKX)')GOALTER TABLE dbo.DettaglioOrdiniPark	DROP CONSTRAINT FK_DettaglioOrdiniPark_OrdiniParkGODROP TABLE dbo.OrdiniParkGOEXECUTE sp_rename N'dbo.Tmp_OrdiniPark', N'OrdiniPark', 'OBJECT'GOALTER TABLE dbo.OrdiniPark ADD CONSTRAINT	PK_OrdiniPark PRIMARY KEY CLUSTERED 	(	Id_Sagra,	IDOrdine	) WITH FILLFACTOR = 90 ON [PRIMARY]GOCREATE NONCLUSTERED INDEX IX_OrdiniPark ON dbo.OrdiniPark	(	DataOrdine	) WITH FILLFACTOR = 90 ON [PRIMARY]GOCREATE NONCLUSTERED INDEX IX_OrdiniPark_1 ON dbo.OrdiniPark	(	Id_Sagra,	TipoOrdine	) WITH FILLFACTOR = 90 ON [PRIMARY]GOALTER TABLE dbo.OrdiniPark ADD CONSTRAINT	IX_OrdiniPark_2 UNIQUE NONCLUSTERED 	(	Id_Sagra,	Idkey	) ON [PRIMARY]GOGRANT SELECT ON dbo.OrdiniPark TO public  AS dboGRANT UPDATE ON dbo.OrdiniPark TO public  AS dboGRANT INSERT ON dbo.OrdiniPark TO public  AS dboGRANT DELETE ON dbo.OrdiniPark TO public  AS dboCOMMITBEGIN TRANSACTIONALTER TABLE dbo.DettaglioOrdiniPark WITH NOCHECK ADD CONSTRAINT	FK_DettaglioOrdiniPark_OrdiniPark FOREIGN KEY	(	Id_Sagra,	IdOrdine	) REFERENCES dbo.OrdiniPark	(	Id_Sagra,	IDOrdine	) ON DELETE CASCADE	 NOT FOR REPLICATIONGOCOMMIT/* ORDINIST*/ BEGIN TRANSACTIONSET QUOTED_IDENTIFIER ONSET ARITHABORT ONSET NUMERIC_ROUNDABORT OFFSET CONCAT_NULL_YIELDS_NULL ONSET ANSI_NULLS ONSET ANSI_PADDING ONSET ANSI_WARNINGS ONCOMMITBEGIN TRANSACTIONCREATE TABLE dbo.Tmp_OrdiniSt	(	Anno char(4) NOT NULL,	Id_Sagra nvarchar(5) NOT NULL,	IDOrdine int NOT NULL,	DataOrdine nvarchar(10) NULL,	OraOrdine nvarchar(10) NULL,	Tavolo nvarchar(20) NULL,	Coperti nvarchar(20) NULL,	Nominativo nvarchar(30) NULL,	NomeComputer nvarchar(20) NULL,	Utente nvarchar(10) NULL,	TipoOrdine nvarchar(2) NULL,	TipoContabilizzazione nvarchar(1) NULL,	DataEvasione nvarchar(10) NULL,	OraEvasione nvarchar(10) NULL,	Note nvarchar(200) NULL,	Priorita nvarchar(1) NULL,	DataContabile char(8) NULL	)  ON [PRIMARY]GOIF EXISTS(SELECT * FROM dbo.OrdiniSt)	 EXEC('INSERT INTO dbo.Tmp_OrdiniSt (Anno, Id_Sagra, IDOrdine, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer, Utente, TipoOrdine, TipoContabilizzazione, DataEvasione, OraEvasione, Note, Priorita, DataContabile)		SELECT Anno, Id_Sagra, IDOrdine, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer, Utente, TipoOrdine, TipoContabilizzazione, DataEvasione, OraEvasione, Note, Priorita, DataContabile FROM dbo.OrdiniSt (HOLDLOCK TABLOCKX)')GODROP TABLE dbo.OrdiniStGOEXECUTE sp_rename N'dbo.Tmp_OrdiniSt', N'OrdiniSt', 'OBJECT'GOALTER TABLE dbo.OrdiniSt ADD CONSTRAINT	PK_OrdiniSt PRIMARY KEY CLUSTERED 	(	Anno,	Id_Sagra,	IDOrdine	) WITH FILLFACTOR = 90 ON [PRIMARY]GOGRANT SELECT ON dbo.OrdiniSt TO public  AS dboGRANT UPDATE ON dbo.OrdiniSt TO public  AS dboGRANT INSERT ON dbo.OrdiniSt TO public  AS dboGRANT DELETE ON dbo.OrdiniSt TO public  AS dboCOMMIT