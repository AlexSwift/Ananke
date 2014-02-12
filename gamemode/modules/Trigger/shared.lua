local modul = Ananke.modules.new()
modul.Name = 'Trigger'

Ananke.Trigger = {}
Ananke.Trigger.CallBacks = {} -- ID , callback 

function Ananke.Trigger.AddCallback( id , StartTouch , EndTouch )
	
	Ananke.Trigger.CallBacks[id] = { 	['start'] 	= StartTouch,
										['end'] 	= EndTouch }
	
end

function Ananke.Trigger.RemoveCallback( id )

	-- CAUTION: This will break functionality
	
	Ananke.Trigger.CallBacks[id] = nil
	
end


function Ananke.Trigger.StartTouch( trigger , ent )

	local m_callback = trigger:GetKeyValues().m_callback
	if not Ananke.Trigger.CallBacks[m_callback]['start'] then return end
	
	Ananke.Trigger.CallBacks[m_callback]['start']( trigger , ent )
	
end

function Ananke.Trigger.EndTouch( trigger , ent )

	local m_callback = trigger:GetKeyValues().m_callback
	if not Ananke.Trigger.CallBacks[m_callback]['end'] then return end
	
	Ananke.Trigger.CallBacks[m_callback]['end']( trigger , ent )
	
end
	
