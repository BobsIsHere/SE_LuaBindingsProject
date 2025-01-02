--- Setting game engine properties
function initialize()
	GAME_ENGINE:SetTitle("Breakout")
	GAME_ENGINE:SetWidth(800)
	GAME_ENGINE:SetHeight(600)
	GAME_ENGINE:SetFrameRate(60)
end

function drawRect()
	--- Setting the color of rectangle
	GAME_ENGINE:SetColor(255, 0, 0, 255)

	--- Draw a rectangle
	local left = 50
	local top = 50
	local right = 200
	local bottom = 200
	GAME_ENGINE:FillRect(left, top, right, bottom)
end