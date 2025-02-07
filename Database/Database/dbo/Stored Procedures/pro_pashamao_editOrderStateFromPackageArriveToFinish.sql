CREATE PROCEDURE [dbo].[pro_pashamao_editOrderStateFromPackageArriveToFinish]
	@todayStartTime DATE
AS
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @orderTable TABLE(f_orderId INT, f_memberId INT, f_discountedAmount DECIMAL(10,2))

		UPDATE t_order WITH(ROWLOCK) SET f_currentState = 6, f_previousState = 5, f_updateTime = GETDATE()
		OUTPUT INSERTED.f_orderId, INSERTED.f_memberId, INSERTED.f_discountedAmount INTO @orderTable
		WHERE f_currentState = 5 AND DATEDIFF(DAY, CAST(f_createTime AS DATE), '2025-01-27') > 6 --鑑賞日期為7天 也就是6天以上

		INSERT INTO t_orderState(f_orderId, f_state)
		SELECT f_orderId, 6 FROM @orderTable
		
		UPDATE t_member
			SET t_member.f_points = t_member.f_points + orderTable.f_discountedAmount
				, t_member.f_level = 
					CASE
					    WHEN t_member.f_points + orderTable.f_discountedAmount < 3000 THEN 1  -- 消費0~3000:普通會員
					    WHEN t_member.f_points + orderTable.f_discountedAmount >= 3000 AND t_member.f_points + orderTable.f_discountedAmount < 12000 THEN 2  -- 消費3000~12000:白金會員
					    WHEN t_member.f_points + orderTable.f_discountedAmount >= 12000 THEN 3  -- 消費大於12000:鑽石會員
					END
			FROM t_member
			LEFT JOIN @orderTable AS orderTable
			ON t_member.f_memberId = orderTable.f_memberId
			WHERE t_member.f_memberId = orderTable.f_memberId
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
END