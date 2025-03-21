--[[

	ModMenu UI Library
	Created By KSploit
	
	Made for PC only
	Works best for Synapse X

]]

if getgenv().ModMenuUI then
	getgenv().ModMenuUI.cleanup()
end

-----------------------------------------------------------------

local uiLibrary = {}
uiLibrary.Version=2
uiLibrary.__index = uiLibrary
uiLibrary.MenuName = "Mod Menu UI"
uiLibrary.Connections = {}
uiLibrary.Presets = {}
uiLibrary.Pages = {}
uiLibrary.Gui = nil
uiLibrary.Keybinds = {
	Up = Enum.KeyCode.Up,
	Down = Enum.KeyCode.Down,
	Left = Enum.KeyCode.LeftBracket, 
	Right = Enum.KeyCode.RightBracket,
	Enter = Enum.KeyCode.KeypadEnter,
	Back = Enum.KeyCode.Backspace,
	Toggle = Enum.KeyCode.CapsLock
}

local defaultTheme = {
	TitleStroke = nil,
	Heading1 = Color3.fromRGB(0, 170, 255),
	TitleColor = Color3.new(1,1,1),
	TitleFont = Enum.Font.ArialBold,
	SeperatorColor = Color3.new(1,1,1),
	CounterColor = Color3.new(0,0.75,1)
}

uiLibrary.GenvSettings = {
	ModMenuTheme = getgenv().ModMenuTheme or "Default",
	ModMenuName = getgenv().ModMenuName or "Mod Menu UI",
	ModMenuPosition = getgenv().ModMenuPosition or UDim2.new(0, 75, 0, 175),
	ModMenuAnchor = getgenv().ModMenuAnchor or Vector2.new(0,0),
	ModMenuTextAlign = getgenv().ModMenuTextAlign or Enum.TextXAlignment.Left,
	ModMenuCustomTheme = getgenv().ModMenuCustomTheme
}

uiLibrary.Themes = {
	Moon = {
		Heading1 = Color3.fromRGB(164, 166, 147),
		TitleFont = Enum.Font.ArialBold,
		SeperatorColor = Color3.new(1,1,1)
	},
	Racer = {
		TitleStroke = Color3.new(0,0,0),
		Heading1 = Color3.fromRGB(255, 255, 0),
		TitleFont = Enum.Font.LuckiestGuy,
		SeperatorColor = Color3.new(255, 255, 0)
	},
	Dragon = {
		Heading1 = Color3.fromRGB(152, 23, 23),
		TitleFont = Enum.Font.ArialBold,
		SeperatorColor = Color3.fromRGB(152, 23, 23),
		CounterColor = Color3.fromRGB(152, 23, 23)
	},
	CherryBlossom = {
		Heading1 = Color3.fromRGB(255, 89, 161),
		TitleFont = Enum.Font.Kalam,
		SeperatorColor = Color3.fromRGB(255, 89, 161),
		CounterColor = Color3.fromRGB(255, 89, 161)
	},
	Century = {
		Heading1 = Color3.fromRGB(177, 157, 111),
		TitleFont = Enum.Font.Fondamento,
		SeperatorColor = Color3.fromRGB(177, 157, 111),
		CounterColor = Color3.fromRGB(177, 157, 111)
	},
	Hacker = {
		Heading1 = Color3.fromRGB(25,255,25),
		TitleFont = Enum.Font.Arcade,
		SeperatorColor = Color3.fromRGB(25,255,25),
		CounterColor = Color3.fromRGB(25,255,25)
	},
	SpecialForces = {
		Heading1 = Color3.fromRGB(70, 93, 34),
		TitleColor = Color3.new(1,1,1),
		TitleFont = Enum.Font.SpecialElite,
		SeperatorColor = Color3.fromRGB(70, 93, 34),
		CounterColor = Color3.fromRGB(70, 93, 34)
	},
	Poo = {
		Heading1 = Color3.fromRGB(65, 47, 26),
		TitleColor = Color3.new(1,1,1),
		TitleFont = Enum.Font.ArialBold,
		SeperatorColor = Color3.fromRGB(65, 47, 26),
		CounterColor = Color3.fromRGB(65, 47, 26)
	},
}

uiLibrary.Themes.Custom = uiLibrary.GenvSettings.ModMenuCustomTheme or uiLibrary.Themes[uiLibrary.GenvSettings.ModMenuTheme] or defaultTheme
uiLibrary.Theme = uiLibrary.Themes.Custom
uiLibrary.MenuName = uiLibrary.GenvSettings.ModMenuName

local theme = uiLibrary.Theme

-----------------------------------------------------------------

--Gui Instantiator

function makeGui()
	local ModMenuUI = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local TitleFrame = Instance.new("Frame")
	local TitleLabel = Instance.new("TextLabel")
	local Footer = Instance.new("Frame")
	local Seperator = Instance.new("Frame")
	local ArrowLabel = Instance.new("ImageLabel")
	local OptionCounter = Instance.new("TextLabel")
	local BackKeybindDisplay = Instance.new("TextLabel")
	local Pages = Instance.new("Frame")

	ModMenuUI.Name = "ModMenuUI"
	ModMenuUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ModMenuUI.ResetOnSpawn = false

	Main.Name = "Main"
	Main.AnchorPoint = uiLibrary.GenvSettings.ModMenuAnchor
	Main.Parent = ModMenuUI
	Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Main.BackgroundTransparency = 0.1
	Main.BorderSizePixel = 0
	Main.Position = uiLibrary.GenvSettings.ModMenuPosition
	Main.Size = UDim2.new(0.185000002, 0, 0.550000012, 0)

	TitleFrame.Name = "TitleFrame"
	TitleFrame.Parent = Main
	TitleFrame.BackgroundColor3 = theme.Heading1 or defaultTheme.Heading1
	TitleFrame.BorderSizePixel = 0
	TitleFrame.Size = UDim2.new(1, 0, 0, 45)

	TitleLabel.Name = "TitleLabel"
	TitleLabel.Parent = TitleFrame
	TitleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1.000
	TitleLabel.TextStrokeTransparency = theme.TitleStroke and 0 or 1
	TitleLabel.TextStrokeColor3 = theme.TitleStroke or Color3.new(0,0,0)
	TitleLabel.BorderSizePixel = 0
	TitleLabel.Position = UDim2.new(0.5, 0, 0.5, 1)
	TitleLabel.Size = UDim2.new(1, -15, 1, -15)
	TitleLabel.Font = theme.TitleFont
	TitleLabel.Text = uiLibrary.MenuName
	TitleLabel.TextColor3 = theme.TitleColor or defaultTheme.TitleColor
	TitleLabel.TextScaled = true
	TitleLabel.TextSize = 14.000
	TitleLabel.TextWrapped = true

	Footer.Name = "Footer"
	Footer.Parent = Main
	Footer.AnchorPoint = Vector2.new(0, 1)
	Footer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Footer.BackgroundTransparency = 1.000
	Footer.BorderSizePixel = 0
	Footer.Position = UDim2.new(0, 0, 1, 0)
	Footer.Size = UDim2.new(1, 0, 0, 25)

	Seperator.Name = "Seperator"
	Seperator.Parent = Footer
	Seperator.BackgroundColor3 = theme.SeperatorColor
	Seperator.BorderSizePixel = 0
	Seperator.Size = UDim2.new(1, 0, 0, 2)

	ArrowLabel.Name = "ArrowLabel"
	ArrowLabel.Parent = Footer
	ArrowLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ArrowLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ArrowLabel.BackgroundTransparency = 1.000
	ArrowLabel.BorderSizePixel = 0
	ArrowLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ArrowLabel.Size = UDim2.new(0, 30, 1, 0)
	ArrowLabel.Image = "rbxassetid://13049153962"
	ArrowLabel.ScaleType = Enum.ScaleType.Fit

	OptionCounter.Name = "OptionCounter"
	OptionCounter.Parent = Footer
	OptionCounter.AnchorPoint = Vector2.new(1, 0)
	OptionCounter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	OptionCounter.BackgroundTransparency = 1.000
	OptionCounter.BorderSizePixel = 0
	OptionCounter.Position = UDim2.new(1, 0, 0, 4)
	OptionCounter.Size = UDim2.new(0, 60, 1, -8)
	OptionCounter.Font = Enum.Font.Arial
	OptionCounter.Text = "1/1"
	OptionCounter.TextColor3 = Color3.fromRGB(255, 255, 255)
	OptionCounter.TextSize = 14.000

	BackKeybindDisplay.Name = "BackKeybindDisplay"
	BackKeybindDisplay.Parent = Footer
	BackKeybindDisplay.AnchorPoint = Vector2.new(0, 0)
	BackKeybindDisplay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BackKeybindDisplay.BackgroundTransparency = 1.000
	BackKeybindDisplay.BorderSizePixel = 0
	BackKeybindDisplay.Position = UDim2.new(0, 4, 0, 4)
	BackKeybindDisplay.Size = UDim2.new(0, 60, 1, -8)
	BackKeybindDisplay.Font = Enum.Font.Arial
	BackKeybindDisplay.Text = "< Back"
	BackKeybindDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
	BackKeybindDisplay.TextSize = 14.000
	BackKeybindDisplay.TextXAlignment = Enum.TextXAlignment.Left
	BackKeybindDisplay.Visible = false

	Pages.Name = "Pages"
	Pages.Parent = Main
	Pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Pages.BackgroundTransparency = 1.000
	Pages.BorderSizePixel = 0
	Pages.ClipsDescendants = true
	Pages.Position = UDim2.new(0, 0, 0, 45)
	Pages.Size = UDim2.new(1, 0, 1, -70)

	return ModMenuUI	
end

uiLibrary.Gui = makeGui()

-----------------------------------------------------------------

--Presets

--Button
function buttonPreset()
	local Button = Instance.new("Frame")
	local ButtonLabel = Instance.new("TextLabel")

	Button.Name = "Button"
	Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Button.BackgroundTransparency = 1
	Button.BorderSizePixel = 0
	Button.Size = UDim2.new(1, 0, 0, 20)

	ButtonLabel.Name = "Label"
	ButtonLabel.AnchorPoint = Vector2.new(0, 0.5)
	ButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ButtonLabel.BackgroundTransparency = 1
	ButtonLabel.BorderSizePixel = 0
	ButtonLabel.Position = UDim2.new(0, 8, 0.5, 0)
	ButtonLabel.Size = UDim2.new(0.5, 0, 1, 0)
	ButtonLabel.Font = Enum.Font.Arial
	ButtonLabel.Text = "Button"
	ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ButtonLabel.TextSize = 14.000
	ButtonLabel.TextWrapped = true
	ButtonLabel.TextXAlignment = uiLibrary.GenvSettings.ModMenuTextAlign
	ButtonLabel.Parent = Button

	return Button
end

--Toggle
function togglePreset()
	local Toggle = Instance.new("Frame")
	local ToggleLabel = Instance.new("TextLabel")
	local ToggleStatus = Instance.new("TextLabel")

	Toggle.Name = "Toggle"
	Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.BackgroundTransparency = 1
	Toggle.BorderSizePixel = 0
	Toggle.Size = UDim2.new(1, 0, 0, 20)

	ToggleLabel.Name = "Label"
	ToggleLabel.Parent = Toggle
	ToggleLabel.AnchorPoint = Vector2.new(0, 0.5)
	ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ToggleLabel.BackgroundTransparency = 1
	ToggleLabel.BorderSizePixel = 0
	ToggleLabel.Position = UDim2.new(0, 8, 0.5, 0)
	ToggleLabel.Size = UDim2.new(0.5, 0, 1, 0)
	ToggleLabel.Font = Enum.Font.Arial
	ToggleLabel.Text = "Toggle"
	ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ToggleLabel.TextSize = 14.000
	ToggleLabel.TextWrapped = true
	ToggleLabel.TextXAlignment = uiLibrary.GenvSettings.ModMenuTextAlign

	ToggleStatus.Name = "ToggleStatus"
	ToggleStatus.Parent = Toggle
	ToggleStatus.AnchorPoint = Vector2.new(0, 0.5)
	ToggleStatus.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ToggleStatus.BackgroundTransparency = 1
	ToggleStatus.BorderSizePixel = 0
	ToggleStatus.Position = UDim2.new(0.699999988, 0, 0.5, 0)
	ToggleStatus.Size = UDim2.new(0.300000012, 0, 1, 0)
	ToggleStatus.Font = Enum.Font.Arial
	ToggleStatus.Text = "Off"
	ToggleStatus.TextColor3 = Color3.fromRGB(255, 65, 65)
	ToggleStatus.TextSize = 14.000
	ToggleStatus.TextStrokeTransparency = 0.500
	ToggleStatus.TextWrapped = true

	return Toggle
end

function valuePreset()
	local Value = Instance.new("Frame")
	local Label = Instance.new("TextLabel")
	local Counter = Instance.new("TextLabel")
	local ArrowRight = Instance.new("ImageLabel")
	local ArrowLeft = Instance.new("ImageLabel")

	Value.Name = "Value"
	Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Value.BackgroundTransparency = 1.000
	Value.BorderSizePixel = 0
	Value.Size = UDim2.new(1, 0, 0, 20)

	Label.Name = "Label"
	Label.Parent = Value
	Label.AnchorPoint = Vector2.new(0, 0.5)
	Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Label.BackgroundTransparency = 1.000
	Label.BorderSizePixel = 0
	Label.Position = UDim2.new(0, 8, 0.5, 0)
	Label.Size = UDim2.new(0.5, 0, 1, 0)
	Label.Font = Enum.Font.Arial
	Label.Text = "Value"
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	Label.TextSize = 14.000
	Label.TextWrapped = true
	Label.TextXAlignment = uiLibrary.GenvSettings.ModMenuTextAlign

	Counter.Name = "Counter"
	Counter.Parent = Value
	Counter.AnchorPoint = Vector2.new(0, 0.5)
	Counter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Counter.BackgroundTransparency = 1.000
	Counter.BorderSizePixel = 0
	Counter.Position = UDim2.new(0.699999988, 0, 0.5, 0)
	Counter.Size = UDim2.new(0.300000012, 0, 1, 0)
	Counter.Font = Enum.Font.Arial
	Counter.Text = "0"
	Counter.TextColor3 = Color3.fromRGB(255, 255, 255)
	Counter.TextSize = 14.000
	Counter.TextStrokeTransparency = 0.500
	Counter.TextWrapped = true

	ArrowRight.Name = "ArrowRight"
	ArrowRight.Parent = Counter
	ArrowRight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ArrowRight.BackgroundTransparency = 1.000
	ArrowRight.BorderSizePixel = 0
	ArrowRight.Position = UDim2.new(1, -20, 0, 0)
	ArrowRight.Rotation = 90.000
	ArrowRight.Size = UDim2.new(0, 20, 1, 0)
	ArrowRight.Image = "rbxassetid://13049395823"
	ArrowRight.ScaleType = Enum.ScaleType.Fit

	ArrowLeft.Name = "ArrowLeft"
	ArrowLeft.Parent = Counter
	ArrowLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ArrowLeft.BackgroundTransparency = 1.000
	ArrowLeft.BorderSizePixel = 0
	ArrowLeft.Rotation = -90.000
	ArrowLeft.Size = UDim2.new(0.271355689, 0, 1, 0)
	ArrowLeft.Image = "rbxassetid://13049395823"
	ArrowLeft.ScaleType = Enum.ScaleType.Fit

	return Value
end

function pagePreset()
	local PagePreset = Instance.new("ScrollingFrame")

	PagePreset.Name = "Page"
	PagePreset.AnchorPoint = Vector2.new(0.5, 0.5)
	PagePreset.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PagePreset.BackgroundTransparency = 1.000
	PagePreset.BorderSizePixel = 0
	PagePreset.ClipsDescendants = false
	PagePreset.Position = UDim2.new(0.5, 0, 0.5, 0)
	PagePreset.Selectable = false
	PagePreset.Size = UDim2.new(1, 0, 1, 0)
	PagePreset.BottomImage = ""
	PagePreset.MidImage = ""
	PagePreset.ScrollingEnabled = false
	PagePreset.TopImage = ""

	return PagePreset
end
function dropdownPreset()
	local DropdownPreset = Instance.new("Frame")

	DropdownPreset.Name = "Dropdown"
	DropdownPreset.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DropdownPreset.BackgroundTransparency = 1
	DropdownPreset.BorderSizePixel = 0
	DropdownPreset.Size = UDim2.new(1, 0, 0, 20)
	
	local Label = Instance.new("TextLabel")
	Label.Name = "Label"
	Label.Size = UDim2.new(1,0,1,0)
	Label.BackgroundTransparency = 1
	Label.TextSize = 14
	Label.Text = "Pick One"
	Label.TextColor3 = Color3.fromRGB(255,255,255)
	Label.TextWrapped = true
	Label.TextXAlignment = uiLibrary.GenvSettings.ModMenuTextAlign
	Label.Parent = DropdownPreset
	
	local List = Instance.new("Frame")
	List.Name = "List"
	List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	List.Size = UDim2.new(1,0,3,0)
	List.Position = UDim2.new(0,0,1,0)
	List.Visible = false
	List.Parent = DropdownPreset
	
	
	for i = 1,3 do
		local Index = Instance.new("TextLabel")
		Index.Name=tostring(i)
		Index.Size = UDim2.new(1,0,0.33,0)
		Index.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Index.TextWrapped = true
		Index.TextXAlignment = uiLibrary.GenvSettings.ModMenuTextAlign
		Index.TextSize = 14
		Index.Text = ""
		Index.Position = UDim2.new(0,0,0.33*(i-1),0)
		Index.Parent = List
	end
	
	return DropdownPreset
	
end
-----------------------------------------------------------------

--Load Presets
uiLibrary.Presets.Button = buttonPreset()
uiLibrary.Presets.Toggle = togglePreset()
uiLibrary.Presets.Value = valuePreset()
uiLibrary.Presets.Page = pagePreset()
uiLibrary.Presets.Dropdown = dropdownPreset()

--Shortcuts
local presets = uiLibrary.Presets
local gui = uiLibrary.Gui
local pages = uiLibrary.Pages
local connections = uiLibrary.Connections

-----------------------------------------------------------------

--Services
local uis = game:GetService("UserInputService")

-----------------------------------------------------------------

--Variables
local currentPage = nil
local currentElement = nil
local selectPosition = 0
local offset = uiLibrary.Presets.Button.Size.Y.Offset

-----------------------------------------------------------------

--Neccessary Functions
function janitor(v)
	table.insert(connections,v)
end

function disconnect()
	for _,c in pairs(connections or {}) do
		c:Disconnect()
	end
end

function uiLibrary.cleanup()
	disconnect()
	gui:Destroy()
	getgenv().ModMenuUI = nil
end

function uiLibrary.toggle(v)
	local toggleState = v or not gui.Enabled

	if toggleState then
		uis.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
		gui.Enabled = true
	else
		uis.MouseBehavior = Enum.MouseBehavior.Default
		gui.Enabled = false
	end

	--selectElement(getElement())
end

function resetElementColors()
	if currentPage then
		for _,element in pairs(currentPage.Frame:GetChildren()) do
			if not element:isA("Frame") then continue end
			element.BackgroundTransparency = 1
			local label = element:FindFirstChild("Label")
			if label then
				label.TextColor3 = Color3.new(1,1,1)
			end
			if element:FindFirstChild("Counter") then
				element.Counter.ArrowLeft.ImageColor3 = Color3.new(1,1,1)
				element.Counter.ArrowRight.ImageColor3 = Color3.new(1,1,1)
				element.Counter.TextColor3 = Color3.new(1,1,1)
			end
		end
	end
end

function getElement(pos)
	if currentPage then
		for _,element in pairs(currentPage.Elements) do
			if element.Frame.Position.Y.Offset == (pos or selectPosition) then
				return element
			end
		end
	end
end

function selectElement(element)
	resetElementColors()
	if element then
		local frame = element.Frame
		frame.BackgroundTransparency = 0
		frame.Label.TextColor3 = Color3.new(0,0,0)
		selectPosition = frame.Position.Y.Offset
		currentElement = element

		if frame:FindFirstChild("Counter") then
			frame.Counter.ArrowLeft.ImageColor3 = Color3.new(0,0,0)
			frame.Counter.ArrowRight.ImageColor3 = Color3.new(0,0,0)
			frame.Counter.TextColor3 = theme.CounterColor or Color3.new(1,1,1)
		end
	end
end

function scroll(up)
	if currentPage then
		if currentPage.Locked then
			return
		end
		local newPos = selectPosition + (up and -offset or offset)
		for _,elm in pairs(currentPage.Elements) do
			if elm.Frame.Position.Y.Offset == newPos then
				--selectElement(elm)
				selectPosition = elm.Frame.Position.Y.Offset
			end
		end
	end
end

function back()
	if currentPage.Locked then
		return
	end
	for _,page in pairs(pages) do
		local frame = page.Frame
		if page.Name:lower() == "home" then
			frame.Visible = true
			currentPage = page
		else
			frame.Visible = false
		end
	end

	selectPosition = 0
	selectElement(getElement())
end

function flip()
	if currentElement and currentElement.Link then
		for _,page in pairs(pages) do
			page.Frame.Visible = false
		end

		currentElement.Link.Frame.Visible = true
		currentPage = currentElement.Link

		selectPosition = 0
		--selectElement(getElement())
	end
end

local keyCalls = {}
function keyPressed(key, callback, condition)
	table.insert(keyCalls, {key, callback, condition})
end

function bindElement(elm,key,callback)
	keyPressed(key, callback, function()
		return (currentElement and currentElement.Frame == elm.Frame)
	end)
end

function checkKeyPressed(input,isTyping)
	if isTyping then return end
	for index,info in pairs(keyCalls) do
		local key = info[1]
		local callback = info[2]
		local condition = info[3]
		if input.KeyCode == key then
			if callback then
				if condition then
					if condition() then
						callback()
					end
				else
					callback()
				end
			end
		end
	end
end

-----------------------------------------------------------------

--Page Constructors

local page = {}
page.__index = page

local element = {}
element.__index = element
element.__newindex = function(a,b,c)
	if typeof(c) == 'RBXScriptConnection' then
		a[b]=janitor(c)
	end
end

function getElementByName(page,name)
	for _,element in pairs(page.Elements) do
		if element.Name == name then
			return element
		end
	end
end

function getElementOrder(elm, page)
	local belowElements = {}
	local aboveElements = {}
	
	local y = elm.Frame.Position.Y.Offset

	for k,v in pairs(page.Elements) do

		local vY = v.Frame.Position.Y.Offset	
		if vY < y then
			table.insert(aboveElements, v)
		elseif vY > y then
			table.insert(belowElements, v)
		end

	end

	return belowElements,aboveElements
end

function shiftElementsFrom(elm, page, up)
	local belowElements, aboveElements = getElementOrder(elm, page)

	if up then
		for _,v in pairs(belowElements) do
			v.Frame.Position -= UDim2.new(0,0,0,offset)
		end
	else
		for _,v in pairs(aboveElements) do
			v.Frame.Position += UDim2.new(0,0,0,offset)
		end
	end
end

function shiftElements(page, up)
	local elements = page.Elements
	for _,element in pairs(elements) do
		if up then
			element.Frame.Position -= UDim2.new(0,0,0,offset)
		else
			element.Frame.Position += UDim2.new(0,0,0,offset)
		end
	end
end

function assertElement(element, page)
	local elements = page.Elements
	local elementCount = #elements
	local backBtn = getElementByName(page, "Back")

	element.Frame.Position = UDim2.new(0,0,0,elementCount*offset)

	if backBtn then
		element.Frame.Position -= UDim2.new(0,0,0,offset)
		backBtn.Frame.Position += UDim2.new(0,0,0,offset)
	end
end

function page:button(name,callback,link)
	local frame = uiLibrary.Presets.Button:Clone()
	frame.Name = name
	frame.Label.Text = name
	frame.Visible = true
	frame.Parent = self.Frame

	local newElement = {}
	newElement.Class = "Button"
	newElement.Selectable = true
	newElement.Name = name
	newElement.Frame = frame
	newElement.Parent = self
	newElement.Callback = callback
	newElement.Link = link

	bindElement(newElement,uiLibrary.Keybinds.Right, newElement.Callback)
	bindElement(newElement,uiLibrary.Keybinds.Enter, newElement.Callback)

	assertElement(newElement, self)

	table.insert(self.Elements, newElement)
	return setmetatable(newElement,element)
end

function page:toggle(name,callback,toggled)
	local frame = uiLibrary.Presets.Toggle:Clone()
	frame.Name = name
	frame.Label.Text = name
	frame.Visible = true
	frame.Parent = self.Frame

	local newElement = {}
	newElement.Class = "Toggle"
	newElement.Name = name
	newElement.Selectable = true
	newElement.Name = name
	newElement.Frame = frame
	newElement.Parent = self
	newElement.Callback = callback
	newElement.Toggled = toggled or false

	local function update()
		local state = newElement.Toggled
		frame.ToggleStatus.Text = state and "On" or "Off"
		frame.ToggleStatus.TextColor3 = state and Color3.new(0.2, 1, 0.3) or Color3.new(1, 0.25, 0.25)
	end

	local function change()
		newElement.Toggled = not newElement.Toggled
		update()
		if newElement.Callback then
			newElement.Callback(newElement.Toggled)
		end
	end

	update()

	bindElement(newElement, uiLibrary.Keybinds.Right, change)
	bindElement(newElement, uiLibrary.Keybinds.Left, change)

	assertElement(newElement, self)

	table.insert(self.Elements, newElement)
	return setmetatable(newElement,element)
end

function page:value(name,callback,startingValue,min,max,increment)
	local frame = uiLibrary.Presets.Value:Clone()
	frame.Name = name
	frame.Label.Text = name
	frame.Counter.Text = startingValue or "0"
	frame.Visible = true
	frame.Parent = self.Frame

	local newElement = {}
	newElement.Class = "Value"
	newElement.Name = name
	newElement.Selectable = true
	newElement.Name = name
	newElement.Frame = frame
	newElement.Parent = self
	newElement.Callback = callback
	newElement.Value = startingValue or 0
	newElement.Min = min or -math.huge
	newElement.Max = max or math.huge
	newElement.Increment = increment or 1

	local function updateCounter()
		frame.Counter.Text = string.sub(tostring(newElement.Value),1,5)
	end

	local function callbackEvent()
		if newElement.Callback then
			newElement.Callback(newElement.Value)
		end
		updateCounter()
	end

	local function sub()
		newElement.Value = math.clamp(newElement.Value - newElement.Increment, newElement.Min, newElement.Max)
		callbackEvent()
	end

	local function add()
		newElement.Value = math.clamp(newElement.Value + newElement.Increment, newElement.Min, newElement.Max)
		callbackEvent()	
	end

	bindElement(newElement,uiLibrary.Keybinds.Left,sub)
	bindElement(newElement,uiLibrary.Keybinds.Right,add)

	assertElement(newElement, self)

	table.insert(self.Elements, newElement)
	return setmetatable(newElement,element)
end
function page:dropdown(name,list,defaultIndex,callback)
	local frame = uiLibrary.Presets.Dropdown:Clone()
	frame.Name = name
	frame.Visible = true
	frame.Parent = self.Frame

	local newElement = {}
	newElement.Class = "Dropdown"
	newElement.Name = name
	newElement.Selectable = true
	newElement.Name = name
	newElement.Frame = frame
	newElement.Parent = self
	newElement.Callback = callback
	newElement.List = list
	newElement.ListVisible = false
	newElement.SelectedElement = defaultIndex or 1
	newElement.CurrentlySelected = nil
	local StartingIndex = 1
	local WindowSize = 3
	local function updateList()
		local firstIndex = newElement.List[StartingIndex]
		local secondIndex = newElement.List[StartingIndex+1] 
		local thirdIndex = newElement.List[StartingIndex+2]
		
		local selectedIndex = (newElement.SelectedElement+1) - StartingIndex
		
		
		for i = 1,3 do
			local item = newElement.List[StartingIndex+(i-1)]
			if item then
				frame.List[tostring(i)].Text = item
			else
				frame.List[tostring(i)].Text = "Empty"
			end
			if selectedIndex == i then
				frame.List[tostring(i)].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				frame.List[tostring(i)].TextColor3 = Color3.fromRGB(0, 0, 0)
			else
				frame.List[tostring(i)].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				frame.List[tostring(i)].TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		end
	end
	local function update()
		if newElement.List[newElement.SelectedElement] then
			frame.Label.Text = newElement.List[newElement.SelectedElement]
		else
			frame.Label.Text = "Pick one"
		end
		frame.List.Visible = newElement.ListVisible
		updateList()
	end
	

	local function hideList()
		if newElement.ListVisible then
			self.Locked = false
			newElement.ListVisible = false
		end
		update()
	end
	local function showList()
		if not newElement.ListVisible then
			self.Locked = true
			newElement.ListVisible = true
		else
			newElement.CurrentlySelected = newElement.List[newElement.SelectedElement]
			callback(newElement.List[newElement.SelectedElement])
			hideList()
		end	
		update()
	end
	local function scrollList(up)
		if newElement.ListVisible then
			if up then
				if newElement.SelectedElement > 1 then
					newElement.SelectedElement -= 1
					if newElement.SelectedElement < StartingIndex then
						StartingIndex -= WindowSize
					end
				end
			else
				if newElement.SelectedElement < #newElement.List then
					newElement.SelectedElement += 1
					if newElement.SelectedElement > (StartingIndex-1)+WindowSize then
						StartingIndex=newElement.SelectedElement
					end
				end
			end
			update()
		end
	end
	
	bindElement(newElement,uiLibrary.Keybinds.Down,scrollList)
	bindElement(newElement, uiLibrary.Keybinds.Up, function()
		scrollList(true)
	end)
	bindElement(newElement,uiLibrary.Keybinds.Right,showList)
	bindElement(newElement,uiLibrary.Keybinds.Enter,showList)
	bindElement(newElement,uiLibrary.Keybinds.Back,hideList)
	
	assertElement(newElement, self)
	
	updateList()

	table.insert(self.Elements, newElement)
	return setmetatable(newElement,element)
end

--Builders
function uiLibrary.createPage(name)
	assert(name, "Invalid Page Name")

	local frame = uiLibrary.Presets.Page:Clone()
	frame.Name = name
	frame.Visible = false 
	frame.Parent = gui.Main.Pages

	local newPage = setmetatable({},page)
	newPage.Locked = false
	newPage.Name = name
	newPage.Frame = frame
	newPage.Class = "Page"
	newPage.Elements = {}

	if name ~= "Home" then
		uiLibrary.Pages.Home:button(name,flip,newPage)
		newPage:button("Back",back)
	end

	pages[name] = newPage
	return newPage
end


--REQUIRED!!! Home page
local homePage = uiLibrary.createPage("Home")
homePage.Frame.Visible = true
currentPage = homePage

--Connections
janitor(uis.InputBegan:Connect(checkKeyPressed))

--Traversing the GUI
keyPressed(uiLibrary.Keybinds.Toggle, uiLibrary.toggle)
keyPressed(uiLibrary.Keybinds.Back, back)
keyPressed(uiLibrary.Keybinds.Up, function()
	scroll(true)
end)
keyPressed(uiLibrary.Keybinds.Down, scroll)

--Finalize GUI
gui.Enabled = true
gui.Parent = game.CoreGui

--Return
getgenv().ModMenuUI = uiLibrary

spawn(function()
	while getgenv().ModMenuUI do
		selectElement(getElement())
		wait()
		if currentPage and currentElement then
			local main = gui:FindFirstChild("Main")
			if not gui or not main then break end

			if currentPage.Name == "Home" then
				main.Footer.BackKeybindDisplay.Visible = false
				main.TitleFrame.TitleLabel.Text = uiLibrary.MenuName
			else
				main.Footer.BackKeybindDisplay.Visible = true
				main.Footer.BackKeybindDisplay.Text = "< "..tostring(uiLibrary.Keybinds.Back):split(".")[3]
				main.TitleFrame.TitleLabel.Text = currentPage.Name
			end
			if #currentPage.Frame:GetChildren() > 0 then
				main.Footer.OptionCounter.Text = math.floor((currentElement.Frame.Position.Y.Offset+20 )/20).."/"..#currentPage.Frame:GetChildren()
			else
				main.Footer.OptionCounter.Text = "0/0"
			end
		end
	end
end)

return uiLibrary
