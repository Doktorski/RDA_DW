CREATE TABLE [dbo].[DimKompanija] (
    [KompanijaKey]        INT           NOT NULL,
    [IzvorniKompanija_ID] INT           NOT NULL,
    [NazivKompanije]      NVARCHAR (50) NULL,
    [SedisteKompanije]    NVARCHAR (30) NULL,
    [SifraKompanije]      CHAR (6)      NULL,
    [HashKey]             INT           NULL,
    [Obrisan]             SMALLDATETIME NULL,
    PRIMARY KEY NONCLUSTERED ([KompanijaKey] ASC)
);

