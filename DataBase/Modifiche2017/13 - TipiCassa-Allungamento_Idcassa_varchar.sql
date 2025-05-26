INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(13,'13 - TipiCassa-Allungamento_Idcassa_varchar.sql', '2.4.114', CURRENT_TIMESTAMP, 'Allungato campo idcassa a 2 varchar.')
go



/*   mercoledì 18 ottobre 2017 12.53.13   User: sa   Server: VMXP-SERVER   Database: Sagra   Application: MS SQLEM - Data Tools*/BEGIN TRANSACTION
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
ALTER TABLE dbo.Ordini
	DROP CONSTRAINT FK_Ordini_Catalogo_Sagre
GO
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_TipiCassa
	(
	IdCassa varchar(2) NOT NULL,
	Descrizione varchar(15) NULL,
	Priorita char(1) NULL,
	MaskBitmap varchar(10) NULL,
	BitmapOblig varchar(10) NULL,
	Discount int NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.TipiCassa)
	 EXEC('INSERT INTO dbo.Tmp_TipiCassa (IdCassa, Descrizione, Priorita, MaskBitmap, BitmapOblig, Discount)
		SELECT CONVERT(varchar(2), IdCassa), Descrizione, Priorita, MaskBitmap, BitmapOblig, Discount FROM dbo.TipiCassa (HOLDLOCK TABLOCKX)')
GO
ALTER TABLE dbo.Ordini
	DROP CONSTRAINT FK_Ordini_TipiCassa
GO
ALTER TABLE dbo.CassaReparti
	DROP CONSTRAINT FK_CassaTipologie_TipiCassa
GO
DROP TABLE dbo.TipiCassa
GO
EXECUTE sp_rename N'dbo.Tmp_TipiCassa', N'TipiCassa', 'OBJECT'
GO
ALTER TABLE dbo.TipiCassa ADD CONSTRAINT
	PK_TipiCassa PRIMARY KEY NONCLUSTERED 
	(
	IdCassa
	) WITH FILLFACTOR = 90 ON [PRIMARY]

GO
GRANT SELECT ON dbo.TipiCassa TO public  AS dbo
GRANT UPDATE ON dbo.TipiCassa TO public  AS dbo
GRANT INSERT ON dbo.TipiCassa TO public  AS dbo
GRANT DELETE ON dbo.TipiCassa TO public  AS dbo
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_CassaReparti
	(
	IdCassaReparti int NOT NULL,
	Id_Sagra char(5) NOT NULL,
	IdCassa varchar(2) NOT NULL,
	IdReparto char(1) NOT NULL,
	ModoEvasione char(1) NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.CassaReparti)
	 EXEC('INSERT INTO dbo.Tmp_CassaReparti (IdCassaReparti, Id_Sagra, IdCassa, IdReparto, ModoEvasione)
		SELECT IdCassaReparti, Id_Sagra, CONVERT(varchar(2), IdCassa), IdReparto, ModoEvasione FROM dbo.CassaReparti (HOLDLOCK TABLOCKX)')
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
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_Ordini
	(
	Id_Sagra char(5) NOT NULL,
	IDOrdine int NOT NULL,
	DataOrdine char(10) NULL,
	OraOrdine char(10) NULL,
	Tavolo varchar(10) NULL,
	Coperti varchar(10) NULL,
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
		SELECT Id_Sagra, IDOrdine, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer, Utente, CONVERT(varchar(2), TipoOrdine), TipoContabilizzazione, DataEvasione, OraEvasione, Note, Priorita, DataContabile FROM dbo.Ordini (HOLDLOCK TABLOCKX)')
GO
ALTER TABLE dbo.CodaReparto
	DROP CONSTRAINT FK_CodaReparto_Ordini
GO
ALTER TABLE dbo.DettaglioOrdini
	DROP CONSTRAINT FK_DettaglioOrdini_Ordini
GO
ALTER TABLE dbo.StatoOrdini
	DROP CONSTRAINT FK_StatoOrdini_Ordini
GO
ALTER TABLE dbo.ImportedOrder
	DROP CONSTRAINT FK_ImportedOrder_Ordini
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





/*   venerdì 20 ottobre 2017 6.59.33   User: sa   Server: VMXP-SERVER   Database: Sagra   Application: MS SQLEM - Data Tools*/BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
CREATE TABLE dbo.Tmp_OrdiniSt
	(
	Anno char(4) NOT NULL,
	Id_Sagra nvarchar(5) NOT NULL,
	IDOrdine int NOT NULL,
	DataOrdine nvarchar(10) NULL,
	OraOrdine nvarchar(10) NULL,
	Tavolo nvarchar(10) NULL,
	Coperti nvarchar(10) NULL,
	Nominativo nvarchar(30) NULL,
	NomeComputer nvarchar(20) NULL,
	Utente nvarchar(10) NULL,
	TipoOrdine nvarchar(2) NULL,
	TipoContabilizzazione nvarchar(1) NULL,
	DataEvasione nvarchar(10) NULL,
	OraEvasione nvarchar(10) NULL,
	Note nvarchar(200) NULL,
	Priorita nvarchar(1) NULL,
	DataContabile char(8) NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.OrdiniSt)
	 EXEC('INSERT INTO dbo.Tmp_OrdiniSt (Anno, Id_Sagra, IDOrdine, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer, Utente, TipoOrdine, TipoContabilizzazione, DataEvasione, OraEvasione, Note, Priorita, DataContabile)
		SELECT Anno, Id_Sagra, IDOrdine, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer, Utente, TipoOrdine, TipoContabilizzazione, DataEvasione, OraEvasione, Note, Priorita, DataContabile FROM dbo.OrdiniSt (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.OrdiniSt
GO
EXECUTE sp_rename N'dbo.Tmp_OrdiniSt', N'OrdiniSt', 'OBJECT'
GO
ALTER TABLE dbo.OrdiniSt ADD CONSTRAINT
	PK_OrdiniSt PRIMARY KEY CLUSTERED 
	(
	Anno,
	Id_Sagra,
	IDOrdine
	) WITH FILLFACTOR = 90 ON [PRIMARY]

GO
GRANT SELECT ON dbo.OrdiniSt TO public  AS dbo
GRANT UPDATE ON dbo.OrdiniSt TO public  AS dbo
GRANT INSERT ON dbo.OrdiniSt TO public  AS dbo
GRANT DELETE ON dbo.OrdiniSt TO public  AS dbo


/*   venerdì 20 ottobre 2017 6.59.33   User: sa   Server: VMXP-SERVER   Database: Sagra   Application: MS SQLEM - Data Tools*/CREATE TABLE dbo.Tmp_OrdiniSt
	(
	Anno char(4) NOT NULL,
	Id_Sagra nvarchar(5) NOT NULL,
	IDOrdine int NOT NULL,
	DataOrdine nvarchar(10) NULL,
	OraOrdine nvarchar(10) NULL,
	Tavolo nvarchar(10) NULL,
	Coperti nvarchar(10) NULL,
	Nominativo nvarchar(30) NULL,
	NomeComputer nvarchar(20) NULL,
	Utente nvarchar(10) NULL,
	TipoOrdine nvarchar(2) NULL,
	TipoContabilizzazione nvarchar(1) NULL,
	DataEvasione nvarchar(10) NULL,
	OraEvasione nvarchar(10) NULL,
	Note nvarchar(200) NULL,
	Priorita nvarchar(1) NULL,
	DataContabile char(8) NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.OrdiniSt)
	 EXEC('INSERT INTO dbo.Tmp_OrdiniSt (Anno, Id_Sagra, IDOrdine, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer, Utente, TipoOrdine, TipoContabilizzazione, DataEvasione, OraEvasione, Note, Priorita, DataContabile)
		SELECT Anno, Id_Sagra, IDOrdine, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer, Utente, TipoOrdine, TipoContabilizzazione, DataEvasione, OraEvasione, Note, Priorita, DataContabile FROM dbo.OrdiniSt (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.OrdiniSt
GO
EXECUTE sp_rename N'dbo.Tmp_OrdiniSt', N'OrdiniSt', 'OBJECT'
GO
ALTER TABLE dbo.OrdiniSt ADD CONSTRAINT
	PK_OrdiniSt PRIMARY KEY CLUSTERED 
	(
	Anno,
	Id_Sagra,
	IDOrdine
	) WITH FILLFACTOR = 90 ON [PRIMARY]

GO
GRANT SELECT ON dbo.OrdiniSt TO public  AS dbo
GRANT UPDATE ON dbo.OrdiniSt TO public  AS dbo
GRANT INSERT ON dbo.OrdiniSt TO public  AS dbo
GRANT DELETE ON dbo.OrdiniSt TO public  AS dbo
COMMIT




