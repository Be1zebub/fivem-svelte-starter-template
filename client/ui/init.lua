UI = {
	visibility = false,
	focus = {
		keyboard = false,
		mouse = false
	},
	page = "none"
}

function UI:Open(page)
	self:SetPage(page)
	self:SetVisible(true)
	self:SetFocus(true, true)
end

-- getters
do
	function UI:IsVisible()
		return self.visibility
	end

	function UI:IsFocused()
		return self.focus.mouse or self.focus.keyboard
	end

	function UI:IsMouseFocused()
		return self.focus.mouse
	end

	function UI:IsKeyboardFocused()
		return self.focus.keyboard
	end

	function UI:GetPage()
		return self.page
	end
end

-- visibility
do
	function UI:SetVisible(visible)
		self.visibility = visible
		SendNUIMessage({
			action = "visibility",
			data = visible
		})
	end

	function UI:ToggleVisibility()
		self:SetVisible(not self:IsVisible())
	end

	RegisterNUICallback("visibility", function(data)
		UI.visibility = data.visibility
	end)
end

-- focus
do
	function UI:SetKeyboardFocus(focused)
		self.focus.keyboard = focused or false
		self:SyncFocus()
	end

	function UI:ToggleKeyboardFocus()
		self:SetKeyboardFocus(not self.focus.keyboard)
	end

	---------

	function UI:SetMouseFocus(focused)
		self.focus.mouse = focused or false\
		self:SyncFocus()
	end

	function UI:ToggleMouseFocus()
		self:SetMouseFocus(not self.focus.mouse)
	end

	---------

	function UI:SetFocus(mouse, keyboard)
		if keyboard == nil then keyboard = mouse end

		self.focus.mouse = mouse
		self.focus.keyboard = keyboard

		self:SyncFocus()
	end

	function UI:ToggleFocus()
		self:SetFocus(not self.focus.mouse, not self.focus.keyboard)
	end

	---------

	function UI:SyncFocus()
		SetNuiFocus(self.focus.keyboard, self.focus.mouse)
		SendNUIMessage({
			action = "focus",
			data = {
				mouse = self.focus.mouse,
				keyboard = self.focus.keyboard
			}
		})
	end

	RegisterNUICallback("focus", function(data)
		UI.focus.mouse = data.mouse
		UI.focus.keyboard = data.keyboard
		SetNuiFocus(UI.focus.keyboard, UI.focus.mouse)
	end)
end

-- pages
do
	function UI:SetPage(page)
		self.page = page
		SendNUIMessage({
			action = "page",
			data = page
		})
	end

	RegisterNUICallback("page", function(data)
		UI.page = data.page
	end)
end

-- admin commands
do
	RegisterCommand(GetCurrentResourceName() .. ":open", function(_, args)
		local page = table.concat(args, "")
		UI:Open(page)
	end, true)

	-------------

	RegisterCommand(GetCurrentResourceName() .. ":show", function()
		UI:SetVisible(true)
	end, true)

	RegisterCommand(GetCurrentResourceName() .. ":hide", function()
		UI:SetVisible(false)
	end, true)

	-------------

	RegisterCommand(GetCurrentResourceName() .. ":focus", function()
		UI:ToggleFocus()
	end, true)

	RegisterCommand(GetCurrentResourceName() .. ":keyboard-focus", function()
		UI:ToggleKeyboardFocus()
	end, true)

	RegisterCommand(GetCurrentResourceName() .. ":mouse-focus", function()
		UI:ToggleMouseFocus()
	end, true)

	-------------

	RegisterCommand(GetCurrentResourceName() .. ":page", function(_, args)
		local page = table.concat(args, "")
		UI:SetPage(page)
	end, true)
end
