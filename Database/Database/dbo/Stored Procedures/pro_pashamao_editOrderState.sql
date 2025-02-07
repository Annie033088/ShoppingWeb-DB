CREATE PROCEDURE [dbo].[pro_pashamao_editOrderState]
	@orderId INT,
	@originalState TINYINT,
	@selectedState TINYINT,
	@updateTime DATETIME
AS
BEGIN
IF @updateTime = (SELECT FORMAT(f_updateTime, 'yyyy-MM-dd HH:mm:ss') FROM t_order WITH(NOLOCK) WHERE f_orderId = @orderId)
	BEGIN
		BEGIN TRANSACTION
		BEGIN TRY
			UPDATE t_order WITH(ROWLOCK) SET f_currentState = @selectedState, f_previousState = @originalState, f_updateTime = GETDATE() WHERE f_orderId = @orderId
	
			INSERT INTO t_orderState(f_orderId, f_state) VALUES (@orderId, @selectedState)
			

			IF @selectedState = 5
			BEGIN
				UPDATE t_member
				SET t_member.f_points = t_member.f_points + t_order.f_discountedAmount
					, t_member.f_level = 
						CASE
						    WHEN t_member.f_points + t_order.f_discountedAmount < 3000 THEN 1  -- 消費0~3000:普通會員
						    WHEN t_member.f_points + t_order.f_discountedAmount >= 3000 AND t_member.f_points + t_order.f_discountedAmount < 12000 THEN 2  -- 消費3000~12000:白金會員
						    WHEN t_member.f_points + t_order.f_discountedAmount >= 12000 THEN 3  -- 消費大於12000:鑽石會員
						END
				FROM t_member
				LEFT JOIN t_order
				ON t_member.f_memberId = t_order.f_memberId
				WHERE f_orderId = @orderId
			END
			
			IF @selectedState = 10
			BEGIN
				UPDATE t_member
				SET t_member.f_points = 
						CASE
							WHEN t_member.f_points - t_order.f_discountedAmount < 0 THEN 0
							ELSE t_member.f_points - t_order.f_discountedAmount
						END
					, t_member.f_level = 
						CASE
						    WHEN t_member.f_points - t_order.f_discountedAmount < 3000 THEN 1  -- 消費0~3000:普通會員
						    WHEN t_member.f_points - t_order.f_discountedAmount >= 3000 AND t_member.f_points - t_order.f_discountedAmount < 12000 THEN 2  -- 消費3000~12000:白金會員
						    WHEN t_member.f_points - t_order.f_discountedAmount >= 12000 THEN 3  -- 消費大於12000:鑽石會員
						END
				FROM t_member
				LEFT JOIN t_order
				ON t_member.f_memberId = t_order.f_memberId
				WHERE f_orderId = @orderId
			END

		    COMMIT
		END TRY
		BEGIN CATCH
			ROLLBACK
		END CATCH
	END
END