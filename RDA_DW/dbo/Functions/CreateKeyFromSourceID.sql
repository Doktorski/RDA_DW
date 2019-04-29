﻿CREATE FUNCTION dbo.CreateKeyFromSourceID
(
	@SourceID VARCHAR(MAX)
)
RETURNS INT
AS
BEGIN
	RETURN CAST( HASHBYTES( 'SHA2_512', @SourceID ) AS INT );
END