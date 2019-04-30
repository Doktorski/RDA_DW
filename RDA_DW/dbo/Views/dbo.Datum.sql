CREATE VIEW dbo.Datum
AS
SELECT 
	DateKey AS [Date Key]
	,Datum AS [Datum Sa Vremenom]
	,DatumRS AS [Datum Tip1]
	,DatumRS2 AS [Datum Tip2]
	,DanUMesecu AS [Dan U Mesecu]
	,ImeDana_C AS [Ime Dana Cirilica]
	,ImeDana_L AS [Ime Dana Latinica]
	,DanUSedmici AS [Dan U Sedmici]
	,NedeljaUGodini AS [Nedelja U Godini]
	,Mesec AS [Mesec]
	,ImeMeseca_C AS [Ime Meseca Cirilica]
	,ImeMeseca_L AS [Ime Meseca Latinica]
	,Kvartal AS [Kvartal]
	,ImeKvartala_C AS [Ime Kvartala Cirilica]
	,ImeKvartala_L AS [Ime Kvartala Latinica]
	,Godina AS [Godina]
	,MesecGodina AS [Mesec Godina]
	,MMYYYY AS [Mesec Godina Skraceno]
FROM dbo.DimDatum;