CREATE PROCEDURE [dbo].[pro_pashamao_addProduct]
	@productId UNIQUEIDENTIFIER,
	@categoryId INT,
	@productName NVARCHAR(30),
	@description NVARCHAR(40),
	@introduction NVARCHAR(1500),
	@productStatus BIT,
	@styles dbo.type_pashamao_addProductStyle READONLY,
	@addImageUrl NVARCHAR(1100)
AS
BEGIN
	BEGIN TRANSACTION

	BEGIN TRY
		
		-- 插入產品
		INSERT INTO t_product(f_productId, f_categoryId, f_name, f_description, f_introduction, f_status) VALUES(@productId, @categoryId, @productName, @description, @introduction, @productStatus)
		
		-- 插入產品樣式
		INSERT INTO t_productStyle(f_productId, f_imageUrl, f_style, f_price, f_stockQuantity, f_status)
		SELECT @productId, f_imageUrl, f_style, f_price, f_stockQuantity, f_status
		FROM @styles
		
		--插入圖片
		IF @addImageUrl IS NOT NULL AND JSON_VALUE(@addImageUrl, '$[0]') IS NOT NULL
		BEGIN
			INSERT INTO t_productImage(f_imageUrl, f_productId) SELECT value, @productId FROM OPENJSON(@addImageUrl);
		END

	    COMMIT;
	END TRY
	BEGIN CATCH
	    ROLLBACK;
	END CATCH;
END