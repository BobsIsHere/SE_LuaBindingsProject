--- Variables
local Player = {}
Player.__index = Player

--- Player Constructor
--- @param x integer
--- @param y integer
--- @param width integer
--- @param height integer
function Player:new(x, y, width, height)
	local self = setmetatable({}, Player)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	return self
end

--- Player Update
--- direction -1 for left, 1 for right
--- @param direction integer
function Player:ChangeDirection(direction)
    self.x = self.x + direction * 10

    -- Keep Player inside screen
    local SCREEN_WIDTH = GAME_ENGINE:GetWidth()

    if self.x < 0 then
        self.x = 0
    elseif self.x + self.width > SCREEN_WIDTH then
        self.x = SCREEN_WIDTH - self.width
    end
end

--- Player Draw
function Player:Draw()
    GAME_ENGINE:SetColor(tonumber("FFFFFF", 16)) 
    GAME_ENGINE:FillRect(self.x, self.y, self.x + self.width, self.y + self.height)
end

--- Initialize Variables
local player = Player:new(350, 550, 100, 20)

--- Setting game engine properties
function Initialize()
	GAME_ENGINE:SetTitle("Breakout Lua")
	GAME_ENGINE:SetWidth(800)
	GAME_ENGINE:SetHeight(600)
	GAME_ENGINE:SetFrameRate(60)
end

function Start()
	--local myButton = Button:new("Click Me!")

	--myButton:SetBounds(100,100,300,150)
	--myButton:SetText("Click Me!")
	--myButton:SetFont("Arial", false, false, false, 24)
	--myButton:SetEnabled(true)
	--myButton:AddActionListener(self)
	--myButton:Show()
end

function End()
	
end

function Paint()
	player:Draw()
end

function Tick()
	
end

function MouseButtonAction(isLeft, isDown, x, y)
	
end

function MouseWheelAction(x, y, distance)
	
end

function MouseMove(x, y) 
	
end

function CheckKeyboard()

	if GAME_ENGINE:IsKeyDown(0x41) then
		-- Move Left
		player:ChangeDirection(-1)
	elseif GAME_ENGINE:IsKeyDown(0x44) then
		-- Move Right
		player:ChangeDirection(1)
	end
end

function KeyPressed(key)
	
end

function CallAction(caller)
	print("Call Action called")
end