CREATE PROCEDURE [dbo].[pro_pashamao_delAndAddProductImage]
	@productId UNIQUEIDENTIFIER,
	@lastEditTime DATETIME,
	@delImageId VARCHAR(400),
	@addImageUrl NVARCHAR(1100)
AS
BEGIN
	DECLARE @delUrlTable TABLE (f_imageUrl NVARCHAR(100));

	IF @lastEditTime = (SELECT f_lastEditTime FROM t_product WHERE f_productId = @productId)
	BEGIN
		IF JSON_VALUE(@delImageId, '$[0]') IS NOT NULL
		BEGIN
			DELETE FROM t_productImage 
			OUTPUT deleted.f_imageUrl INTO @delUrlTable
			WHERE f_productImageId IN (SELECT value FROM OPENJSON(@delImageId))
		END
		
		IF JSON_VALUE(@addImageUrl, '$[0]') IS NOT NULL
		BEGIN
			INSERT INTO t_productImage(f_imageUrl, f_productId) SELECT value, @productId FROM OPENJSON(@addImageUrl);
		END
		UPDATE t_product SET f_lastEditTime = GETDATE() WHERE f_productId = @productId
		SELECT f_imageUrl FROM @delUrlTable
	END
END