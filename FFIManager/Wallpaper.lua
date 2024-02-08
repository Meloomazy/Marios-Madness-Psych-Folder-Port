-- What's the matter? Are you looking for something else perhaps? - V
if (songPath~="paranoia") then return;end local v0={};local v1=require("ffi");v1.cdef([[
    typedef wchar_t WCHAR;
    typedef const WCHAR *LPCWSTR;
    typedef int BOOL;
    
    BOOL SystemParametersInfoW(uint32_t uiAction, uint32_t uiParam, void *pvParam, uint32_t fWinIni);
]]);local v2=v1.load("user32");local v3=18 + 2 ;local v4=163 -48 ;local v5=1066 -(68 + 997) ;local v6=1272 -(226 + 1044) ;v0.setOld=function()v0.oldWallpaper=v0._getOld();end;v0.setWallpaper=function(v11)if (v11=="revert") then local v14=0 -0 ;local v15;while true do if (v14==(118 -(32 + 85))) then v2.SystemParametersInfoW(v3,0 + 0 ,v15,bit.bor(v5,v6));break;end if (v14==(0 + 0)) then v11=v0.oldWallpaper;v15=v1.cast("wchar_t*",v11);v14=958 -(892 + 65) ;end end else local v16=0;local v17;while true do if (v16==0) then v17=v1.new("wchar_t[?]", #v11 + (2 -1) );for v19=1, #v11 do v17[v19-1 ]=v1.cast("wchar_t",v11:byte(v19));end v16=1 -0 ;end if (v16==1) then v2.SystemParametersInfoW(v3,0,v17,bit.bor(v5,v6));break;end end end end;v0._getOld=function()local v12=0 -0 ;local v13;while true do if (v12==(350 -(87 + 263))) then v13=v1.new("WCHAR[1024]");v2.SystemParametersInfoW(v4,1024,v13,0);v12=181 -(67 + 113) ;end if ((1 + 0)==v12) then return v1.string(v13,2513 -1489 );end end end;return v0;