CREATE FUNCTION dbo.ufn_GetHashFactReklama
(
	@IzvorniReklama_ID INT
	,@TVkanaliKey INT
	,@PrivrednaGranaKey INT
	,@AgencijaKey INT
	,@OdborKey INT
	,@GradKey INT
	,@VremePrikazivanjaKey INT
	,@KompanijaKey INT
	,@BrojPrikaza INT
	,@TrajanjeReklame INT
	,@CenaReklame INT
)
RETURNS INT
AS
BEGIN
	RETURN CAST( HASHBYTES( 'SHA2_512', (
	SELECT 
		@IzvorniReklama_ID AS IzvorniReklama_ID
		,@TVkanaliKey AS TVkanaliKey
		,@PrivrednaGranaKey AS PrivrednaGranaKey
		,@AgencijaKey AS AgencijaKey
		,@OdborKey AS OdborKey
		,@GradKey AS GradKey
		,@VremePrikazivanjaKey AS VremePrikazivanjaKey
		,@KompanijaKey AS KompanijaKey
		,@BrojPrikaza AS BrojPrikaza
		,@TrajanjeReklame AS TrajanjeReklame
		,@CenaReklame AS CenaReklame
	FOR XML RAW('R'))) AS INT )
END