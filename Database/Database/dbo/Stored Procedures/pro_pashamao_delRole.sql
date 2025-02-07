CREATE PROCEDURE [dbo].[pro_pashamao_delRole]
	@roleId TINYINT
AS
BEGIN
	SELECT 1 FROM t_user WHERE f_roleId = @roleId
	IF @@ROWCOUNT = 0
	BEGIN
		DELETE FROM t_role WHERE f_roleId = @roleId
	END
END