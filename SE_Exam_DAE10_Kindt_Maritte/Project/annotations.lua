---@meta

--- Game Engine Class
---@class GameEngine
GAME_ENGINE = {}

--- Sets Window Title
--- @param title string
--- @return nil
function GAME_ENGINE:SetTitle(title) end

--- Sets Window Width
--- @param width number
--- @return nil
function GAME_ENGINE:SetWidth(width) end

--- Sets Window Height
--- @param height number
--- @return nil
function GAME_ENGINE:SetHeight(height) end

--- Sets Window Frame Rate
--- @param frameRate number
--- @return nil
function GAME_ENGINE:SetFrameRate(frameRate) end

--- Sets Color
--- @param r number
--- @param g number
--- @param b number
--- @param a number
--- @return nil
function GAME_ENGINE:SetColor(r, g, b, a) end

--- Makes Filled Rectangle
--- @param left number
--- @param top number
--- @param right number
--- @param bottom number
--- @return boolean
function GAME_ENGINE:FillRect(left, top, right, bottom) end

--- Predefined Game Engine
--- @type GameEngine
GAME_ENGINE.GAME_ENGINE = GAME_ENGINE


--- Caller Class
--- @class Caller

--- Add Action Listener
--- @param target Callable
--- @return boolean
function Caller:AddActionListener(target) end

--- Remove Action Listener
--- @param target Callable
--- @return boolean
function Caller:RemoveActionListener(target) end


--- Callable Class
--- @class Callable

--- Call Action
--- @param caller Caller
--- @return nil
function Callable:CallAction(caller) end


--- Button Class
--- @class Button : Caller
--- Represents a UI Button that can be interacted with.
Button = {}

--- Button Constructor
--- @param text string
--- @return Button
function Button:new(text) 
    local self = setmetatable({}, Button)
    self.text = text

    return self
end

--- @return Button
function Button:new() 
    local self = setmetatable({}, Button)

    return self
end

--- Set Bounds
--- @param left number
--- @param top number
--- @param right number
--- @param bottom number
--- @return nil
function Button:SetBounds(left, top, right, bottom) end

--- Set Text
--- @param text string
--- @return nil
function Button:SetText(text) end

--- Set Fond
--- @param font_name string
--- @param bold bool
--- @param italic bool
--- @param underline bool
--- @param size int
--- @return nil
function Button:SetFont(font_name, bold, italic, underline, size) end

--- Set Enabled
--- @param enable bool
--- @return nil
function Button:SetEnabled(enable) end

--- Show
--- @return nil
function Button:Show() end

--- Hide
--- @return nil
function Button:Hide() end

---Gets the bounds of the button.
---@return table A table containing the bounds of the button (left, top, right, bottom).
function Button:GetBounds() end

---Gets the text displayed on the button.
---@return string The text displayed on the button.
function Button:GetText() end

---Gets the type of the caller.
---@return Type The type of the caller (e.g., Button, TextBox).
function Button:GetType() end


--- Game Class
--- @class GAME
GAME = {}

--- Initialize
--- @return nil
function GAME:Initialize() end

--- Start
--- @return nil
function GAME:Start() end
    
--- End
--- @return nil
function GAME:End() end

--- Paints
--- @return nil
function GAME:Paint() end

--- Tick
--- @return nil
function GAME:Tick() end

--- Mouse Button Action
--- @param isLeft boolean
--- @param isDown boolean
--- @param x int
--- @param y int
--- @return nil
function GAME:MouseButtonAction(isLeft, isDown, x, y) end

--- Mouse Wheel Action
--- @param x int
--- @param y int
--- @param distance int
--- @return nil
function GAME:MouseWheelAction(x, y, distance) end

--- Mouse Move
--- @param x int
--- @param y int
--- @return nil
function GAME:MouseMove(x, y) end

--- Check Keyboard
--- @return nil
function GAME:CheckKeyboard() end

--- Key Pressed
--- @param key string
--- @return nil
function GAME:KeyPressed(key) end

--- Call Action
--- @param caller Caller
--- @return nil
function GAME:CallAction(caller) end