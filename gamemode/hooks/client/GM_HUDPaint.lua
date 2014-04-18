function GM:HUDPaint()

	hook.Run( "HUDDrawTargetID" )
	hook.Run( "HUDDrawPickupHistory" )
	hook.Run( "DrawDeathNotice", 0.85, 0.04 )

end