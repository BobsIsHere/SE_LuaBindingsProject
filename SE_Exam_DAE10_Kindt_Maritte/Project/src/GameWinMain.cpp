//-----------------------------------------------------------------
// Game Engine WinMain Function
// C++ Source - GameWinMain.cpp - version v8_01
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// Include Files
//-----------------------------------------------------------------
#include "GameWinMain.h"
#include "GameEngine.h"

#include "Game.h"	

//-----------------------------------------------------------------
// Lua Test Function
//-----------------------------------------------------------------
int cpp_function(int a, int b)
{
	return a + b;
}

//-----------------------------------------------------------------
// Create GAME_ENGINE global (singleton) object and pointer
//-----------------------------------------------------------------
GameEngine myGameEngine;
GameEngine* GAME_ENGINE{ &myGameEngine };

//-----------------------------------------------------------------
// Main Function
//-----------------------------------------------------------------
int APIENTRY wWinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPWSTR lpCmdLine, _In_ int nCmdShow)
{
	sol::state lua; 

	lua.open_libraries(sol::lib::base);

	// Loads all libraries at once
	//lua.open_libraries(lua.lua_state());

	//Bind the function to Lua
	lua.set_function("cpp_function", cpp_function);

	//Bind a C++ variable 
	int cpp_variable{ 10 }; 
	lua["cpp_variable"] = cpp_variable; 

	//Load & execute the ext. Lua Script
	if (std::ifstream("game_breakout.lua"))
	{
		lua.script_file("game_breakout.lua");
	}
	else
	{
		std::cerr << "Lua script not found!" << std::endl;
	}

	//Retrieve value set by Lua script
	int value_from_lua{ lua["lua_variable"] };  
	std::cout << "Value from Lua: " << value_from_lua << std::endl;  
	
	GAME_ENGINE->SetGame(new Game());			// any class that implements AbstractGame

	return GAME_ENGINE->Run(hInstance, nCmdShow);		// here we go
}