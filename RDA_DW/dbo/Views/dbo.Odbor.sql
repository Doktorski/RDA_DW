CREATE VIEW dbo.Odbor
AS
SELECT 
	OdborKey AS [Odbor Key]
	,NazivOdbora AS [Naziv Odbora]
	,NazivPolitickeStranke AS [Naziv Politicke Stranke]
	,NazivOpstine AS [Naziv Opstine]
FROM dbo.DimOdbor
WHERE Obrisan IS NULL;