CREATE PROCEDURE [dbo].[pro_pashamao_getAllRole]
	@page INT,
	@totalPages INT OUTPUT
AS
BEGIN
	DECLARE @dataCntAtEveryPage INT = 8
	DECLARE @pageDataCnt INT = (@page-1) * @dataCntAtEveryPage
	DECLARE @totalItems INT



	SELECT f_roleId, f_name, f_description FROM t_role WITH(NOLOCK) 
	ORDER BY (SELECT NULL)
	OFFSET @pageDataCnt ROWS 
	FETCH NEXT 8 ROWS ONLY

	SET @totalItems = ( SELECT COUNT(*) FROM t_role)
	SET @totalPages = CEILING(@totalItems / CAST(8 AS FLOAT))
END