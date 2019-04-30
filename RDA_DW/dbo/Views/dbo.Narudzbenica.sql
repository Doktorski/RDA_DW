CREATE VIEW dbo.Narudzbenica
AS
SELECT 
	NarudzbeniceKey AS [Narudzbenice Key]
	,ZaposleniKey AS [Zaposleni Key]
	,OdborKey AS [Odbor Key]
	,GradKey AS [Grad Key]
	,VremePrikazivanjaKey AS [Vreme Prikazivanja Key]
	,KompanijaKey AS [Kompanija Key]
	,BrojNarudzbenica AS [Broj Narudzbenica]
	,PocetakTermina AS [Pocetak Termina]
	,ZavrsetakTermina AS [Zavrsetak Termina]
FROM dbo.FactNarudzbenice
WHERE Obrisan IS NULL;