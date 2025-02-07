CREATE TABLE [dbo].[t_orderState] (
    [f_orderStateId] INT           IDENTITY (1, 1) NOT NULL,
    [f_orderId]      INT           NOT NULL,
    [f_state]        TINYINT       CONSTRAINT [DF__t_orderSt__f_sta__1C873BEC] DEFAULT ((1)) NOT NULL,
    [f_remark]       NVARCHAR (50) CONSTRAINT [DF_t_orderState_f_remark] DEFAULT ('') NOT NULL,
    [f_createTime]   DATETIME      CONSTRAINT [DF__t_orderSt__f_cre__1D7B6025] DEFAULT (getdate()) NOT NULL,
    [f_updateTime]   DATETIME      CONSTRAINT [DF__t_orderSt__f_upd__1E6F845E] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK__t_orderS__6AFD63C185587F1C] PRIMARY KEY CLUSTERED ([f_orderStateId] ASC)
);

