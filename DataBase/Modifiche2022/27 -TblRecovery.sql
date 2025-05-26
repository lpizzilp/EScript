INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(27,'27 - TblRecovery', '2.5.26', CURRENT_TIMESTAMP, 'Creazione della tabella per la gestione del Recovry da Disastro')
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
CREATE TABLE [dbo].[TblRecovery] (
	[Sezione] [varchar] (2) COLLATE Latin1_General_CI_AS NULL ,
	[Riferimento] [varchar] (10) COLLATE Latin1_General_CI_AS NULL ,
	[DataEvento] [varchar] (22) COLLATE Latin1_General_CI_AS NULL ,
	[Active] [varchar] (10) COLLATE Latin1_General_CI_AS NULL 
) ON [PRIMARY]

GO
COMMIT

