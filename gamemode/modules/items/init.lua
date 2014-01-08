local modul = modules.new()
modul.name = 'items'

items = {}
items['items'] = {}
items.mt = {}
items.mt._index = {}

function items.mt:Register( data )
	items['items'][data.name] = table.copy(data)
end

function items.mt:Equip()

end

function items.mt.UnEquip()

end

function items.mt.New()
	return setmetatable( {} , items.mt )
end

function items.Initialise()

	f,d = file.Find( "gamemodes/wp_base/gamemode/modules/items/items/*.lua", "GAME" )

	print('Loading Items :')
	for k,v in pairs(f) do
		if file.Size('gamemodes/wp_base/gamemode/modules/items/items/'..v ,"GAME") == 0 then continue end
		print('\tLoading ' .. v)
			do
				include("wp_base/gamemode/modules/items/items/"..v)
			end
		end
	end

end

function modul:OnLoad()
	items.Initialise()
end

function modul:UnLoad()
	items = nil
end


function profiles:GiveItem(data)
	local tabl = self:GetItems()
	table.insert(tabl,data)
	self:SetItems(tabl)
end

function profiles:GetItems()
	return self:Get('inventory')
end

function profiles:SetItems(data)
	self:Set('inventory',data)
end

modul:Register()
