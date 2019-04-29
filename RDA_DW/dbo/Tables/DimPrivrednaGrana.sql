CREATE TABLE [dbo].[DimPrivrednaGrana] (
    [PrivrednaGranaKey]        INT           NOT NULL,
    [IzvorniPrivrednaGrana_ID] INT           NOT NULL,
    [NazivPrivredneGrane]      NVARCHAR (50) NULL,
    [HashKey]                  INT           NULL,
    [Obrisan]                  SMALLDATETIME NULL,
    PRIMARY KEY NONCLUSTERED ([PrivrednaGranaKey] ASC)
);

