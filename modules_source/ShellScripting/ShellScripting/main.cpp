#ifndef GMMODULE
#define GMMODULE
#endif

#include <windows.h>
#include <stdio.h>
#include "Lua/Interface.h"
#include "main.h"

using GarrysMod::Lua::CFunc;

typedef int *voidFunc( );

voidFunc *Function = NULL;

void PushLFunction( lua_State *state, char *funcName, CFunc func ) 
{
	LUA->PushSpecial( GarrysMod::Lua::SPECIAL_GLOB ); 
	LUA->PushString( funcName ); 
	LUA->PushCFunction( func );
	LUA->SetTable( -3 );
}


int Run( lua_State *state )
{	

	const char *Function = LUA->GetString( 1 );
	void *lpAlloc = NULL;
	lpAlloc = VirtualAlloc( 0, 4096, MEM_COMMIT, PAGE_EXECUTE_READWRITE);

	if(lpAlloc == NULL){
		return 0;
	}

	memcpy(lpAlloc, Function, lstrlenA((LPCSTR)Function) + 1);

	__asm
	{
		MOV EAX, lpAlloc
		CALL EAX
		RET
	}

	return 0;

}


GMOD_MODULE_OPEN()
{
	
	StartTable();
		PushFunctionToTable( "Run", (CFunc )Run );
	EndTable( "ShellScripting" );

	DebugPrint( "Module Loaded", 1 );
	
	return 0;
};

GMOD_MODULE_CLOSE()
{

	return 0;
}
