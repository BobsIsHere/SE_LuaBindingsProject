--- Setting game engine properties
function Initialize()
	GAME_ENGINE:SetTitle("Breakout Lua")
	GAME_ENGINE:SetWidth(800)
	GAME_ENGINE:SetHeight(600)
	GAME_ENGINE:SetFrameRate(60)
end

function Start()
	local myButton = Button:new("Click Me!")

	myButton:SetBounds(100,100,300,150)
	myButton:SetText("Click Me!")
	myButton:SetFont("Arial", false, false, false, 24)
	myButton:SetEnabled(true)
	myButton:AddActionListener(self)
	myButton:Show()
end

function End()
	
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

function Tick()
	
end

function MouseButtonAction(isLeft, isDown, x, y)
	
end

function MouseWheelAction(x, y, distance)
	
end

function MouseMove(x, y) 
	
end

function CheckKeyboard()

end

function KeyPressed(key)
	if key == "W" then
		print("You Moved Mother Fucker")
	end
end

function CallAction(caller)
	print("Call Action called")
end