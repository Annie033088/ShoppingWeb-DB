CREATE PROCEDURE [dbo].[pro_pashamao_getSortedMemberAddress]
	@column VARCHAR(20),
	@page INT,
	@sortOrder VARCHAR(10),
	@totalPages INT OUTPUT
AS
BEGIN
	DECLARE @dataCntAtEveryPage INT = 8
	DECLARE @pageDataCnt INT = (@page-1) * @dataCntAtEveryPage
	DECLARE @sql NVARCHAR(1000)
	DECLARE @totalItems INT

	SET @sql = N'SELECT f_addressId, f_memberId, f_city, f_district, f_detail , f_postalCode 
	             FROM t_memberAddress WITH(NOLOCK) 
	             ORDER BY ' + QUOTENAME(@column) + 
	             CASE 
	                 WHEN @sortOrder = 'Descending' THEN ' DESC'
	                 ELSE ' ASC'
	             END  + '
				OFFSET @pageDataCnt ROWS 
				FETCH NEXT ' + CAST(@dataCntAtEveryPage AS NVARCHAR(10)) + '  ROWS ONLY'

	EXEC sp_executesql @SQL, N'@pageDataCnt INT', @pageDataCnt
	SELECT @totalItems = COUNT(*) FROM t_memberAddress;
	SET @totalPages = CEILING(@totalItems / CAST(@dataCntAtEveryPage AS FLOAT));
END