CREATE PROCEDURE [dbo].usp_PopulationDimZaposleni
AS
BEGIN
	BEGIN TRANSACTION

	MERGE [dbo].[DimZaposleni] AS TARGET
	USING (
		SELECT 
			dbo.CreateKeyFromSourceID(Z.Zaposleni_ID) AS ZaposleniKey
			,Z.Zaposleni_ID AS IzvorniZaposleni_ID
			,Z.Ime AS ImeZaposlenog
			,Z.Prezime AS PrezimeZaposlenog
			,Z.JMBG AS JmbgZaposlenog
			,Z.Email AS EmailZaposlenog
			,PZ.Pozicija AS PozicijaZaposlenog
			,dbo.ufn_GetHashDimZaposleni(
				Z.Zaposleni_ID
				,Z.Ime
				,Z.Prezime
				,Z.JMBG
				,Z.Email
				,PZ.Pozicija
			) AS HashKey
		FROM [$(RDA)].dbo.Zaposleni AS Z WITH (NOLOCK)
			INNER JOIN [$(RDA)].dbo.Pozicija_zaposlenog AS PZ WITH (NOLOCK) ON Z.Poz_zaposlenog_ID=PZ.Poz_zaposlenog_ID
	) AS SOURCE ON ( TARGET.HashKey = SOURCE.HashKey )
	WHEN MATCHED THEN
		UPDATE
			SET TARGET.ImeZaposlenog = SOURCE.ImeZaposlenog
				,TARGET.PrezimeZaposlenog = SOURCE.PrezimeZaposlenog
				,TARGET.JmbgZaposlenog = SOURCE.JmbgZaposlenog
				,TARGET.EmailZaposlenog = SOURCE.EmailZaposlenog
				,TARGET.PozicijaZaposlenog = SOURCE.PozicijaZaposlenog
	WHEN NOT MATCHED BY TARGET THEN
		INSERT(
			ZaposleniKey
			,IzvorniZaposleni_ID
			,ImeZaposlenog
			,PrezimeZaposlenog
			,JmbgZaposlenog
			,EmailZaposlenog
			,PozicijaZaposlenog
			,HashKey
			,Obrisan
		)
		VALUES(
			SOURCE.ZaposleniKey
			,SOURCE.IzvorniZaposleni_ID
			,SOURCE.ImeZaposlenog
			,SOURCE.PrezimeZaposlenog
			,SOURCE.JmbgZaposlenog
			,SOURCE.EmailZaposlenog
			,SOURCE.PozicijaZaposlenog
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