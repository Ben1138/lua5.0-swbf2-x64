LIBNAME = lua50
PROJNAME = lua50
OPT = Yes
USE_NODEPEND = Yes    
NO_DYNAMIC = no

INCLUDES = ../include

SRC = lapi.c lcode.c ldebug.c ldo.c ldump.c lfunc.c lgc.c llex.c lmem.c lobject.c lopcodes.c \
	lparser.c lstate.c lstring.c ltable.c ltests.c ltm.c lundump.c lvm.c lzio.c

# LuaLib

SRC += lib/lauxlib.c lib/lbaselib.c lib/ldblib.c lib/liolib.c lib/lmathlib.c lib/ltablib.c lib/lstrlib.c lib/loadlib.c

DEFINES = USE_TMPNAME=1

ifeq ($(findstring Win, $(TEC_SYSNAME)), )
  DEFINES += USE_POPEN=1 USE_DLOPEN=1
endif
