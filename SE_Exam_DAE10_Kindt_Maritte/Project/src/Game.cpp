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

	sol::function luaMouseMove = m_Lua["MouseMove"];
	luaMouseMove(x, y); 
}

void Game::CheckKeyboard()
{	
	// Here you can check if a key is pressed down
	// Is executed once per frame 

	sol::function luaCheckKeyboard = m_Lua["CheckKeyboard"];
	luaCheckKeyboard();  
}

void Game::KeyPressed(TCHAR key)
{	
	// DO NOT FORGET to use SetKeyList() !!

	// Insert code that needs to execute when a key is pressed
	// The function is executed when the key is *released*
	// You need to specify the list of keys with the SetKeyList() function

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
	// WIN32 API Bindings
	/*m_Lua.new_usertype<RECT>("RECT",
		sol::constructors<RECT(LONG, LONG, LONG, LONG)>(),
		"left", &RECT::left,
		"top", &RECT::top,
		"right", &RECT::right,
		"bottom", &RECT::bottom
	);

	m_Lua.new_usertype<POINT>("POINT",
		sol::constructors<POINT(LONG, LONG)>(),
		"x", &POINT::x,
		"y", &POINT::y
	);

	m_Lua.new_usertype<SIZE>("SIZE",
		sol::constructors<SIZE(LONG, LONG)>(),
		"cx", &SIZE::cx,
		"cy", &SIZE::cy
	);*/

	// Game Engine Bindings
	m_Lua.new_usertype<GameEngine>("GameEngine",
		// General Member Functions
		"SetTitle", &GameEngine::SetTitle,
		"SetWindowPosition", &GameEngine::SetWindowPosition,
		"SetWindowRegion", &GameEngine::SetWindowRegion,
		"SetKeyList", &GameEngine::SetKeyList,
		"SetFrameRate", &GameEngine::SetFrameRate,
		"SetWidth", &GameEngine::SetWidth,
		"SetHeight", &GameEngine::SetHeight,

		"GoFullscreen", &GameEngine::GoFullscreen,
		"GoWindowedMode", &GameEngine::GoWindowedMode,
		"ShowMousePointer", &GameEngine::ShowMousePointer,
		"Quit", &GameEngine::Quit,

		"HasWindowRegion", & GameEngine::HasWindowRegion,
		"IsFullscreen", & GameEngine::IsFullscreen,

		"IsKeyDown", &GameEngine::IsKeyDown,

		"MessageBox", sol::overload(
			static_cast<void(GameEngine::*)(const tstring&) const>(&GameEngine::MessageBox),
			static_cast<void(GameEngine::*)(const TCHAR*) const>(&GameEngine::MessageBox)
		),
		"MessageContinue", & GameEngine::MessageContinue,

		// Text Dimensions
		"CalculateTextDimensions", sol::overload(
			static_cast<SIZE(GameEngine::*)(const tstring&, const Font*) const>(&GameEngine::CalculateTextDimensions),
			static_cast<SIZE(GameEngine::*)(const tstring&, const Font*, RECT) const>(&GameEngine::CalculateTextDimensions)
		),

		// Draw Functions
		"SetColor", &GameEngine::SetColor,

		"FillWindowRect", &GameEngine::FillWindowRect, 

		"DrawLine", & GameEngine::DrawLine,

		"DrawRect", & GameEngine::DrawRect,
		"FillRect", sol::overload(
			static_cast<bool(GameEngine::*)(int, int, int, int) const>(&GameEngine::FillRect),
			static_cast<bool(GameEngine::*)(int, int, int, int, int) const>(&GameEngine::FillRect)
		),
		"DrawRoundRect", & GameEngine::DrawRoundRect,
		"FillRoundRect", & GameEngine::FillRoundRect,
		"DrawOval", & GameEngine::DrawOval,
		"FillOval", sol::overload(
			static_cast<bool(GameEngine::*)(int, int, int, int) const>(&GameEngine::FillOval),
			static_cast<bool(GameEngine::*)(int, int, int, int, int) const>(&GameEngine::FillOval)
		),
		"DrawArc", & GameEngine::DrawArc,
		"FillArc", & GameEngine::FillArc,

		"DrawString", sol::overload(
			static_cast<int(GameEngine::*)(const tstring&, int, int) const>(&GameEngine::DrawString),
			static_cast<int(GameEngine::*)(const tstring&, int, int, int, int) const>(&GameEngine::DrawString)
		),

		"DrawBitmap", sol::overload(
			static_cast<bool(GameEngine::*)(const Bitmap*, int, int) const>(&GameEngine::DrawBitmap),
			static_cast<bool(GameEngine::*)(const Bitmap*, int, int, RECT) const>(&GameEngine::DrawBitmap)
		),

		"GetDrawColor", & GameEngine::GetDrawColor,
		"Repaint", & GameEngine::Repaint,

		// Accessor Member Functions
		"GetWidth", &GameEngine::GetWidth,
		"GetHeight", &GameEngine::GetHeight,
		"GetFrameRate", & GameEngine::GetFrameRate,
		"GetFrameDelay", & GameEngine::GetFrameDelay,

		// Game Engine Variable
		"GAME_ENGINE", sol::readonly_property([]() { return GAME_ENGINE; })
	);

	// Button Engine Bindings
	m_Lua.new_usertype<Button>("Button",
		// Constructors
		sol::constructors<Button(const tstring&), Button()>(),

		// Methods
		"SetBounds", &Button::SetBounds,
		"SetText", &Button::SetText,
		"SetFont", &Button::SetFont,
		"SetEnabled", &Button::SetEnabled,
		"Show", &Button::Show,
		"Hide", &Button::Hide,

		//Callable Functions
		"AddActionListener", &Button::AddActionListener
	);

	// Audio Engine Bindings
	m_Lua.new_usertype<Audio>("Audio",
		//Constructor
		sol::constructors<Audio(const tstring&)>(),

		//Methods
		"Tick", &Audio::Tick,
		"Play", &Audio::Play,
		"Pause", &Audio::Pause,
		"Stop", &Audio::Stop,
		"SetVolume", &Audio::SetVolume,
		"SetRepeat", &Audio::SetRepeat
	);

	// Bitmap Engine Bindings
	m_Lua.new_usertype<Bitmap>("Bitmap",
		//Constructor
		sol::constructors<Bitmap(const tstring&, bool)>(),

		//Methods
		"GetWidth", &Bitmap::GetWidth,
		"GetHeight", &Bitmap::GetHeight
	);

	// HitRegion Enum
	sol::table hitRegionShape{ m_Lua.create_named_table("shape", 
		"ellipse", HitRegion::Shape::Ellipse,
		"rectangle", HitRegion::Shape::Rectangle) 
	};

	// HitRegion Engine Bindings
	m_Lua.new_usertype<HitRegion>("HitRegion",
		//Constructors
		sol::constructors<HitRegion(HitRegion::Shape, int, int, int, int),
						  HitRegion(const POINT*, int),
						  HitRegion(const Bitmap*, COLORREF, COLORREF)>(),

		//Methods
		"Move", & HitRegion::Move,
		"HitTest", sol::overload(
			static_cast<bool(HitRegion::*)(int, int) const>(&HitRegion::HitTest),
			static_cast<bool(HitRegion::*)(const HitRegion*) const>(&HitRegion::HitTest)),
		"CollisionTest", &HitRegion::CollisionTest,
		"GetBounds", &HitRegion::GetBounds,
		"Exist", &HitRegion::Exists,

		// Enum
		"Shape", hitRegionShape
	);

	// Font Engine Bindings
	m_Lua.new_usertype<Font>("Font",
		//Constructor
		sol::constructors<Font(const tstring&, bool, bool, bool, int)>()
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