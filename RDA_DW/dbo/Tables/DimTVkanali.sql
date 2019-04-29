CREATE TABLE [dbo].[DimTVkanali] (
    [TVkanaliKey]      INT           NOT NULL,
    [IzvorniKanali_ID] INT           NULL,
    [NazivKanala]      NVARCHAR (30) NULL,
    [TVkuca]           NVARCHAR (20) NULL,
    [SedisteTVkuca]    NVARCHAR (30) NULL,
    [AdresaTVkuca]     NVARCHAR (50) NULL,
    [EmailTVkuca]      CHAR (25)     NULL,
    [TelefonTVkuca]    CHAR (18)     NULL,
    [VrstaVlasnistva]  NVARCHAR (50) NULL,
    [HashKey]          INT           NULL,
    [Obrisan]          SMALLDATETIME NULL,
    PRIMARY KEY NONCLUSTERED ([TVkanaliKey] ASC)
);

