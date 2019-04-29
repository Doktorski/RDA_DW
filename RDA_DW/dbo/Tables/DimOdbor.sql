CREATE TABLE [dbo].[DimOdbor] (
    [OdborKey]              INT           NOT NULL,
    [IzvorniOdbor_ID]       INT           NOT NULL,
    [NazivOdbora]           NVARCHAR (50) NULL,
    [NazivPolitickeStranke] NVARCHAR (50) NULL,
    [NazivOpstine]          NVARCHAR (50) NULL,
    [HashKey]               INT           NULL,
    [Obrisan]               SMALLDATETIME NULL,
    PRIMARY KEY NONCLUSTERED ([OdborKey] ASC)
);

