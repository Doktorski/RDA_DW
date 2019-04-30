CREATE VIEW dbo.TvKanali
AS
SELECT 
	TVkanaliKey AS [TV Kanali Key]
	,NazivKanala AS [Naziv Kanala]
	,TVkuca AS [TV Kuca]
	,SedisteTVkuca AS [Sediste TV Kuce]
	,AdresaTVkuca AS [ Adresa TV Kuce]
	,EmailTVkuca AS [E-mail TV Kuce]
	,TelefonTVkuca AS [Teleon TV Kuce]
	,VrstaVlasnistva AS [Vrsta Vlasnistva]
FROM dbo.DimTVkanali
WHERE Obrisan IS NULL;