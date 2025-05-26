INSERT INTO ScriptDB([DDLVersion], [ScriptName], [SwVersione], [DataInserimento], [Note])
VALUES(25,'25 -InsertReport_dml.sql', '2.5.25', CURRENT_TIMESTAMP, 'Creati report per stampanti III e IV. Da tenere come default')
go 


DELETE FROM    tipistampa 
where idstampa = 'TERMICA80' ;
go
DELETE FROM    tipistampa 
where idstampa = 'TERMICA80V' ;

Insert into Tipistampa values
('TERMICA80V','Stampante termica 80 Epson III e IV e superiori') ;
go 


DELETE FROM    IdentReport 
where DescReport like  '80 -%' ;
DELETE FROM    IdentReport 
where DescReport like  '80V -%' ;

GO

Insert into IdentReport values(
'rpt80VArticoli.rpt', '80V - Anagrafica articoli') ; 
Insert into IdentReport values(
'rpt80VEvasione.rpt', '80V - Report evasioni reparto' );
Insert into IdentReport values(
'rpt80VEvasione__RA.rpt', '80V - Report evasioni RAUSCEDO' );
Insert into IdentReport values(
'rpt80VEvasione_V.rpt', '80V - Report evasioni reparto X Varianti' );
Insert into IdentReport values(
'rpt80VOrdini.rpt', '80V - Stampa Ordini cassa');
Insert into IdentReport values(
'rpt80VOrdini_1.rpt', '80V - Stampa con pagebreak x reparto');
Insert into IdentReport values(
'rpt80VOrdini_2.rpt', '80V - Stampa Ordini cassa CON biglietto x reparto');
Insert into IdentReport values(
'rpt80VOrdini_11.rpt', '80V - Stampa con pagebreak x reparto + Font Ordine ridotto');
Insert into IdentReport values(
'rpt80VOrdini_BS.rpt', '80V - Stampa Ordini biglietto singolo');
Insert into IdentReport values(
'rpt80VOrdini_PK.rpt', '80V - Stampa IDKEY Ordine parkeggiato');
Insert into IdentReport values(
'rpt80VTotals.rpt','80V - Riepilogo venduto');
Insert into IdentReport values(
'rpt80VTotals_AG.rpt','80V - Riepilogo venduto Aggregato per cassa/utente');
Insert into IdentReport values(
'rpt80VTotals_S.rpt','80V - Riepilogo venduto storico');
Insert into IdentReport values(
'rpt80VUtenti.rpt','80V - Utenti autorizzati');
GO



DELETE FROM    StampeReport 
where IdStampa =  'TERMICA80' ;
DELETE FROM    StampeReport 
where IdStampa =  'TERMICA80V' ;

GO

Insert into StampeReport values (
'frmAnagraficaArticoli'	,'TERMICA80V',	'rpt80VArticoli.rpt');
Insert into StampeReport values (
'frmEvasione',	'TERMICA80V',	    'rpt80VEvasione.rpt');
Insert into StampeReport values (
'frmEvasioneV',	'TERMICA80V',	    'rpt80VEvasione_V.rpt');
Insert into StampeReport values (
'frmOrdini'	,'TERMICA80V',	'rpt80VOrdini.rpt');
Insert into StampeReport values (
'frmOrdiniBS'	,'TERMICA80V',	    'rpt80VOrdini_BS.rpt');
Insert into StampeReport values (
'frmOrdiniPK'	,'TERMICA80V',	    'rpt80VOrdini_PK.rpt');
Insert into StampeReport values (
'frmTotals'	,'TERMICA80V',	'rpt80VTotals.rpt');
Insert into StampeReport values (
'frmTotalsAG'	,'TERMICA80V',	'rpt80VTotals_AG.rpt');
Insert into StampeReport values (
'frmTotalsS'	,'TERMICA80V',	'rpt80VTotals_S.rpt' ); 
Insert into StampeReport values (
'frmManageUsers',	'TERMICA80V',	'rpt80VUtenti.rpt');

GO

