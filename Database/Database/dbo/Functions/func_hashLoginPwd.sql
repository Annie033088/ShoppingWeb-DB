-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[func_hashLoginPwd]
(
	-- Add the parameters for the function here
	@pwd VARCHAR(20),
	@dbHash VARCHAR(101)
)
RETURNS VARCHAR(101)
AS
BEGIN
	-- Declare the return variable here
    DECLARE @hashedPwd VARCHAR(64)
	DECLARE @salt VARCHAR(36)

	-- Add the T-SQL statements to compute the return value here
	SET @salt = SUBSTRING(@dbHash, 1, CHARINDEX('|', @dbHash) - 1)
	DECLARE @saltWithPwd VARCHAR(56) = @salt + @pwd  -- 鹽值和密碼結合
	SET @hashedPwd = CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', CONVERT(VARCHAR(256), @saltWithPwd)), 2)
	
	DECLARE @saltAndHash VARCHAR(101)= @salt + '|' + @hashedPwd

	-- Return the result of the function
	RETURN @saltAndHash

END