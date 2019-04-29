CREATE FUNCTION dbo.ufn_GetHashFactNarudzbine
(
	@IzvorniNarudzbine_ID INT
	,@ZaposleniKey INT
	,@OdborKey INT
	,@GradKey INT
	,@VremePrikazivanjaKey INT
	,@KompanijaKey INT
	,@BrojNarudzbina INT
	,@PocetakTermina DATETIME
	,@ZavrsetakTermina DATETIME 
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN CAST( HASHBYTES( 'SHA2_512', (
	SELECT 
		@IzvorniNarudzbine_ID AS IzvorniNarudzbine_ID
		,@ZaposleniKey AS ZaposleniKey
		,@OdborKey AS OdborKey
		,@GradKey AS GradKey
		,@VremePrikazivanjaKey AS VremePrikazivanjaKey
		,@KompanijaKey AS KompanijaKey
		,@BrojNarudzbina AS BrojNarudzbina
		,@PocetakTermina AS PocetakTermina
		,@ZavrsetakTermina AS ZavrsetakTermina
	FOR XML RAW('R'))) AS INT )
END