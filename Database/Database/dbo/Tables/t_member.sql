CREATE TABLE [dbo].[t_member] (
    [f_memberId]      INT           IDENTITY (1, 1) NOT NULL,
    [f_memberAccount] VARCHAR (20)  NOT NULL,
    [f_hash]          VARCHAR (101) NOT NULL,
    [f_email]         VARCHAR (254) NOT NULL,
    [f_phone]         INT           NULL,
    [f_memberName]    NVARCHAR (50) NOT NULL,
    [f_nickname]      NVARCHAR (25) NULL,
    [f_status]        BIT           CONSTRAINT [DF__t_members__f_sta__02FC7413] DEFAULT ((1)) NOT NULL,
    [f_points]        INT           CONSTRAINT [DF__t_members__f_poi__03F0984C] DEFAULT ((0)) NOT NULL,
    [f_level]         TINYINT       CONSTRAINT [DF__t_members__f_lev__04E4BC85] DEFAULT ((1)) NOT NULL,
    [f_ttt]           INT           NULL,
    CONSTRAINT [PK__t_member__283A7354D8B4BFCC] PRIMARY KEY CLUSTERED ([f_memberId] ASC)
);

