--- Variables
local Player = {}
Player.__index = Player

local Ball = {}
Ball.__index = Ball

local Block = {}
Block.__index = Block

local PowerUp = {}
PowerUp.__index = PowerUp

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
function Player:change_direction(direction)
    self.x = self.x + direction * 10

    -- Keep Player inside screen
    local SCREEN_WIDTH = GAME_ENGINE:get_width()

    if self.x < 0 then
        self.x = 0
    elseif self.x + self.width > SCREEN_WIDTH then
        self.x = SCREEN_WIDTH - self.width
    end
end

--- Player Draw
function Player:draw()
    GAME_ENGINE:set_color(tonumber("575757", 16)) 
    GAME_ENGINE:fill_rect(self.x, self.y, self.x + self.width, self.y + self.height)
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
function Ball:move()
	self.x = self.x + self.directionX * self.speed
	self.y = self.y + self.directionY * self.speed
end

--- Draw Ball
function Ball:draw()
	GAME_ENGINE:set_color(tonumber("FFFFFF", 16))
	GAME_ENGINE:fill_oval(self.x, self.y, self.x +  self.radius, self.y +  self.radius)
end

--- Check Window collision
function Ball:check_window_collision()
	-- Ball collision with left & right
	if self.x - self.radius < 0 then
		self.directionX = -self.directionX
	elseif self.x + self.radius > GAME_ENGINE:get_width() then
		self.directionX = -self.directionX
	end

	-- Ball collisions with top & bottom
	if self.y - self.radius < 0 then

		self.directionY = -self.directionY
	elseif self.y + self.radius > GAME_ENGINE:get_height() then
		self.directionY = -self.directionY

		if GAME_ENGINE:message_continue("Game Over") then
			GAME_ENGINE:quit()
		end
	end
end

--- Check player Collision
--- @param player Player
function Ball:check_player_collision(player)
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
function Block:new(x,y,width,height)
	local self = setmetatable({}, Block)
	self.x = x
	self.y = y
	self.width = width
	self.height = height

	return self
end

--- Draw Block
function Block:draw()
	GAME_ENGINE:set_color(self.color)
	GAME_ENGINE:fill_rect(self.x, self.y, self.x + self.width, self.y + self.height)
end

--- Check Collision with Ball
--- @param ball Ball
--- @param player Player
--- @return boolean
function Block:check_ball_collision(ball)

	-- Find the closest point on the rectangle to the ball's center
    local closestX = math.max(self.x, math.min(ball.x, self.x + self.width))
    local closestY = math.max(self.y, math.min(ball.y, self.y + self.height))

    -- Calculate the distance from the ball's center to this closest point
    local dx = ball.x - closestX
    local dy = ball.y - closestY
    local distance = math.sqrt(dx * dx + dy * dy)

    -- Check if the distance is less than or equal to the ball's radius (collision)
    if distance <= ball.radius then
        -- Handle collision: Reverse direction of ball based on which side it hits
        if math.abs(dx) > math.abs(dy) then
            -- Horizontal collision (left or right)
            ball.directionX = -ball.directionX
        else
            -- Vertical collision (top or bottom)
            ball.directionY = -ball.directionY
        end

        return true
    end

    return false

end

--- -------------------------------------
--- PowerUp Class
--- -------------------------------------

--- PowerUp Constructor
--- @param x integer
--- @param y integer
--- @param width integer
--- @param height integer
--- @param type string
--- @return PowerUp
function PowerUp:new(x,y,width,height,type)
	local self = setmetatable({}, PowerUp)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.type = type
	self.is_applied = false

	return self
end

--- Move Function
--- @param speed number
function PowerUp:move(speed)
	self.y = self.y + speed
end

--- Check Collision
--- @param player Player
--- @return boolean
function PowerUp:check_collision(player)
	if self.x < player.x + player.width and self.x + self.width > player.x then
		if self.y < player.y + player.height and self.y + self.height > player.y then
			return true
		end
	end

	return false
end

--- Draw Function
function PowerUp:draw()
	if self.type == "wider_paddle" then
		GAME_ENGINE:set_color(tonumber("00FF00", 16)) -- Green
	elseif self.type == "extra_ball" then
		GAME_ENGINE:set_color(tonumber("FFFF00", 16)) -- Yellow
	end

	GAME_ENGINE:draw_oval(self.x, self.y, self.x + self.width, self.y + self.height)
end

--- -------------------------------------
--- Game Class
--- -------------------------------------

--- Initialize Variables
local score = 0
local is_menu = true

local play_button = {}

local menu_bit_map = {}

local balls = {}

local player = Player:new(280, 550, 100, 20)
local ball = Ball:new(330, 540, 10, 3,1, -1)
table.insert(balls, ball)

local game_audio = {}
local game_over_audio = {}
local hit_audio = {}

local blocks = {}

local power_ups = {}

-- Rainbow Color Variable
local rainbow_colors = {
	"0000FF",
	"007FFF",
	"00FFFF",
	"00FF00",
	"FF0000",
	"FF008B" 
}

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
		local block = Block:new(x, y, blockWidth, blockHeight)

		-- Assign color based on row
		block.color = tonumber(rainbow_colors[row], 16)

		table.insert(blocks,block)
	end
end

--- Game Engine Properties
function initialize()
	GAME_ENGINE:set_title("Breakout Lua")
	GAME_ENGINE:set_width(620)
	GAME_ENGINE:set_height(600)
	GAME_ENGINE:set_frame_rate(60)
end

function start()
	game_audio = Audio.new("resources/583613__evretro__8-bit-brisk-music-loop.mp3")
	game_over_audio = Audio.new("resources/442127__euphrosyyn__8-bit-game-over.mp3")
	hit_audio = Audio.new("resources/277213__thedweebman__8-bit-hit.mp3")

	play_button = Button.new("Play Game")

	menu_bit_map = Bitmap.new("resources/BreakOutMenu.png", true)

	-- Set up Audio
	game_audio:set_volume(50)
	game_audio:set_repeat(true)
	game_audio:play(0, -1)

	hit_audio:set_volume(50)
	hit_audio:set_repeat(false)

	-- Set up Play Button
	play_button:set_bounds(160, 400, 460, 450)
	play_button:add_action_listener(callable_this_ptr)
	play_button:set_font("Arial", true, false, false, 45)
	play_button:show()
end

function game_end()
	
end

function paint()

	GAME_ENGINE:fill_window_rect(tonumber("000000", 16))

	if is_menu then
		GAME_ENGINE:fill_rect(0, 0, GAME_ENGINE:get_width(), GAME_ENGINE:get_height())
		GAME_ENGINE:draw_bitmap(menu_bit_map, 175, 10)
	else
		-- Draw Player
		player:draw()

		-- Draw Ball
		for _, ball in ipairs(balls) do
			ball:draw()
		end

		-- Draw Blocks
		for _, block in ipairs(blocks) do
			block:draw()
		end

		-- Draw Score
		GAME_ENGINE:set_color(tonumber("FFFFFF", 16))
		GAME_ENGINE:draw_string("Score: " .. score, 10, 10)

		-- Draw PowerUp
		for _, power_up in ipairs(power_ups) do
			power_up:draw()
		end
	end

end

function tick()

	if not is_menu then
		-- Audio Tick
		game_audio:tick()
		hit_audio:tick()

		local power_up_types = {"wider_paddle", "extra_ball"}

		for _, ball in ipairs(balls) do
			-- Move Function
			ball:move()

			-- Collision Function
			ball:check_window_collision()
			ball:check_player_collision(player)

			-- Check for each block
			for i = #blocks, 1, -1 do
				local block = blocks[i]

				if block then
					if block:check_ball_collision(ball) then
						-- Remove the block from the table after collision
						table.remove(blocks, i)
						-- Play sound
						hit_audio:play(0, -1)
						-- Increase Score
						score = score + 10

						-- Choose a random type from the power-up types table
						local random_type = power_up_types[math.random(#power_up_types)]

						-- Random change for power-up
						if math.random(1, 100) <= 20 then
							local power_up = PowerUp:new(block.x, block.y, 20, 20, random_type)
							table.insert(power_ups, power_up)
						end
					end
				end
			end

		end

		-- Check for each power-up
		for idx = #power_ups, 1, -1 do
			local power_up = power_ups[idx]
			power_up:move(3)

			if power_up:check_collision(player) then
				if not power_up.is_applied then
					-- Apply the power-up's effect only once
					power_up.is_applied = true

					if power_up.type == "wider_paddle" then
						player.width = player.width + 1
					elseif power_up.type == "extra_ball" then
						local ball = Ball:new(330, 540, 10, 3,1, -1)
						table.insert(balls, ball)
					end
					
					table.remove(power_up, idx) -- Remove collected power-up

				end
				
			elseif power_up.y > GAME_ENGINE:get_height() then
				table.remove(power_up, idx) -- Remove off-screen power-up
			end
		end

	end

end

function mouse_button_action(isLeft, isDown, x, y)
	
end

function mouse_wheel_action(x, y, distance)
	
end

function mouse_move(x, y) 
	
end

function check_keyboard()

	if not is_menu then
		if GAME_ENGINE:is_key_down(0x41) then
			-- Move Left
			player:change_direction(-1)
		elseif GAME_ENGINE:is_key_down(0x44) then
			-- Move Right
			player:change_direction(1)
		end
	end

end

function key_pressed(key)
	
end

function call_action(caller)
	is_menu = false
	play_button:hide()
end