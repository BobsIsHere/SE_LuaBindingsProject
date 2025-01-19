---@meta

--- -------------------------------------
--- Callable Variable
--- -------------------------------------
callable_this_ptr = nil

--- -------------------------------------
--- Game Engine Class
--- -------------------------------------
---@class GameEngine
GAME_ENGINE = {}

--- General Member Functions

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

--- Draw Functions

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

--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param opacity integer
--- @return boolean
function GAME_ENGINE:FillRect(left, top, right, bottom, opacity) end

--- Makes Filled Oval
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:FillOval(left, top, right, bottom) end

--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param opacity integer
--- @return boolean
function GAME_ENGINE:FillOval(left, top, right, bottom, opacity) end

--- Draw String
--- @param text string
--- @param left integer
--- @param top integer
--- @return integer
function GAME_ENGINE:DrawString(text, left, top) end

--- @param text string
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return integer
function GAME_ENGINE:DrawString(text, left, top, right, bottom) end

--- Draw Bitmap


--- Accessor Member Functions

--- Get Screen Width
--- @return integer
function GAME_ENGINE:GetWidth() end

--- Get Screen Height
--- @return integer
function GAME_ENGINE:GetHeight() end

--- Predefined Game Engine
--- @type GameEngine
GAME_ENGINE.GAME_ENGINE = GAME_ENGINE


--- -------------------------------------
--- Audio Class
--- -------------------------------------
--- @class Audio
AUDIO = {}

--- Constructor
--- @param file_name string
--- @return Audio
function AUDIO.new(file_name) end

--- Tick Function
--- @return nil
function AUDIO:Tick() end

--- Play Functions
--- @return nil
function AUDIO:Play() end

--- Pause Function
--- @return nil
function AUDIO:Pause() end

--- Stop Function
--- @return nil
function AUDIO:Stop() end

--- Set Volume
--- @param volume integer
--- @return nil
function AUDIO:SetVolume(volume) end

--- Set Repeat
--- @param set_repeat boolean
--- @return nil
function AUDIO:SetRepeat(set_repeat) end


--- -------------------------------------
--- Game Class
--- -------------------------------------
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