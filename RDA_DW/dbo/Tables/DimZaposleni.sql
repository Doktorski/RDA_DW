CREATE TABLE [dbo].[DimZaposleni] (
    [ZaposleniKey]        INT                                            NOT NULL,
    [IzvorniZaposleni_ID] INT                                            NOT NULL,
    [ImeZaposlenog]       NVARCHAR (20)                                  NULL,
    [PrezimeZaposlenog]   NVARCHAR (20)                                  NULL,
    [JmbgZaposlenog]      CHAR (13) MASKED WITH (FUNCTION = 'default()') NULL,
    [EmailZaposlenog]     CHAR (30) MASKED WITH (FUNCTION = 'email()')   NULL,
    [PozicijaZaposlenog]  NVARCHAR (30)                                  NULL,
    [HashKey]             INT                                            NULL,
    [Obrisan]             SMALLDATETIME                                  NULL,
    PRIMARY KEY NONCLUSTERED ([ZaposleniKey] ASC)
);






GO
GRANT SELECT
    ON OBJECT::[dbo].[DimZaposleni] TO [DELL\SalesPerson]
    AS [dbo];

