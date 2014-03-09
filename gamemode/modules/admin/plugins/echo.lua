PLUGIN.Name = 'Echo'
PLUGIN.Author = ''
PLUGIN.Contact = ''
PLUGIN.Website = ''
PLUGIN.Description = ''

PLUGIN.Data.args = {
	['p'] = {'string','Default'}
	}
	
function PLUGIN.Functions.CallBack( data ) 
	print( data['p'] ) 
end


