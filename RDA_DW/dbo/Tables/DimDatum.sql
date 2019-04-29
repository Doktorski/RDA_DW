CREATE TABLE [dbo].[DimDatum] (
    [DateKey]        INT           NOT NULL,
    [Datum]          DATETIME      NULL,
    [DatumRS]        CHAR (10)     NULL,
    [DatumRS2]       CHAR (10)     NULL,
    [DanUMesecu]     VARCHAR (2)   NULL,
    [ImeDana_C]      NVARCHAR (10) NULL,
    [ImeDana_L]      NVARCHAR (10) NULL,
    [DanUSedmici]    CHAR (1)      NULL,
    [NedeljaUGodini] VARCHAR (2)   NULL,
    [Mesec]          VARCHAR (2)   NULL,
    [ImeMeseca_C]    NVARCHAR (9)  NULL,
    [ImeMeseca_L]    NVARCHAR (9)  NULL,
    [Kvartal]        CHAR (1)      NULL,
    [ImeKvartala_C]  NVARCHAR (9)  NULL,
    [ImeKvartala_L]  NVARCHAR (9)  NULL,
    [Godina]         CHAR (4)      NULL,
    [MesecGodina]    CHAR (10)     NULL,
    [MMYYYY]         CHAR (6)      NULL,
    CONSTRAINT [PK_DateKey] PRIMARY KEY NONCLUSTERED ([DateKey] ASC)
);

