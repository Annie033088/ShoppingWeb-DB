CREATE TABLE [dbo].[t_user] (
    [f_userId]    INT           IDENTITY (1, 1) NOT NULL,
    [f_account]   VARCHAR (20)  NOT NULL,
    [f_hash]      VARCHAR (101) NULL,
    [f_name]      VARCHAR (20)  NULL,
    [f_status]    BIT           CONSTRAINT [DF__t_users__f_statu__49C3F6B7] DEFAULT ((1)) NOT NULL,
    [f_roleId]    TINYINT       NOT NULL,
    [f_sessionId] VARCHAR (24)  NULL,
    CONSTRAINT [PK__t_users__EAF60E98C465B373] PRIMARY KEY CLUSTERED ([f_userId] ASC),
    CONSTRAINT [UQ__t_users__2F3D26A72FA58798] UNIQUE NONCLUSTERED ([f_account] ASC)
);

