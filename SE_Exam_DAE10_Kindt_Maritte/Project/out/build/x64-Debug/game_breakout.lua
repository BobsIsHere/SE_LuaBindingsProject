--- Setting game engine properties
function Start()
	GAME_ENGINE:SetTitle("Breakout Lua")
	GAME_ENGINE:SetWidth(800)
	GAME_ENGINE:SetHeight(600)
	GAME_ENGINE:SetFrameRate(60)
end

function Paint()
	--- Setting the color of rectangle
	GAME_ENGINE:SetColor(255, 0, 0, 255)

	--- Draw a rectangle
	local left = 50
	local top = 50
	local right = 200
	local bottom = 200
	GAME_ENGINE:FillRect(left, top, right, bottom)
end