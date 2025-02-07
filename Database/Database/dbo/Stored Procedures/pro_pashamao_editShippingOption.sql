CREATE PROCEDURE [dbo].[pro_pashamao_editShippingOption]
	@shippingOptionId INT,
	@shippingFee DECIMAL(10,2),
	@freeShipping DECIMAL(10,2),
	@updateTime DATETIME
AS
BEGIN
	IF @updateTime = (SELECT FORMAT(f_updateTime, 'yyyy-MM-dd HH:mm:ss') FROM t_shippingOption WITH(NOLOCK) WHERE f_shippingOptionId = @shippingOptionId)
	BEGIN
		UPDATE t_shippingOption WITH(ROWLOCK)
		SET f_shippingFee = @shippingFee, f_freeShipping = @freeShipping, f_updateTime = @updateTime 
		WHERE f_shippingOptionId = @shippingOptionId
	END
END