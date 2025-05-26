INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(15,'15 - Anagrafica_add_deleteCascade_onEsauriti.sql', '2.4.114', CURRENT_TIMESTAMP, 'Inserita kiave esterna per cancellazione esuriti se cancello codice anagrafica')
go



/*   giovedì 19 ottobre 2017 18.51.22   User: sa   Server: VMXP-SERVER   Database: Sagra   Application: MS SQLEM - Data Tools*/BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.Esauriti
	DROP CONSTRAINT FK_Esauriti_AnagraficaArticoli
GO
COMMIT
BEGIN TRANSACTION
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

GO
COMMIT
