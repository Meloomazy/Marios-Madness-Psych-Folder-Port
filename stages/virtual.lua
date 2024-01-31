function onCreatePost()
    setProperty('gfGroup.visible',false)
    setProperty('introSoundsSuffix', '-null')
    local x, y = -1200, -750


    makeLuaSprite('WallBg', 'stages/virtual/Wall Bg', x, y)
    setScrollFactor('WallBg', 0.6, 0.6)
    addLuaSprite('WallBg')

    makeLuaSprite('BackPipes', 'stages/virtual/Back Pipes', x, y)
    setScrollFactor('BackPipes', 0.75, 0.75)
    addLuaSprite('BackPipes')

    makeLuaSprite('BackPlatform', 'stages/virtual/Back Platform', x, y)
    setScrollFactor('BackPlatform', 0.75, 0.75)
    addLuaSprite('BackPlatform')

    makeLuaSprite('CornertopLeftPipes', 'stages/virtual/Corner top Left Pipes', -1400, -600)
    setScrollFactor('CornertopLeftPipes', 0.75, 0.75)
    addLuaSprite('CornertopLeftPipes')

    makeLuaSprite('FrontPipes', 'stages/virtual/Front Pipes', x, y)
    addLuaSprite('FrontPipes')

    makeLuaSprite('MainPlatform', 'stages/virtual/Main Platform', x, y)
    addLuaSprite('MainPlatform')

    makeLuaSprite('Platform', 'stages/virtual/Platform', x, -170)
end

function onCountdownTick(t)
    if t == 0 then
        playSound('virtualintro', 1)
        runHaxeCode([[
            FlxTween.tween(Lib.application.window, {y: getVar('winY')}, 0.7, {ease: FlxEase.backInOut});
        ]])
    end
end

function onEvent(n,v1,v2)
    if n == 'Triggers Paranoia' then
        if v1 == '4' then
            removeLuaSprite('Platform', true)
        end
        if v1 == '1' then
            addLuaSprite('Platform')
            removeLuaSprite('MainPlatform')
            removeLuaSprite('FrontPipes')
            removeLuaSprite('CornertopLeftPipes')
            removeLuaSprite('BackPlatform')
            removeLuaSprite('BackPipes')
            removeLuaSprite('WallBg')
        end
    end
    --debugPrint('EventName: '..n..'\nval1: '..v1..'\nval2: '..v2)
end