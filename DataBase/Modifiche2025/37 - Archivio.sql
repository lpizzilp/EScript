BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
commit 


INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(37,'37 - Archivio', '3.0.123', CURRENT_TIMESTAMP, 'Gestione tabelle archivio attraverso viste ')
 

/*
   martedì  giugno 2025 
*/

EXEC sp_rename 'OrdiniSt', 'OrdiniSt_BAK'
go
CREATE VIEW OrdiniSt AS
SELECT * FROM Archive.dbo.OrdiniSt
go

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[OrdiniSt]  TO [public]

	 
EXEC sp_rename 'DettaglioOrdiniSt', 'DettaglioOrdiniSt_BAK'
go
CREATE VIEW DettaglioOrdiniSt AS
SELECT * FROM Archive.dbo.DettaglioOrdiniSt
go

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[DettaglioOrdiniSt]  TO [public]



EXEC sp_rename 'StatoOrdiniSt', 'StatoOrdiniSt_BAK'
go
CREATE VIEW StatoOrdiniSt AS
SELECT * FROM Archive.dbo.StatoOrdiniSt
go

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[StatoOrdiniSt]  TO [public]

	 




