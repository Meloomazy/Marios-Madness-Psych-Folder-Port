local walls = {}

local ffi = require("ffi")

ffi.cdef([[
    typedef wchar_t WCHAR;
    typedef const WCHAR *LPCWSTR;
    typedef int BOOL;
    
    BOOL SystemParametersInfoW(uint32_t uiAction, uint32_t uiParam, void *pvParam, uint32_t fWinIni);
]])

local user32 = ffi.load("user32")

local SPI_SETDESKWALLPAPER = 0x0014
local SPI_GETDESKWALLPAPER = 0x0073
local SPIF_UPDATEINIFILE = 0x01
local SPIF_SENDCHANGE = 0x02

function walls.setOld()
    walls.oldWallpaper = walls._getOld()
    --debugPrint(walls.oldWallpaper)
end

function walls.setWallpaper(path)
    if path == 'revert' then
        path = walls.oldWallpaper
        local wallpath = ffi.cast("wchar_t*", path)
        user32.SystemParametersInfoW(SPI_SETDESKWALLPAPER, 0, wallpath, bit.bor(SPIF_UPDATEINIFILE, SPIF_SENDCHANGE))
    else
        -- that is stupid
        local rPath = ffi.new("wchar_t[?]", #path + 1)
        for i = 1, #path do rPath[i - 1] = ffi.cast("wchar_t", path:byte(i)) end
        user32.SystemParametersInfoW(SPI_SETDESKWALLPAPER, 0, rPath, bit.bor(SPIF_UPDATEINIFILE, SPIF_SENDCHANGE))
    end
end

function walls._getOld()
    local buffer = ffi.new("WCHAR[1024]")
    user32.SystemParametersInfoW(SPI_GETDESKWALLPAPER, 1024, buffer, 0)
    return ffi.string(buffer, 1024)
end

return walls
-- walls