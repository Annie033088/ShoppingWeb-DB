CREATE PROCEDURE [dbo].[pro_pashamao_addProductStyle]
	@productId UNIQUEIDENTIFIER,
	@imageUrl NVARCHAR(100),
	@style NVARCHAR(25),
	@price DECIMAL(10,2),
	@stockQuantity INT,
	@status BIT,
	@lastEditTime DATETIME
AS
BEGIN
	IF @lastEditTime = (SELECT f_lastEditTime FROM t_product WHERE f_productId = @productId)
	BEGIN
		INSERT INTO t_productStyle (f_productId, f_imageUrl, f_style, f_price, f_stockQuantity, f_status)
		VALUES(@productId, @imageUrl, @style, @price, @stockQuantity, @status)
		
		UPDATE t_product SET f_lastEditTime = GETDATE() WHERE f_productId = @productId
	END
END