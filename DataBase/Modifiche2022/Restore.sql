USE Master; 
GO  
SET NOCOUNT ON 
DECLARE @dbName sysname 
DECLARE @IDSAGRA NVARCHAR(10) 
-- -------------------------------------
SET @dbName = 'Sagravigonovo' 
SET @IDSAGRA = '001'
-- -------------------------------------
-- 1 - Variable declaration 
DECLARE @backupPath NVARCHAR(500) 
DECLARE @cmd NVARCHAR(500) 
DECLARE @lastFullBackup NVARCHAR(500) 
DECLARE @lastDiffBackup NVARCHAR(500) 
DECLARE @backupFile NVARCHAR(500) 
DECLARE @CRLF VARCHAR(100)
DECLARE @SEP VARCHAR(100)
DECLARE @ORDINE NVARCHAR(10)

-- -------------------------------------
-- 2 - Initialize variables 
-- -------------------------------------
SET @backupPath = 'D:\BACKUP\' 
SET @CRLF = CHAR(13)+CHAR(10)
SET @SEP = @CRLF + '-------------------------------------'  

-- -------------------------------------
-- 3 - get list of files 
CREATE TABLE #fileList (backupFile NVARCHAR(255))
SET @cmd = 'DIR /b "' + @backupPath + '"'

INSERT INTO #fileList(backupFile) 
EXEC xp_cmdshell @cmd 

-- -------------------------------------
-- 4 - Find latest full backup 
SELECT @lastFullBackup = MAX(backupFile)  
FROM #fileList  
WHERE backupFile LIKE '%Full.BAK'  
   AND backupFile LIKE @dbName + '%' 

SET @cmd = 'RESTORE DATABASE [' + @dbName + '] FROM DISK = '''  
       + @backupPath + @lastFullBackup + ''' WITH NORECOVERY' 

PRINT @SEP + @SEP
PRINT @cmd 
exec sp_executesql @cmd
PRINT @SEP + @SEP

-- -------------------------------
-- 5 - Find latest diff backup 
SELECT @lastDiffBackup = MAX(backupFile)  
FROM #fileList  
WHERE backupFile LIKE '%Inc.BAK'  
   AND backupFile LIKE @dbName + '%' 
   AND backupFile > @lastFullBackup 

-- check to make sure there is a diff backup 
IF @lastDiffBackup IS NOT NULL 
BEGIN 
   SET @cmd = 'RESTORE DATABASE [' + @dbName + '] FROM DISK = '''  
       + @backupPath + @lastDiffBackup + ''' WITH NORECOVERY' 
	   
   PRINT @cmd 
   exec sp_executesql @cmd
   PRINT @SEP + @SEP
END 

-- -------------------------------------
-- 6 - put database in a useable state 
SET @cmd = 'RESTORE DATABASE [' + @dbName + '] WITH RECOVERY' 

PRINT @cmd 

exec sp_executesql @cmd
PRINT @SEP + @SEP

-- -------------------------------------
-- 7 - set user operative
set @cmd = 'use ' + @dbName 
exec sp_executesql @cmd 

EXEC sp_revokedbaccess 'sagra'
EXEC sp_grantdbaccess 'sagra'

use sagra
-- -------------------------------------
-- 8 - Ultimo ordine immesso 
PRINT @SEP + @SEP
SELECT @ORDINE = MAX(IDORDINE) FROM ORDINI where id_sagra = @IDSAGRA 
PRINT @CRLF
-- -------------------------------------
-- 9 - Inserisci tabella Recovery
PRINT @SEP + @SEP
PRINT @CRLF
PRINT 'Inserimento tabella Recovery '
Delete from TblRecovery ;

INSERT INTO TblRecovery 
SELECT distinct('R') as section , CT.IdReparto as Rif, getdate() as DataEvento, 'Y' as Active
                     FROM CassaReparti Ct
                     WHERE CT.Id_Sagra = @IDSAGRA
                     AND   CT.ModoEvasione = 'A' 

UNION 
SELECT distinct('C') as section , CT.Idcassa as Rif, getdate() as DataEvento, 'Y' as Active
                     FROM CassaReparti Ct
                     WHERE CT.Id_Sagra = @IDSAGRA
                     AND   CT.ModoEvasione = 'A' 
	                     

UNION
SELECT 'O' as section, CAST(MAX(IDORDINE)  as varchar(10) ) as rif, getdate() as DataEvento,  CAST((MAX(IDORDINE)+100)  as varchar(10) ) as Active
FROM ORDINI 
where id_sagra = @IDSAGRA

ORDER BY 1,2

PRINT @CRLF
-- -------------------------------------
-- 10 - Inserisci ultimo record
PRINT @SEP + @SEP
PRINT @CRLF
PRINT 'Inserisci ultimo record'
PRINT @CRLF

DECLARE @ORDINE_100 NVARCHAR(10)
SET @ORDINE_100 = @ORDINE + 100

INSERT INTO ORDINI
SELECT Id_Sagra, @ORDINE_100, DataOrdine, OraOrdine, Tavolo, Coperti, Nominativo, NomeComputer ,Utente, TipoOrdine
                             ,TipoContabilizzazione, DataEvasione,OraEvasione , 'RECOVERY', Priorita,DataContabile  
                             FROM Ordini 
                             WHERE Id_Sagra =  @IDSAGRA
								and IdOrdine = @ORDINE
								AND DataEvasione <> ''

PRINT @SEP + @SEP
go
QUIT
