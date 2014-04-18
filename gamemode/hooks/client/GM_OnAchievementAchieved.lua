function GM:OnAchievementAchieved( ply, achid )
	
	chat.AddText( ply, Color( 230, 230, 230 ), " earned the achievement ", Color( 255, 200, 0 ), achievements.GetName( achid ) );
	
end