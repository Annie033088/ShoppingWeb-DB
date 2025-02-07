CREATE TABLE [dbo].[t_productStyle] (
    [f_productStyleId]     INT              IDENTITY (1, 1) NOT NULL,
    [f_productId]          UNIQUEIDENTIFIER NOT NULL,
    [f_imageUrl]           NVARCHAR (100)   NOT NULL,
    [f_style]              NVARCHAR (25)    NOT NULL,
    [f_price]              DECIMAL (10, 2)  NOT NULL,
    [f_stockQuantity]      INT              NOT NULL,
    [f_status]             BIT              CONSTRAINT [DF_t_productStyles_f_status] DEFAULT ((0)) NOT NULL,
    [f_createTime]         DATETIME         CONSTRAINT [DF_t_productStyles_f_createTime
f_createTime] DEFAULT (getdate()) NOT NULL,
    [f_lastShelveEditTime] DATETIME         CONSTRAINT [DF_t_productStyles_f_lastShelveEditTime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK__t_produc__D19186B5310C2709] PRIMARY KEY CLUSTERED ([f_productStyleId] ASC)
);

