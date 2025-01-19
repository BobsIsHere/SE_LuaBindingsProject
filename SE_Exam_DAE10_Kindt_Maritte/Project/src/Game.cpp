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
	m_Lua.open_libraries(sol::lib::math);
	m_Lua.open_libraries(sol::lib::table);

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
		// General Member Functions
		"SetTitle", &GameEngine::SetTitle,
		"SetWidth", &GameEngine::SetWidth,
		"SetHeight", &GameEngine::SetHeight,
		"SetFrameRate", &GameEngine::SetFrameRate,
		"IsKeyDown", &GameEngine::IsKeyDown,

		// Draw Functions
		"SetColor", &GameEngine::SetColor,
		"FillRect", sol::overload(
			static_cast<bool(GameEngine::*)(int, int, int, int) const>(&GameEngine::FillRect),
			static_cast<bool(GameEngine::*)(int, int, int, int, int) const>(&GameEngine::FillRect)
		),
		"FillOval", sol::overload(
			static_cast<bool(GameEngine::*)(int, int, int, int) const>(&GameEngine::FillOval),
			static_cast<bool(GameEngine::*)(int, int, int, int, int) const>(&GameEngine::FillOval)
		),
		"DrawString", sol::overload(
			static_cast<int(GameEngine::*)(const tstring&, int, int) const>(&GameEngine::DrawString),
			static_cast<int(GameEngine::*)(const tstring&, int, int, int, int) const>(&GameEngine::DrawString)
		),
		"DrawBitmap", sol::overload(
			static_cast<bool(GameEngine::*)(const Bitmap*, int, int) const>(&GameEngine::DrawBitmap),
			static_cast<bool(GameEngine::*)(const Bitmap*, int, int, RECT) const>(&GameEngine::DrawBitmap)
		),

		// Accessor Member Functions
		"GetWidth", &GameEngine::GetWidth,
		"GetHeight", &GameEngine::GetHeight,

		// Game Engine Variable
		"GAME_ENGINE", sol::readonly_property([]() { return GAME_ENGINE; })
	);

	m_Lua.new_usertype<Audio>("Audio",
		//Constructor
		sol::constructors<Audio(const tstring&)>(),

		//Methods
		"Tick", &Audio::Tick,
		"Play", &Audio::Play,
		"Pause", &Audio::Pause,
		"Stop", &Audio::Stop,
		"SetVolume", &Audio::SetVolume,
		"SetRepeat", &Audio::SetRepeat,
		"AddActionListener", &Caller::AddActionListener
	);

	m_Lua["GAME_ENGINE"] = GAME_ENGINE;
	m_Lua["callable_this_ptr"] = static_cast<Callable*>(this); 
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