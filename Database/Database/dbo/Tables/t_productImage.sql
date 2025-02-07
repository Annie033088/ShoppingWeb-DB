CREATE TABLE [dbo].[t_productImage] (
    [f_productImageId] INT              IDENTITY (1, 1) NOT NULL,
    [f_productId]      UNIQUEIDENTIFIER NOT NULL,
    [f_imageUrl]       NVARCHAR (100)   NOT NULL,
    CONSTRAINT [PK__t_produc__471790984C906639] PRIMARY KEY CLUSTERED ([f_productImageId] ASC)
);

