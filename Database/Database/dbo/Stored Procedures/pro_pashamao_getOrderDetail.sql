CREATE PROCEDURE [dbo].[pro_pashamao_getOrderDetail]
	@orderId INT
AS
BEGIN
	SELECT f_memberId, f_orderNumber, f_currentState, f_recipientName, f_phone, f_address, f_shippingOptionName, f_logisticsNumber, f_shippingFee, f_originalAmount, f_discountedAmount, f_totalAmount,
	 f_remark, f_createTime, f_updateTime
	FROM t_order WITH(NOLOCK)
	WHERE f_orderId = @orderId
		
	SELECT f_productName, f_style, f_quantity, f_price
	FROM t_orderItem WITH(NOLOCK)
	WHERE f_orderId = @orderId

	SELECT f_orderStateId, f_state, f_remark, f_createTime, f_updateTime FROM t_orderState WITH(NOLOCK) WHERE f_orderId = @orderId
END