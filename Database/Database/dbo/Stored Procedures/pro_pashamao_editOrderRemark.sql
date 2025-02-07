CREATE PROCEDURE [dbo].[pro_pashamao_editOrderRemark]
	@orderId INT,
	@remark NVARCHAR(50)
AS
BEGIN
	UPDATE t_order WITH(ROWLOCK) SET f_remark = @remark WHERE f_orderId = @orderId
END