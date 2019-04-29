CREATE FUNCTION dbo.ufn_GetHashDimPrivrednaGrana
(
	@IzvorniPrivrednaGrana_ID INT,
	@Privredna_grana NVARCHAR (50)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN CAST( HASHBYTES( 'SHA2_512', (
	SELECT 
		@IzvorniPrivrednaGrana_ID AS IzvorniPrivrednaGrana_ID,
		@Privredna_grana AS Privredna_grana
	FOR XML RAW('R'))) AS INT )
END