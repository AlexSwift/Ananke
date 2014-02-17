#ifndef GL_NETADR_T
#define GL_NETADR_T

#include "main.h"

EXT_META_ID( netadr_t, 8 );

EXT_META_FUNCTION( netadr_t, IsLocalhost );
EXT_META_FUNCTION( netadr_t, IsLoopback );
EXT_META_FUNCTION( netadr_t, IsReservedAdr );
EXT_META_FUNCTION( netadr_t, IsValid );

EXT_META_FUNCTION( netadr_t, GetIP );
EXT_META_FUNCTION( netadr_t, GetPort );
EXT_META_FUNCTION( netadr_t, GetType );

EXT_META_FUNCTION( netadr_t, ToString );

#endif // GL_NETADR_T