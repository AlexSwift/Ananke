MODULE.Name = 'Trigger'
MODULE.Author = 'WARPAC Studios';
MODULE.Contact = 'n/a';
MODULE.Website = 'www.warpac-rp.com';
MODULE.Description = 'Module designed for brush_trigger lua callbacks'

function MODULE.Functions.AddCallback( id , StartTouch , EndTouch )
	
	MODULE._Data.CallBacks[id] = 	{ 	['start'] 	= StartTouch,
										['end'] 	= EndTouch }
	
end

function MODULE.RemoveCallback( id )
	
	MODULE._Data.CallBacks[id] = nil
	
end


function MODULE.StartTouch( trigger , ent )

	local m_callback = trigger:GetKeyValues().m_callback
	if not MODULE._Data.CallBacks[m_callback]['start'] then return end
	
	MODULE._Data.CallBacks[m_callback]['start']( trigger , ent )
	
end

function MODULE.Functions.EndTouch( trigger , ent )

	local m_callback = trigger:GetKeyValues().m_callback
	if not MODULE._Data.CallBacks[m_callback]['end'] then return end
	
	Module._Data.CallBacks[m_callback]['end']( trigger , ent )
	
end
	
