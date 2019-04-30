CREATE PROCEDURE dbo.usp_PopulationDimGrad
AS
BEGIN
	BEGIN TRANSACTION

	MERGE dbo.DimGrad AS TARGET
	USING (
		SELECT 
			dbo.CreateKeyFromSourceID(G.Grad_ID) AS GradKey
			,G.Grad_ID AS IzvorniGradID 
			,G.Naziv AS NazivGrada
			,R.Naziv AS NazivRegiona
			,dbo.ufn_GetHashDimGrad(
				R.Region_ID
				,R.Naziv
				,G.Naziv
			) AS HashKey
		FROM [$(RDA)].dbo.Grad AS G WITH (NOLOCK)
			INNER JOIN [$(RDA)].dbo.Region AS R WITH (NOLOCK) ON G.Region_ID=R.Region_ID
	) AS SOURCE ON ( TARGET.HashKey = SOURCE.HashKey )
	WHEN MATCHED THEN
		UPDATE
			SET TARGET.NazivRegiona = SOURCE.NazivRegiona
				,TARGET.NazivGrada = SOURCE.NazivGrada
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (
			GradKey
			,IzvorniGrad_ID
			,NazivGrada
			,NazivRegiona
			,HashKey
			,Obrisan
		) 
		VALUES (
			SOURCE.GradKey
			,SOURCE.IzvorniGradID
			,SOURCE.NazivGrada
			,SOURCE.NazivRegiona
			,SOURCE.HashKey
			,NULL
		)
	WHEN NOT MATCHED BY SOURCE THEN UPDATE SET TARGET.Obrisan = CAST( GETDATE() AS SMALLDATETIME );

	IF @@ERROR <> 0
		BEGIN
			ROLLBACK;
		END
	ELSE
		BEGIN
			COMMIT;
		END
END