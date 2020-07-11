PROJNAME = lua50
APPNAME = lua50
APPTYPE = console
OPT = Yes
STRIP = 
USE_NODEPEND = Yes    
NO_SCRIPTS = Yes

SRC = lua/lua.c

INCLUDES = ../include

ifneq ($(findstring Win, $(TEC_SYSNAME)), )
  SRC += lua.rc
  SLIBS += setargv.obj
  
  #Windows Use Dynamic Libraries
  USE_DLL = Yes
  LIBS += lua50
  ifeq "$(TEC_SYSNAME)" "Win32"
    LDIR += ../lib/dll
  else
    LDIR += ../lib/dll8_64
  endif
else
  #UNIX Use Static Libraries
  SLIB += ../lib/$(TEC_UNAME)/liblua50.a
endif

ifneq ($(findstring Linux, $(TEC_UNAME)), )
  LIBS += dl 
  
  DEFINES += LUA_USERCONFIG='"$(LUA5)/etc/saconfig.c"' USE_READLINE
  LIBS += readline history curses ncurses
  
  LFLAGS = -Wl,-E
endif

ifneq ($(findstring SunOS, $(TEC_UNAME)), )
  LIBS += dl 
endif

ifdef USE_CYGWIN
  DEFINES += LUA_USERCONFIG='"$(LUA5)/etc/saconfig.c"' USE_READLINE
  LIBS += readline history
endif
