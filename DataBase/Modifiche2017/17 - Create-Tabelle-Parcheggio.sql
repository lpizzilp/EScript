INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(17,'17 - Create-Tabelle-Parcheggio.sql', '2.4.114', CURRENT_TIMESTAMP, 'Creazione tabelle Ordini e DettaglioOrdini per funzione parcheggio')
go

 CREATE TABLE [dbo].[OrdiniPark] (
	[Id_Sagra] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL ,
	[IDOrdine] [int] NOT NULL ,
	[DataOrdine] [char] (10) COLLATE Latin1_General_CI_AS NULL ,
	[OraOrdine] [char] (10) COLLATE Latin1_General_CI_AS NULL ,
	[Tavolo] [varchar] (10) COLLATE Latin1_General_CI_AS NULL ,
	[Coperti] [varchar] (10) COLLATE Latin1_General_CI_AS NULL ,
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
	[IdKey] [varchar] (20) COLLATE Latin1_General_CI_AS NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrdiniPark] WITH NOCHECK ADD 
	CONSTRAINT [PK_OrdiniPark] PRIMARY KEY  CLUSTERED 
	(
		[Id_Sagra],
		[IDOrdine]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

 CREATE  INDEX [IX_OrdiniPark] ON [dbo].[OrdiniPark]([DataOrdine]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [IX_OrdiniPark_1] ON [dbo].[OrdiniPark]([Id_Sagra], [TipoOrdine]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE dbo.OrdiniPark ADD CONSTRAINT
	IX_OrdiniPark_2 UNIQUE NONCLUSTERED 
	(
	Id_Sagra,
	Idkey
	) ON [PRIMARY]

GO

GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[OrdiniPark]  TO [public]
GO



CREATE TABLE [dbo].[DettaglioOrdiniPark] (
	[Id_Sagra] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL ,
	[IdOrdine] [int] NOT NULL ,
	[IdArticolo] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL ,
	[IdProg] [int] NOT NULL ,
	[QuantitaOrdinata] [int] NULL ,
	[PrezzoVendita] [real] NULL 
) ON [PRIMARY]
GO

 CREATE  UNIQUE  CLUSTERED  INDEX [pk_DettaglioOrdiniPark] ON [dbo].[DettaglioOrdiniPark]([Id_Sagra], [IdOrdine], [IdProg], [IdArticolo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [IX_DettaglioOrdiniPark] ON [dbo].[DettaglioOrdiniPark]([Id_Sagra], [IdOrdine], [IdArticolo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO


GRANT  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[DettaglioOrdiniPark]  TO [public]
GO

BEGIN TRANSACTION
ALTER TABLE dbo.DettaglioOrdiniPark WITH NOCHECK ADD CONSTRAINT
	FK_DettaglioOrdiniPark_OrdiniPark FOREIGN KEY
	(
	Id_Sagra,
	IdOrdine
	) REFERENCES dbo.OrdiniPark
	(
	Id_Sagra,
	IDOrdine
	) ON DELETE CASCADE
	 NOT FOR REPLICATION

GO
COMMIT
