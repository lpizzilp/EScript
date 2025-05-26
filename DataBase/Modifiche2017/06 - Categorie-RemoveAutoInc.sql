INSERT INTO ScriptDB([ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES('6 - Categorie-RemoveAutoInc.sql', 'xx', CURRENT_TIMESTAMP, '')
go




/*   mercoledì 23 agosto 2017 22.37.10   User: sa   Server: VMXP-SERVER   Database: SagraCopia   Application: MS SQLEM - Data Tools*/BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
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
	Descrizione varchar(255) NULL,
	BackcolorTs varchar(10) NULL,
	ForecolorTs varchar(10) NULL,
	IdPosition int NULL,
	IdPositionXRep int NULL
	)  ON [PRIMARY]
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
ALTER TABLE dbo.AnagraficaArticoli
	DROP CONSTRAINT FK_AnagraficaArticoli_Categorie
GO
DROP TABLE dbo.Categorie
GO
EXECUTE sp_rename N'dbo.Tmp_Categorie', N'Categorie', 'OBJECT'
GO
ALTER TABLE dbo.Categorie ADD CONSTRAINT
	PK_Categorie PRIMARY KEY CLUSTERED 
	(
	Id_Sagra,
	IdCategoria
	) WITH FILLFACTOR = 90 ON [PRIMARY]

GO
GRANT SELECT ON dbo.Categorie TO public  AS dbo
GRANT UPDATE ON dbo.Categorie TO public  AS dbo
GRANT INSERT ON dbo.Categorie TO public  AS dbo
GRANT DELETE ON dbo.Categorie TO public  AS dbo
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.AnagraficaArticoli WITH NOCHECK ADD CONSTRAINT
	FK_AnagraficaArticoli_Categorie FOREIGN KEY
	(
	Id_Sagra,
	IdCategoria
	) REFERENCES dbo.Categorie
	(
	Id_Sagra,
	IdCategoria
	) ON UPDATE CASCADE
	 NOT FOR REPLICATION

GO



 CREATE  UNIQUE  INDEX [UQ_Categorie] ON [dbo].[Categorie]([Id_Sagra], [Descrizione]) ON [PRIMARY]
GO
COMMIT

