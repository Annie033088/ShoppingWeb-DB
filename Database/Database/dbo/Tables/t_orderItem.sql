CREATE TABLE [dbo].[t_orderItem] (
    [f_orderItemId] INT             IDENTITY (1, 1) NOT NULL,
    [f_orderId]     INT             NOT NULL,
    [f_productName] NVARCHAR (30)   NOT NULL,
    [f_style]       NVARCHAR (25)   NOT NULL,
    [f_quantity]    INT             NOT NULL,
    [f_price]       DECIMAL (10, 2) NOT NULL,
    CONSTRAINT [PK__t_orderP__9EA9E93C1B5D621C] PRIMARY KEY CLUSTERED ([f_orderItemId] ASC)
);

