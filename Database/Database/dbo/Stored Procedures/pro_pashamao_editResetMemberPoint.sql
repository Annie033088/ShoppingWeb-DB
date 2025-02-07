CREATE PROCEDURE [dbo].[pro_pashamao_editResetMemberPoint]
AS
BEGIN
	UPDATE t_member WITH(ROWLOCK) SET f_points = 0, f_level = 1
END