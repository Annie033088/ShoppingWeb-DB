CREATE PROCEDURE [dbo].[pro_pashamao_delUser]
	@userId int
AS
BEGIN
	DELETE t_user
	WHERE f_userId = @userId
END