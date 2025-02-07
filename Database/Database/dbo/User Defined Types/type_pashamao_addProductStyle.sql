CREATE TYPE [dbo].[type_pashamao_addProductStyle] AS TABLE (
    [f_imageUrl]      NVARCHAR (100)  NULL,
    [f_style]         NVARCHAR (25)   NULL,
    [f_price]         DECIMAL (10, 2) NULL,
    [f_stockQuantity] INT             NULL,
    [f_status]        BIT             NULL);

