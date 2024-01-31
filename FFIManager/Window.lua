local ffi = require("ffi")

ffi.cdef([[
    typedef void* HWND;
    typedef int BOOL;
    typedef wchar_t WCHAR;
    typedef LPARAM LPARAM;
    typedef int WindowColorMode;
    typedef float FLOAT;

    BOOL ShowWindow(HWND hWnd, int nCmdShow);
    int GetWindowTextA(HWND hWnd, char* lpString, int nMaxCount);
    BOOL IsWindowVisible(HWND hWnd);
    HWND FindWindowW(const WCHAR* lpClassName, const WCHAR* lpWindowName);
    BOOL GetPhysicallyInstalledSystemMemory(unsigned long long* TotalMemoryInKb);
    BOOL SystemParametersInfoW(unsigned int uiAction, unsigned int uiParam, void* pvParam, unsigned int fWinIni);
    BOOL DwmSetWindowAttribute(HWND hwnd, DWORD dwAttribute, LPCVOID pvAttribute, DWORD cbAttribute);
    int SetWindowLong(HWND hWnd, int nIndex, int dwNewLong);
    LONG_PTR SetWindowLongPtr(HWND hWnd, int nIndex, LONG_PTR dwNewLong);
    BOOL SetWindowPos(HWND hWnd, HWND hWndInsertAfter, int X, int Y, int cx, int cy, UINT uFlags);
    BOOL SetLayeredWindowAttributes(HWND hwnd, COLORREF crKey, BYTE bAlpha, DWORD dwFlags);
    void UpdateWindow(HWND hWnd);
    BOOL SetProcessDPIAware();
]])

local winData = {}
local function _hideTaskbar()
    local taskbar = ffi.C.FindWindowW(L"Shell_TrayWnd", nil)
    if taskbar == nil then
        return 0
    end
    local taskbarVisible = ffi.C.IsWindowVisible(taskbar)
    ffi.C.ShowWindow(taskbar, SW_HIDE)
    return taskbarVisible
end

local function _restoreTaskbar(wasVisible)
    if wasVisible == 0 then
        return
    end
    local taskbar = ffi.C.FindWindowW(L"Shell_TrayWnd", nil)
    if taskbar == nil then
        return
    end
    ffi.C.ShowWindow(taskbar, SW_SHOWNOACTIVATE)
end

local function _hideWindows(windowTitle)
    local winNames = { ffi.string(windowTitle) }
    local enumWinProc = ffi.cast("WNDENUMPROC", winData.enumWinProc)
    ffi.C.EnumWindows(enumWinProc, ffi.cast("LPARAM", winNames))
    local hwnd = ffi.C.FindWindowA(nil, windowTitle)
    if hwnd ~= nil then
        ffi.C.ShowWindow(hwnd, SW_SHOW)
    end
    local hxNames = {}
    for i = 2, #winNames do
        hxNames[i - 1] = winNames[i]
    end
    hxNames[#winNames] = winNames[1]
    return hxNames
end

local function _restoreWindows(prevHidden, sizeHidden)
    for i = 1, sizeHidden do
        local hwnd = ffi.C.FindWindowA(nil, prevHidden[i])
        if hwnd ~= nil then
            ffi.C.ShowWindow(hwnd, SW_SHOWNA)
        end
    end
end

local function setWindowAlpha(alpha)
    local window = ffi.C.GetActiveWindow()
    local a = alpha
    if alpha > 1 then
        a = 1
    end
    if alpha < 0 then
        a = 0
    end
    ffi.C.SetLayeredWindowAttributes(window, 0, math.floor(255 * (a * 100)) / 100, LWA_ALPHA)
end

return winData
