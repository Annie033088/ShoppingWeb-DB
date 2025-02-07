CREATE PROCEDURE [dbo].[pro_pashamao_getProductDetail]
	@productId UNIQUEIDENTIFIER
AS
BEGIN
	SELECT f_name, f_categoryId, f_description, f_introduction, f_status, f_lastEditTime
	FROM t_product WITH(NOLOCK)
	WHERE f_productId = @productId
		
	SELECT f_productStyleId, f_style, f_price, f_stockQuantity, f_imageUrl, f_status
	FROM t_productStyle AS s WITH(NOLOCK)
	WHERE f_productId = @productId

	SELECT f_productImageId, f_imageUrl FROM t_productImage WHERE f_productId = @productId
END