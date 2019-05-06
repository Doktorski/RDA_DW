
CREATE VIEW [dbo].[Zaposleni]
AS
SELECT 
	ZaposleniKey AS [Zaposleni Key]
	,ImeZaposlenog AS [Ime Zaposlenog] 
	,PrezimeZaposlenog AS [Prezime Zaposlenog]
	,JmbgZaposlenog AS [JMBG Zaposlenog]
	,PozicijaZaposlenog AS [Pozicija Zaposlenog]
	,EmailZaposlenog AS [Email Zasposlenog]
FROM dbo.DimZaposleni
WHERE Obrisan IS NULL;