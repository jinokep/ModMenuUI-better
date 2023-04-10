# ModMenuUI
## GTA 5 Mod Menu UI turned into a Roblox UI Library!
### Pros
- Aesthetic Design
- Automatic Cleanup
- Simple Syntax
- Adjustable Settings
- Adjustable Keybinds
- No Mouse Required
- Built-in themes/Custom themes
- Works for all executors
- Well Documented
### Cons
- PC Only
- No Flags
- Keyboard Required
### How To Use
```lua
getgenv().ModMenuName = "Mod Menu" --The name you want to display at the top of the gui
getgenv().ModMenuTheme = "CherryBlossom" --The theme you want the gui to be, we will get into themes next

local uiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/KSploit/ModMenuUI/main/Source.lua"))() --Load the uiLibrary in

local page = uiLibrary.createPage("Page Name") --Create a new page

local button = page:button("Button Name", print) --Creates a button with a specified callback function
local toggle = page:toggle("Toggle Name", print, false) --Creates a toggle with a specified callback function and initial toggle state
local value = page:value("Value Name", print, 0, -10, 10, 1) --Creates a value that can be changed with a specified callback function, initial value, minimum value, maximum value, and an increment

wait(5)
uiLibrary.cleanup() --Destroys the gui and disconnects all RBXScriptSignals
```
### Themes
Themes are a way to customize your GUI, in this section we will take a look at themes, applying themes, and making your own themes.

#### All Current Themes
!Default("https://google.com")
!Moon("https://google.com")
!Racer("https://google.com")
!Dragon("https://google.com")
!CherryBlossom("https://google.com")
!Century("https://google.com")
!Hacker("https://google.com")
!SpecialForces("https://google.com")
!Poo("https://google.com")

#### Applying a theme
To apply a theme, just type this line before loading ModMenu UI Library
```lua
    getgenv().ModMenuTheme = "CherryBlossom" --Change this to the name of your theme (Must be the exact name including capital letters)
```
#### Custom Themes
The ModMenu UI Library has a built in way to add your own themes, lets look at how to do it
```lua
--This will be your theme
local customTheme = {
  TitleStroke = Color3.new(0,0,0), --Adds a stroke color to your title, set to nil if you don't want stroke
	Heading1 = Color3.fromRGB(0, 170, 255), --Changes the background color of the title
	TitleColor = Color3.new(1,1,1), --Changes the textcolor of the title
	TitleFont = Enum.Font.ArialBold, --Changes the font of the title
	SeperatorColor = Color3.new(1,1,1), --Changes the line color at the bottom of the menu
	CounterColor = Color3.new(0,0.75,1) --Changes the textcolor of counters when you hover over them
}

--Now to apply your theme, just type this line before loading ModMenu UI Library
getgenv().ModMenuCustomTheme = customTheme
```
