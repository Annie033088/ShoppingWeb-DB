CREATE PROCEDURE [dbo].[pro_pashamao_addUser]
    @acct VARCHAR(20),
    @pwd VARCHAR(20),
	@name VARCHAR(20),
	@roleId TINYINT
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM t_user WHERE f_account = @acct)
	BEGIN
		DECLARE @salt VARCHAR(36)
		DECLARE @hashedPwd VARCHAR(64)

		-- 生成一個隨機鹽值
		SET @salt = CONVERT(VARCHAR(36), NEWID())

		-- 將鹽值和密碼結合
		DECLARE @saltWithPwd VARCHAR(56)
		SET @saltWithPwd = @salt + @pwd

		-- 進行 SHA-256 雜湊
		SET @hashedPwd = CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONVERT(VARBINARY(256), @saltWithPwd)), 2)

		DECLARE @saltAndHashed VARCHAR(101) = @salt + '|' + @hashedPwd

		-- 插入數據到user表
		INSERT INTO t_user (f_account, f_hash, f_name, f_roleId)
		VALUES (@acct,  @saltAndHashed, @name, @roleId)
	END
END