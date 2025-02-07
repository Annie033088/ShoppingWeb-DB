CREATE TABLE [dbo].[t_memberAddress] (
    [f_addressId]  INT            IDENTITY (1, 1) NOT NULL,
    [f_memberId]   INT            NOT NULL,
    [f_city]       NVARCHAR (10)  NOT NULL,
    [f_district]   NVARCHAR (10)  NOT NULL,
    [f_detail]     NVARCHAR (300) NOT NULL,
    [f_postalCode] CHAR (6)       NOT NULL,
    PRIMARY KEY CLUSTERED ([f_addressId] ASC)
);

