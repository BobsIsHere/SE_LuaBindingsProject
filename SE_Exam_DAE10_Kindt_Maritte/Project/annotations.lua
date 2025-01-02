---@meta

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

--- @class GAME
GAME = {}

--- Initialize the game
--- @param engine GameEngine
--- @return nil
function GAME:Initialize(engine) end

--- Start the game
--- @param engine GameEngine
--- @return nil
function GAME:Start(engine) end

--- Paints the game
--- @param engine GameEngine
--- @return nil
function GAME:Paint(engine) end