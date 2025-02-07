CREATE PROCEDURE [dbo].[pro_pashamao_editProductStyle]
	@productId UNIQUEIDENTIFIER,
	@productStyleId INT,
	@imageUrl NVARCHAR(100),
	@style NVARCHAR(25),
	@price DECIMAL(10,2),
	@stockQuantity INT,
	@status BIT,
	@lastEditTime DATETIME,
	@delImageUrl NVARCHAR(100) OUTPUT
AS
BEGIN
	IF @lastEditTime = (SELECT f_lastEditTime FROM t_product WHERE f_productId = @productId)
	BEGIN
		DECLARE @delUrlTable TABLE (f_imageUrl NVARCHAR(100))
		IF @imageUrl IS NOT NULL AND @imageUrl != ''
		BEGIN
			UPDATE t_productStyle WITH(ROWLOCK)
			SET f_imageUrl = @imageUrl, f_style = @style, f_price = @price, f_stockQuantity = @stockQuantity, f_status = @status
			OUTPUT deleted.f_imageUrl INTO @delUrlTable
			WHERE f_productStyleId = @productStyleId
		END
		ELSE
		BEGIN
			UPDATE t_productStyle WITH(ROWLOCK)
			SET f_style = @style, f_price = @price, f_stockQuantity = @stockQuantity, f_status = @status
			WHERE f_productStyleId = @productStyleId
		END

		UPDATE t_product SET f_lastEditTime = GETDATE() WHERE f_productId = @productId

		SET @delImageUrl = (SELECT TOP 1 f_imageUrl FROM @delUrlTable)
	END
END