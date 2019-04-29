CREATE FUNCTION dbo.ufn_GetHashDimOdbor
(
	@IzvorniOdbor_ID INT,
	@Odbor NVARCHAR (50),
	@Politicka_stranka NVARCHAR (50),
	@Opstina NVARCHAR (50)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN CAST( HASHBYTES( 'SHA2_512', (
	SELECT 
		@IzvorniOdbor_ID AS IzvorniOdbor_ID,
		@Odbor AS Odbor,
		@Politicka_stranka AS Politicka_stranka,
		@Opstina AS Opstina
	FOR XML RAW('R'))) AS INT )
END