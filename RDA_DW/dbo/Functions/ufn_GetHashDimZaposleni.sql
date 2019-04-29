CREATE FUNCTION dbo.ufn_GetHashDimZaposleni
(
	@IzvorniZaposleni_ID INT
	,@ImeZaposlenog NVARCHAR (20)
	,@PrezimeZaposlenog NVARCHAR (20)
	,@JmbgZaposlenog CHAR (13)
	,@EmailZaposlenog CHAR(20)
	,@PozicijaZaposlenog NVARCHAR (30)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN CAST( HASHBYTES( 'SHA2_512', (
	SELECT 
		@IzvorniZaposleni_ID AS IzvorniZaposleni_ID
		,@ImeZaposlenog AS ImeZaposlenog
		,@PrezimeZaposlenog AS PrezimeZaposlenog
		,@JmbgZaposlenog AS JmbgZaposlenog
		,@EmailZaposlenog AS EmailZaposlenog
		,@PozicijaZaposlenog AS PozicijaZaposlenog
	FOR XML RAW('R'))) AS INT)
END