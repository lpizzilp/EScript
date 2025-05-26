INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(14,'14 - TipiCassa_Addfield_QuickCassa.sql', '2.4.114', CURRENT_TIMESTAMP, 'Aggiunto campo per svincolare il cambio cassa da costanti T A B P')
go




/*
   mercoledì 18 ottobre 2017 13.31.40   User: sa   Server: VMXP-SERVER   Database: Sagra   Application: MS SQLEM - Data Tools*/BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.TipiCassa ADD
	IdQuickCassa int NOT NULL CONSTRAINT DF_TipiCassa_IdQuickCassa DEFAULT 0
GO

UPDATE TIPICASSA SET idquickcassa = 1 where idcassa= 'T'
UPDATE TIPICASSA SET idquickcassa = 2 where idcassa= 'A'
UPDATE TIPICASSA SET idquickcassa = 3 where idcassa= 'B'
UPDATE TIPICASSA SET idquickcassa = 4 where idcassa= 'P'
GO
COMMIT

