--[[
	Author:			Matthew Rabey and Alex Swift
	Name:			uiBase
	Description:	Base for all UIObjects in-game
]]--

PANEL = core.menu.gui.New('UIBase');
-- PANEL.name = 'UIBase';

function PANEL:Init()

	self.MouseInBounds = false
	self.IsEnabled = false
	self.uiParent = false
	self.uiChildren = {}

end

function PANEL:OnCursorMoved()

end

function PANEL:OnCursorEntered()

	self.MouseInBounds = true

end

function PANEL:OnCursorExited()

	self.MouseInBounds = false

end

function PANEL:SetPosition(x, y)

end

function PANEL:SetParent(parent)

	self.uiParent = parent
	table.insert(parent.uiChildren, self)
	
end 

function PANEL:GetParent()

	return self.parent
	
end

function PANEL:IsEnabled()

	return IsEnabled
	
end

function PANEL:Enable()

	self.IsEnabled = true
	
	local children = self.children
	if children then
		for k, v in pairs(children) do
			children[k].Enable()
		end
	end
	
end

function PANEL:Disable()

	self.IsEnabled = false
	
	local children = self.children
	if children then
		for k, v in pairs(children) do
			children[k].Disable()
		end
	end
	
end

function PANEL:Draw()
	--surface.DrawRect((surface.ScreenWidth * 0.5) - 50, (surface.ScreenHeight * 0.5) - 50, 100, 100)
end

PANEL:Register();
