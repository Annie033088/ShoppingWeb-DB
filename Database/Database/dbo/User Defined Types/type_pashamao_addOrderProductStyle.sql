CREATE TYPE [dbo].[type_pashamao_addOrderProductStyle] AS TABLE (
    [f_productStyleId] INT              NOT NULL,
    [f_productId]      UNIQUEIDENTIFIER NOT NULL,
    [f_quantity]       INT              NULL);

