cmake_minimum_required(VERSION 3.20)
project(SELua)

#C++ 17 required (filesystem)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)

# Fetch LUA
FetchContent_Declare(
    lua
    URL https://github.com/marovira/lua/archive/refs/tags/5.4.4.tar.gz
)
FetchContent_MakeAvailable(lua)


# Fetch SOL2
FetchContent_Declare(
    sol2
    URL https://github.com/ThePhD/sol2/archive/refs/tags/v3.3.0.tar.gz
)
FetchContent_MakeAvailable(sol2)

# Gather sources
list(APPEND SOURCES 
            "src/Game.cpp"
            "src/GameEngine.cpp"
            "src/AbstractGame.cpp"
            "src/GameWinMain.cpp"
)

list(APPEND LUA_SOURCES 
            "game_breakout.lua"
)

# Executable target
set(EXE_NAME SELua)
add_executable(${EXE_NAME} ${SOURCES} ${LUA_SOURCES})
target_link_libraries(${EXE_NAME} PRIVATE lua::lua sol2)
target_include_directories(${EXE_NAME} PRIVATE src)

# Define Unicode preprocessor definitions
target_compile_definitions(${EXE_NAME} PRIVATE _UNICODE UNICODE)

# Set entry point to wWinMainCRTStartup
if (WIN32)
    set_target_properties(${EXE_NAME} PROPERTIES LINK_FLAGS "/ENTRY:wWinMainCRTStartup")
endif()

# Copy Lua scripts
add_custom_target(CopyScripts ALL
    COMMENT "Copying Lua scripts to output directory"
)

FOREACH(LUA_SOURCE IN LISTS LUA_SOURCES)
    add_custom_command(TARGET CopyScripts POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        ${CMAKE_CURRENT_SOURCE_DIR}/${LUA_SOURCE}
        $<TARGET_FILE_DIR:${EXE_NAME}>/${LUA_SOURCE})
ENDFOREACH()

add_dependencies(CopyScripts ${EXE_NAME})