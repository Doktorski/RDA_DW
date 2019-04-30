CREATE VIEW dbo.Agencija
AS
SELECT 
	AgencijaKey AS [Agencija Key]
	,NazivAgencije AS [Naziv Agencije]
	,SredisteAgencije AS [Sediste Agencije]
	,AdresaAgencije AS [Adresa Agencije]
	,TelefonAgencije AS [Telefon Agencije]
	,EmailAgencije AS [E-mail Agencije]
FROM dbo.DimAgencija
WHERE Obrisan IS NULL;