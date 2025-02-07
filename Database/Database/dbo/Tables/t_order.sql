CREATE TABLE [dbo].[t_order] (
    [f_orderId]            INT             IDENTITY (1, 1) NOT NULL,
    [f_memberId]           INT             NOT NULL,
    [f_orderNumber]        BIGINT          NOT NULL,
    [f_previousState]      TINYINT         CONSTRAINT [DF_t_order_f_previousState] DEFAULT ((0)) NOT NULL,
    [f_currentState]       TINYINT         CONSTRAINT [DF__t_order__f_state__14E61A24] DEFAULT ((1)) NOT NULL,
    [f_recipientName]      NVARCHAR (50)   NOT NULL,
    [f_phone]              INT             NOT NULL,
    [f_address]            NVARCHAR (326)  NOT NULL,
    [f_originalAmount]     DECIMAL (10, 2) NOT NULL,
    [f_discountedAmount]   DECIMAL (10, 2) NOT NULL,
    [f_shippingOptionName] NVARCHAR (10)   NOT NULL,
    [f_shippingFee]        DECIMAL (10, 2) NOT NULL,
    [f_totalAmount]        DECIMAL (10, 2) NOT NULL,
    [f_logisticsNumber]    VARCHAR (20)    CONSTRAINT [DF_t_order_f_logisticsNumber] DEFAULT ('') NOT NULL,
    [f_remark]             NVARCHAR (50)   CONSTRAINT [DF_t_order_f_remark] DEFAULT ('') NOT NULL,
    [f_createTime]         DATETIME        CONSTRAINT [DF__t_order__f_creat__15DA3E5D] DEFAULT (getdate()) NOT NULL,
    [f_updateTime]         DATETIME        CONSTRAINT [DF__t_order__f_updat__16CE6296] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK__t_order__732D9E25D1CBBF90] PRIMARY KEY CLUSTERED ([f_orderId] ASC)
);

