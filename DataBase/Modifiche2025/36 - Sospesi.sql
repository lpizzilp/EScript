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

INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(36,'36 - Sospesi+Sscorta', '3.0.122', CURRENT_TIMESTAMP, 'Gestione articoli sospesi+ articoli sottoscorta')
 
/*
   martedì  giugno 2024 15.39.28
*/

CREATE TABLE dbo.ArtSospesi
	(
	Id_Sagra char(5) NOT NULL,
	IdArticolo char(5) NOT NULL,
	TsInizio datetime NULL
	)  ON [PRIMARY]

ALTER TABLE dbo.ArtSospesi ADD CONSTRAINT
	PK_ArtSospesi PRIMARY KEY CLUSTERED 
	(
	Id_Sagra,
	IdArticolo
	) ON [PRIMARY]



GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[ArtSospesi]  TO [public]
COMMIT


BEGIN TRANSACTION
ALTER TABLE dbo.Esauriti
	DROP CONSTRAINT FK_Esauriti_AnagraficaArticoli

	
	
ALTER TABLE dbo.Esauriti
	DROP CONSTRAINT DF_Esauriti_StatoNotifica

CREATE TABLE dbo.Tmp_Esauriti
	(
	Id_Sagra char(5) NOT NULL,
	IdArticolo char(5) NOT NULL,
	QtaDisponibile int NOT NULL,
	StatoNotifica int NOT NULL,
	QtaSottoScorta int NOT NULL
	)  ON [PRIMARY]

ALTER TABLE dbo.Tmp_Esauriti ADD CONSTRAINT
	DF_Esauriti_QtaDisponibile DEFAULT 0 FOR QtaDisponibile

ALTER TABLE dbo.Tmp_Esauriti ADD CONSTRAINT
	DF_Esauriti_StatoNotifica DEFAULT (0) FOR StatoNotifica

ALTER TABLE dbo.Tmp_Esauriti ADD CONSTRAINT
	DF_Esauriti_QtaSottoScorta DEFAULT 0 FOR QtaSottoScorta

	
IF EXISTS(SELECT * FROM dbo.Esauriti)
	 EXEC('INSERT INTO dbo.Tmp_Esauriti (Id_Sagra, IdArticolo, QtaDisponibile, StatoNotifica)
		SELECT Id_Sagra, IdArticolo, QtaDisponibile, StatoNotifica FROM dbo.Esauriti (HOLDLOCK TABLOCKX)')

DROP TABLE dbo.Esauriti

EXECUTE sp_rename N'dbo.Tmp_Esauriti', N'Esauriti', 'OBJECT'

ALTER TABLE dbo.Esauriti ADD CONSTRAINT
	PK_Esauriti PRIMARY KEY NONCLUSTERED 
	(
	Id_Sagra,
	IdArticolo
	) WITH FILLFACTOR = 90 ON [PRIMARY]


ALTER TABLE dbo.Esauriti WITH NOCHECK ADD CONSTRAINT
	FK_Esauriti_AnagraficaArticoli FOREIGN KEY
	(
	Id_Sagra,
	IdArticolo
	) REFERENCES dbo.AnagraficaArticoli
	(
	Id_Sagra,
	IdArticolo
	) ON DELETE CASCADE
	 NOT FOR REPLICATION


GRANT SELECT ON dbo.Esauriti TO public  AS dbo
GRANT UPDATE ON dbo.Esauriti TO public  AS dbo
GRANT INSERT ON dbo.Esauriti TO public  AS dbo
GRANT DELETE ON dbo.Esauriti TO public  AS dbo
COMMIT

/*

   domenica 8 giugno 2025 9.01.33

   User: sa

   Server: VMXP-SERVER

   Database: SagraMulti

   Application: MS SQLEM - Data Tools

*/

BEGIN TRANSACTION
CREATE TABLE dbo.AnaArtComposti
	(
	Id_Sagra char(5) NOT NULL,
	IdArticolo char(5) NOT NULL,
	IdArticoloFiglio char(5) NOT NULL,
	QtaFiglio int NOT NULL
	)  ON [PRIMARY]

ALTER TABLE dbo.AnaArtComposti ADD CONSTRAINT
	DF_AnaArtComposti_QtaFiglio DEFAULT 1 FOR QtaFiglio

ALTER TABLE dbo.AnaArtComposti ADD CONSTRAINT
	PK_AnaArtComposti PRIMARY KEY CLUSTERED 
	(
	Id_Sagra,
	IdArticolo,
	IdArticoloFiglio
	) ON [PRIMARY]



GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[AnaArtComposti]  TO [public]

	 

COMMIT


