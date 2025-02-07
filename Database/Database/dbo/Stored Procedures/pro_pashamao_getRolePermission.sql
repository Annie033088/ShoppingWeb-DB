CREATE PROCEDURE [dbo].[pro_pashamao_getRolePermission]
	@roleId TINYINT
AS
BEGIN
	SELECT f_rolePermission FROM t_role WITH(NOLOCK)  WHERE f_roleId = @roleId
END