//-----------------------------------------------------------------
// Main Game File
// C++ Source - Game.cpp - version v8_01
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// Include Files
//-----------------------------------------------------------------
#include <algorithm>
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

	std::string luaScriptPath{};
	std::string commandLine{ GetCommandLineA() };

	commandLine.erase(std::remove(commandLine.begin(), commandLine.end(), ' '), commandLine.end());

	if (commandLine.find(".lua") != std::string::npos)
	{
		// Extact file path if present
		luaScriptPath = commandLine.substr(commandLine.find_last_of('\"') + 1);
	}

	if (!luaScriptPath.empty())
	{
		try
		{
			//Load & execute the ext. Lua Script
			m_Lua.script_file(luaScriptPath);
		}
		catch (const std::exception&)
		{
			std::cerr << "Error loading Lua file" << std::endl;
			return;
		}
	}
	else
	{
		std::cerr << "No Lua file provided" << std::endl;
	}

	// Bind GameEngine classes
	BindGameEngineClasses();

	// Bind Game class
	BindGameFunctions(); 

	m_Lua["GAME"] = this; 

	sol::function luaInitialize = m_Lua["initialize"];
	luaInitialize();
}

void Game::Start()
{
	sol::function luaStart = m_Lua["start"];
	luaStart(); 
}

void Game::End()
{
	sol::function luaEnd = m_Lua["end"];
	luaEnd();
}

void Game::Paint(RECT rect) const
{
	sol::function luaPaint = m_Lua["paint"];
	luaPaint(); 
}

void Game::Tick()
{
	sol::function luaTick = m_Lua["tick"];
	luaTick(); 
}

void Game::MouseButtonAction(bool isLeft, bool isDown, int x, int y, WPARAM wParam)
{	
	// Insert code for a mouse button action

	sol::function luaMouseButtonAction = m_Lua["moues_button_action"];
	luaMouseButtonAction(isLeft, isDown, x, y);
}

void Game::MouseWheelAction(int x, int y, int distance, WPARAM wParam)
{	
	sol::function luaMouseWheelAction = m_Lua["mouse_wheel_action"];
	luaMouseWheelAction(x, y, distance);
}

void Game::MouseMove(int x, int y, WPARAM wParam)
{	
	// Insert code that needs to execute when the mouse pointer moves across the game window

	sol::function luaMouseMove = m_Lua["mouse_move"];
	luaMouseMove(x, y); 
}

void Game::CheckKeyboard()
{	
	// Here you can check if a key is pressed down
	// Is executed once per frame 

	sol::function luaCheckKeyboard = m_Lua["check_keyboard"];
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

	sol::function luaKeyPressed = m_Lua["key_pressed"];
	luaKeyPressed(keyStr);
}

void Game::CallAction(Caller* callerPtr)
{
	// Insert the code that needs to execute when a Caller (= Button, TextBox, Timer, Audio) executes an action
	sol::function luaCallAction = m_Lua["call_action"];
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
		"set_title", &GameEngine::SetTitle,
		"set_window_position", &GameEngine::SetWindowPosition,
		"set_window_region", &GameEngine::SetWindowRegion,
		"set_key_list", &GameEngine::SetKeyList,
		"set_frame_rate", &GameEngine::SetFrameRate,
		"set_width", &GameEngine::SetWidth,
		"set_height", &GameEngine::SetHeight,

		"go_fullscreen", &GameEngine::GoFullscreen,
		"go_windowed_mode", &GameEngine::GoWindowedMode,
		"show_mouse_pointer", &GameEngine::ShowMousePointer,
		"quit", &GameEngine::Quit,

		"has_window_region", & GameEngine::HasWindowRegion,
		"is_fullscreen", & GameEngine::IsFullscreen,

		"is_key_down", &GameEngine::IsKeyDown,

		"message_box", sol::overload(
			static_cast<void(GameEngine::*)(const tstring&) const>(&GameEngine::MessageBox),
			static_cast<void(GameEngine::*)(const TCHAR*) const>(&GameEngine::MessageBox)
		),
		"message_continue", & GameEngine::MessageContinue,

		// Text Dimensions
		"calculate_text_dimensions", sol::overload(
			static_cast<SIZE(GameEngine::*)(const tstring&, const Font*) const>(&GameEngine::CalculateTextDimensions),
			static_cast<SIZE(GameEngine::*)(const tstring&, const Font*, RECT) const>(&GameEngine::CalculateTextDimensions)
		),

		// Draw Functions
		"set_color", &GameEngine::SetColor,

		"fill_window_rect", &GameEngine::FillWindowRect, 

		"draw_line", & GameEngine::DrawLine,

		"draw_rect", & GameEngine::DrawRect,
		"fill_rect", sol::overload(
			static_cast<bool(GameEngine::*)(int, int, int, int) const>(&GameEngine::FillRect),
			static_cast<bool(GameEngine::*)(int, int, int, int, int) const>(&GameEngine::FillRect)
		),
		"draw_round_rect", & GameEngine::DrawRoundRect,
		"fill_round_rect", & GameEngine::FillRoundRect,
		"draw_oval", & GameEngine::DrawOval,
		"fill_oval", sol::overload(
			static_cast<bool(GameEngine::*)(int, int, int, int) const>(&GameEngine::FillOval),
			static_cast<bool(GameEngine::*)(int, int, int, int, int) const>(&GameEngine::FillOval)
		),
		"draw_arc", & GameEngine::DrawArc,
		"fill_arc", & GameEngine::FillArc,

		"draw_string", sol::overload(
			static_cast<int(GameEngine::*)(const tstring&, int, int) const>(&GameEngine::DrawString),
			static_cast<int(GameEngine::*)(const tstring&, int, int, int, int) const>(&GameEngine::DrawString)
		),

		"draw_bitmap", sol::overload(
			static_cast<bool(GameEngine::*)(const Bitmap*, int, int) const>(&GameEngine::DrawBitmap),
			static_cast<bool(GameEngine::*)(const Bitmap*, int, int, RECT) const>(&GameEngine::DrawBitmap)
		),

		"get_draw_color", & GameEngine::GetDrawColor,
		"repaint", & GameEngine::Repaint,

		// Accessor Member Functions
		"get_width", &GameEngine::GetWidth,
		"get_height", &GameEngine::GetHeight,
		"get_frame_rate", & GameEngine::GetFrameRate,
		"get_frame_delay", & GameEngine::GetFrameDelay,

		// Game Engine Variable
		"GAME_ENGINE", sol::readonly_property([]() { return GAME_ENGINE; })
	);

	// Button Engine Bindings
	m_Lua.new_usertype<Button>("Button",
		// Constructors
		sol::constructors<Button(const tstring&), Button()>(),

		// Methods
		"set_bounds", &Button::SetBounds,
		"set_text", &Button::SetText,
		"set_font", &Button::SetFont,
		"set_enabled", &Button::SetEnabled,
		"show", &Button::Show,
		"hide", &Button::Hide,

		//Callable Functions
		"add_action_listener", &Button::AddActionListener
	);

	// Audio Engine Bindings
	m_Lua.new_usertype<Audio>("Audio",
		//Constructor
		sol::constructors<Audio(const tstring&)>(),

		//Methods
		"tick", &Audio::Tick,
		"play", &Audio::Play,
		"pause", &Audio::Pause,
		"stop", &Audio::Stop,
		"set_volume", &Audio::SetVolume,
		"set_repeat", &Audio::SetRepeat
	);

	// Bitmap Engine Bindings
	m_Lua.new_usertype<Bitmap>("Bitmap",
		//Constructor
		sol::constructors<Bitmap(const tstring&, bool)>(),

		//Methods
		"get_width", &Bitmap::GetWidth,
		"get_height", &Bitmap::GetHeight
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
		"move", & HitRegion::Move,
		"hit_test", sol::overload(
			static_cast<bool(HitRegion::*)(int, int) const>(&HitRegion::HitTest),
			static_cast<bool(HitRegion::*)(const HitRegion*) const>(&HitRegion::HitTest)),
		"collision_test", &HitRegion::CollisionTest,
		"get_bounds", &HitRegion::GetBounds,
		"exist", &HitRegion::Exists,

		// Enum
		"shape", hitRegionShape
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
		"initialize", &Game::Initialize,
		"start", &Game::Start,
		"game_end", &Game::End,
		"paint", &Game::Paint,
		"tick", &Game::Tick,
		"mouse_button_action", &Game::MouseButtonAction,
		"mouse_wheel_action", &Game::MouseWheelAction,
		"mouse_move", &Game::MouseMove,
		"check_keyboard", &Game::CheckKeyboard,
		"key_pressed", &Game::KeyPressed,
		"call_action", &Game::CallAction
	);
}