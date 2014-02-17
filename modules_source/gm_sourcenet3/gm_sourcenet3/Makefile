SOURCE_SDK=../../sdk
SRCDS_DIR=../../../Downloads/srcds_gmod_linux/orangebox

PROJECT_DIR=.
OUT_DIR=../Release
OBJ_DIR=./Release

CPP=/usr/bin/g++-4.3
LINK=/usr/bin/gcc-4.3

USER_CFLAGS=-m32
USER_LFLAGS=-m32

OPTFLAGS=-O1 -fomit-frame-pointer -ffast-math -fforce-addr -funroll-loops -fthread-jumps -fcrossjumping -foptimize-sibling-calls -fcse-follow-jumps -fcse-skip-blocks -fgcse -fgcse-lm -fexpensive-optimizations -frerun-cse-after-loop -fcaller-saves -fpeephole2 -fschedule-insns2 -fsched-interblock -fsched-spec -fregmove -fstrict-overflow -fdelete-null-pointer-checks -freorder-blocks -freorder-functions -falign-functions -falign-jumps -falign-loops -falign-labels -ftree-vrp -ftree-pre -finline-functions -funswitch-loops -fgcse-after-reload

LIBFILES= \
  $(SOURCE_SDK)/lib/linux/tier1.a \
  $(SOURCE_SDK)/lib/linux/choreoobjects.a \
  $(SOURCE_SDK)/lib/linux/particles.a \
  $(SOURCE_SDK)/lib/linux/dmxloader.a \
  libtier0.so \
  libvstdlib.so \
  libsteam_api.so
  
SOURCENET3_OBJS = \
	$(OBJ_DIR)/main.o \
	$(OBJ_DIR)/engine/net_chan.o \
	$(OBJ_DIR)/simplescan/csimplescan.o \
	$(OBJ_DIR)/simplescan/sigscan.o \
	$(OBJ_DIR)/sourcemod/memutils.o \
	$(OBJ_DIR)/sourcenet/gl_bitbuf_read.o \
	$(OBJ_DIR)/sourcenet/gl_bitbuf_write.o \
	$(OBJ_DIR)/sourcenet/gl_cnetchan.o \
	$(OBJ_DIR)/sourcenet/gl_datafragments_t.o \
	$(OBJ_DIR)/sourcenet/gl_filehandle_t.o \
	$(OBJ_DIR)/sourcenet/gl_hooks.o \
	$(OBJ_DIR)/sourcenet/gl_igameevent.o \
	$(OBJ_DIR)/sourcenet/gl_igameeventmanager2.o \
	$(OBJ_DIR)/sourcenet/gl_inetchannelhandler.o \
	$(OBJ_DIR)/sourcenet/gl_inetworkstringtable.o \
	$(OBJ_DIR)/sourcenet/gl_inetworkstringtablecontainer.o \
	$(OBJ_DIR)/sourcenet/gl_netadr_t.o \
	$(OBJ_DIR)/sourcenet/gl_subchannel_t.o \
	$(OBJ_DIR)/sourcenet/gl_ucharptr.o

TIER0_OBJS = \
	$(OBJ_DIR)/tier0/memoverride.o \

INCLUDE=-I$(PROJECT_DIR) -I$(PROJECT_DIR)/common -I$(PROJECT_DIR)/engine -I$(PROJECT_DIR)/sourcemod -I$(PROJECT_DIR)/sourcenet -I$(SOURCE_SDK)/public -I$(SOURCE_SDK)/common -I$(SOURCE_SDK)/public/tier0 -I$(SOURCE_SDK)/public/tier1 -I$(SOURCE_SDK)/tier1 -I$(SOURCE_SDK)/public/game/server -I$(SOURCE_SDK)/game/shared -I$(SOURCE_SDK)/game/server -I$(SOURCE_SDK)/game/client

CFLAGS=$(USER_CFLAGS) $(OPTFLAGS) -mtune=i686 -march=pentium -mmmx -msse -pipe -D__LINUX__ -D_LINUX -Dstrcmpi=strcasecmp -D_alloca=alloca -DVPROF_LEVEL=1 -DSWDS -D_LINUX -DLINUX -DNDEBUG -fpermissive -Dstricmp=strcasecmp -D_stricmp=strcasecmp -Dstrcpy_s=strncpy -D_strnicmp=strncasecmp -Dstrnicmp=strncasecmp -D_snprintf=snprintf -D_vsnprintf=vsnprintf -D_alloca=alloca -Dstrcmpi=strcasecmp  -Usprintf=use_Q_snprintf_instead_of_sprintf -Ustrncpy=use_Q_strncpy_instead -Ufopen=dont_use_fopen -UPROTECTED_THINGS_ENABLE

LFLAGS=$(USER_LFLAGS) -lm -ldl $(LIBFILES) -shared -Wl

DO_CC=$(CPP) $(INCLUDE) -w $(CFLAGS) -DARCH=i486 -o $@ -c $<

all: dirs gm_sourcenet3 install

dirs:
	-mkdir -p $(OUT_DIR)
	-mkdir -p $(OBJ_DIR)
	-mkdir -p $(OBJ_DIR)/engine
	-mkdir -p $(OBJ_DIR)/simplescan
	-mkdir -p $(OBJ_DIR)/sourcemod
	-mkdir -p $(OBJ_DIR)/sourcenet
	-mkdir -p $(OBJ_DIR)/tier0

gm_sourcenet3: $(SOURCENET3_OBJS) $(TIER0_OBJS) libs
	$(LINK) -o $(OUT_DIR)/gm_sourcenet3_linux.dll $(SOURCENET3_OBJS) $(TIER1_OBJS) $(TIER0_OBJS) $(LFLAGS)

install:
	cp $(OUT_DIR)/gm_sourcenet3_linux.dll $(SRCDS_DIR)/garrysmod/lua/includes/modules/

libs:
	ln -f -s $(SRCDS_DIR)/bin/libtier0.so
	ln -f -s $(SRCDS_DIR)/bin/libvstdlib.so
	ln -f -s $(SRCDS_DIR)/bin/libsteam_api.so

$(OBJ_DIR)/%.o: ./%.cpp
	$(DO_CC)

$(OBJ_DIR)/engine/%.o: ./engine/%.cpp
	$(DO_CC)

$(OBJ_DIR)/simplescan/%.o : ./simplescan/%.cpp
	$(DO_CC)

$(OBJ_DIR)/sourcemod/%.o: ./sourcemod/%.cpp
	$(DO_CC)

$(OBJ_DIR)/sourcenet/%.o : ./sourcenet/%.cpp
	$(DO_CC)

$(OBJ_DIR)/tier0/%.o: $(SOURCE_SDK)/public/tier0/%.cpp
	$(DO_CC)

clean:
	-rm -rf $(OBJ_DIR)
