CREATE VIEW dbo.PrivrednaGrana
AS
SELECT 
	PrivrednaGranaKey AS [Privredna Grana Key]
	,NazivPrivredneGrane AS [Naziv Privredne Grane]
FROM dbo.DimPrivrednaGrana
WHERE Obrisan IS NULL;