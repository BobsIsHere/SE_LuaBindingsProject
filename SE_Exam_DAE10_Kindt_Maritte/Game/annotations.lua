---@meta

--- -------------------------------------
--- Callable Variable
--- -------------------------------------
callable_this_ptr = nil


--- -------------------------------------
--- WIN32 Variables
--- -------------------------------------
--RECT = {}
--RECT.__index = RECT

--- @param left LONG
--- @param top LONG
--- @param right LONG
--- @param bottom LONG
--- @return RECT
--function RECT.new(left, top, right, bottom)
    --local self = setmetatable({}, RECT)
    --self.left = left or 0
    --self.top = top or 0
    --self.right = right or 0
    --self.bottom = bottom or 0

    --return self
--end

--POINT = {}
--POINT.__index = POINT

--- @param x LONG
--- @param y LONG
--- @return POINT
--function POINT.new(x, y)
    --local self = setmetatable({}, POINT)
    --self.x = x or 0
    --self.y = y or 0

    --return self
--end

--SIZE = {}
--SIZE.__index = SIZE

--- @param c_x LONG
--- @param c_y LONG
--- @return SIZE
--function SIZE.new(c_x, c_y)
    --local self = setmetatable({}, SIZE)
    --self.c_x = c_x or 0
    --self.c_y = c_y or 0

    --return self
--end


--- -------------------------------------
--- Game Engine Class
--- -------------------------------------
---@class GameEngine
GAME_ENGINE = {}

--- General Member Functions

--- Sets Window Title
--- @param title string
--- @return nil
function GAME_ENGINE:set_title(title) end

--- Set Window position
--- @param left integer
--- @param top integer
--- @return nil
function GAME_ENGINE:set_window_position(left, top) end

--- Set Window Region
--- @param region HitRegion
--- @return boolean
function GAME_ENGINE:set_window_region(region) end

--- Set Key Listener
--- @param key_list string
--- @return nil
function GAME_ENGINE:set_key_list(key_list) end

--- Sets Window Frame Rate
--- @param frameRate integer
--- @return nil
function GAME_ENGINE:set_frame_rate(frameRate) end

--- Sets Window Width
--- @param width integer
--- @return nil
function GAME_ENGINE:set_width(width) end

--- Sets Window Height
--- @param height integer
--- @return nil
function GAME_ENGINE:set_height(height) end

--- Sets Window Full Screen
--- @return boolean
function GAME_ENGINE:go_fullscreen() end

--- Sets Window Windowed Mode
--- @return boolean
function GAME_ENGINE:go_windowed_mode() end

--- Shows Mouse Pointer
--- @param value boolean
--- @return nil
function GAME_ENGINE:show_mouse_pointer(value) end

--- Quit Game
--- @return nil
function GAME_ENGINE:quit() end

--- Checks Window Region
--- @return boolean
function GAME_ENGINE:has_window_region() end

--- Return if Window is Full Screen
--- @return boolean
function GAME_ENGINE:is_fullscreen() end

--- Check What Key is Pressed
--- @param key integer
--- @return boolean
function GAME_ENGINE:is_key_down(key) end

--- Show Message Box
--- @param message string
--- @return nil
function GAME_ENGINE:message_box(message) end

--- Show Message Continue Box
--- @param message string
--- @return boolean
function GAME_ENGINE:message_continue(message) end

--- Text Dimentions
--- @param text string
--- @param font Font
--- @return SIZE
function GAME_ENGINE:calculate_text_dimensions(text, font) end

--- @param text string
--- @param font Font
--- @param rect RECT
--- @return SIZE
function GAME_ENGINE:calculate_text_dimensions(text, font, rect) end

--- Draw Functions

--- Sets Color
--- @param color COLORREF
--- @return nil
function GAME_ENGINE:set_color(color) end

--- Fill Window Rectangle
--- @param color COLORREF
--- @return boolean
function GAME_ENGINE:fill_window_rect(color) end

--- Draws Line
--- @param x1 integer
--- @param y1 integer
--- @param x2 integer
--- @param y2 integer
--- @return boolean
function GAME_ENGINE:draw_line(x1, y1, x2, y2) end

--- Draw Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:draw_rect(left, top, right, bottom) end

--- Draws Filled Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:fill_rect(left, top, right, bottom) end

--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param opacity integer
--- @return boolean
function GAME_ENGINE:fill_rect(left, top, right, bottom, opacity) end

--- Draws Round Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param radius integer
--- @return boolean
function GAME_ENGINE:draw_round_rect(left, top, right, bottom, radius) end

--- Draws Filled Round Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param radius integer
--- @return boolean
function GAME_ENGINE:fill_round_rect(left, top, right, bottom, radius) end

--- Draws Oval
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:draw_oval(left, top, right, bottom) end

--- Draws Filled Oval
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:fill_oval(left, top, right, bottom) end

--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param opacity integer
--- @return boolean
function GAME_ENGINE:fill_oval(left, top, right, bottom, opacity) end

--- Draws Arc
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param start_degree integer
--- @param angle integer
--- @return boolean
function GAME_ENGINE:draw_arc(left, top, right, bottom, start_degree, angle) end

--- Draws Filled Arc
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param start_degree integer
--- @param angle integer
--- @return boolean
function GAME_ENGINE:fill_arc(left, top, right, bottom, start_degree, angle) end

--- Draws String
--- @param text string
--- @param left integer
--- @param top integer
--- @return integer
function GAME_ENGINE:draw_string(text, left, top) end

--- @param text string
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return integer
function GAME_ENGINE:draw_string(text, left, top, right, bottom) end

--- Draws Bitmap
--- @param bit_map Bitmap
--- @param left integer
--- @param top integer
function GAME_ENGINE:draw_bitmap(bit_map, left, top) end

--- Gets Draw Color
--- @return DWORD
function GAME_ENGINE:get_draw_color() end

--- Repaint
--- @return boolean
function GAME_ENGINE:repaint() end

--- Accessor Member Functions

--- Get Screen Width
--- @return integer
function GAME_ENGINE:get_width() end

--- Get Screen Height
--- @return integer
function GAME_ENGINE:get_height() end

--- Get Frame Rate
--- @return integer
function GAME_ENGINE:get_frame_rate() end

--- Get Frame Deay
--- @return integer
function GAME_ENGINE:get_frame_delay() end

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
function Button:set_bounds(left, top, right, bottom) end

--- Set Button text
--- @param text string
--- @return nil
function Button:set_text(text) end

--- Set Button Font
--- @param font_name string
--- @param bold boolean
--- @param italic boolean
--- @param underline boolean
--- @param size integer
--- @return nil
function Button:set_font(font_name, bold, italic, underline, size) end

--- Set Button Enabled
--- @param enable boolean
--- @return nil
function Button:set_enabled(enable) end

--- Show Button
--- @return nil
function Button:show() end

--- Hide Button
--- @return nil
function Button:hide() end

--- Add Action Listener
--- @param callable Callable
--- @return boolean
function Button:add_action_listener(callable) end


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
function Audio:tick() end

--- Play Functions
--- @param msecStart integer
--- @param msecStop integer
--- @return nil
function Audio:play(msecStart, msecStop) end

--- Pause Function
--- @return nil
function Audio:pause() end

--- Stop Function
--- @return nil
function Audio:stop() end

--- Set Volume
--- @param volume integer
--- @return nil
function Audio:set_volume(volume) end

--- Set Repeat
--- @param set_repeat boolean
--- @return nil
function Audio:set_repeat(set_repeat) end


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
function Bitmap:get_width() end

--- Get Bitmap Height
--- @return integer
function Bitmap:get_height() end


--- -------------------------------------
--- HitRegion Enum
--- -------------------------------------
--- @enum shape
shape = {
    ellipse = 0,
    rectangle = 1
}

--- -------------------------------------
--- HitRegion Class
--- -------------------------------------
--- @class HitRegion
HitRegion = {}

--- Enum
--- @field shape_enum shape

--- Constructors
--- @param shape shape
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return HitRegion
function HitRegion.new(shape, left, top, right, bottom) end

--- @param point_array POINT
--- @param number_of_points integer
--- @return HitRegion
function HitRegion.new(point_array, number_of_points) end

--- @param bitmap Bitmap
--- @param c_transparent COLORREF
--- @param c_tolerance COLORREF
--- @return HitRegion
function HitRegion.new(bitmap, c_transparent, c_tolerance) end

--- Move Function
--- @param delta_x integer
--- @param delta_y integer
--- @return nil
function HitRegion:move(delta_x, delta_y) end

--- Hit Test Functions
--- @param x integer
--- @param y integer
--- @return boolean
function HitRegion:hit_test(x, y) end

--- @param region HitRegion
--- @return boolean
function HitRegion:hit_test(region) end

--- Collision Test Function
--- @param region HitRegion
--- @return POINT
function HitRegion:collision_test(region) end

--- Get Bounds Function
--- @return RECT
function HitRegion:get_bounds() end

--- Exists Function
--- @return boolean
function HitRegion:exist() end


--- -------------------------------------
--- Font Class
--- -------------------------------------
--- @class Font
Font = {}

--- Constructor
--- @param font_name string
--- @param bold boolean
--- @param italic boolean
--- @param underline boolean
--- @param size integer
--- @return Font
function Font.new(font_name, bold, italic, underline, size) end


--- -------------------------------------
--- Game Class
--- -------------------------------------
--- @class GAME
GAME = {}

--- Initialize
--- @return nil
function GAME:initialize() end

--- Start
--- @return nil
function GAME:start() end
    
--- End
--- @return nil
function GAME:game_end() end

--- Paints
--- @return nil
function GAME:paint() end

--- Tick
--- @return nil
function GAME:tick() end

--- Mouse Button Action
--- @param isLeft boolean
--- @param isDown boolean
--- @param x integer
--- @param y integer
--- @return nil
function GAME:mouse_button_action(isLeft, isDown, x, y) end

--- Mouse Wheel Action
--- @param x integer
--- @param y integer
--- @param distance integer
--- @return nil
function GAME:mouse_wheel_action(x, y, distance) end

--- Mouse Move
--- @param x integer
--- @param y integer
--- @return nil
function GAME:mouse_move(x, y) end

--- Check Keyboard
--- @return nil
function GAME:check_keyboard() end

--- Key Pressed
--- @param key string
--- @return nil
function GAME:key_pressed(key) end

--- Call Action
--- @param caller Caller
--- @return nil
function GAME:call_action(caller) end