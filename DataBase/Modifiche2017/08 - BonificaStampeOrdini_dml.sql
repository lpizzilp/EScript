INSERT INTO ScriptDB([ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES('8 - NewStampeOrdini_dml.sql', '2.4.107', CURRENT_TIMESTAMP, 'Create 2 nuove stampe ordini come variante della base. 1ma variante crea rottura pagina per ogni reparto. 2da variante è come la prima con la differenza che l ordine perde il grassetto.')
go

/************************/

Insert into IdentReport values(
'rpt80COrdini_1.rpt', '80C - Stampa Ordini con pagebreak x reparto');

Insert into IdentReport values(
'rpt80COrdini_11.rpt', '80C - Stampa Ordini con pagebreak x reparto + ordine scritto normale 15cpi');




