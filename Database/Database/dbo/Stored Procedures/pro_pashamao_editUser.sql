CREATE PROCEDURE [dbo].[pro_pashamao_editUser]
	@userId int,
	@roleId TINYINT,
	@status Bit
AS
BEGIN
	UPDATE t_user WITH(ROWLOCK) SET f_roleId = @roleId, f_status = @status WHERE f_userId = @userId
END