Insert into Tipistampa values
('TERMICA80III','Stampante termica 80c Epson modelli advanced') ;

go 
DELETE FROM    tipistampa 
where idstampa = 'TERMICA80CASSA' ;

go

Insert into IdentReport values(
'rptUtenti80III.rpt','80CIII- Utenti autorizzati');

Insert into IdentReport values(
'rptRiepVendRid80III_Storico.rpt','8OIII - Riepilogo venduto storico');

Insert into IdentReport values(
'rptRiepVendRid80III.rpt','80III - Riepilogo venduto');

Insert into IdentReport values(

'rptOrdiniRidottaR280III.rpt', '80III - Subreport Ordini biglietto singolo');

Insert into IdentReport values(

'rptOrdiniRidottaR180III.rpt', '80III - Ordini biglietto singolo');
Insert into IdentReport values(

'rptOrdini80III_SV-SS_FF.rpt', '80III - Ordini free font');
Insert into IdentReport values(

'rptEvasione80III.rpt', '80III - Report evasioni' );
Insert into IdentReport values(

'rptAnaArticoliRid80III.rpt', '80III - Anagrafica articoli') ; 

GO

Insert into StampeReport values (
'frmAnagraficaArticoli'	,'TERMICA80III',	'rptAnaArticoliRid80III.rpt');
Insert into StampeReport values (
'frmEvasione',	'TERMICA80III',	    'rptEvasione80III.rpt');
Insert into StampeReport values (
'frmManageUsers',	'TERMICA80III',	'rptUtenti80III.rpt');
Insert into StampeReport values (
'frmOrdini'	,'TERMICA80III',	'rptOrdini80III_SV-SS_FF.rpt');
Insert into StampeReport values (
'frmOrdiniBS'	,'TERMICA80III',	    'rptOrdiniRidottaR180III.rpt');
Insert into StampeReport values (
'frmTotals'	,'TERMICA80III',	'rptRiepVendRid80III.rpt');
Insert into StampeReport values (
'frmTotalsS'	,'TERMICA80III',	'rptRiepVendRid80III_Storico.rpt' ); 

GO