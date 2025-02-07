CREATE PROCEDURE pro_pashamao_editOrderStateRemark
	@orderStateId INT,
	@remark NVARCHAR(50)
AS
BEGIN
	UPDATE t_orderState SET f_remark = @remark, f_updateTime = GETDATE() WHERE f_orderStateId = @orderStateId
END