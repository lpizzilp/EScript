INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(26,'26 -Disabilitazione Articoli', '2.5.26', CURRENT_TIMESTAMP, 'Inserita la possibilità di disabilitare gli articoli')
go 

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
ALTER TABLE dbo.AnagraficaArticoli ADD
	FlgDisabled bit NOT NULL CONSTRAINT DF_AnagraficaArticoli_FlgDisabled DEFAULT 0,
	FlgValidita bit NOT NULL CONSTRAINT DF_AnagraficaArticoli_FlgValidita DEFAULT 0,
	DataInizioValidita varchar(8) NOT NULL CONSTRAINT DF_AnagraficaArticoli_DataInizioValidita DEFAULT '',
	DataFineValidita varchar(9) NOT NULL CONSTRAINT DF_AnagraficaArticoli_DataFineValidita DEFAULT ''
GO
COMMIT

BEGIN TRANSACTION
GO
update anagraficaarticoli
set flgdisabled  = 1
where idreparto = 'D'

COMMIT
