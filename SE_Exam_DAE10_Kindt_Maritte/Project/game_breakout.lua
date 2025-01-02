print("Lua script loaded")

--- Setting game engine properties
function Initialize(engine)
	print("Initialize function called")

	engine:SetTitle("Breakout Lua")
	engine:SetWidth(800)
	engine:SetHeight(600)
	engine:SetFrameRate(60)
end

function Start(engine)
	print("Start function called")
end

function Paint(engine)
	--- Setting the color of rectangle
	engine:SetColor(255, 0, 0, 255)

	--- Draw a rectangle
	local left = 50
	local top = 50
	local right = 200
	local bottom = 200
	engine:FillRect(left, top, right, bottom)
end