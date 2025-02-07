create PROCEDURE [dbo].pro_pashamao_delOrder
	@orderId INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;
		DELETE t_order WHERE f_orderId = @orderId
		DELETE t_orderItem WHERE f_orderId = @orderId
		DELETE t_orderState WHERE f_orderId = @orderId		    
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
	    ROLLBACK TRANSACTION;
	    THROW;  
	END CATCH;
END