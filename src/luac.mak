PROJNAME = lua50
APPNAME = luac50
APPTYPE = console
OPT = Yes
STRIP = 
USE_NODEPEND = Yes    
NO_SCRIPTS = Yes

SRC = luac/luac.c luac/print.c lopcodes.c

# print.c needs opcode names from lopcodes.c
DEFINES = LUA_OPNAMES

INCLUDES = ../src ../include

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
  #UNIX Static Libraries
  SLIB += ../lib/$(TEC_UNAME)/liblua50.a
endif

ifneq ($(findstring Linux, $(TEC_UNAME)), )
  LIBS += dl 
endif
