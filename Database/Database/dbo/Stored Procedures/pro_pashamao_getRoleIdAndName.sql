CREATE PROCEDURE [dbo].[pro_pashamao_getRoleIdAndName]
AS
BEGIN
	SELECT f_roleId, f_name FROM t_role WITH(NOLOCK) 
END