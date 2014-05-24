#include "Lua/Interface.h"

#define LUA_FUNCITON( function ) int _function_( lua_State *state )

#define StartTable( ) \
	LUA->PushSpecial(GarrysMod::Lua::SPECIAL_GLOB); \
	LUA->CreateTable()

#define EndTable( name ) \
	LUA->SetField(-2, name ); \
	LUA->Pop();

#define PushFunctionToTable( funcName, func ) \
	LUA->PushCFunction( func ); \
	LUA->SetField(-2, funcName );

#define DebugPrint( reg, value ) \
	LUA->PushSpecial( GarrysMod::Lua::SPECIAL_GLOB ); \
	LUA->GetField( -1, "print" ); \
	LUA->PushString( reg ); \
	LUA->PushNumber( value ); \
	LUA->Call( 2, 0 ); \
	LUA->Pop();
	
