CREATE TABLE [dbo].[t_product] (
    [f_productId]    UNIQUEIDENTIFIER NOT NULL,
    [f_categoryId]   INT              CONSTRAINT [DF_t_products_f_categoryId] DEFAULT ((1)) NOT NULL,
    [f_name]         NVARCHAR (30)    NOT NULL,
    [f_description]  NVARCHAR (40)    NOT NULL,
    [f_introduction] NVARCHAR (1500)  NOT NULL,
    [f_status]       BIT              CONSTRAINT [DF__t_product__f_sta__18EBB532] DEFAULT ((0)) NOT NULL,
    [f_createTime]   DATETIME         CONSTRAINT [DF_t_products_f_createdTime
f_createdTime
f_createdTime
f_createTime] DEFAULT (getdate()) NOT NULL,
    [f_lastEditTime] DATETIME         CONSTRAINT [DF_t_products_f_lastShelveEditTime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [t_productsPk] PRIMARY KEY CLUSTERED ([f_productId] ASC)
);

