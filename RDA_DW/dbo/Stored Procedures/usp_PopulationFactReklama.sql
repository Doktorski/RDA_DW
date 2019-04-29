CREATE PROCEDURE dbo.usp_PopulationFactReklama
AS
BEGIN
	BEGIN TRANSACTION

	MERGE FactReklama AS TARGET
	USING
	(
		SELECT 
			dbo.CreateKeyFromSourceID( 
				'_||_' + CAST( R.Reklama_ID AS VARCHAR ) + '_||_' + CAST( dbo.CreateKeyFromDate(P.Termin_Prikaza_Od) AS VARCHAR ) + '_||_' + 
				CAST( K.Kanali_ID AS VARCHAR ) + '_||_' + CAST( A.Duzina_trajanja AS VARCHAR ) + '_||_' + 
				CAST( A.Cena AS VARCHAR ) + '_||_' + CAST( G.Grad_ID AS VARCHAR ) + '_||_' + 
				CAST( O.Odbor_ID AS VARCHAR ) + '_||_' + CAST( A.Kompanija_ID AS VARCHAR ) + '_||_' 
			) AS ReklamaKey 
			,R.Reklama_ID AS IzvorniReklama_ID--
			,dbo.CreateKeyFromSourceID(K.Kanali_ID) AS TVkanaliKey
			,dbo.CreateKeyFromSourceID(A.Priv_grana_ID) AS PrivrednaGranaKey
			,dbo.CreateKeyFromSourceID(A.Agencija_ID) AS AgencijaKey
			,dbo.CreateKeyFromSourceID(O.Odbor_ID) AS OdborKey
			,dbo.CreateKeyFromSourceID(G.Grad_ID) AS GradKey
			,dbo.CreateKeyFromDate(P.Termin_Prikaza_Od) AS VremePrikazivanjaKey
			,dbo.CreateKeyFromSourceID(A.Kompanija_ID) AS KompanijaKey
			,P.Broj_prikaza AS BrojPrikaza
			,A.Duzina_trajanja AS TrajanjeReklame
			,A.Cena AS CenaReklame
			,dbo.ufn_GetHashFactReklama( 
				R.Reklama_ID,
				K.Kanali_ID, 
				A.Priv_grana_ID, 
				A.Agencija_ID, 
				O.Odbor_ID,
				G.Grad_ID, 
				[dbo].[CreateKeyFromDate](P.Termin_Prikaza_Od), 
				A.Kompanija_ID, 
				P.Broj_prikaza,
				A.Duzina_trajanja, 
				A.Cena 
			) AS HashKey
		FROM [$(RDA)].dbo.Reklama AS R
			INNER JOIN [$(RDA)].dbo.Prikazuje AS P ON P.Reklama_ID=R.Reklama_ID
			INNER JOIN [$(RDA)].dbo.Cenovnik AS C ON R.Cenovnik_ID=C.Cenovnik_ID
			INNER JOIN [$(RDA)].dbo.Kanali AS K ON P.Kanali_ID=K.Kanali_ID
			INNER JOIN [$(RDA)].dbo.Agencija AS AG ON R.Agencija_ID=AG.Agencija_ID
			INNER JOIN [$(RDA)].dbo.Odbor AS O ON R.Odbor_ID=O.Odbor_ID
			INNER JOIN [$(RDA)].dbo.Grad AS G ON O.Grad_ID=G.Grad_ID
			INNER JOIN [$(RDA)].dbo.Region AS RR ON G.Region_ID=RR.Region_ID
			INNER JOIN [$(RDA)].dbo.Politicka_stranka AS PS ON O.Politicka_stranka_ID=PS.Politicka_stranka_ID
			INNER JOIN 
		(
			SELECT 
				PG.Priv_grana_ID, 
				KK.Kompanija_ID,
				AAA.Agencija_ID,
				RRR.Duzina_trajanja, 
				CC.Cena  
			FROM [$(RDA)].dbo.Privredna_grana AS PG
				INNER JOIN [$(RDA)].dbo.Reklama AS RRR ON RRR.Priv_grana_ID=PG.Priv_grana_ID
				INNER JOIN [$(RDA)].dbo.Stavka_narudzenice AS SN ON SN.Reklama_ID=RRR.Reklama_ID
				INNER JOIN [$(RDA)].dbo.Narudzbenica AS N ON SN.Narudzbenica_ID=N.Narudzbenica_ID
				INNER JOIN [$(RDA)].dbo.Kompanija AS KK ON N.Kompanija_ID=KK.Kompanija_ID
				INNER JOIN [$(RDA)].dbo.Cenovnik AS CC ON RRR.Cenovnik_ID=CC.Cenovnik_ID
				INNER JOIN [$(RDA)].dbo.Agencija AS AAA ON RRR.Agencija_ID=AAA.Agencija_ID
		) AS A ON R.Agencija_ID=A.Agencija_ID
	) AS SOURCE ON ( TARGET.HashKey = SOURCE.HashKey )
	WHEN MATCHED THEN
		UPDATE
		   SET TARGET.[TVkanaliKey] = SOURCE.[TVkanaliKey]
			  ,TARGET.[PrivrednaGranaKey] = SOURCE.[PrivrednaGranaKey]
			  ,TARGET.[AgencijaKey] = SOURCE.[AgencijaKey]
			  ,TARGET.[OdborKey] = SOURCE.[OdborKey]
			  ,TARGET.[GradKey] = SOURCE.[GradKey]
			  ,TARGET.[VremePrikazivanjaKey] = SOURCE.[VremePrikazivanjaKey]
			  ,TARGET.[KompanijaKey] = SOURCE.[KompanijaKey]
			  ,TARGET.[BrojPrikaza] = SOURCE.[BrojPrikaza]
			  ,TARGET.[TrajanjeReklame] = SOURCE.[TrajanjeReklame]
			  ,TARGET.[CenaReklame] = SOURCE.[CenaReklame]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ( 
			ReklamaKey
			,IzvorniReklama_ID
			,TVkanaliKey
			,PrivrednaGranaKey
			,[AgencijaKey]
			,[OdborKey]
			,[GradKey]
			,[VremePrikazivanjaKey]
			,[KompanijaKey]
			,[BrojPrikaza]
			,[TrajanjeReklame]
			,[CenaReklame]
			,HashKey
			,Obrisan				
		)
		VALUES (
			SOURCE.[ReklamaKey]
			,SOURCE.[IzvorniReklama_ID]
			,SOURCE.[TVkanaliKey]
			,SOURCE.[PrivrednaGranaKey]
			,SOURCE.[AgencijaKey]
			,SOURCE.[OdborKey]
			,SOURCE.[GradKey]
			,SOURCE.[VremePrikazivanjaKey]
			,SOURCE.[KompanijaKey]
			,SOURCE.[BrojPrikaza]
			,SOURCE.[TrajanjeReklame]
			,SOURCE.[CenaReklame]
			,SOURCE.HashKey
			,NULL
		)
	WHEN NOT MATCHED BY SOURCE THEN UPDATE SET Obrisan = CAST( GETDATE() AS SMALLDATETIME );


	IF @@ERROR <> 0
		BEGIN
			ROLLBACK;
			PRINT 'Nije izvrsen Transfer_factReklama';
		END
	ELSE
		BEGIN
			COMMIT;
			PRINT 'Izvrsen je Transfer_factReklama';
		END
END