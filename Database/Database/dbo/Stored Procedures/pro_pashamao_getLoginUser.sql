CREATE PROCEDURE [dbo].[pro_pashamao_getLoginUser]
	@acc VARCHAR(20),
	@pwd VARCHAR(20),
	@sessionId VARCHAR(128)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @dbHash VARCHAR(101)
	DECLARE @loginHash VARCHAR(101)

	SET @dbHash = (SELECT f_hash FROM t_user WITH(NOLOCK) WHERE f_account = @acc)

	IF @@ROWCOUNT = 1
	BEGIN
		SET @loginHash =  dbo.func_hashLoginPwd(@pwd, @dbHash) 
		IF @loginHash = @dbHash
		BEGIN
			UPDATE t_user	WITH(ROWLOCK) 
			SET f_sessionId = @sessionId 
			OUTPUT INSERTED.f_userId, INSERTED.f_account, INSERTED.f_name, INSERTED.f_status, INSERTED.f_roleId,  r.f_rolePermission
			FROM t_user AS u
			JOIN t_role AS r ON u.f_roleId = r.f_roleId
			WHERE u.f_account = @acc
		END
	END
END