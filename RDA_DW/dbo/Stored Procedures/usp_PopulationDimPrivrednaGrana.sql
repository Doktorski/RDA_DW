CREATE PROCEDURE dbo.usp_PopulationDimPrivrednaGrana
AS
BEGIN
	BEGIN TRANSACTION

		MERGE dbo.DimPrivrednaGrana AS TARGET
		USING (
			SELECT  
				[dbo].[CreateKeyFromSourceID](pg.[Priv_Grana_ID]) AS PrivrednaGranaKey
				,pg.[Priv_Grana_ID] AS IzvorniPrivrednaGranaID
				,pg.[Naziv] AS NazivPrivredneGrane
				,[dbo].[ufn_GetHashDimPrivrednaGrana](
					pg.[Priv_Grana_ID]
					,pg.[Naziv]
				) AS HashKey
			FROM [$(RDA)].[dbo].[Privredna_grana] AS pg
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
		WHEN NOT MATCHED BY SOURCE THEN UPDATE SET TARGET.Obrisan = 1;

	IF @@ERROR <> 0
		BEGIN
			ROLLBACK;
		END
	ELSE
		BEGIN
			COMMIT;
		END
END