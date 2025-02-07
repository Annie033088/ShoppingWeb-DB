CREATE PROCEDURE [dbo].[pro_pashamao_getRole]
	@roleId TINYINT
AS
BEGIN
	SELECT f_name, f_description FROM t_role WITH(NOLOCK)  WHERE f_roleId = @roleId 
END