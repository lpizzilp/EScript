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
VALUES(30,'30 - Gestione Sconto', '2.5.155', CURRENT_TIMESTAMP, 'Creazione Tabella TblSconto + Campo Sconto in Ordini OrdiniPark e OrdiniST')
go 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TblSconto]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TblSconto]
GO

if not exists (select * from dbo.sysusers where name = N'sagra' and uid < 16382)
	EXEC sp_grantdbaccess N'sagra', N'sagra'
GO

BEGIN TRANSACTION

CREATE TABLE [dbo].[TblSconto] (
	[IdKey] [int] IDENTITY (1, 1) NOT NULL ,
	[Id_Sagra] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL ,
	[Sconto] [int] NOT NULL ,
	[Beneficiario] [varchar] (255) COLLATE Latin1_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TblSconto] WITH NOCHECK ADD 
	CONSTRAINT [DF_TblSconto_Sconto] DEFAULT (0) FOR [Sconto]
	
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[TblSconto]  TO [public]
GO
commit 

/* TABELLA ORDINI  */
BEGIN TRANSACTION
ALTER TABLE dbo.Ordini ADD
	Sconto int NOT NULL CONSTRAINT DF_Ordini_Sconto DEFAULT 0
GO
COMMIT


/* TABELLA ORDINI parkeggio   */
BEGIN TRANSACTION
ALTER TABLE dbo.OrdiniPark ADD
	Sconto int NOT NULL CONSTRAINT DF_OrdiniPark_Sconto DEFAULT 0
GO
COMMIT


/* TABELLA ORDINIST    */
BEGIN TRANSACTION
ALTER TABLE dbo.OrdiniSt ADD
	Sconto int NOT NULL CONSTRAINT DF_OrdiniSt_Sconto DEFAULT 0
GO
COMMIT
