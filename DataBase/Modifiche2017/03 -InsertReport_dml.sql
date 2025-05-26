Insert into Tipistampa values
('TERMICA80','Stampante termica 80 Epson APD') ;

go 
DELETE FROM    tipistampa 
where idstampa = 'TERMICA80III' ;

go

Insert into IdentReport values(
'rpt80Articoli.rpt', '80 - Anagrafica articoli') ; 
Insert into IdentReport values(
'rpt80Evasione.rpt', '80 - Report evasioni reparto' );
Insert into IdentReport values(
'rpt80Evasione_V.rpt', '80 - Report evasioni reparto X Varianti' );
Insert into IdentReport values(
'rpt80Ordini.rpt', '80 - Stampa Ordini cassa');
Insert into IdentReport values(
'rpt80Ordini_BS.rpt', '80 - Stampa Ordini biglietto singolo');
Insert into IdentReport values(
'rpt80Totals.rpt','80 - Riepilogo venduto');
Insert into IdentReport values(
'rpt80Totals_AG.rpt','8O - Riepilogo venduto Aggregato per cassa/utente');
Insert into IdentReport values(
'rpt80Totals_S.rpt','8O - Riepilogo venduto storico');
Insert into IdentReport values(
'rpt80Utenti.rpt','80 - Utenti autorizzati');
GO
DELETE FROM    IdentReport 
where IdReport like  '%III%' ;

GO

Insert into StampeReport values (
'frmAnagraficaArticoli'	,'TERMICA80',	'rpt80Articoli.rpt');
Insert into StampeReport values (
'frmEvasione',	'TERMICA80',	    'rpt80Evasione.rpt');
Insert into StampeReport values (
'frmEvasioneV',	'TERMICA80',	    'rpt80Evasione_V.rpt');
Insert into StampeReport values (
'frmOrdini'	,'TERMICA80',	'rpt80Ordini.rpt');
Insert into StampeReport values (
'frmOrdiniBS'	,'TERMICA80',	    'rpt80Ordini_BS.rpt');
Insert into StampeReport values (
'frmTotals'	,'TERMICA80',	'rpt80Totals.rpt');
Insert into StampeReport values (
'frmTotalsAG'	,'TERMICA80',	'rpt80Totals_AG.rpt');
Insert into StampeReport values (
'frmTotalsS'	,'TERMICA80',	'rpt80Totals_S.rpt' ); 
Insert into StampeReport values (
'frmManageUsers',	'TERMICA80',	'rpt80Utenti.rpt');

GO

DELETE FROM    StampeReport 
where IdStampa =  'TERMICA80III' ;

GO


Insert into IdentReport values(
'rptEvasione80_V.rpt', '80C - Report evasioni reparto X Varianti' );
Insert into IdentReport values(
'rptRiepVendRid80_AGG.rpt','8OC - Riepilogo venduto Aggregato per cassa/utente');

Insert into StampeReport values (
'frmEvasioneV',	'TERMICA80C',	    'rptEvasione80_V.rpt');
Insert into StampeReport values (
'frmTotalsAG'	,'TERMICA80C',	'rptRiepVendRid80_AGG.rpt');
go