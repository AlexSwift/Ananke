local modul = Ananke.modules.new()
modul.Name = 'SoundScape'

Ananke.SoundScape = {}
Ananke.SoundScape.Data = {} -- ID , callback 

function Ananke.SoundScape.AddSoundScape( id , SndData )
	
	Ananke.SoundScape.CallBacks[id] = { start 	= StartTouch,
										['end']	= EndTouch }
	
end

function Ananke.SoundScape.RemoveCallback( id )

	-- CAUTION: This will break functionality
	
	Ananke.SoundScape.CallBacks[id] = nil
	
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
	
