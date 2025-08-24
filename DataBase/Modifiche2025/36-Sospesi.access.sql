
-- Inserimento nella tabella ScriptDB
INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(36,'36 - Sospesi+Sscorta', '3.0.123', NOW(), 'Gestione articoli sospesi+ articoli sottoscorta')


-- Creazione della tabella ArtSospesi
CREATE TABLE ArtSospesi (
    Id_Sagra TEXT(5) NOT NULL,
    IdArticolo TEXT(5) NOT NULL,
    TsInizio DATETIME,
    CONSTRAINT PK_ArtSospesi PRIMARY KEY (Id_Sagra, IdArticolo)
);


-- Eliminazione della tabella Esauriti se esiste
DROP TABLE IF EXISTS Esauriti;

-- Creazione della tabella Esauriti
CREATE TABLE Esauriti (
    Id_Sagra TEXT(5) NOT NULL,
    IdArticolo TEXT(5) NOT NULL,
    QtaDisponibile INTEGER DEFAULT 0,
    StatoNotifica INTEGER DEFAULT 0,
    QtaSottoScorta INTEGER DEFAULT 0,
    CONSTRAINT PK_Esauriti PRIMARY KEY (Id_Sagra, IdArticolo)
);

-- Creazione della tabella AnaArtComposti
CREATE TABLE AnaArtComposti (
    Id_Sagra TEXT(5) NOT NULL,
    IdArticolo TEXT(5) NOT NULL,
    IdArticoloFiglio TEXT(5) NOT NULL,
    QtaFiglio INTEGER  NOT NULL DEFAULT 1,
    CONSTRAINT PK_AnaArtComposti PRIMARY KEY (Id_Sagra, IdArticolo, IdArticoloFiglio)
	);