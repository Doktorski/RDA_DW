CREATE TABLE [dbo].[FactNarudzbenice] (
    [NarudzbeniceKey]              INT           NOT NULL,
    [IzvorniStavkaNarudzbenice_ID] INT           NOT NULL,
    [ZaposleniKey]                 INT           NOT NULL,
    [OdborKey]                     INT           NULL,
    [GradKey]                      INT           NOT NULL,
    [VremePrikazivanjaKey]         INT           NOT NULL,
    [KompanijaKey]                 INT           NULL,
    [BrojNarudzbenica]             INT           DEFAULT ((1)) NULL,
    [PocetakTermina]               DATETIME      NULL,
    [ZavrsetakTermina]             DATETIME      NULL,
    [HashKey]                      INT           NULL,
    [Obrisan]                      SMALLDATETIME NULL,
    PRIMARY KEY NONCLUSTERED ([NarudzbeniceKey] ASC),
    CONSTRAINT [FK_Datum_Narudzbine] FOREIGN KEY ([VremePrikazivanjaKey]) REFERENCES [dbo].[DimDatum] ([DateKey]),
    CONSTRAINT [FK_Kompanije_Narudzbine] FOREIGN KEY ([KompanijaKey]) REFERENCES [dbo].[DimKompanija] ([KompanijaKey]),
    CONSTRAINT [FK_Odbor_Narudzbine] FOREIGN KEY ([OdborKey]) REFERENCES [dbo].[DimOdbor] ([OdborKey]),
    CONSTRAINT [FK_Region_Narudzbine] FOREIGN KEY ([GradKey]) REFERENCES [dbo].[DimGrad] ([GradKey]),
    CONSTRAINT [FK_Zaposleni_Narudzbine] FOREIGN KEY ([ZaposleniKey]) REFERENCES [dbo].[DimZaposleni] ([ZaposleniKey])
);

