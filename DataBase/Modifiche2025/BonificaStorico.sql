-- =========================================
-- Script compatibile con SQL Server 2000
-- Archiviazione + override Id_Sagra + TRUNCATE + WHERE
-- =========================================

DECLARE @IdSagra NVARCHAR(5);         -- Nuovo ID da assegnare ai record archiviati
DECLARE @IdSagraFilter NVARCHAR(5);   -- ID esistente da filtrare nei dati sorgente

SET @IdSagra = 'CA2';         -- <<<<< IMPOSTA QUI L'ID SAGRA DA ASSEGNARE NEGLI ARCHIVI
SET @IdSagraFilter = '001';    -- <<<<< IMPOSTA QUI L'ID SAGRA DA FILTRARE NELLE TABELLE ORIGINALI

DECLARE @err INT;

BEGIN TRANSACTION;

-- Archivio StatoOrdini
INSERT INTO [Archive].[dbo].[StatoOrdiniSt]
SELECT
    [Anno],
    @IdSagra AS [Id_Sagra],
    [IdOrdine],
    [Stato],
    [IdReparto],
    [DataInizio],
    [OraInizio],
    [DataFine],
    [OraFine]
FROM [dbo].[StatoOrdiniST]
WHERE Id_Sagra = @IdSagraFilter;

SET @err = @@ERROR;
IF @err <> 0 GOTO ErrorHandler;

-- Archivio DettaglioOrdini
INSERT INTO [Archive].[dbo].[DettaglioOrdiniSt]
SELECT
    [Anno],
    @IdSagra AS [Id_Sagra],
    [IdOrdine],
    [IdArticolo],
    [IdProg],
    [QuantitaOrdinata],
    [PrezzoVendita]
FROM [dbo].[DettaglioOrdiniST]
WHERE Id_Sagra = @IdSagraFilter;

SET @err = @@ERROR;
IF @err <> 0 GOTO ErrorHandler;

-- Archivio Ordini
INSERT INTO [Archive].[dbo].[OrdiniSt]
SELECT
    [Anno],
    @IdSagra AS [Id_Sagra],
    [IDOrdine],
    [DataOrdine],
    [OraOrdine],
    [Tavolo],
    [Coperti],
    [Nominativo],
    [NomeComputer],
    [Utente],
    [TipoOrdine],
    [TipoContabilizzazione],
    [DataEvasione],
    [OraEvasione],
    [Note],
    [Priorita],
    [DataContabile],
    [Sconto]
FROM [dbo].[OrdiniST]
WHERE Id_Sagra = @IdSagraFilter;

SET @err = @@ERROR;
IF @err <> 0 GOTO ErrorHandler;

-- Pulizia tabelle origine
DELETE FROM [dbo].[StatoOrdiniST] WHERE Id_Sagra = @IdSagraFilter;
SET @err = @@ERROR;
IF @err <> 0 GOTO ErrorHandler;

DELETE FROM [dbo].[DettaglioOrdiniST] WHERE Id_Sagra = @IdSagraFilter;
SET @err = @@ERROR;
IF @err <> 0 GOTO ErrorHandler;

DELETE FROM [dbo].[OrdiniST] WHERE Id_Sagra = @IdSagraFilter;
SET @err = @@ERROR;
IF @err <> 0 GOTO ErrorHandler;

COMMIT TRANSACTION;
PRINT '? Archiviazione completata con successo e dati filtrati eliminati.';
RETURN;

-- Gestione errore
ErrorHandler:
    ROLLBACK TRANSACTION;
    PRINT '? Errore durante l''archiviazione. Operazione annullata.';
    RETURN;
