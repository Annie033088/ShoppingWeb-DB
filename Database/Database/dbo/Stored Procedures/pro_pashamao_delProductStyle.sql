CREATE PROCEDURE [dbo].[pro_pashamao_delProductStyle]
	@productStyleId INT,
	@productId UNIQUEIDENTIFIER,
	@lastEditTime DATETIME,
	@delImageUrl NVARCHAR(100) OUTPUT
AS
BEGIN
	IF @lastEditTime = (SELECT f_lastEditTime FROM t_product WHERE f_productId = @productId)
	BEGIN
		DECLARE @delUrlTable TABLE (f_imageUrl NVARCHAR(100))
		DELETE t_productStyle
		OUTPUT  deleted.f_imageUrl INTO @delUrlTable 
		WHERE f_productStyleId = @productStyleId

		UPDATE t_product SET f_lastEditTime = GETDATE() WHERE f_productId = @productId

		SET @delImageUrl = (SELECT TOP 1 f_imageUrl FROM @delUrlTable)
	END
END