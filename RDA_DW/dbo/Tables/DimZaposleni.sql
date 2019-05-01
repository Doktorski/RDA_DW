CREATE TABLE [dbo].[DimZaposleni] (
    [ZaposleniKey]        INT           NOT NULL,
    [IzvorniZaposleni_ID] INT           NOT NULL,
    [ImeZaposlenog]       NVARCHAR (20) NULL,
    [PrezimeZaposlenog]   NVARCHAR (20) NULL,
    [JmbgZaposlenog]      CHAR (13)     NULL,
    [EmailZaposlenog]     CHAR (30)     NULL,
    [PozicijaZaposlenog]  NVARCHAR (30) NULL,
    [HashKey]             INT           NULL,
    [Obrisan]             SMALLDATETIME NULL,
    PRIMARY KEY NONCLUSTERED ([ZaposleniKey] ASC)
);



