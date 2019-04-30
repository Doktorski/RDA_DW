CREATE VIEW dbo.Kompanija
AS
SELECT 
	KompanijaKey AS [Kompanija Key]
	,NazivKompanije AS [Naziv Kompanija]
	,SedisteKompanije AS [Sediste Kompanije]
	,SifraKompanije AS [Sifra Kompanije]
FROM dbo.DimKompanija
WHERE Obrisan IS NULL;