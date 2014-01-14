--[[
	Author:			Matthew Rabey
	Name:			uiBase
	Description:	Base for all UIObjects in-game
]]--

PANEL = core.menu.gui.New();
PANEL.name = 'UIBase';


function PANEL:Init()

	self.MouseInBounds = false

end

function PANEL:OnCursorMoved()

end

function PANEL:OnCursorEntered()

	self.MouseInBounds = true

end

function PANEL:OnCursorExited()

	self.MouseInBounds = false

end

function PANEL:Draw()

end

PANEL:Register();
