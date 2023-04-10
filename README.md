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
### Cons
- PC Only
- No Flags
- Keyboard Required
### How To Use
```lua
getgenv().ModMenuName = "Title" --The name you want to display at the top of the gui
getgenv().ModMenuTheme = "CherryBlossom" --The theme you want the gui to be, we will get into themes after this

local uiLibrary = loadstring("https://raw.githubusercontent.com/KSploit/ModMenuUI/Source.lua")() --Load the uiLibrary in

local page = uiLibrary.createPage("Page Name") --Create a new page

local button = page:button("Button Name", print) --Creates a button with a specified callback function
local toggle = page:toggle("Toggle Name", print, false) --Creates a toggle with a specified callback function and initial toggle state
local value = page:value("Value Name", print, 0, -10, 10, 1) --Creates a value that can be changed with a specified callback function, initial value, minimum value, maximum value, and an increment

wait(5)
uiLibrary.cleanup() --Destroys the gui and disconnects all RBXScriptSignals
```
