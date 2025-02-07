CREATE PROCEDURE [dbo].[pro_pashamao_getSelectMember]
	@selectColumn VARCHAR(20),
	@value VARCHAR(254),
	@sortColumn VARCHAR(20),
	@page INT,
	@sortOrder VARCHAR(10),
	@totalPages INT OUTPUT
AS
BEGIN
	DECLARE @dataCntAtEveryPage INT = 8
	DECLARE @pageDataCnt INT = (@page-1) * @dataCntAtEveryPage
	DECLARE @sql NVARCHAR(1000)
	DECLARE @totalItems INT
	SET @sql = N'SELECT f_memberId, f_email, f_phone, f_memberName, f_status, f_level
	             FROM t_member WITH(NOLOCK) 
				 WHERE ' + QUOTENAME(@selectColumn) + ' = @value  
	             ORDER BY ' + QUOTENAME(@sortColumn) + 
	             CASE 
	                 WHEN @sortOrder = 'Descending' THEN ' DESC'
	                 ELSE ' ASC'
	             END  + '
				OFFSET @pageDataCnt ROWS 
				FETCH NEXT ' + CAST(@dataCntAtEveryPage AS NVARCHAR(10)) + ' ROWS ONLY
				
				SET @totalItems = (SELECT COUNT(*) FROM t_member  WHERE ' + QUOTENAME(@selectColumn) + ' = @value) '
	EXEC sp_executesql @SQL, N'@value VARCHAR(254), @pageDataCnt INT, @totalItems INT OUTPUT', @value, @pageDataCnt, @totalItems OUTPUT
	
	SET @totalPages = CEILING(@totalItems / CAST(@dataCntAtEveryPage AS FLOAT));
END