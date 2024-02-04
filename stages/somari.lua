
if buildTarget == 'android' then
    return -- return the script if it on android   -Tatoraa
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
    setProperty('defaultCamZoom', 1.5)
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
        if getPropertyFromClass('openfl.Lib', 'application.window.width') == 1280 and getPropertyFromClass('openfl.Lib', 'application.window.height') == 720 then
            runHaxeCode([[
                Lib.application.window.move(getVar('winX') + 240, getVar('winY') + 60);
            ]])
        else
            runHaxeCode([[
                Lib.application.window.move(560, 240);
            ]])
        end
        runHaxeCode([[
            Lib.application.window.resize(800, 600);
            Lib.current.scaleX = 1.2;
            Lib.current.scaleY = 1.2;
        ]])
    end
end

function onCreatePost()
    runHaxeCode([[
        Main.fpsVar.defaultTextFormat = new openfl.text.TextFormat(Paths.font('PixeL NES.otf'), 10, -1);

        game.camHUD.x -= 100;  
        game.camHUD.y -= 100;  
        game.camHUD.height = 960;
        game.camOther.y -= 100;  
        game.camOther.height = 960;
        game.camGame.x -= 100;  
        game.camGame.y -= 0;
        game.camGame.height = 960;

        game.healthBar.y = ClientPrefs.data.downScroll ? FlxG.height * 0.11 : 960 * 0.89;
        game.iconP1.y = game.healthBar.y - 75;
        game.iconP2.y = game.healthBar.y - 75;
        game.scoreTxt.y = game.healthBar.y + 36;
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