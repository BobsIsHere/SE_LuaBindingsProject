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

--- Set Window position
--- @param left integer
--- @param top integer
--- @return nil
function GAME_ENGINE:SetWindowPosition(left, top) end

--- Set Window Region
--- @param region HitRegion
--- @return boolean
function GAME_ENGINE:SetWindowRegion(region) end

--- Set Key Listener
--- @param key_list string
--- @return nil
function GAME_ENGINE:SetKeyList(key_list) end

--- Sets Window Frame Rate
--- @param frameRate integer
--- @return nil
function GAME_ENGINE:SetFrameRate(frameRate) end

--- Sets Window Width
--- @param width integer
--- @return nil
function GAME_ENGINE:SetWidth(width) end

--- Sets Window Height
--- @param height integer
--- @return nil
function GAME_ENGINE:SetHeight(height) end

--- Sets Window Full Screen
--- @return boolean
function GAME_ENGINE:GoFullscreen() end

--- Sets Window Windowed Mode
--- @return boolean
function GAME_ENGINE:GoWindowedMode() end

--- Shows Mouse Pointer
--- @param value boolean
--- @return nil
function GAME_ENGINE:ShowMousePointer(value) end

--- Quit Game
--- @return nil
function GAME_ENGINE:Quit() end

--- Checks Window Region
--- @return boolean
function GAME_ENGINE:HasWindowRegion() end

--- Return if Window is Full Screen
--- @return boolean
function GAME_ENGINE:IsFullscreen() end

--- Check What Key is Pressed
--- @param key integer
--- @return boolean
function GAME_ENGINE:IsKeyDown(key) end

--- Show Message Box
--- @param message string
--- @return nil
function GAME_ENGINE:MessageBox(message) end

--- Show Message Continue Box
--- @param message string
--- @return boolean
function GAME_ENGINE:MessageContinue(message) end

--- Text Dimentions


--- Draw Functions

--- Sets Color
--- @param color DWORD
--- @return nil
function GAME_ENGINE:SetColor(color) end

--- Fill Window Rectangle
--- @param color DWORD
--- @return boolean
function GAME_ENGINE:FillWindowRect(color) end

--- Draws Line
--- @param x1 integer
--- @param y1 integer
--- @param x2 integer
--- @param y2 integer
--- @return boolean
function GAME_ENGINE:DrawLine(x1, y1, x2, y2) end

--- Draw Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:DrawRect(left, top, right, bottom) end

--- Draws Filled Rectangle
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

--- Draws Round Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param radius integer
--- @return boolean
function GAME_ENGINE:DrawRoundRect(left, top, right, bottom, radius) end

--- Draws Filled Round Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param radius integer
--- @return boolean
function GAME_ENGINE:FillRoundRect(left, top, right, bottom, radius) end

--- Draws Oval
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:DrawOval(left, top, right, bottom) end

--- Draws Filled Oval
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

--- Draws Arc
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param start_degree integer
--- @param angle integer
--- @return boolean
function GAME_ENGINE:DrawArc(left, top, right, bottom, start_degree, angle) end

--- Draws Filled Arc
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param start_degree integer
--- @param angle integer
--- @return boolean
function GAME_ENGINE:FillArc(left, top, right, bottom, start_degree, angle) end

--- Draws String
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

--- Draws Bitmap
--- @param bit_map Bitmap
--- @param left integer
--- @param top integer
function GAME_ENGINE:DrawBitmap(bit_map, left, top) end

--- Gets Draw Color
--- @return DWORD
function GAME_ENGINE:GetDrawColor() end

--- Repaint
--- @return boolean
function GAME_ENGINE:Repaint() end

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
--- Button Class
--- -------------------------------------
--- @class Button
Button = {}

--- Constructor
--- @param label string
--- @return Button
function Button.new(label) end

--- @return Button
function Button.new() end

--- Set Button Bounds
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return nil
function Button:SetBounds(left, top, right, bottom) end

--- Set Button text
--- @param text string
--- @return nil
function Button:SetText(text) end

--- Set Button Font
--- @param font_name string
--- @param bold boolean
--- @param italic boolean
--- @param underline boolean
--- @param size integer
--- @return nil
function Button:SetFont(font_name, bold, italic, underline, size) end

--- Set Button Enabled
--- @param enable boolean
--- @return nil
function Button:SetEnabled(enable) end

--- Show Button
--- @return nil
function Button:Show() end

--- Hide Button
--- @return nil
function Button:Hide() end

--- Add Action Listener
--- @param callable Callable
--- @return boolean
function Button:AddActionListener(callable) end


--- -------------------------------------
--- Audio Class
--- -------------------------------------
--- @class Audio
Audio = {}

--- Constructor
--- @param file_name string
--- @return Audio
function Audio.new(file_name) end

--- Tick Function
--- @return nil
function Audio:Tick() end

--- Play Functions
--- @param msecStart integer
--- @param msecStop integer
--- @return nil
function Audio:Play(msecStart, msecStop) end

--- Pause Function
--- @return nil
function Audio:Pause() end

--- Stop Function
--- @return nil
function Audio:Stop() end

--- Set Volume
--- @param volume integer
--- @return nil
function Audio:SetVolume(volume) end

--- Set Repeat
--- @param set_repeat boolean
--- @return nil
function Audio:SetRepeat(set_repeat) end


--- -------------------------------------
--- Bitmap Class
--- -------------------------------------
--- @class Bitmap
Bitmap = {}

--- Constructor
--- @param file_name string
--- @param create_alpha_channel boolean
--- @return Bitmap
function Bitmap.new(file_name, create_alpha_channel) end

--- Get Bitmap Width
--- @return integer
function Bitmap:GetWidth() end

--- Get Bitmap Height
--- @return integer
function Bitmap:GetHeight() end


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