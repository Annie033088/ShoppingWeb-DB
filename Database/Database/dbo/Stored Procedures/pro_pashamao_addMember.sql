CREATE PROCEDURE [dbo].[pro_pashamao_addMember]
	@acct VARCHAR(20), 
	@pwd VARCHAR(20),
	@email VARCHAR(254), 
	@phone INT, 
	@memberName NVARCHAR(50), 
	@nickname NVARCHAR(25)
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM t_member WHERE f_memberAccount = @acct)
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
		INSERT INTO t_member (f_memberAccount, f_hash, f_email, f_phone, f_memberName, f_nickname)
		VALUES (@acct,  @saltAndHashed, @email, @phone, @memberName, @nickname)

	END
END