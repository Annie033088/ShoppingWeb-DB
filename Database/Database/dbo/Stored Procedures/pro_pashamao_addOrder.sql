CREATE PROCEDURE [dbo].[pro_pashamao_addOrder]
	@orderNumber BIGINT,
	@memberId INT, 
	@name NVARCHAR(50), 
	@address NVARCHAR(326), 
	@phone INT, 
	@shippingOptionId INT, 
	@orderProductStyles type_pashamao_addOrderProductStyle READONLY
AS
BEGIN
	--取得會員等級 並檢查有無被禁用
	DECLARE @level TINYINT
	SELECT @level = f_level
			FROM t_member WITH(NOLOCK)
			WHERE f_memberId = @memberId
			AND f_status = 1

	--檢查庫存量
	IF NOT EXISTS (
	    SELECT 1
	    FROM t_productStyle AS p WITH(NOLOCK)
	    INNER JOIN @orderProductStyles AS o ON p.f_productStyleId = o.f_productStyleId
	    WHERE p.f_stockQuantity < o.f_quantity) 
		AND @level IS NOT NULL
	BEGIN
		BEGIN TRY
		    BEGIN TRANSACTION;
			
		    DECLARE @orderIdTable TABLE(f_orderId INT);
		    DECLARE @orderId INT;
			
		    -- 宣告新增訂單商品的對應表
		    DECLARE @productItem TABLE (
				f_productName NVARCHAR(30) NOT NULL,
		        f_style NVARCHAR(25) NOT NULL,
		        f_quantity INT NOT NULL,
		        f_stylePrice DECIMAL(10,2) NOT NULL
		    );
		
		    -- 插入商品樣式數據
		    INSERT INTO @productItem (f_productName, f_style, f_quantity, f_stylePrice)
		    SELECT p.f_name, ps.f_style, o.f_quantity, (ps.f_price * o.f_quantity) 
		    FROM @orderProductStyles AS o 
		    LEFT JOIN t_productStyle AS ps WITH(NOLOCK) ON ps.f_productStyleId = o.f_productStyleId
			LEFT JOIN t_product AS p WITH(NOLOCK) ON ps.f_productId = p.f_productId
		
			--宣告運輸變數
			DECLARE @shippingOptionName NVARCHAR(10);
			DECLARE @shippingFee DECIMAL(10,2);
			DECLARE @freeShipping DECIMAL(10,2);

			--取得運輸數據
			SELECT @shippingOptionName = f_optionName, @shippingFee = f_shippingFee, @freeShipping = f_freeShipping FROM t_shippingOption WITH(NOLOCK) WHERE f_shippingOptionId = @shippingOptionId

			--宣告金額用變數
			DECLARE @memberLevelDiscount DECIMAL(3,2);
		    DECLARE @originalAmount DECIMAL(10,2);
		    DECLARE @discountedAmount DECIMAL(10,2);
		    DECLARE @totalAmount DECIMAL(10,2);
				--會員對應折數
				DECLARE @generalMemberDiscount DECIMAL(3,2) = 1		--普通會員
				DECLARE @platinumMemberDiscount DECIMAL(3,2) = 0.97	--白金會員 97折
				DECLARE @diamondMemberDiscount DECIMAL(3,2) = 0.93	--鑽石會員 93折
			--設定折數
			SET @memberLevelDiscount =	CASE 
											WHEN @level = 1 THEN @generalMemberDiscount
											WHEN @level = 2 THEN @platinumMemberDiscount
											WHEN @level = 3 THEN @diamondMemberDiscount
										END;

			--原始金額
			SET @originalAmount = (SELECT SUM(f_stylePrice) FROM @productItem) ;

			--折扣後的金額
			SET @discountedAmount = ROUND(@originalAmount * @memberLevelDiscount, 0)

			--運費
			SET @shippingFee =	CASE 
									WHEN @discountedAmount > @freeShipping THEN 0
									ELSE @shippingFee
								END;

		    -- 取得總金額
		    SET @totalAmount = @discountedAmount + @shippingFee
		
		    -- 插入訂單數據
		    INSERT INTO
			t_order(f_memberId, f_orderNumber,f_recipientName, f_phone, f_address, f_originalAmount, f_discountedAmount, f_shippingOptionName, f_shippingFee, f_totalAmount)
		    OUTPUT INSERTED.f_orderId INTO @orderIdTable
		    VALUES(@memberId, @orderNumber, @name, @phone, @address, @originalAmount, @discountedAmount, @shippingOptionName, @shippingFee, @totalAmount);
		    SET @orderId = (SELECT f_orderId FROM @orderIdTable);
		
		    -- 插入訂單商品表
		    INSERT INTO t_orderItem(f_orderId, f_productName, f_style, f_price, f_quantity)
		    SELECT @orderId, f_productName, f_style, f_stylePrice, f_quantity
		    FROM @productItem;
		
		    -- 插入訂單狀態表
		    INSERT INTO t_orderState (f_orderId) VALUES (@orderId);
		
		    -- 更新商品庫存
		    UPDATE p WITH(ROWLOCK)
		    SET p.f_stockQuantity = p.f_stockQuantity - o.f_quantity
		    FROM t_productStyle AS p
		    INNER JOIN @orderProductStyles AS o ON p.f_productStyleId = o.f_productStyleId;
		
		    COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		    ROLLBACK TRANSACTION;
		    THROW;  
		END CATCH;
	END
END