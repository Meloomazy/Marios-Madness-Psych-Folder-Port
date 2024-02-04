
if buildTarget == 'android' then
    return -- return the script if it on android   -Tatoraa
end

if not getModSetting('forceWindow') then
    return
end

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

function onCreate() -- what the hell is OPENFL RAAHHH -Tatoraa
    addHaxeLibrary('Main')
    addHaxeLibrary('Lib', 'openfl')
    winSave.fullscreen = getPropertyFromClass('openfl.Lib', 'application.window.fullscreen')
    winSave.maximized = getPropertyFromClass('openfl.Lib', 'application.window.maximized')
    winSave.x = getPropertyFromClass('openfl.Lib', 'application.window.x')
    winSave.y = getPropertyFromClass('openfl.Lib', 'application.window.y')
    winSave.width = getPropertyFromClass('openfl.Lib', 'application.window.width')
    winSave.height = getPropertyFromClass('openfl.Lib', 'application.window.height')
    winSave.fullWidth = getPropertyFromClass("openfl.Lib", "application.window.display.bounds.width")
    winSave.fullHeight = getPropertyFromClass("openfl.Lib", "application.window.display.bounds.height")

    setPropertyFromClass('openfl.Lib', 'application.window.resizable', false)
    setPropertyFromClass('openfl.Lib', 'application.window.fullscreen', false)
    setPropertyFromClass('openfl.Lib', 'application.window.maximized', false)
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', true)

    setVar('winX', winSave.x)
    setVar('winY', winSave.y)
    setVar('winW', winSave.width)
    setVar('winH', winSave.height)
    setVar('winSX', winSave.fullWidth)
    setVar('winSY', winSave.fullHeight)

    if getPropertyFromClass('openfl.Lib', 'application.window.maximized') == false then
        runHaxeCode([[
            var win = Lib.application.window;
            win.move(win.x + Std.int((win.width - 512) / 2), win.y + Std.int((win.height - 768) / 2));
			win.resize(512, 768);
            Lib.current.scaleX = 2.665;
			Lib.current.scaleY = 2.665;
        ]])
    end
end

function onCreatePost()
    runHaxeCode([[
        Main.fpsVar.defaultTextFormat = new openfl.text.TextFormat(Paths.font('BIOSNormal.ttf'), 10, -1);
    
        var x = 400;
        var y = 600;
        getVar('camEst').x -= x;
        game.camHUD.x -= x;  
        game.camGame.x -= x;  
        game.camGame.y -= y;
        game.camHUD.y -= y;  
        game.camOther.y -= y; 
        getVar('camEst').y -= y;

        getVar('camEst').height = 768;
        game.camGame.height = 768;
        game.camHUD.height = 768;
        game.camOther.height = 768;
    ]])
end

function onDestroy()
    runHaxeCode([[
        Main.fpsVar.defaultTextFormat = new openfl.text.TextFormat("_sans", 14, -1);
        Lib.application.window.resize(1280, 720);
        Lib.current.scaleX = 1;
        Lib.current.scaleY = 1;
    ]])

    setPropertyFromClass('openfl.Lib', 'application.window.x', winSave.x)
    setPropertyFromClass('openfl.Lib', 'application.window.y', winSave.y)

    setPropertyFromClass('openfl.Lib', 'application.window.width', winSave.width)
    setPropertyFromClass('openfl.Lib', 'application.window.height', winSave.height)
    setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
end