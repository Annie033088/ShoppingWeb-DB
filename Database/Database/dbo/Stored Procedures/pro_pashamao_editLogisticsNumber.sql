create PROCEDURE [dbo].pro_pashamao_editLogisticsNumber
	@orderId INT,
	@logisticsNumber VARCHAR(20)
AS
BEGIN
	UPDATE t_order SET f_logisticsNumber = @logisticsNumber WHERE f_orderId = @orderId
END