function onCreate()
    precacheImage('characters/vDialog2')
    setProperty('gfGroup.visible',false)
    setProperty('introSoundsSuffix', '-null')
    local x, y = -1200, -750

    makeLuaSprite('WallBg', 'stages/virtual/Wall Bg', x, y)
    setScrollFactor('WallBg', 0.6, 0.6)
    addLuaSprite('WallBg')

    makeAnimatedLuaSprite('fakeGF', 'characters/Mr_Virtual_Girlfriend_Assets_jaj', 900, 0)
    addAnimationByPrefix('fakeGF', 'dies', 'GF Dies lol', 24, false)
    setScrollFactor('fakeGF', 0.75, 0.75)
    setProperty('fakeGF.alpha',0.001)
    addLuaSprite('fakeGF')

    makeLuaSprite('BackPipes', 'stages/virtual/Back Pipes', x, y)
    setScrollFactor('BackPipes', 0.75, 0.75)
    addLuaSprite('BackPipes')

    makeLuaSprite('BackPlatform', 'stages/virtual/Back Platform', x, y)
    setScrollFactor('BackPlatform', 0.75, 0.75)
    addLuaSprite('BackPlatform')

    makeAnimatedLuaSprite('koop1', 'stages/virtual/v_koopa_thorny', 800, 200)
    addAnimationByPrefix('koop1', 'in', 'glitch in', 24, false)
    addAnimationByPrefix('koop1', 'idle', 'glitch in', 24, false)
    playAnim('koop1', 'in', true)
    scaleObject('koop1', 0.8, 0.8, false)
    setScrollFactor('koop1', 0.75, 0.75)
    setProperty('koop1.alpha',0.001)
    setProperty('koop1.flipX',true)
    addLuaSprite('koop1')

    makeAnimatedLuaSprite('koop2', 'stages/virtual/v_koopa_thorny', 200, 200)
    addAnimationByPrefix('koop2', 'in', 'glitch in', 24, false)
    addAnimationByPrefix('koop2', 'idle', 'glitch in', 24, false)
    playAnim('koop2', 'in', true)
    scaleObject('koop2', 0.8, 0.8, false)
    setScrollFactor('koop2', 0.75, 0.75)
    setProperty('koop2.alpha',0.001)
    addLuaSprite('koop2')

    makeLuaSprite('CornertopLeftPipes', 'stages/virtual/Corner top Left Pipes', -1400, -600)
    setScrollFactor('CornertopLeftPipes', 0.75, 0.75)
    addLuaSprite('CornertopLeftPipes')

    makeLuaSprite('FrontPipes', 'stages/virtual/Front Pipes', x, y)
    addLuaSprite('FrontPipes')

    makeLuaSprite('MainPlatform', 'stages/virtual/Main Platform', x, y)
    addLuaSprite('MainPlatform')

    makeLuaSprite('Platform', 'stages/virtual/Platform', x, -170)

    setProperty('camHUD.alpha', 0)
end

function onBeatHit()
    if curBeat % 2 == 0 and getProperty('koop1.animation.curAnim.name') == 'idle' then
        playAnim('koop1', 'idle', true)
        playAnim('koop2', 'idle', true)
    end
end

function onCountdownTick(c)
    if c == 0 then
        playSound('virtualintro', 1)
    end
    if c == 1 then
        setProperty('countdownReady.visible', false)
    elseif c == 2 then
        setProperty('countdownSet.visible', false)
    elseif c == 3 then
        setProperty('countdownGo.visible', false)
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