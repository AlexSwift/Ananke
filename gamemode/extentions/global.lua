local m_include = _G.include

function Ananke.include( file )
	do --New thread
		m_include( file )
	end
end

function Ananke.GetExeDir( level )
	local m_data = debug.getlocal(0)
	return m_data.src , m_data.short_src
end

