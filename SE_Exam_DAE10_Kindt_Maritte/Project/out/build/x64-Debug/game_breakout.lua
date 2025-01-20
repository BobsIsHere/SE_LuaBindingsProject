--- Variables
local Player = {}
Player.__index = Player

local Ball = {}
Ball.__index = Ball

local Block = {}
Block.__index = Block

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
    GAME_ENGINE:SetColor(tonumber("575757", 16)) 
    GAME_ENGINE:FillRect(self.x, self.y, self.x + self.width, self.y + self.height)
end

--- -------------------------------------
--- Ball Class
--- -------------------------------------

--- Ball Constructor
--- @param x integer
--- @param y integer
--- @param radius integer
--- @param speed integer
--- @param directionX integer
--- @param directionY integer
function Ball:new(x,y,radius, speed,directionX,directionY)
	local self = setmetatable({}, Ball)
	self.x = x
	self.y = y
	self.radius = radius
	self.speed = speed
	self.directionX = directionX
	self.directionY = directionY

	return self
end

--- Move Ball in Window
function Ball:Move()
	self.x = self.x + self.directionX * self.speed
	self.y = self.y + self.directionY * self.speed
end

--- Draw Ball
function Ball:Draw()
	GAME_ENGINE:SetColor(tonumber("FFFFFF", 16))
	GAME_ENGINE:FillOval(self.x, self.y, self.x +  self.radius, self.y +  self.radius)
end

--- Check Window collision
function Ball:CheckWindowCollision()
	-- Ball collision with left & right
	if self.x - self.radius < 0 then
		self.directionX = -self.directionX
	elseif self.x + self.radius > GAME_ENGINE:GetWidth() then
		self.directionX = -self.directionX
	end

	-- Ball collisions with top & bottom
	if self.y - self.radius < 0 then

		self.directionY = -self.directionY
	elseif self.y + self.radius > GAME_ENGINE:GetHeight() then

		GAME_ENGINE:MessageBox("Game Over")
		self.directionY = -self.directionY
	end
end

--- Check player Collision
--- @param player Player
function Ball:CheckPlayerCollision(player)
	if self.x + self.radius > player.x and self.x - self.radius < player.x + player.width then
		if self.y + self.radius > player.y and self.y - self.radius < player.y + player.height then

			self.y = player.y - self.radius - 1
			
			-- Calculate relative hit
			local relativeHit = (self.x - (player.x + player.width / 2)) / (player.width / 2)
			-- Calculate angle
			local angle = relativeHit * math.pi 

			self.directionX = math.floor(self.speed * math.cos(angle))
			-- Keep the horizontal direction consistent with the relative hit
			if relativeHit < 0 and self.directionX > 0 then
				self.directionX = -self.directionX
			elseif relativeHit > 0 and self.directionX < 0 then
				self.directionX = -self.directionX
			end

			-- Adjust vertical direction to always bounce upward
			self.directionY = -math.ceil(self.speed * math.abs(math.sin(angle)))
		end
	end
end

--- -------------------------------------
--- Block Class
--- -------------------------------------

--- Block Constructor
--- @param x integer
--- @param y integer
--- @param width integer
--- @param height integer
function Block.new(x,y,width,height)
	local self = setmetatable({}, Block)
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	return self
end

--- Draw Block
function Block:Draw()
	GAME_ENGINE:SetColor(tonumber("BE030C", 16))
	GAME_ENGINE:FillRect(self.x, self.y, self.x + self.width, self.y + self.height)
end

--- Check Collision with Ball
--- @param ball Ball
--- @param player Player
--- @return boolean
function Block:CheckBallCollision(ball)
	-- Check for left & right collision
	if ball.x + ball.radius > self.x and ball.x - ball.radius < self.x + self.width then
		-- Check for top & bottom collision
		if ball.y + ball.radius > self.y and ball.y - ball.radius < self.y + self.height then
			ball.directionY = -ball.directionY
			return true
		end
	end

	return false
end

--- -------------------------------------
--- Game Class
--- -------------------------------------

--- Initialize Variables
local score = 0
local is_menu = true

local play_button = {}

local menu_bit_map = {}

local player = Player:new(280, 550, 100, 20)
local ball = Ball:new(330, 540, 10, 3,1, -1)

local game_audio = {}
local game_over_audio = {}
local hit_audio = {}

local blocks = {}

-- Generate 3 rows of blocks, with 10 blocks
local rows = 6
local cols = 9
local blockWidth = 60
local blockHeight = 20
local blockSpacing = 10
local windowSpacing = 50

for row = 1, rows do
	for col = 1, cols do
		-- Caluclate position of block
		local x = (col - 1) * (blockWidth + blockSpacing)
		local y = (row - 1) * (blockHeight + blockSpacing) + windowSpacing

		-- Create new block & insert in table
		local block = Block.new(x, y, blockWidth, blockHeight)
		table.insert(blocks,block)
	end
end

--- Game Engine Properties
function Initialize()
	GAME_ENGINE:SetTitle("Breakout Lua")
	GAME_ENGINE:SetWidth(620)
	GAME_ENGINE:SetHeight(600)
	GAME_ENGINE:SetFrameRate(60)
end

function Start()
	game_audio = Audio.new("resources/583613__evretro__8-bit-brisk-music-loop.mp3")
	game_over_audio = Audio.new("resources/442127__euphrosyyn__8-bit-game-over.mp3")
	hit_audio = Audio.new("resources/277213__thedweebman__8-bit-hit.mp3")

	play_button = Button.new("Play Game")

	menu_bit_map = Bitmap.new("resources/BreakOutMenu.png", true)

	-- Set up Audio
	game_audio:SetVolume(50)
	game_audio:SetRepeat(true)
	game_audio:Play(0, -1)

	hit_audio:SetVolume(50)
	hit_audio:SetRepeat(false)

	-- Set up Play Button
	play_button:SetBounds(160, 400, 460, 450)
	play_button:AddActionListener(callable_this_ptr)
	play_button:SetFont("Arial", true, false, false, 45)
	play_button:Show()
end

function End()
	
end

function Paint()
	GAME_ENGINE:FillWindowRect(tonumber("000000", 16))

	if is_menu then
		--GAME_ENGINE:SetColor(tonumber("000000", 16))
		GAME_ENGINE:FillRect(0, 0, GAME_ENGINE:GetWidth(), GAME_ENGINE:GetHeight())
		GAME_ENGINE:DrawBitmap(menu_bit_map, 175, 10)
	else
		-- Draw Player
		player:Draw()

		-- Draw Ball
		ball:Draw()

		-- Draw Blocks
		for _, block in ipairs(blocks) do
			block:Draw()
		end

		-- Draw Score
		GAME_ENGINE:SetColor(tonumber("FFFFFF", 16))
		GAME_ENGINE:DrawString("Score: " .. score, 10, 10)
		end
end

function Tick()

	if not is_menu then
		-- Audio Tick
		game_audio:Tick()
		hit_audio:Tick()

		-- Move Functions
		ball:Move()

		-- Collision Functions
		ball:CheckWindowCollision()
		ball:CheckPlayerCollision(player)

		for i = #blocks, 1, -1 do
			local block = blocks[i]

			if block then
				if block:CheckBallCollision(ball) then
					-- Remove the block from the table after collision
					table.remove(blocks, i)
					-- Play sound
					hit_audio:Play(0, -1)
					-- Increase Score
					score = score + 10
				end
			end
		end
	end
end

function MouseButtonAction(isLeft, isDown, x, y)
	
end

function MouseWheelAction(x, y, distance)
	
end

function MouseMove(x, y) 
	
end

function CheckKeyboard()

	if not is_menu then
		if GAME_ENGINE:IsKeyDown(0x41) then
			-- Move Left
			player:ChangeDirection(-1)
		elseif GAME_ENGINE:IsKeyDown(0x44) then
			-- Move Right
			player:ChangeDirection(1)
		end
	end
end

function KeyPressed(key)
	
end

function CallAction(caller)
	is_menu = false
	play_button:Hide()
end