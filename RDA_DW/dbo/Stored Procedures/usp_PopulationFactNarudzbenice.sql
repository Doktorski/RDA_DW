CREATE PROCEDURE dbo.usp_PopulationFactNarudzbenice
AS
BEGIN
	BEGIN TRANSACTION

		MERGE dbo.FactNarudzbenice AS TARGET
		USING(
			SELECT
				dbo.CreateKeyFromSourceID( CAST( N.Narudzbenica_ID AS VARCHAR ) + '-||-' + CAST( SN.Stavka_narudzenice_ID AS VARCHAR ) + 
					'-||-' + CAST( O.Odbor_ID AS VARCHAR ) + '-||-' + CAST( G.Grad_ID AS VARCHAR ) + 
					'-||-' + CAST( P.Prikazuje_ID AS VARCHAR ) + '-||-' + CAST( K.Kompanija_ID AS VARCHAR ) + 
					'-||-' + CAST( Z.Zaposleni_ID AS VARCHAR )
				) AS NarudzbeniceKey
				,SN.Stavka_Narudzenice_ID AS IzvorniStavkaNarudzbenice_ID
				,dbo.CreateKeyFromSourceID(O.Odbor_ID) AS OdborKey
				,dbo.CreateKeyFromSourceID(G.Grad_ID) AS GradKey
				,dbo.CreateKeyFromDate(P.Termin_Prikaza_Od) AS VremePrikazivanjaKey
				,dbo.CreateKeyFromSourceID(K.Kompanija_ID) AS KompanijaKey
				,dbo.CreateKeyFromSourceID(Z.Zaposleni_ID) AS ZaposleniKey
				,SN.Kolicina AS BrojNarudzbenica
				,P.Termin_Prikaza_Od AS PocetakTermina
				,P.Termin_Prikaza_Do AS ZavrsetakTermina
				,dbo.ufn_GetHashFactNarudzbine(
					SN.Stavka_Narudzenice_ID
					,dbo.CreateKeyFromSourceID(Z.Zaposleni_ID)
					,dbo.CreateKeyFromSourceID(O.Odbor_ID)
					,dbo.CreateKeyFromSourceID(G.Grad_ID)
					,dbo.CreateKeyFromSourceID(P.Prikazuje_ID)
					,dbo.CreateKeyFromSourceID(K.Kompanija_ID)
					,SN.Kolicina
					,P.Termin_Prikaza_Od
					,P.Termin_Prikaza_Do
				) AS HashKey
			FROM [$(RDA)].dbo.Stavka_narudzenice AS SN WITH (NOLOCK)
				INNER JOIN [$(RDA)].dbo.Narudzbenica AS N WITH (NOLOCK) ON SN.Narudzbenica_ID=N.Narudzbenica_ID
				INNER JOIN [$(RDA)].dbo.Kompanija AS K WITH (NOLOCK) ON N.Kompanija_ID=K.Kompanija_ID
				INNER JOIN [$(RDA)].dbo.Zaposleni AS Z WITH (NOLOCK) ON N.Zaposleni_ID=Z.Zaposleni_ID
				INNER JOIN [$(RDA)].dbo.Agencija AS A WITH (NOLOCK) ON Z.Agencija_ID=A.Agencija_ID
				INNER JOIN [$(RDA)].dbo.Reklama AS R WITH (NOLOCK) ON R.Agencija_ID=A.Agencija_ID
				INNER JOIN [$(RDA)].dbo.Odbor AS O WITH (NOLOCK) ON R.Odbor_ID=O.Odbor_ID
				INNER JOIN [$(RDA)].dbo.Grad AS G WITH (NOLOCK) ON O.Grad_ID=G.Grad_ID
				INNER JOIN [$(RDA)].dbo.Prikazuje AS P WITH (NOLOCK) ON P.Reklama_ID=R.Reklama_ID
		) AS SOURCE ON ( TARGET.HashKey = SOURCE.HashKey )
		WHEN MATCHED THEN 
			UPDATE
				SET TARGET.ZaposleniKey = SOURCE.ZaposleniKey
					,TARGET.OdborKey = SOURCE.OdborKey
					,TARGET.GradKey = SOURCE.GradKey
					,TARGET.VremePrikazivanjaKey = SOURCE.VremePrikazivanjaKey
					,TARGET.KompanijaKey = SOURCE.KompanijaKey
					,TARGET.PocetakTermina = SOURCE.PocetakTermina
					,TARGET.ZavrsetakTermina = SOURCE.ZavrsetakTermina
		WHEN NOT MATCHED BY TARGET THEN
			INSERT(
				NarudzbeniceKey
				,IzvorniStavkaNarudzbenice_ID
				,ZaposleniKey
				,OdborKey
				,GradKey
				,VremePrikazivanjaKey
				,KompanijaKey
				,BrojNarudzbenica
				,PocetakTermina
				,ZavrsetakTermina
				,HashKey
				,Obrisan
			)
			VALUES(
				SOURCE.NarudzbeniceKey
				,SOURCE.IzvorniStavkaNarudzbenice_ID
				,SOURCE.ZaposleniKey
				,SOURCE.OdborKey
				,SOURCE.GradKey
				,SOURCE.VremePrikazivanjaKey
				,SOURCE.KompanijaKey
				,SOURCE.BrojNarudzbenica
				,SOURCE.PocetakTermina
				,SOURCE.ZavrsetakTermina
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