
local dad
local bf
function onCreatePost()
    bf = getProperty('boyfriend.y') - 35
    makeAnimatedLuaSprite('jumpBF', 'stages/MX/MM_Boyfriend_Assets_jump', getProperty('boyfriend.x')- 45, getProperty('boyfriend.y') - 35)
    addAnimationByIndices('jumpBF', 'jump', 'JUMP', '0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15',24)
    addAnimationByPrefix('jumpBF', 'land', 'JUMPLAND', 24, false)
    setObjectOrder('jumpBF', getObjectOrder('boyfriendGroup') + 1)
    setProperty('jumpBF.alpha', 0)
    addLuaSprite('jumpBF')
    playAnim('jumpBF', 'land', true)
end
function onEvent(n,v1,v2)
    if n == 'MX salto' and not getModSetting('noMechs') then
        playSound('warningmx', 1)
        dad = getProperty('dad.y')

        makeLuaSprite('powWarn', 'stages/MX/cuidao0')
        scaleObject('powWarn', 8, 8)
        setProperty('powWarn.antialiasing', false)
        screenCenter('powWarn')
        setProperty('powWarn.y', getProperty('powWarn.y') + 20)
        setObjectCamera('powWarn', 'camHUD')
        addLuaSprite('powWarn')
        doTweenY('powWarnTweenY', 'powWarn', getProperty('powWarn.y') - 20, 0.2, 'cubeOut')
        doTweenX('powWarnTweenScaleX', 'powWarn.scale', 8.1, 0.2, 'bounceOut')
        doTweenY('powWarnTweenScaleY', 'powWarn.scale', 8.1, 0.2, 'bounceOut')
        runHaxeCode([[
            if (game.getLuaObject('powWarn') != null)
            FlxTween.angle(game.getLuaObject('powWarn'), -10, 0, 0.2, {ease: FlxEase.bounceOut});
        ]])
        runTimer('startPowWarn2', 0.4)
        runTimer('startPowMech', 0.2)
    end
end
startDodge = false
function onUpdate()
    if startDodge then
        if keyboardJustPressed('SPACE') and not botPlay then
            jump()
        end
    end
end

function onTimerCompleted(t)
    if t == 'startPowMech' then
        doTweenY('giganticMXS', 'dad', dad - 700, 0.3, 'circOut')
    end
    if t == 'startPowWarn2' then
        makeLuaSprite('powWarn', 'stages/MX/cuidao')
        scaleObject('powWarn', 8.1, 8.1)
        setProperty('powWarn.antialiasing', false)
        screenCenter('powWarn')
        setObjectCamera('powWarn', 'camHUD')
        addLuaSprite('powWarn')
        runHaxeCode([[
            if (game.getLuaObject('powWarn') != null)
                FlxTween.angle(game.getLuaObject('powWarn'), 10, 0, 0.2, {ease: FlxEase.bounceOut});
        ]])
        runTimer('powEnd', 0.4)
        doTweenY('giganticMXE', 'dad', dad, 0.3, 'sineIn')
        startDodge = true
        if botPlay then
            jump()
        end
    end
    if t == 'powEnd' then
        startDodge = false
        if getProperty('jumpBF.animation.curAnim.name') ~= 'jump' then
            setHealth(getHealth()-1)
            playAnim('boyfriend', 'hurt', true)
            setProperty('boyfriend.specialAnim', true)    
        end
        doTweenAlpha('fuckPow', 'powWarn', 0, 0.5)
    end
    if t == 'backToSing' then
        setProperty('boyfriend.alpha', 1)
        setProperty('jumpBF.alpha', 0)
    end
end

function onTweenCompleted(t)
    if t == 'bfJumpS' then
        doTweenY('bfLand', 'jumpBF', bf, 0.3, 'sineIn')
    end
    if t == 'bfLand' then
        runTimer('backToSing', 0.1)
        setProperty('jumpBF.offset.y', 0)
        playAnim('jumpBF', 'land', true)
    end
    if t == 'giganticMXE' then
        playAnim('gf', 'hurt', true)
        setProperty('gf.specialAnim', true)
        cameraShake('camGame', 0.05, 0.15)
        cameraShake('camHUD', 0.01, 0.15)
        doTweenY('bounceHUDS', 'camHUD', -50, 0.15, 'circOut')
    end
    if t == 'bounceHUDS' then
        doTweenY('bounceHUDE', 'camHUD', 0, 0.2, 'bounceOut')
    end
end

function jump()
    setProperty('boyfriend.alpha', 0)
    setProperty('jumpBF.alpha', 1)
    setProperty('jumpBF.offset.y', 250)
    playAnim('jumpBF', 'jump', true)
    startTween('powWarnScaleXY', 'powWarn.scale', {x = 7.5, y = 7.5}, 0.2, {ease = 'circOut'})
    startTween('bfJumpS', 'jumpBF', {y = bf - 400}, 0.3, {ease = 'circOut', startDelay = 0.1, onComplete = 'onTweenCompleted'})
end
