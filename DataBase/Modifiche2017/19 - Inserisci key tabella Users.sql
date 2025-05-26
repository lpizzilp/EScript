INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(19,'19 - Inserisci key tabella Users.sql', '2.4.114', CURRENT_TIMESTAMP, 'Inserisco chiava idsagra alla tabella utenti')
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
ALTER TABLE dbo.Users
	DROP CONSTRAINT DF_Users_ChangePwd
GO
CREATE TABLE dbo.Tmp_Users
	(
	ID int NOT NULL,
	Id_Sagra char(5) NOT NULL,
	UserName varchar(10) NOT NULL,
	Password varchar(32) NOT NULL,
	Nome varchar(25) NOT NULL,
	Cognome varchar(50) NOT NULL,
	AuthLevel int NOT NULL,
	ChangePwd int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Users ADD CONSTRAINT
	DF_Users_Id_Sagra DEFAULT '001' FOR Id_Sagra
GO
ALTER TABLE dbo.Tmp_Users ADD CONSTRAINT
	DF_Users_ChangePwd DEFAULT (1) FOR ChangePwd
GO
IF EXISTS(SELECT * FROM dbo.Users)
	 EXEC('INSERT INTO dbo.Tmp_Users (ID, UserName, Password, Nome, Cognome, AuthLevel, ChangePwd)
		SELECT ID, UserName, Password, Nome, Cognome, AuthLevel, ChangePwd FROM dbo.Users (HOLDLOCK TABLOCKX)')
GO
DROP TABLE dbo.Users
GO
EXECUTE sp_rename N'dbo.Tmp_Users', N'Users', 'OBJECT'
GO
CREATE UNIQUE CLUSTERED INDEX ixID ON dbo.Users
	(
	ID DESC
	) WITH FILLFACTOR = 90 ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX ixUserName ON dbo.Users
	(
	UserName
	) WITH FILLFACTOR = 90 ON [PRIMARY]
GO
GRANT SELECT ON dbo.Users TO public  AS dbo
GRANT UPDATE ON dbo.Users TO public  AS dbo
GRANT INSERT ON dbo.Users TO public  AS dbo
GRANT DELETE ON dbo.Users TO public  AS dbo
COMMIT

BEGIN TRANSACTION
DROP INDEX dbo.Users.ixUserName
GO
ALTER TABLE dbo.Users ADD CONSTRAINT
	PK_Users PRIMARY KEY NONCLUSTERED 
	(
	Id_Sagra,
	UserName
	) ON [PRIMARY]

GO
COMMIT

BEGIN TRANSACTION
DROP INDEX dbo.Users.ixID
GO
CREATE UNIQUE CLUSTERED INDEX ixID ON dbo.Users
	(
	ID DESC,
	Id_Sagra
	) WITH FILLFACTOR = 90 ON [PRIMARY]
GO
COMMIT


/*
insert into users
select id,'002',username, password,nome,cognome, authlevel ,changepwd from users
where id_sagra='001'
*/