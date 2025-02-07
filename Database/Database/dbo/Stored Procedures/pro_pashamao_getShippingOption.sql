CREATE PROCEDURE [dbo].[pro_pashamao_getShippingOption]
AS
BEGIN
	SELECT f_shippingOptionId, f_optionName, f_shippingFee, f_freeShipping, f_updateTime FROM t_shippingOption WITH(NOLOCK)
END