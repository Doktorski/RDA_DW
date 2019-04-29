CREATE FUNCTION dbo.ufn_GetHashDimTVkanali
(
	@IzvorniKanali_ID INT
	,@NazivKanala NVARCHAR(30)
	,@TVkuca NVARCHAR(20)
	,@SedisteTVkuca NVARCHAR(30)
	,@AdresaTVkuca NVARCHAR(50)
	,@EmailTVkuca CHAR(25)
	,@TelefonTVkuca CHAR(18)
	,@VrstaVlasnistva NVARCHAR (50)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN CAST( HASHBYTES( 'SHA2_512', (
	SELECT 
		@IzvorniKanali_ID AS IzvorniKanali_ID
		,@NazivKanala AS NazivKanala
		,@TVkuca AS TVkuca
		,@SedisteTVkuca AS SedisteTVkuca
		,@AdresaTVkuca AS AdresaTVkuca
		,@EmailTVkuca AS EmailTVkuca
		,@TelefonTVkuca AS TelefonTVkuca
		,@VrstaVlasnistva AS VrstaVlasnistva
	FOR XML RAW('R'))) AS INT )
END