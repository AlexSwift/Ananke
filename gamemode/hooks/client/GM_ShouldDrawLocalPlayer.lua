--
-- If return true: 		Will draw the local player
-- If return false: 	Won't draw the local player
-- If return nil:	 	Will carry out default action
--
function GM:ShouldDrawLocalPlayer( ply )

	return player_manager.RunClass( ply, "ShouldDrawLocal" )

end