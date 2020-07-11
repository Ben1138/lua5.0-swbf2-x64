----------------------------------------------------
-- The main porpouse of this file is to build linux gcc makefiles.
-- Must have Premake version 3 installed.
-- Original Premake was changed to remove some parameters and add others.
-- Default parameters:
--   premake3s --target gnu --os linux
-- But it can build windows gcc makefiles, and visual studio projects.
--   premake3s --target gnu --os windows
--   premake3s --target gnu --os macosx
--   premake3s --target vs6
--   premake3s --target vs2002
--   premake3s --target vs2003
--   premake3s --target vs2005
-- In Linux the generated makefiles will not correctly build libraries in 64-bits.
--              must add "-m64 -fPIC" flags
----------------------------------------------------

if (not options.target) then 
  options.target = "gnu"
end

if (not options.os) then
  if (options.target ~= "gnu") then
    options.os = "windows"
  else
    options.os = "linux"
  end
end

function fixPackagePath(package_files)
  if (options.os ~= "linux") then
    for i, file in package_files do 
      package_files[i] = "../src/"..file 
    end
  end
end

----------------------------------------------------

lua_suffix = "50"

project.name = "lua"..lua_suffix
project.bindir = "../bin"
project.libdir = "../lib"

if (options.os ~= "linux") then
  if (options.os == "macosx") then
	project.path = "../mak.macosx"
  else
	project.path = "../mak."..options.target
  end
end

lua_defines = { "USE_TMPNAME=1" }

if (options.os ~= "windows") then
  -- All non-Windows (posix)                         
  tinsert(lua_defines, {"USE_POPEN=1", "USE_DLOPEN=1"})
end

if (options.target == "vs2005") then
  tinsert(lua_defines, {"_CRT_SECURE_NO_DEPRECATE"})
end

----------------------------------------------------

package = newpackage()
package.name = "lua"..lua_suffix.."_dll"
package.target = "lua"..lua_suffix
package.objdir = "../obj/"..package.name
package.language = "c"
package.kind = "dll"
package.defines = lua_defines
package.includepaths = { "../include" }
package.path = project.path

lua_files =
{
  "lapi.c", "lcode.c", "ldebug.c", "ldo.c", "ldump.c", "lfunc.c", "lgc.c", "llex.c", "lmem.c",
  "lobject.c", "lopcodes.c", "lparser.c", "lstate.c", "lstring.c", "ltable.c", "ltests.c", "ltm.c",
  "lundump.c", "lvm.c", "lzio.c",
  "lib/lauxlib.c", "lib/lbaselib.c", "lib/ldblib.c", "lib/liolib.c", "lib/lmathlib.c", "lib/ltablib.c",
  "lib/lstrlib.c", "lib/loadlib.c"
}                        
fixPackagePath(lua_files)

package.files = lua_files

if (options.os == "windows") then
  tinsert(package.files, {"../src/lua"..lua_suffix..".def"}) 
end
  
---------------------------------------------------------------------

package = newpackage()
package.name = "lua"..lua_suffix.."_lib"
package.target = "lua"..lua_suffix
package.objdir = "../obj/"..package.name
if (options.os == "windows") then
  package.libdir = "../lib/static"
end
package.language = "c"
package.kind = "lib"
package.defines = lua_defines
package.files = lua_files
package.includepaths = { "../include" }
package.path = project.path

---------------------------------------------------------------------

package = newpackage()
package.name = "lua"..lua_suffix.."_exe"
package.target = "lua"..lua_suffix
package.objdir = "../obj/"..package.name
package.language = "c"
package.kind = "exe"
package.includepaths = { "../include" }
package.path = project.path

package.files =
{
  "lua/lua.c"
}
fixPackagePath(package.files)

if (options.os == "windows") then
  tinsert(package.files, {"../src/lua.rc"})
  package.links = { "lua"..lua_suffix }
  package.libpaths = { "../lib" }
  package.linkoptions = { "setargv.obj" }
  
  if (options.target == "gnu") then
    tinsert(package.links, {"readline", "history"})
  end
else
  package.links = { "lua"..lua_suffix, "m" }
  package.libpaths = { "../lib" }
  
  if (options.os == "linux") then
    package.defines = {"LUA_USERCONFIG='\"../etc/saconfig.c\"'" , "USE_READLINE"}
    tinsert(package.links, {"readline", "history", "curses", "ncurses"})
    tinsert(package.links, {"dl"})
    package.linkoptions = { "-Wl,-E" }
  end
  
  if (options.os == "bsd") then
    package.linkoptions = { "-Wl,-E" }
  end
  
  if (options.os == "sunos") then
    tinsert(package.links, {"dl"})
  end
end

if (options.target == "vs2005") then
  tinsert(package.defines, {"_CRT_SECURE_NO_DEPRECATE"})
end

---------------------------------------------------------------------

package = newpackage()
package.name = "luac"..lua_suffix.."_exe"
package.target = "luac"..lua_suffix
package.objdir = "../obj/"..package.name
package.language = "c"
package.kind = "exe"
package.defines = {"LUA_OPNAMES"}
package.includepaths = { "../include", "../src" }
package.path = project.path

package.files =
{
  "luac/luac.c", "luac/print.c", "lopcodes.c"
}
fixPackagePath(package.files)

if (options.os == "windows") then
  tinsert(package.files, {"../src/lua.rc"})
  package.links = { "lua"..lua_suffix }
  package.libpaths = { "../lib" }
  package.linkoptions = { "setargv.obj" }
else
  package.links = { "lua"..lua_suffix, "m" }
  package.libpaths = { "../lib" }
  
  if (options.os == "linux") then
    tinsert(package.links, {"dl"})
    package.linkoptions = { "-Wl,-E" }
  end
  
  if (options.os == "bsd") then
    package.linkoptions = { "-Wl,-E" }
  end
  
  if (options.os == "sunos") then
    tinsert(package.links, {"dl"})
  end
end

if (options.target == "vs2005") then
  tinsert(package.defines, {"_CRT_SECURE_NO_DEPRECATE"})
end

---------------------------------------------------------------------

package = newpackage()
package.name = "bin2c"..lua_suffix.."_exe"
package.target = "bin2c"..lua_suffix
package.objdir = "../obj/"..package.name
package.language = "c"
package.kind = "exe"
package.linkflags = { "static-runtime" }
package.path = project.path

package.files =
{
  "../etc/bin2c.c"
}

if (options.os == "windows") then
  tinsert(package.files, {"../src/lua.rc"})
end

---------------------------------------------------------------------
