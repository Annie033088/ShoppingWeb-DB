CREATE PROCEDURE [dbo].[pro_pashamao_delProduct]
	@productId UNIQUEIDENTIFIER
AS
BEGIN
	BEGIN TRY
	    BEGIN TRANSACTION;
			DELETE t_product WHERE f_productId = @productId
			DELETE t_productImage WHERE f_productId = @productId
			DELETE t_productStyle WHERE f_productId = @productId
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
	    ROLLBACK TRANSACTION;
	    THROW;  
	END CATCH;
END