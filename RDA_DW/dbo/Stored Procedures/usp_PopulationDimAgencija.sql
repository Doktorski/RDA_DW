CREATE PROCEDURE dbo.usp_PopulationDimAgencija
AS
BEGIN
	BEGIN TRANSACTION
		
		MERGE dbo.DimAgencija AS TARGET
		USING (
			SELECT 
				dbo.CreateKeyFromSourceID(Agencija_ID) AS AgencijaKey,
				Agencija_ID AS IzvorniAgencija_ID,
				Naziv AS NazivAgencije,
				Srediste AS SredisteAgencije,
				Adresa AS AdresaAgencije,
				Telefon AS TelefonAgencije,
				Email AS EmailAgencije,
				dbo.ufn_GetHashDimAgencija(
					Agencija_ID,
					Naziv,
					Srediste,
					Adresa,
					Telefon,
					Email
				) AS HashKey
			FROM [$(RDA)].dbo.Agencija
		) AS SOURCE ON ( TARGET.HashKey = SOURCE.HashKey )
		WHEN MATCHED THEN
			UPDATE
			   SET TARGET.NazivAgencije = SOURCE.NazivAgencije
				   ,TARGET.SredisteAgencije = SOURCE.SredisteAgencije
				   ,TARGET.AdresaAgencije = SOURCE.AdresaAgencije
				   ,TARGET.TelefonAgencije = SOURCE.TelefonAgencije
				   ,TARGET.EmailAgencije = SOURCE.EmailAgencije
		WHEN NOT MATCHED BY TARGET THEN
			INSERT ( 
				AgencijaKey
				,IzvorniAgencija_ID
				,NazivAgencije
				,SredisteAgencije
				,AdresaAgencije
				,TelefonAgencije
				,EmailAgencije
				,HashKey
				,Obrisan		
			)
			VALUES (
				SOURCE.AgencijaKey
				,SOURCE.IzvorniAgencija_ID
				,SOURCE.NazivAgencije
				,SOURCE.SredisteAgencije
				,SOURCE.AdresaAgencije
				,SOURCE.TelefonAgencije
				,SOURCE.EmailAgencije
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