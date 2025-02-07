CREATE PROCEDURE [dbo].[pro_pashamao_editUserPwd]
	@userId int,
	@oldPwd varchar(20),
	@newPwd varchar(20)
AS
BEGIN
	DECLARE @dbHash VARCHAR(129)
	DECLARE @oldHash VARCHAR(129)
    DECLARE @newPwdHash VARCHAR(64)

	SET @dbHash = (SELECT TOP 1 f_hash FROM t_user WITH(NOLOCK) WHERE f_userId = @userId)
	IF @@ROWCOUNT = 1
	BEGIN
		SET @oldHash =  dbo.func_hashLoginPwd(@oldPwd, @dbHash) 
		IF @oldHash = @dbHash
		BEGIN
			DECLARE @salt VARCHAR(64)
			SET @salt = SUBSTRING(@dbHash, 1, CHARINDEX('|', @dbHash) - 1)
			DECLARE @saltWithPwd VARCHAR(84) = @salt + @newPwd  
			SET @newPwdHash = CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONVERT(VARCHAR(256), @saltWithPwd)), 2)
			DECLARE @newHash VARCHAR(129)= @salt + '|' + @newPwdHash

			UPDATE t_user	WITH(ROWLOCK) SET f_hash = @newHash OUTPUT inserted.f_userId WHERE f_userId = @userId
		END
	END	
END