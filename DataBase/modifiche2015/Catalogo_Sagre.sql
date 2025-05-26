/*
   domenica 20 settembre 2015 9.37.52
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
CREATE TABLE dbo.Tmp_Catalogo_Sagre
	(
	Id_Sagra char(5) NOT NULL,
	Descrizione char(50) NULL,
	Localita varchar(50) NULL,
	Cap varchar(50) NULL,
	Provincia char(2) NULL,
	Image varchar(50) NULL,
	Note varchar(400) NULL
	)  ON [PRIMARY]
GO
IF EXISTS(SELECT * FROM dbo.Catalogo_Sagre)
	 EXEC('INSERT INTO dbo.Tmp_Catalogo_Sagre (Id_Sagra, Descrizione, Localita, Cap, Provincia, Image, Note)
		SELECT Id_Sagra, Descrizione, CONVERT(varchar(50), Localita), CONVERT(varchar(50), Cap), Provincia, CONVERT(varchar(50), Image), CONVERT(varchar(400), Note) FROM dbo.Catalogo_Sagre TABLOCKX')
GO
ALTER TABLE dbo.AnagraficaArticoli
	DROP CONSTRAINT FK_AnagraficaArticoli_Catalogo_Sagre
GO
ALTER TABLE dbo.Ordini
	DROP CONSTRAINT FK_Ordini_Catalogo_Sagre
GO
DROP TABLE dbo.Catalogo_Sagre
GO
EXECUTE sp_rename N'dbo.Tmp_Catalogo_Sagre', N'Catalogo_Sagre', 'OBJECT'
GO
ALTER TABLE dbo.Catalogo_Sagre ADD CONSTRAINT
	PK_Catalogo_Sagre PRIMARY KEY CLUSTERED 
	(
	Id_Sagra
	) WITH FILLFACTOR = 90 ON [PRIMARY]

GO
GRANT SELECT ON dbo.Catalogo_Sagre TO public  AS dbo
GRANT UPDATE ON dbo.Catalogo_Sagre TO public  AS dbo
GRANT INSERT ON dbo.Catalogo_Sagre TO public  AS dbo
GRANT DELETE ON dbo.Catalogo_Sagre TO public  AS dbo
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.Ordini WITH NOCHECK ADD CONSTRAINT
	FK_Ordini_Catalogo_Sagre FOREIGN KEY
	(
	Id_Sagra
	) REFERENCES dbo.Catalogo_Sagre
	(
	Id_Sagra
	) NOT FOR REPLICATION

GO
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.AnagraficaArticoli WITH NOCHECK ADD CONSTRAINT
	FK_AnagraficaArticoli_Catalogo_Sagre FOREIGN KEY
	(
	Id_Sagra
	) REFERENCES dbo.Catalogo_Sagre
	(
	Id_Sagra
	) NOT FOR REPLICATION

GO
COMMIT
