CREATE TABLE [dbo].[DimAgencija] (
    [AgencijaKey]        INT           NOT NULL,
    [IzvorniAgencija_ID] INT           NOT NULL,
    [NazivAgencije]      NVARCHAR (50) NULL,
    [SredisteAgencije]   NVARCHAR (50) NULL,
    [AdresaAgencije]     NVARCHAR (30) NULL,
    [TelefonAgencije]    CHAR (18)     NULL,
    [EmailAgencije]      CHAR (20)     NULL,
    [HashKey]            INT           NULL,
    [Obrisan]            SMALLDATETIME NULL,
    PRIMARY KEY NONCLUSTERED ([AgencijaKey] ASC)
);

