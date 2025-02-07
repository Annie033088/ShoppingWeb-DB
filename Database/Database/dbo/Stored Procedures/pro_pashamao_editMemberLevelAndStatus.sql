CREATE PROCEDURE [dbo].[pro_pashamao_editMemberLevelAndStatus]
	@memberId INT,
	@status BIT,
	@points INT,
	@level TINYINT
AS
BEGIN
	UPDATE t_member WITH(ROWLOCK) SET f_level = @level, f_status = @status, f_points = @points WHERE f_memberId = @memberId
END