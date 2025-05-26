if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Sponsor]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Sponsor]
GO

if not exists (select * from dbo.sysusers where name = N'sagra' and uid < 16382)
	EXEC sp_grantdbaccess N'sagra', N'sagra'
GO

CREATE TABLE [dbo].[Sponsor] (
	[IdKey] [int] IDENTITY (1, 1) NOT NULL ,
	[Id_Sagra] [char] (5) COLLATE Latin1_General_CI_AS NOT NULL ,
	[PercApparizione] [int] NOT NULL ,
	[Descrizione] [varchar] (400) COLLATE Latin1_General_CI_AS NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sponsor] WITH NOCHECK ADD 
	CONSTRAINT [DF_Sponsor_PercApparizione] DEFAULT (1) FOR [PercApparizione]
GO

GRANT  REFERENCES ,  SELECT ,  UPDATE ,  INSERT ,  DELETE  ON [dbo].[Sponsor]  TO [public]
GO

