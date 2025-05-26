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
VALUES(32,'32 - Modfica Parkeggio', '2.6.0', CURRENT_TIMESTAMP, 'Moodifica logica Parkeggio in ottica annche degli ordini WEB')
go 
/*
   martedì 27 giugno 2023 15.39.28
*/

BEGIN TRANSACTION
ALTER TABLE dbo.AnagraficaArticoli ADD
	FlgPrenotabile bit NOT NULL CONSTRAINT DF_AnagraficaArticoli_FlgPrenotabile DEFAULT 0,
	Img varchar(50) NULL,
	ExtendedDesc varchar(100) NULL,
	DataFinePRT varchar(8) NULL

GO


ALTER TABLE dbo.Catalogo_Sagre ADD
	FlgOrdiniWeb bit NOT NULL CONSTRAINT DF_Catalogo_Sagre_FlgOrdiniWeb DEFAULT 0
GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_DettaglioOrdiniPark_OrdiniPark]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[DettaglioOrdiniPark] DROP CONSTRAINT FK_DettaglioOrdiniPark_OrdiniPark
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DettaglioOrdiniPark]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DettaglioOrdiniPark]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrdiniPark]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OrdiniPark]
GO


CREATE TABLE [dbo].[OrdiniPark] (
	[Id_Sagra] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL ,
	[IdRecord] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL ,
	[IDOrdine] [int] NOT NULL ,
	[DataOrdine] [char] (10) COLLATE Latin1_General_CI_AS NULL ,
	[OraOrdine] [char] (10) COLLATE Latin1_General_CI_AS NULL ,
	[Tavolo] [varchar] (20) COLLATE Latin1_General_CI_AS NULL ,
	[Coperti] [varchar] (20) COLLATE Latin1_General_CI_AS NULL ,
	[Nominativo] [varchar] (30) COLLATE Latin1_General_CI_AS NULL ,
	[NomeComputer] [varchar] (20) COLLATE Latin1_General_CI_AS NULL ,
	[Utente] [varchar] (10) COLLATE Latin1_General_CI_AS NULL ,
	[TipoOrdine] [varchar] (2) COLLATE Latin1_General_CI_AS NULL ,
	[TipoContabilizzazione] [char] (1) COLLATE Latin1_General_CI_AS NULL ,
	[DataEvasione] [char] (10) COLLATE Latin1_General_CI_AS NULL ,
	[OraEvasione] [char] (10) COLLATE Latin1_General_CI_AS NULL ,
	[Note] [char] (200) COLLATE Latin1_General_CI_AS NULL ,
	[Priorita] [char] (1) COLLATE Latin1_General_CI_AS NULL ,
	[DataContabile] [char] (8) COLLATE Latin1_General_CI_AS NULL ,
	[Idkey] [varchar] (20) COLLATE Latin1_General_CI_AS NULL ,
	[Sconto] [int] NOT NULL ,
	[Status] [int] NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrdiniPark] ADD 
	CONSTRAINT [DF_OrdiniPark_IdRecord] DEFAULT ('K') FOR [IdRecord],
	CONSTRAINT [DF_OrdiniPark_Sconto] DEFAULT (0) FOR [Sconto],
	CONSTRAINT [DF_OrdiniPark_Status] DEFAULT (0) FOR [Status],
	CONSTRAINT [PK_OrdiniPark] PRIMARY KEY  CLUSTERED 
	(
		[Id_Sagra],
		[IdRecord],
		[IDOrdine]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
	
go 

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[OrdiniPark]  TO [public]
GO
/*---------------------------------------*/
/* DETTAGLIO ORDINI PARKEGGIO */ 



CREATE TABLE [dbo].[DettaglioOrdiniPark] (
	[Id_Sagra] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL ,
	[IdRecord] [char] (1) COLLATE Latin1_General_CI_AS NOT NULL ,
	[IdOrdine] [int] NOT NULL ,
	[IdArticolo] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL ,
	[IdProg] [int] NOT NULL ,
	[QuantitaOrdinata] [int] NULL ,
	[PrezzoVendita] [real] NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DettaglioOrdiniPark] ADD 
	CONSTRAINT [DF_DettaglioOrdiniPark_iDrecord] DEFAULT ('K') FOR [IdRecord],
	CONSTRAINT [IX_DettaglioOrdiniPark_1] UNIQUE  NONCLUSTERED 
	(
		[Id_Sagra],
		[IdRecord],
		[IdOrdine],
		[IdProg],
		[IdArticolo]
	)  ON [PRIMARY] 
GO

 CREATE  INDEX [IX_DettaglioOrdiniPark] ON [dbo].[DettaglioOrdiniPark]([Id_Sagra], [IdRecord], [IdOrdine], [IdArticolo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrdiniPark] ADD 
	CONSTRAINT [DF_OrdiniPark_IdRecord] DEFAULT ('K') FOR [IdRecord],
	CONSTRAINT [DF_OrdiniPark_Sconto] DEFAULT (0) FOR [Sconto]
GO

ALTER TABLE [dbo].[DettaglioOrdiniPark] ADD 
	CONSTRAINT [FK_DettaglioOrdiniPark_OrdiniPark] FOREIGN KEY 
	(
		[Id_Sagra],
		[IdRecord],
		[IdOrdine]
	) REFERENCES [dbo].[OrdiniPark] (
		[Id_Sagra],
		[IdRecord],
		[IDOrdine]
	) ON DELETE CASCADE 
GO


ALTER TABLE dbo.TblAppo ADD
	Stringa_dummy1 varchar(50) NOT NULL CONSTRAINT DF_TblAppo_String_dummy1 DEFAULT '', 
	Numerico_dummy1 real NOT NULL CONSTRAINT DF_TblAppo_Numerico_dummy1 DEFAULT 0,
	Stringa_dummy2 varchar(50) NOT NULL CONSTRAINT DF_TblAppo_String_dummy2 DEFAULT '',
	Numerico_dummy2 real NOT NULL CONSTRAINT DF_TblAppo_Numerico_dummy2 DEFAULT 0
go

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[DettaglioOrdiniPark]  TO [public]
GO

COMMIT


