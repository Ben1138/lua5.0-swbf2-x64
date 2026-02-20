cmake_minimum_required(VERSION 3.10)

# Project name
project(MyStaticLibrary)

# Set the output directory for the library
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Add the source files
set(SOURCE_FILES
    ./src/lapi.c
    ./src/lcode.c
    ./src/ldebug.c
    ./src/ldo.c
    ./src/ldump.c
    ./src/lfunc.c
    ./src/lgc.c
    ./src/llex.c
    ./src/lmem.c
    ./src/lobject.c
    ./src/lopcodes.c
    ./src/lparser.c
    ./src/lstate.c
    ./src/lstring.c
    ./src/ltable.c
    ./src/ltests.c
    ./src/ltm.c
    ./src/lundump.c
    ./src/lvm.c
    ./src/lzio.c
    ./src/lib/lauxlib.c
    ./src/lib/lbaselib.c
    ./src/lib/ldblib.c
    ./src/lib/liolib.c
    ./src/lib/lmathlib.c
    ./src/lib/ltablib.c
    ./src/lib/lstrlib.c
    ./src/lib/loadlib.c
)

# Create the static library
add_library(lua50 SHARED ${SOURCE_FILES})

# Set C standard
set_target_properties(lua50 PROPERTIES
    C_STANDARD 99
    C_STANDARD_REQUIRED ON
)

target_include_directories(lua50 PRIVATE ./include)
