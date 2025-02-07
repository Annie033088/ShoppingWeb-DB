CREATE PROCEDURE [dbo].[pro_pashamao_editOrderStateMock]
	@orderId INT,
	@logisticsNumber CHAR(20),
	@state TINYINT
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY

		IF @orderId IS NOT NULL --會員提交 申請退貨/申請取消
		BEGIN
			--修改訂單狀態跟時間
			UPDATE t_order
			SET t_order.f_previousState = t_order.f_currentState, f_currentState =  @state, f_updateTime = GETDATE()
			WHERE f_orderId = @orderId
			
			--插入訂單狀態歷史紀錄表
			INSERT INTO t_orderState (f_orderId, f_state)
			VALUES(@orderId, @state)
		END
		ELSE IF @logisticsNumber IS NOT NULL --物流傳入狀態 已到貨
		BEGIN
			DECLARE @orderIdTable TABLE (f_orderId INT)

			--修改訂單狀態跟時間
			UPDATE t_order
			SET t_order.f_previousState = t_order.f_currentState, f_currentState =  @state, f_updateTime = GETDATE()
			OUTPUT inserted.f_orderId INTO @orderIdTable
			WHERE f_logisticsNumber = @logisticsNumber
			
			--插入訂單狀態歷史紀錄表
			INSERT INTO t_orderState (f_orderId, f_state)
			SELECT f_orderId, @state
			FROM @orderIdTable
		END
	    COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
END