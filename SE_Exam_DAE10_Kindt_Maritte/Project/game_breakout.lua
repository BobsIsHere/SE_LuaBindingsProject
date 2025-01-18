--- Variables
local Player = {}
Player.__index = Player

local Ball = {}
Ball.__index = Ball

--- -------------------------------------
--- Player Class
--- -------------------------------------

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
    GAME_ENGINE:SetColor(tonumber("10085C", 16)) 
    GAME_ENGINE:FillRect(self.x, self.y, self.x + self.width, self.y + self.height)
end

--- -------------------------------------
--- Ball Class
--- -------------------------------------

--- Ball Constructor
--- @param x integer
--- @param y number
--- @param radius integer
--- @param speedX integer
--- @param speedY integer
function Ball:new(x,y,radius,speedX,speedY)
	local self = setmetatable({}, Ball)
	self.x = x
	self.y = y
	self.radius = radius
	self.speedX = speedX
	self.speedY = speedY

	return self
end

--- Move Ball in Window
function Ball:Move()
	self.x = self.x + self.speedX
	self.y = self.y + self.speedY
end

--- Draw Ball
function Ball:Draw()
	GAME_ENGINE:SetColor(tonumber("FFFFFF", 16))
	GAME_ENGINE:FillRect(self.x, self.y, self.x +  self.radius, self.y +  self.radius)
end

--- Check Window collision
function Ball:CheckWindowCollision()
	-- Ball collision with left & right
	if self.x - self.radius < 0 then
		self.speedX = -self.speedX
	elseif self.x + self.radius > GAME_ENGINE:GetWidth() then
		self.speedX = -self.speedX
	end

	-- Ball collisions with top & bottom
	if self.y - self.radius < 0 then
		self.speedY = -self.speedY
	elseif self.y + self.radius > GAME_ENGINE:GetHeight() then
		self.speedY = -self.speedY
	end
end

--- Check player Collision
--- @param player Player
function Ball:CheckPlayerCollision(player)
	if self.x + self.radius > player.x and self.x - self.radius < player.x + player.width then
		if self.y + self.radius > player.y and self.y - self.radius < player.y + player.height then
			self.speedY = -self.speedY
		end
	end
end

--- -------------------------------------
--- Game Class
--- -------------------------------------

--- Initialize Variables
local player = Player:new(350, 550, 100, 20)
local ball = Ball:new(400, 300, 10, 4, -4)

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
	ball:Draw()
end

function Tick()
	ball:Move()

	ball:CheckWindowCollision()
	ball:CheckPlayerCollision(player)
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