# Lua 5.0 SWBF2 x64
A port of Lua 5.0.3 from x86 to x64 and MSVC++ 14.2 (Visual Studio 2019).<br/>
This port has been modified to execute Lua binary code compiled with a custom Lua version used in Star Wars Battlefront 2 (2005). That means this port:
- Does not execute x64 binary code (as expected from a x64 version), but only binaries in x86 format
- Does not execute regular x86 code that has been compiled with the official version of lua 5.0.3