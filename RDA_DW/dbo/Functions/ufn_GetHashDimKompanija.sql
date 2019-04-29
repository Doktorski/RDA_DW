CREATE FUNCTION dbo.ufn_GetHashDimKompanija
(
	@IzvorniKompanija_ID INT
	,@NazivKompanije NVARCHAR (50)
	,@SedisteKompanije NVARCHAR (30)
	,@SifraKompanije CHAR(6)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN CAST( HASHBYTES( 'SHA2_512', (
	SELECT 
		@IzvorniKompanija_ID AS IzvorniKompanija_ID
		,@NazivKompanije AS NazivKompanije
		,@SedisteKompanije AS SedisteKompanije
		,@SifraKompanije AS SifraKompanije
	FOR XML RAW('R'))) AS INT)
END