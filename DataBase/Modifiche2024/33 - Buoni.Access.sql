
INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(33,'33 - Buoni', '3.0.30', now(), 'Gestione Buoni')
go 
/*
   martedì  giugno 2024 15.39.28
*/
-- [Buoni] definition


CREATE TABLE [Buoni] (
	[Id_Sagra] TEXT(5) NOT NULL,
	[IdArticolo] TEXT(5) NOT NULL,
	[QtaEmessa] INTEGER NOT NULL,
	CONSTRAINT SYS_PK_10694 PRIMARY KEY ([Id_Sagra], [IdArticolo])
);

	
ALTER TABLE [AnagraficaArticoli] ADD column FlgBuono BOOLEAN  default 0 ;