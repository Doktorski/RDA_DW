CREATE PROCEDURE dbo.usp_PopulationDimKompanija
AS
BEGIN
	BEGIN TRANSACTION

	MERGE dbo.DimKompanija AS TARGET
	USING (
		SELECT 
			dbo.CreateKeyFromSourceID(Kompanija_ID) AS KompanijaKey
			,Kompanija_ID AS IzvorniKompanija_ID
			,Naziv AS NazivKompanije
			,Sifra AS SifraKompanije
			,Sediste AS SedisteKompanije
			,dbo.ufn_GetHashDimKompanija(
				Kompanija_ID
				,Naziv
				,Sifra
				,Sediste
			) AS HashKey
		FROM [$(RDA)].dbo.Kompanija
	) AS SOURCE ON ( TARGET.HashKey = SOURCE.HashKey )
	WHEN MATCHED THEN 
		UPDATE
			SET TARGET.NazivKompanije = SOURCE.NazivKompanije
				,TARGET.SifraKompanije = SOURCE.SifraKompanije
				,TARGET.SedisteKompanije = SOURCE.SedisteKompanije
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (
			KompanijaKey
			,IzvorniKompanija_ID
			,NazivKompanije
			,SedisteKompanije
			,SifraKompanije
			,HashKey
			,Obrisan
		)
		VALUES (
			SOURCE.KompanijaKey
			,SOURCE.IzvorniKompanija_ID
			,SOURCE.NazivKompanije
			,SOURCE.SedisteKompanije
			,SOURCE.SifraKompanije
			,SOURCE.HashKey
			,NULL
		)
	WHEN NOT MATCHED BY SOURCE THEN UPDATE SET Obrisan = CAST( GETDATE() AS SMALLDATETIME );

	IF @@ERROR <> 0
		BEGIN
			ROLLBACK;
		END
	ELSE
		BEGIN
			COMMIT;
		END
END