CREATE PROCEDURE [dbo].[pro_pashamao_editProduct]
	@productId	UNIQUEIDENTIFIER, 
	@categoryId INT,
	@name NVARCHAR(30), 
	@description NVARCHAR(40), 
	@introduction NVARCHAR(1500), 
	@status BIT,
	@lastEditTime DATETIME
AS
BEGIN
	IF @lastEditTime = (SELECT f_lastEditTime FROM t_product WITH(NOLOCK) WHERE f_productId = @productId)
	BEGIN
		UPDATE t_product WITH(ROWLOCK)
		SET f_categoryId = @categoryId, f_name = @name, f_description = @description, f_introduction = @introduction, f_status = @status, f_lastEditTime = GETDATE()
		WHERE f_productId = @productId
	END
END