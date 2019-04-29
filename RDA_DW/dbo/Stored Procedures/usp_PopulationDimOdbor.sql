CREATE PROCEDURE dbo.usp_PopulationDimOdbor
AS
BEGIN
	BEGIN TRANSACTION

		MERGE dbo.DimOdbor AS TARGET
		USING (
			SELECT 
				dbo.CreateKeyFromSourceID(O.Odbor_ID) AS OdborKey
				,O.Odbor_ID AS IzvorniOdborID
				,O.Naziv AS NazivOdbora
				,PS.Naziv AS NazivPolitickeStranke
				,PS.Opstina AS NazivOpstine
				,dbo.ufn_GetHashDimOdbor(
					O.Odbor_ID
					,O.Naziv
					,PS.Naziv
					,PS.Opstina
				) AS HashKey
			FROM [$(RDA)].dbo.Politicka_stranka AS PS WITH (NOLOCK)
				INNER JOIN [$(RDA)].dbo.Odbor AS O WITH (NOLOCK) ON O.Politicka_stranka_ID=PS.Politicka_stranka_ID
		) AS SOURCE ON ( TARGET.HashKey = SOURCE.HashKey )
		WHEN MATCHED THEN 
			UPDATE
				SET TARGET.NazivOdbora = SOURCE.NazivOdbora 
				,TARGET.NazivPolitickeStranke = SOURCE.NazivPolitickeStranke
				,TARGET.NazivOpstine = SOURCE.NazivOpstine
		WHEN NOT MATCHED BY TARGET THEN 
		INSERT (
			OdborKey
			,IzvorniOdbor_ID
			,NazivOdbora
			,NazivPolitickeStranke
			,NazivOpstine
			,HashKey-->DONE
			,Obrisan
		)
		VALUES (
			SOURCE.OdborKey
			,SOURCE.IzvorniOdborID
			,SOURCE.NazivOdbora
			,SOURCE.NazivPolitickeStranke
			,SOURCE.NazivOpstine
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