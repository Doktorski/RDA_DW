CREATE PROCEDURE dbo.usp_PopulationDimTVKanali
AS
BEGIN
	BEGIN TRANSACTION

		MERGE dbo.DimTVKanali AS TARGET
		USING (
			SELECT 
				[dbo].[CreateKeyFromSourceID](K.[Kanali_ID]) AS TVkanaliKey
				,K.[Kanali_ID] AS IzvorniKanali_ID
				,K.[Naziv] AS NazivKanala
				,TV.[Naziv] AS TVkuca
				,TV.[Sediste] AS SedisteTVkuca
				,TV.[Adresa] AS AdresaTVkuca
				,TV.[Email] AS EmailTVkuca
				,TV.[Telefon] AS TelefonTVkuca 
				,SV.[Opis_strukture_vlasnistva] AS VrstaVlasnistva
				,[dbo].[ufn_GetHashDimTVkanali](
					K.[Kanali_ID]
					,K.[Naziv]
					,TV.[Naziv]
					,TV.[Sediste]
					,TV.[Adresa]
					,TV.[Email]
					,TV.[Telefon]
					,SV.[Opis_strukture_vlasnistva]
				) AS HashKey
			FROM [$(RDA)].[dbo].[Struktura_vlasnistva] AS SV WITH (NOLOCK)
				INNER JOIN [$(RDA)].[dbo].[TV_kuca] AS TV WITH (NOLOCK) ON TV.Struktura_vlasnistva_ID=SV.Struktura_vlasnistva_ID
				INNER JOIN[$(RDA)].[dbo].[Kanali] AS K WITH (NOLOCK) ON K.TV_kuca_ID=TV.TV_kuca_ID
		) AS SOURCE ON ( TARGET.HashKey = SOURCE.HashKey  )
		WHEN MATCHED THEN
			UPDATE
				SET TARGET.NazivKanala = SOURCE.NazivKanala
					,TARGET.TVkuca = SOURCE.TVkuca
					,TARGET.SedisteTVkuca = SOURCE.SedisteTVkuca
					,TARGET.AdresaTVkuca = SOURCE.AdresaTVkuca
					,TARGET.EmailTVkuca = SOURCE.EmailTVkuca
					,TARGET.TelefonTVkuca = SOURCE.TelefonTVkuca
					,TARGET.VrstaVlasnistva = SOURCE.VrstaVlasnistva
		WHEN NOT MATCHED BY TARGET THEN
			INSERT ( 
				TVkanaliKey
				,IzvorniKanali_ID
				,NazivKanala
				,TVkuca
				,SedisteTVkuca
				,AdresaTVkuca
				,EmailTVkuca
				,TelefonTVkuca
				,VrstaVlasnistva
				,HashKey
				,Obrisan		
			)
			VALUES (
				SOURCE.TVkanaliKey
				,SOURCE.IzvorniKanali_ID
				,SOURCE.NazivKanala
				,SOURCE.TVkuca
				,SOURCE.SedisteTVkuca
				,SOURCE.AdresaTVkuca
				,SOURCE.EmailTVkuca
				,SOURCE.TelefonTVkuca 
				,SOURCE.VrstaVlasnistva
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