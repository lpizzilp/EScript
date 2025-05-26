Insert into IdentReport values(
'rpt80CArticoli.rpt', '80C - Anagrafica articoli') ; 
Insert into IdentReport values(
'rpt80CEvasione.rpt', '80C - Report evasioni reparto' );
Insert into IdentReport values(
'rpt80CEvasione_V.rpt', '80C - Report evasioni reparto X Varianti' );
Insert into IdentReport values(
'rpt80COrdini.rpt', '80C - Stampa Ordini cassa');
Insert into IdentReport values(
'rpt80COrdini_BS.rpt', '80C - Stampa Ordini biglietto singolo');
Insert into IdentReport values(
'rpt80CTotals.rpt','80C - Riepilogo venduto');
Insert into IdentReport values(
'rpt80CTotals_AG.rpt','80C - Riepilogo venduto Aggregato per cassa/utente');
Insert into IdentReport values(
'rpt80CTotals_S.rpt','80C - Riepilogo venduto storico');
Insert into IdentReport values(
'rpt80CUtenti.rpt','80C - Utenti autorizzati');
GO

DELETE FROM    StampeReport 
where IdStampa like  'TERMICA80C%' ;

GO

Insert into StampeReport values (
'frmAnagraficaArticoli'	,'TERMICA80C',	'rpt80CArticoli.rpt');
Insert into StampeReport values (
'frmEvasione',	'TERMICA80C',	    'rpt80CEvasione.rpt');
Insert into StampeReport values (
'frmEvasioneV',	'TERMICA80C',	    'rpt80CEvasione_V.rpt');
Insert into StampeReport values (
'frmOrdini'	,'TERMICA80C',	'rpt80COrdini.rpt');
Insert into StampeReport values (
'frmOrdiniBS'	,'TERMICA80C',	    'rpt80COrdini_BS.rpt');
Insert into StampeReport values (
'frmTotals'	,'TERMICA80C',	'rpt80CTotals.rpt');
Insert into StampeReport values (
'frmTotalsAG'	,'TERMICA80C',	'rpt80CTotals_AG.rpt');
Insert into StampeReport values (
'frmTotalsS'	,'TERMICA80C',	'rpt80CTotals_S.rpt' ); 
Insert into StampeReport values (
'frmManageUsers',	'TERMICA80C',	'rpt80CUtenti.rpt');

GO


