CREATE PROCEDURE [dbo].[pro_pashamao_addRole]
	 @name VARCHAR(30),
	 @description VARCHAR(60),
	 @rolePermission BIGINT
AS
BEGIN
	INSERT INTO t_role(f_name, f_description, f_rolePermission)
	VALUES (@name, @description, @rolePermission)
END