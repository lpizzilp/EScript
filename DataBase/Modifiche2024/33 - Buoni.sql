BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT

INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(33,'33 - Buoni', '3.0.30', CURRENT_TIMESTAMP, 'Gestione Buoni')
go 
/*
   martedì  giugno 2024 15.39.28
*/

BEGIN TRANSACTION
CREATE TABLE dbo.Buoni
	(
	Id_Sagra char(5) NOT NULL,
	IdArticolo char(5) NOT NULL,
	QtaEmessa int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Buoni ADD CONSTRAINT
	DF_Buoni_QtaEmessa DEFAULT 0 FOR QtaEmessa
GO


ALTER TABLE dbo.AnagraficaArticoli ADD
	FlgBuono bit NOT NULL CONSTRAINT DF_AnagraficaArticoli_FlgBuono DEFAULT 0
GO



ALTER TABLE dbo.Buoni ADD CONSTRAINT
	FK_Buoni_AnagraficaArticoli FOREIGN KEY
	(
	Id_Sagra,
	IdArticolo
	) REFERENCES dbo.AnagraficaArticoli
	(
	Id_Sagra,
	IdArticolo
	) ON DELETE CASCADE
	 NOT FOR REPLICATION
GO 


GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Buoni]  TO [public]
GO
	 
COMMIT


