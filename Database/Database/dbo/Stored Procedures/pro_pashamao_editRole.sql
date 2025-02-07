CREATE PROCEDURE [dbo].[pro_pashamao_editRole]
	@roleId TINYINT,
	@name VARCHAR(30),
	@description VARCHAR(60),
	@rolePermission BIGINT
AS
BEGIN
	UPDATE t_role SET f_name = @name, f_description = @description, f_rolePermission = @rolePermission WHERE f_roleId = @roleId
END