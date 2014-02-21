local modul = Ananke.modules.new()
modul.Name = 'SoundScape'

Ananke.SoundScape = {}
Ananke.SoundScape.Scapes = {} 

function Ananke.SoundScape.AddSoundScape( id , SndData )

	local SoundObj = CreateSound( pl, SndData.Sound )
	
	local StartTouch = function( trigger , ent, m_scape )
		if not CLIENT then return end
		
		for k, v in pairs( Ananke.SoundScape.Scapes ) do
			v.SndData.controlVol = 0
		end
		
		Ananke.SoundScape.Scapes[m_scape].SndData.controlVol = .5
		-- UPDATE SOUND OBJECTS HERE --
	end
		
	local EndTouch = function( trigger , ent, m_scape )
		if not CLIENT then return end
		Ananke.SoundScape.Scapes[m_scape].SndData.controlVol = 0
		-- UPDATE SOUND OBJECTS HERE --
	end
	
	Ananke.SoundScape.Scapes[id] = { start 	= StartTouch,
									['end']	= EndTouch,
									SndData = SndData}
	
end

function Ananke.SoundScape.RemoveCallback( id )
	Ananke.SoundScape.Scapes[id] = nil
end


function Ananke.SoundScape.StartTouch( trigger , ent )

	local m_scape = trigger:GetKeyValues().m_scape
	if not Ananke.SoundScape.Scapes[m_scape]['start'] then return end
	
	Ananke.SoundScape.Scapes[m_scape]['start']( trigger , ent, m_scape )
	
end

function Ananke.SoundScape.EndTouch( trigger , ent )

	local m_scape = trigger:GetKeyValues().m_scape
	if not Ananke.SoundScape.Scapes[m_scape]['end'] then return end
	
	Ananke.SoundScape.Scapes[m_scape]['end']( trigger , ent, m_scape )
	
end
	
