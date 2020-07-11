PROJNAME = lua50
APPNAME = bin2c50
APPTYPE = console
OPT = Yes
USE_NODEPEND = Yes    
NO_SCRIPTS = Yes

SRC = ../etc/bin2c.c

ifneq ($(findstring Win, $(TEC_SYSNAME)), )
  SRC += lua.rc
endif
