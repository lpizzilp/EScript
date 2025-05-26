INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(18,'18 - Reprot per Parcheggio.sql', '2.4.114', CURRENT_TIMESTAMP, 'Inserimento nuovo report per consegna ID parkeggio')
go

Insert into IdentReport values(
'rpt80COrdini_PK.rpt', '80C - Stampa IDKEY ordine parcheggiato');
GO

Insert into StampeReport values (
'frmOrdiniPK'	,'TERMICA80C',	    'rpt80COrdini_PK.rpt');

GO


