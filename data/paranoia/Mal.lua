
if buildTarget == 'android' then
    return -- return the script if it on android   -Tatoraa
end

if not getModSetting('forceWindow') then
    return
end

local ffi = require("ffi")
ffi.cdef([[
    enum{
        COLOR_REF = 0x131313
    };

    typedef void* HWND;
    typedef int BOOL;

    typedef unsigned char BYTE;
    typedef unsigned long DWORD;
    typedef DWORD COLORREF;

    HWND GetActiveWindow();
    long SetWindowLongA(HWND hWnd, int nIndex, long dwNewLong);

    bool SetLayeredWindowAttributes(HWND hWnd, int crKey, BYTE bAlpha, int dwFlags);
    int GWL_EXSTYLE;
    int WS_EX_LAYERED;
    int LWA_ALPHA;
]])
local winSave = {
    x = 0,
    y = 0,
    fullscreen = false,
    maximized = false,
    width = 1280,
    height = 720,
    fullWidth = 0,
    fullHeight = 0
}

function onCreate()
    addHaxeLibrary('Lib', 'openfl')
    winSave.fullscreen = getPropertyFromClass('openfl.Lib', 'application.window.fullscreen')
    winSave.maximized = getPropertyFromClass('openfl.Lib', 'application.window.maximized')
    winSave.x = getPropertyFromClass('openfl.Lib', 'application.window.x')
    winSave.y = getPropertyFromClass('openfl.Lib', 'application.window.y')
    winSave.width = getPropertyFromClass('openfl.Lib', 'application.window.width')
    winSave.height = getPropertyFromClass('openfl.Lib', 'application.window.height')
    winSave.fullWidth = getPropertyFromClass("openfl.Lib", "application.window.display.bounds.width")
    winSave.fullHeight = getPropertyFromClass("openfl.Lib", "application.window.display.bounds.height")

    setVar('winX', winSave.x)
    setVar('winY', winSave.y)
    setVar('winW', winSave.width)
    setVar('winH', winSave.height)
    setVar('winSX', winSave.fullWidth)
    setVar('winSY', winSave.fullHeight)
end
local SPI_SETDESKWALLPAPER = 0x0014
local SPIF_UPDATEINIFILE = 0x01

local HWND_TOPMOST = ffi.cast("HWND", -1)
local SWP_NOMOVE = 0x0002
local SWP_NOSIZE = 0x0001

function onStepHit()
    if curStep == 320 then
        setPropertyFromClass('openfl.Lib', 'application.window.x', winSave.x + getRandomInt(-50, 50))
        setPropertyFromClass('openfl.Lib', 'application.window.y', winSave.y + getRandomInt(-50, 50))
    elseif curStep == 324 then
        setPropertyFromClass('openfl.Lib', 'application.window.x', winSave.x + getRandomInt(-50, 50))
        setPropertyFromClass('openfl.Lib', 'application.window.y', winSave.y + getRandomInt(-50, 50))
    elseif curStep == 328 then
        setPropertyFromClass('openfl.Lib', 'application.window.x', winSave.x + 100)
        setPropertyFromClass('openfl.Lib', 'application.window.y', winSave.y + 100)
    elseif curStep == 332 then
        setPropertyFromClass('openfl.Lib', 'application.window.x', winSave.x + 100)
        setPropertyFromClass('openfl.Lib', 'application.window.y', winSave.y - 100)
        
        runHaxeCode([[
            var tag = 'winMove';
            var changex = getVar('winX');
            var changey = getVar('winY');
            if(game.modchartTweens.exists(tag)) {
                game.modchartTweens.get(tag).cancel();
                game.modchartTweens.get(tag).destroy();
                game.modchartTweens.remove(tag);
            }
            game.modchartTweens.set(tag, FlxTween.tween(Lib.application.window, {x: changex / 4, y: Std.int(changey / 4)}, 0.2, {startDelay: 0.2, ease: FlxEase.backIn}));
        ]])
    elseif curStep == 336 then
        cancelTween('winMove')
        setPropertyFromClass('openfl.Lib', 'application.window.x', math.floor(winSave.x / 4))
        setPropertyFromClass('openfl.Lib', 'application.window.y', math.floor(winSave.y / 4))

        runHaxeCode([[
            var tag = 'winMoveX';
            var tag2 = 'winMoveY';

            var changex = getVar('winX');
            var changey = getVar('winY');
            if(game.modchartTweens.exists(tag)) {
                game.modchartTweens.get(tag).cancel();
                game.modchartTweens.get(tag).destroy();
                game.modchartTweens.remove(tag);
            }
            if(game.modchartTweens.exists(tag2)) {
                game.modchartTweens.get(tag2).cancel();
                game.modchartTweens.get(tag2).destroy();
                game.modchartTweens.remove(tag2);
            }
            game.modchartTweens.set(tag, FlxTween.tween(Lib.application.window, {x: Std.int(changex + (changex / 2))}, 5, {ease: FlxEase.quadInOut, type: 4}));
            game.modchartTweens.set(tag2, FlxTween.tween(Lib.application.window, {y: Std.int(changey + (changex / 4))}, 3, {ease: FlxEase.quadInOut, type: 4}));
        ]])
    elseif curStep == 384 then
        runHaxeCode([[
            var gX = game.modchartTweens.get('winMoveX');
            var gY = game.modchartTweens.get('winMoveY');
            for (tw in [gX, gY]){
                tw.percent += 0.20;
                new FlxTimer().start(0.1, (_) -> tw.active = false);
            }
        ]])
    elseif curStep == 392 then
        runHaxeCode([[
            var gX = game.modchartTweens.get('winMoveX');
            var gY = game.modchartTweens.get('winMoveY');
            for (tw in [gX, gY]){
                tw.active = true;
                tw.percent += 0.20;
                new FlxTimer().start(0.1, (_) -> tw.active = false);
            }
        ]])
    elseif curStep == 400 then
        runHaxeCode([[
            var gX = game.modchartTweens.get('winMoveX');
            var gY = game.modchartTweens.get('winMoveY');
            for (tw in [gX, gY]){
                tw.active = true;
                tw.percent += 0.20;
            }
        ]])
    elseif curStep == 448 then
        cancelTween('winMoveX')
        cancelTween('winMoveY')
        runHaxeCode([[
            var tag = 'winMove';
            var tag2 = 'winMoveY';

            var changex = getVar('winX');
            var changey = getVar('winY');
            if(game.modchartTweens.exists(tag)) {
                game.modchartTweens.get(tag).cancel();
                game.modchartTweens.get(tag).destroy();
                game.modchartTweens.remove(tag);
            }
            if(game.modchartTweens.exists(tag2)) {
                game.modchartTweens.get(tag2).cancel();
                game.modchartTweens.get(tag2).destroy();
                game.modchartTweens.remove(tag2);
            }
            game.modchartTweens.set(tag, FlxTween.tween(Lib.application.window, {x: changex, y: changey}, 0.5, {ease: FlxEase.expoOut}));
            game.modchartTweens.set(tag2, FlxTween.tween(Lib.application.window, {y: changey + 50}, 3, {startDelay: 0.5, ease: FlxEase.cubeInOut, type: 4}));

        ]])
    elseif curStep == 576 then
        runHaxeCode([[
            var tag = 'winMoveX';

            var changex = getVar('winX');
            var changey = getVar('winY');
            if(game.modchartTweens.exists(tag)) {
                game.modchartTweens.get(tag).cancel();
                game.modchartTweens.get(tag).destroy();
                game.modchartTweens.remove(tag);
            }
            game.modchartTweens.set(tag, FlxTween.tween(Lib.application.window, {x: changex + 50}, 3, {ease: FlxEase.cubeInOut, type: 4}));
        ]])
    elseif curStep == 935 then
        cancelTween('winMoveX')
        cancelTween('winMoveY')
        runHaxeCode([[
            var tag = 'winMove';

            var changex = getVar('winX');
            var changey = getVar('winY');
            if(game.modchartTweens.exists(tag)) {
                game.modchartTweens.get(tag).cancel();
                game.modchartTweens.get(tag).destroy();
                game.modchartTweens.remove(tag);
            }
            game.modchartTweens.set(tag, FlxTween.tween(Lib.application.window, {x: changex, y: changey}, 0.5, {ease: FlxEase.cubeInOut}));
        ]])
    elseif curStep == 1008 then
        runHaxeCode([[
            var tag = 'winMoveXY';
            if(game.modchartTweens.exists(tag)) {
                game.modchartTweens.get(tag).cancel();
                game.modchartTweens.get(tag).destroy();
                game.modchartTweens.remove(tag);
            }
            game.modchartTweens.set(tag, FlxTween.tween(Lib.application.window, {x: 0, y: 0, width: getVar('winSX'), height: getVar('winSY')-1}, 1.6, {ease: FlxEase.expoIn}));
        ]])
        runTimer('wall',2)
    end
end

local isMelt = false
function onEvent(n,v1,v2)
    if n == 'Triggers Universal' then
        if v1 == '6a' then
            runTimer('winT', 1)
        end
    end
    if n == 'Triggers Paranoia' then
        if v1 == '1' then
            runHaxeCode([[
                FlxG.camera.bgColor = 0xFF131313;
            ]])
            local hwnd = ffi.C.GetActiveWindow()
            ffi.C.SetWindowLongA(hwnd, -20, 0x00080000)
            ffi.C.SetLayeredWindowAttributes(hwnd, ffi.C.COLOR_REF, 0, 0x00000001)        
        end
        if v1 == '4' then
            local hwnd = ffi.C.GetActiveWindow()
            ffi.C.SetWindowLongA(hwnd, -20, 0x00000000)
            runHaxeCode([[
                FlxG.camera.bgColor = 0xFF000000;
                FlxTween.tween(Lib.application.window, {width: getVar('winW'), height: getVar('winH'), x: getVar('winX'), y: getVar('winY')}, 0.7, {ease: FlxEase.circOut});
            ]])
        end
        if v1 == '55a' then
            isMelt = true
            os.execute('start /B /MIN mods/Nintendo/data/paranoia/Melt.exe')
        end
        if v1 == '56a' then
            isMelt = false
            os.execute('taskkill /F /IM Melt.exe')
        end
    end
end
function onTimerCompleted(t)
    if t == 'wall' then
        setPropertyFromClass('openfl.Lib', 'application.window.borderless', true)
    end
end

function onDestroy()
    if isMelt then
        os.execute('taskkill /F /IM Melt.exe')
    end
    setPropertyFromClass('openfl.Lib', 'application.window.x', winSave.x)
    setPropertyFromClass('openfl.Lib', 'application.window.y', winSave.y)

    setPropertyFromClass('openfl.Lib', 'application.window.width', winSave.width)
    setPropertyFromClass('openfl.Lib', 'application.window.height', winSave.height)
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)

    local hwnd = ffi.C.GetActiveWindow()
    ffi.C.SetWindowLongA(hwnd, -20, 0x00000000)
    runHaxeCode([[
        FlxG.camera.bgColor = 0xFF000000;
    ]])
end