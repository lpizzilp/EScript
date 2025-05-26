INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])VALUES(16,'16 - Categorie-Modifiche_LineaReparto.sql', '2.4.114', CURRENT_TIMESTAMP, 'Tutte le modifiche necessarie per dividere le categorie touch da quelle reparto')go/*
   domenica 22 ottobre 2017 23.27.53
   User: sa
   Server: VMXP-SERVER
   Database: Sagra
   Application: MS SQLEM - Data Tools
*/

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
ALTER TABLE dbo.AnagraficaArticoli
	DROP CONSTRAINT FK_AnagraficaArticoli_Categorie
GO
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.Categorie
	DROP CONSTRAINT DF_Categorie_IDPosition
GO
ALTER TABLE dbo.Categorie
	DROP CONSTRAINT DF_Categorie_IdPositionXRep
GO
CREATE TABLE dbo.Tmp_Categorie
	(
	Id_Sagra char(5) NOT NULL,
	IdCategoria int NOT NULL,
	IdDestinazione varchar(1) NOT NULL,
	Descrizione varchar(255) NULL,
	BackcolorTs varchar(10) NULL,
	ForecolorTs varchar(10) NULL,
	IdPosition int NULL,
	IdPositionXRep int NULL
	)  ON [PRIMARY]
GO
DECLARE @v sql_variant 
SET @v = N'T= TOUCH R= REPARTO'
EXECUTE sp_addextendedproperty N'MS_Description', @v, N'user', N'dbo', N'table', N'Tmp_Categorie', N'column', N'IdDestinazione'
GO
ALTER TABLE dbo.Tmp_Categorie ADD CONSTRAINT
	DF_Categorie_IdDestinazione DEFAULT 'T' FOR IdDestinazione
GO
ALTER TABLE dbo.Tmp_Categorie ADD CONSTRAINT
	DF_Categorie_IDPosition DEFAULT (0) FOR IdPosition
GO
ALTER TABLE dbo.Tmp_Categorie ADD CONSTRAINT
	DF_Categorie_IdPositionXRep DEFAULT (0) FOR IdPositionXRep
GO
IF EXISTS(SELECT * FROM dbo.Categorie)
	 EXEC('INSERT INTO dbo.Tmp_Categorie (Id_Sagra, IdCategoria, Descrizione, BackcolorTs, ForecolorTs, IdPosition, IdPositionXRep)
		SELECT Id_Sagra, IdCategoria, Descrizione, BackcolorTs, ForecolorTs, IdPosition, IdPositionXRep FROM dbo.Categorie (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.Categorie
GO
EXECUTE sp_rename N'dbo.Tmp_Categorie', N'Categorie', 'OBJECT'
GO
CREATE UNIQUE NONCLUSTERED INDEX UQ_Categorie ON dbo.Categorie
	(
	Id_Sagra,
	Descrizione,
	IdDestinazione
	) WITH FILLFACTOR = 90 ON [PRIMARY]
GO
ALTER TABLE dbo.Categorie ADD CONSTRAINT
	PK_Categorie PRIMARY KEY CLUSTERED 
	(
	IdCategoria
	) ON [PRIMARY]

GO
GRANT SELECT ON dbo.Categorie TO public  AS dbo
GRANT UPDATE ON dbo.Categorie TO public  AS dbo
GRANT INSERT ON dbo.Categorie TO public  AS dbo
GRANT DELETE ON dbo.Categorie TO public  AS dbo
COMMIT
/* insert */ BEGIN TRANSACTIONInsert into categorie select id_sagra,idcategoria + 1000, 'R' ,Descrizione, 0,0,idpositionxrep,0from categorieCOMMIT/* CANCELLA COLANNA XREP */BEGIN TRANSACTIONALTER TABLE dbo.Categorie	DROP CONSTRAINT DF_Categorie_IdPositionXRepGOALTER TABLE dbo.Categorie	DROP COLUMN IdPositionXRepGOCOMMIT/* anagrafica */BEGIN TRANSACTIONALTER TABLE dbo.AnagraficaArticoli ADD	IdCategoriaR int NULLGOupdate anagraficaarticoli set idcategoriar = (idcategoria + 1000)COMMIT/* FK ANAGRAFICA */BEGIN TRANSACTIONALTER TABLE dbo.AnagraficaArticoli ADD CONSTRAINT	FK_AnagraficaArticoli_Categorie FOREIGN KEY	(	Id_Sagra,	IdCategoria	) REFERENCES dbo.Categorie	(	Id_Sagra,	IdCategoria	)GOALTER TABLE dbo.AnagraficaArticoli ADD CONSTRAINT	FK_AnagraficaArticoli_Categorie1 FOREIGN KEY	(	Id_Sagra,	IdCategoriaR	) REFERENCES dbo.Categorie	(	Id_Sagra,	IdCategoria	)GOCOMMIT