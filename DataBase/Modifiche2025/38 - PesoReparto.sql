/*
   domenica 24 agosto 2025 15.44.39
   Database: SagraMulti
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

INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(38,'38 - PesoReparto', '3.0.146', CURRENT_TIMESTAMP, 'Aggiunto peso reparto per ordinamenti')
GO

ALTER TABLE dbo.Reparti ADD
	PesoReparto int NULL
GO
ALTER TABLE dbo.Reparti ADD CONSTRAINT
	DF_Reparti_PesoReparto DEFAULT 0 FOR PesoReparto
GO

UPDATE REPARTI SET pesoREPARTO = 0 
GO 
COMMIT






