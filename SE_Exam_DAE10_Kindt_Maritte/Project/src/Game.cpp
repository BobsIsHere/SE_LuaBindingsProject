//-----------------------------------------------------------------
// Main Game File
// C++ Source - Game.cpp - version v8_01
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// Include Files
//-----------------------------------------------------------------
#include "Game.h"

//-----------------------------------------------------------------
// Game Member Functions																				
//-----------------------------------------------------------------

Game::Game() 																	
{
	// nothing to create
}

Game::~Game()																						
{
	// nothing to destroy
}

void Game::Initialize()			
{
	AbstractGame::Initialize();

	// Loads all libraries at once
	m_Lua.open_libraries(sol::lib::base);

	//Load & execute the ext. Lua Script
	m_Lua.script_file("game_breakout.lua");

	// Bind GameEngine classes
	BindGameEngineClasses();

	// Bind Game class
	BindGameFunctions(); 

	m_Lua["GAME"] = this; 

	sol::function luaInitialize = m_Lua["Initialize"];
	luaInitialize();
}

void Game::Start()
{
	sol::function luaStart = m_Lua["Start"];
	luaStart();
}

void Game::End()
{
	sol::function luaEnd = m_Lua["End"];
	luaEnd();
}

void Game::Paint(RECT rect) const
{
	// Add To Lua Bindings
	GAME_ENGINE->FillWindowRect(0x000000);

	sol::function luaPaint = m_Lua["Paint"];
	luaPaint(); 
}

void Game::Tick()
{
	sol::function luaTick = m_Lua["Tick"];
	luaTick(); 
}

void Game::MouseButtonAction(bool isLeft, bool isDown, int x, int y, WPARAM wParam)
{	
	// Insert code for a mouse button action

	/* Example:
	if (isLeft == true && isDown == true) // is it a left mouse click?
	{
		if ( x > 261 && x < 261 + 117 ) // check if click lies within x coordinates of choice
		{
			if ( y > 182 && y < 182 + 33 ) // check if click also lies within y coordinates of choice
			{
				GAME_ENGINE->MessageBox(_T("Clicked."));
			}
		}
	}
	*/

	sol::function luaMouseButtonAction = m_Lua["MouseButtonAction"];
	luaMouseButtonAction(isLeft, isDown, x, y);
}

void Game::MouseWheelAction(int x, int y, int distance, WPARAM wParam)
{	
	sol::function luaMouseWheelAction = m_Lua["MouseWheelAction"];
	luaMouseWheelAction(x, y, distance);
}

void Game::MouseMove(int x, int y, WPARAM wParam)
{	
	// Insert code that needs to execute when the mouse pointer moves across the game window

	/* Example:
	if ( x > 261 && x < 261 + 117 ) // check if mouse position is within x coordinates of choice
	{
		if ( y > 182 && y < 182 + 33 ) // check if mouse position also is within y coordinates of choice
		{
			GAME_ENGINE->MessageBox("Mouse move.");
		}
	}
	*/

	sol::function luaMouseMove = m_Lua["MouseMove"];
	luaMouseMove(x, y); 
}

void Game::CheckKeyboard()
{	
	// Here you can check if a key is pressed down
	// Is executed once per frame 

	/* Example:
	if (GAME_ENGINE->IsKeyDown(_T('K'))) xIcon -= xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('L'))) yIcon += xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('M'))) xIcon += xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('O'))) yIcon -= ySpeed;
	*/

	sol::function luaCheckKeyboard = m_Lua["CheckKeyboard"];
	luaCheckKeyboard();  
}

void Game::KeyPressed(TCHAR key)
{	
	// DO NOT FORGET to use SetKeyList() !!

	// Insert code that needs to execute when a key is pressed
	// The function is executed when the key is *released*
	// You need to specify the list of keys with the SetKeyList() function

	/* Example:
	switch (key)
	{
	case _T('K'): case VK_LEFT:
		GAME_ENGINE->MessageBox("Moving left.");
		break;
	case _T('L'): case VK_DOWN:
		GAME_ENGINE->MessageBox("Moving down.");
		break;
	case _T('M'): case VK_RIGHT:
		GAME_ENGINE->MessageBox("Moving right.");
		break;
	case _T('O'): case VK_UP:
		GAME_ENGINE->MessageBox("Moving up.");
		break;
	case VK_ESCAPE:
		GAME_ENGINE->MessageBox("Escape menu.");
	}
	*/

	std::string keyStr{};

	// Single character + null terminator
	char buffer[2];
	// Convert wchar_t to char
	wcstombs(buffer, &key, 1);
	// Create string from character
	keyStr = std::string(buffer, 1);

	sol::function luaKeyPressed = m_Lua["KeyPressed"];
	luaKeyPressed(keyStr);
}

void Game::CallAction(Caller* callerPtr)
{
	// Insert the code that needs to execute when a Caller (= Button, TextBox, Timer, Audio) executes an action
	sol::function luaCallAction = m_Lua["CallAction"];
	luaCallAction(callerPtr);
}

void Game::BindGameEngineClasses()
{
	m_Lua.new_usertype<GameEngine>("GameEngine",
		// Methods
		"SetTitle", &GameEngine::SetTitle,
		"SetWidth", &GameEngine::SetWidth,
		"SetHeight", &GameEngine::SetHeight,
		"SetFrameRate", &GameEngine::SetFrameRate,
		"IsKeyDown", &GameEngine::IsKeyDown,
		"SetColor", &GameEngine::SetColor,
		"FillRect", sol::overload(
			static_cast<bool(GameEngine::*)(int, int, int, int) const>(&GameEngine::FillRect),
			static_cast<bool(GameEngine::*)(int, int, int, int, int) const>(&GameEngine::FillRect)
		),
		"GAME_ENGINE", sol::readonly_property([]() {return GAME_ENGINE; }),

		//Read-Only properties
		"GetWidth", &GameEngine::GetWidth
	);

	m_Lua.new_usertype<Callable>("Callable",
		"CallAction", &Callable::CallAction
	);

	m_Lua.new_usertype<Caller>("Caller",
		// Methods
		"AddActionListener", &Caller::AddActionListener,
		"RemoveActionListener", &Caller::RemoveActionListener
	);

	m_Lua.new_usertype<Button>("Button",
		// Constructors
		sol::constructors<Button(const tstring&), Button()>(),
		// specify inheritance
		sol::base_classes, sol::bases<Caller>(),

		// Methods
		"SetBounds", &Button::SetBounds, 
		"SetText", [this](Button& btn, const std::string& text) 
		{
			// Convert to tstring
			btn.SetText(ToTString(text));
		},
		"SetFont", [this](Button& btn, const std::string& fontName, bool bold, bool italic, bool underline, int size) 
		{
			// Convert to tstring
			btn.SetFont(ToTString(fontName), bold, italic, underline, size);
		},
		"SetEnabled", &Button::SetEnabled,
		"Show", &Button::Show,
		"Hide", &Button::Hide,

		// Read-Only properties
		"GetBounds", sol::readonly_property(&Button::GetBounds),
		"GetText", sol::readonly_property([this](Button& btn) -> std::string
		{
			// Convert to std::string
			tstring text = btn.GetText();
			return ToStdString(text);  
		}),
		"GetType", sol::readonly_property(&Button::GetType)
	);

	m_Lua["GAME_ENGINE"] = GAME_ENGINE;
}

void Game::BindGameFunctions()
{
	m_Lua.new_usertype<Game>("Game",
		"Initialize", &Game::Initialize,
		"Start", &Game::Start,
		"End", &Game::End,
		"Paint", &Game::Paint,
		"Tick", &Game::Tick,
		"MouseButtonAction", &Game::MouseButtonAction,
		"MouseWheelAction", &Game::MouseWheelAction,
		"MouseMove", &Game::MouseMove,
		"CheckKeyboard", &Game::CheckKeyboard,
		"KeyPressed", &Game::KeyPressed,
		"CallAction", &Game::CallAction
	);
}

tstring Game::ToTString(const std::string& string)
{
	return tstring(string.begin(), string.end());
}

std::string Game::ToStdString(const tstring& string)
{
	return std::string(string.begin(), string.end());
}