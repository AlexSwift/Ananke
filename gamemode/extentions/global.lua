local m_include = _G.include
local m_addcsluafile = _G.AddCSLuaFile

function Ananke.include( file )
	do --New thread
		m_include( file )
	end
end

function Ananke.AddCSLuaFile( file )
	if not SERVER then return end
	do
		m_addcsluafile( file )
	end
end

function Ananke.GetExeDir( )
	local m_data = debug.getinfo( 2 )
	return m_data.src , m_data.short_src
end

