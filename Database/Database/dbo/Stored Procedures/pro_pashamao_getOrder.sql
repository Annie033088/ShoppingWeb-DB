CREATE PROCEDURE [dbo].[pro_pashamao_getOrder]
	@orderNumber BIGINT,
	@phone INT,
	@memberId INT,
	@dateStart DATETIME,
	@dateEnd DATETIME,
	@status TINYINT,
	@page INT,
	@totalPages INT OUTPUT
AS
BEGIN
	DECLARE @pageDataCnt INT = (@page-1) * 8
	DECLARE @totalItems INT

	SELECT f_orderId, f_orderNumber, f_createTime, f_updateTime, f_memberId, f_recipientName, f_phone, f_previousState, f_currentState, f_totalAmount FROM t_order WITH(NOLOCK)  
	 WHERE
        (@orderNumber IS NULL OR f_orderNumber = @orderNumber) 
        AND (@phone IS NULL OR CAST(f_phone AS CHAR(9)) LIKE '%' + CAST(@phone AS CHAR(3)))
        AND (@dateStart IS NULL OR f_createTime BETWEEN @dateStart AND @dateEnd)
        AND (@memberId IS NULL OR f_memberId = @memberId) 
        AND (@status IS NULL OR f_currentState = @status) 
	ORDER BY (SELECT NULL)
	OFFSET @pageDataCnt ROWS
	FETCH NEXT 8 ROWS ONLY

	SET @totalItems = (    
	SELECT COUNT(*) 
    FROM t_order WITH(NOLOCK)  
    WHERE
       (@orderNumber IS NULL OR f_orderNumber = @orderNumber) 
        AND (@phone IS NULL OR CAST(f_phone AS CHAR(9)) LIKE '%' + CAST(@phone AS CHAR(3)))
        AND (@dateStart IS NULL OR f_createTime BETWEEN @dateStart AND @dateEnd)
        AND (@memberId IS NULL OR f_memberId = @memberId) 
        AND (@status IS NULL OR f_currentState = @status) )

	SET @totalPages = CEILING(@totalItems / CAST(8 AS FLOAT))
END