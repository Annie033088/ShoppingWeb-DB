CREATE TABLE [dbo].[t_role] (
    [f_roleId]         TINYINT      IDENTITY (1, 1) NOT NULL,
    [f_name]           VARCHAR (30) NOT NULL,
    [f_description]    VARCHAR (60) NOT NULL,
    [f_rolePermission] BIGINT       NOT NULL,
    CONSTRAINT [PK__t_roles__FE050C3E2FEF2C6A] PRIMARY KEY CLUSTERED ([f_roleId] ASC),
    CONSTRAINT [uniqueName] UNIQUE NONCLUSTERED ([f_name] ASC)
);

