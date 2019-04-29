CREATE TABLE [dbo].[DimGrad] (
    [GradKey]        INT           NOT NULL,
    [IzvorniGrad_ID] INT           NOT NULL,
    [NazivGrada]     NVARCHAR (30) NULL,
    [NazivRegiona]   NVARCHAR (50) NULL,
    [HashKey]        INT           NULL,
    [Obrisan]        SMALLDATETIME NULL,
    PRIMARY KEY NONCLUSTERED ([GradKey] ASC)
);

