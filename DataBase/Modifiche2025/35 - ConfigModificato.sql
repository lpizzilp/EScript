BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON

BEGIN TRANSACTION
INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(35,'35 - ConfigModificato', '3.0.80', CURRENT_TIMESTAMP, 'Aggiunto Idsagra a tabella Config')
GO

ALTER TABLE dbo.Config ADD
	Id_sagra char(5) NOT NULL CONSTRAINT DF_Config_Id_sagra DEFAULT 0
GO

DELETE from config where configKey = 'idsagrais'
GO

INSERT INTO Config (ConfigSection, ConfigKey, ConfigValue , Id_Sagra  ) 
values ('Sagra','IdSagraIs','001','00000')
GO
COMMIT


UPDATE CONFIG SET id_sagra = '001' where id_Sagra= '0'
GO 
COMMIT

--select * from catalogosagre
--cambiare 0  e 001 
--INSERT INTO Config (ConfigSection, ConfigKey, ConfigValue , Id_Sagra  )
--SELECT ConfigSection, ConfigKey, ConfigValue , '0' from Config WHERE Id_sagra = '001'
--GO




