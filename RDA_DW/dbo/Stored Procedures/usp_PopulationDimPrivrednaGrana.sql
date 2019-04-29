CREATE PROCEDURE dbo.usp_PopulationDimPrivrednaGrana
AS
BEGIN
	BEGIN TRANSACTION

		MERGE dbo.DimPrivrednaGrana AS TARGET
		USING (
			SELECT  
				dbo.CreateKeyFromSourceID(Priv_Grana_ID) AS PrivrednaGranaKey
				,Priv_Grana_ID AS IzvorniPrivrednaGranaID
				,Naziv AS NazivPrivredneGrane
				,dbo.ufn_GetHashDimPrivrednaGrana(
					Priv_Grana_ID
					,Naziv
				) AS HashKey
			FROM [$(RDA)].dbo.Privredna_grana
		) AS SOURCE ON ( TARGET.HashKey = SOURCE.HashKey )
		WHEN MATCHED THEN
			UPDATE
				SET TARGET.NazivPrivredneGrane = SOURCE.NazivPrivredneGrane
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (
					PrivrednaGranaKey
					,IzvorniPrivrednaGrana_ID
					,NazivPrivredneGrane
					,HashKey
					,Obrisan
				)
			VALUES (
					SOURCE.PrivrednaGranaKey
					,SOURCE.IzvorniPrivrednaGranaID
					,SOURCE.NazivPrivredneGrane
					,SOURCE.HashKey
					,NULL
				)
		WHEN NOT MATCHED BY SOURCE THEN UPDATE SET Obrisan = 1;

	IF @@ERROR <> 0
		BEGIN
			ROLLBACK;
		END
	ELSE
		BEGIN
			COMMIT;
		END
END