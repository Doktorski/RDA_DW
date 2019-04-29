CREATE FUNCTION dbo.ufn_GetHashDimGrad
(
	@IzvorniGrad_ID INT,
	@NazivGrada NVARCHAR (50),
	@NazivRegiona NVARCHAR (30)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN CAST( HASHBYTES( 'SHA2_512', (
	SELECT 
		@IzvorniGrad_ID AS IzvorniGrad_ID,
		@NazivGrada AS NazivGrada,
		@NazivRegiona AS NazivRegiona
	FOR XML RAW('R'))) AS INT )
END