CREATE VIEW dbo.Grad
AS
SELECT 
	GradKey AS [Grad Key]
	,NazivGrada AS [Naziv Grada]
	,NazivRegiona AS [Naziv Regiona]
FROM dbo.DimGrad
WHERE Obrisan IS NULL;