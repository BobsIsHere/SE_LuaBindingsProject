---@meta

--- #################
--- Game Engine Class
--- #################
---@class GameEngine
GAME_ENGINE = {}

--- Sets Window Title
--- @param title string
--- @return nil
function GAME_ENGINE:SetTitle(title) end

--- Sets Window Width
--- @param width integer
--- @return nil
function GAME_ENGINE:SetWidth(width) end

--- Sets Window Height
--- @param height integer
--- @return nil
function GAME_ENGINE:SetHeight(height) end

--- Sets Window Frame Rate
--- @param frameRate integer
--- @return nil
function GAME_ENGINE:SetFrameRate(frameRate) end

--- Check What Key is Pressed
--- @param key integer
--- @return boolean
function GAME_ENGINE:IsKeyDown(key) end

--- Sets Color
--- @param color DWORD
--- @return nil
function GAME_ENGINE:SetColor(color) end

--- Makes Filled Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:FillRect(left, top, right, bottom) end

--- Get Screen Width
--- @return integer
function GAME_ENGINE:GetWidth() end

--- Predefined Game Engine
--- @type GameEngine
GAME_ENGINE.GAME_ENGINE = GAME_ENGINE


--- ############
--- Caller Class
--- ############
--- @class Caller

--- Add Action Listener
--- @param target Callable
--- @return boolean
function Caller:AddActionListener(target) end

--- Remove Action Listener
--- @param target Callable
--- @return boolean
function Caller:RemoveActionListener(target) end

--- ##############
--- Callable Class
--- ##############
--- @class Callable

--- Call Action
--- @param caller Caller
--- @return nil
function Callable:CallAction(caller) end

--- ############
--- Button Class
--- ############
--- @class Button : Caller
--- Represents a UI Button that can be interacted with.
Button = {}

--- Add Action Listener
--- @param target Callable
--- @return boolean
function Button:AddActionListener(target) 
    target:AddActionListener(self)
end

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
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return nil
function Button:SetBounds(left, top, right, bottom) end

--- Set Text
--- @param text string
--- @return nil
function Button:SetText(text) end

--- Set Fond
--- @param font_name string
--- @param bold boolean
--- @param italic boolean
--- @param underline boolean
--- @param size integer
--- @return nil
function Button:SetFont(font_name, bold, italic, underline, size) end

--- Set Enabled
--- @param enable boolean
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


--- ##########
--- Game Class
--- ##########
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
--- @param x integer
--- @param y integer
--- @return nil
function GAME:MouseButtonAction(isLeft, isDown, x, y) end

--- Mouse Wheel Action
--- @param x integer
--- @param y integer
--- @param distance integer
--- @return nil
function GAME:MouseWheelAction(x, y, distance) end

--- Mouse Move
--- @param x integer
--- @param y integer
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