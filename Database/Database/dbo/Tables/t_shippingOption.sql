CREATE TABLE [dbo].[t_shippingOption] (
    [f_shippingOptionId] INT             IDENTITY (1, 1) NOT NULL,
    [f_optionName]       NVARCHAR (10)   NOT NULL,
    [f_shippingFee]      DECIMAL (10, 2) NOT NULL,
    [f_freeShipping]     DECIMAL (10, 2) NOT NULL,
    [f_createTime]       DATETIME        CONSTRAINT [DF_t_shippingOption_f_createTime] DEFAULT (getdate()) NOT NULL,
    [f_updateTime]       DATETIME        CONSTRAINT [DF_t_shippingOption_f_createTime1] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([f_shippingOptionId] ASC)
);

