CREATE FUNCTION dbo.ufn_GetHashDimAgencija
(
	@IzvorniAgencija_ID INT,
	@NazivAgencije NVARCHAR (50),
	@SredisteAgencije NVARCHAR(50),
	@AdresaAgencije NVARCHAR(30),
	@TelefonAgencije CHAR(18),
	@EmailAgencije CHAR(20)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN CAST( HASHBYTES( 'SHA2_512', (
	SELECT 
		@IzvorniAgencija_ID AS IzvorniAgencija_ID,
		@NazivAgencije AS NazivAgencije,
		@SredisteAgencije AS SredisteAgencije,
		@AdresaAgencije AS AdresaAgencije,
		@TelefonAgencije AS TelefonAgencije,
		@EmailAgencije AS EmailAgencije
	FOR XML RAW('R'))) AS INT )
END