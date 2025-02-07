CREATE PROCEDURE [dbo].[pro_pashamao_getStatusSessionIdPermissions]
	@userId int
AS
BEGIN
	SELECT f_status, f_sessionId, r.f_rolePermission FROM t_user AS u WITH(NOLOCK) 
			JOIN t_role AS r ON u.f_roleId = r.f_roleId
	WHERE f_userId = @userId 
END