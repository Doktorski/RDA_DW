CREATE VIEW dbo.Reklama
AS
SELECT 
	ReklamaKey AS [Reklama Key]
	,TVkanaliKey AS [TV Kanali Key]
	,PrivrednaGranaKey AS [Privredna GranaKey]
	,AgencijaKey AS [Agencija Key]
	,OdborKey AS [Odbor Key]
	,GradKey AS [Grad Key]
	,VremePrikazivanjaKey AS [Vreme Prikazivanja Key]
	,KompanijaKey AS [Kompanija Key]
	,BrojPrikaza AS [Broj Prikaza]
	,TrajanjeReklame AS [Trajanje Reklame]
	,CenaReklame AS [Cena Reklame]
FROM dbo.FactReklama
WHERE Obrisan IS NULL;