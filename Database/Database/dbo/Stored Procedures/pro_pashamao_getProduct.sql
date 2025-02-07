CREATE PROCEDURE [dbo].[pro_pashamao_getProduct]
	@categoryId INT,
	@productId UNIQUEIDENTIFIER,
	@name NVARCHAR(30),
	@page INT,
	@totalPages INT OUTPUT
AS
BEGIN
	DECLARE @pageDataCnt INT = (@page-1) * 8
	DECLARE @totalItems INT

	SELECT f_productId, f_categoryId, f_name, f_status FROM t_product WITH(NOLOCK)  
	 WHERE
        (@categoryId IS NULL OR f_categoryId = @categoryId) 
        AND (@productId IS NULL OR f_productId = @productId) 
        AND (@name IS NULL OR f_name LIKE '%' + @name + '%') 
	ORDER BY (SELECT NULL)
	OFFSET @pageDataCnt ROWS 
	FETCH NEXT 8 ROWS ONLY

	SET @totalItems = (    
	SELECT COUNT(*) 
    FROM t_product WITH(NOLOCK)  
    WHERE
        (@categoryId IS NULL OR f_categoryId = @categoryId) 
        AND (@productId IS NULL OR f_productId = @productId) 
        AND (@name IS NULL OR f_name LIKE '%' + @name + '%'))

	SET @totalPages = CEILING(@totalItems / CAST(8 AS FLOAT))
END