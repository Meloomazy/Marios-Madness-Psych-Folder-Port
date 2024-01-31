function onCreate()
    setProperty('introSoundsSuffix', '-null')

    makeLuaSprite('wall', 'stages/IHY/Ladrillos y ventanas', -960, -700)
    setScrollFactor('wall', 0.6, 0.6)
    addLuaSprite('wall')
    
    makeLuaSprite('sign', 'stages/IHY/Luigi_IHY_Background_Assets_ete_sech_v2', 1160, 300)
    setScrollFactor('sign', 0.6, 0.6)
    addLuaSprite('sign')

    makeLuaSprite('floor', 'stages/IHY/Puente Roto', -1360, -680)
    addLuaSprite('floor')

    makeAnimatedLuaSprite('ghostboo1', 'stages/IHY/Luigi_HY_BG_Assetss', -500, 233)
    setProperty('ghostboo1.flipX', true)
    addAnimationByPrefix('ghostboo1', 'idle', 'GhostIdle', 24, true)
    setScrollFactor('ghostboo1', 0.8, 0.8)
    addLuaSprite('ghostboo1')

    makeAnimatedLuaSprite('ghostboo2', 'stages/IHY/Luigi_HY_BG_Assetss', 1500, 33)
    addAnimationByPrefix('ghostboo2', 'idle', 'GhostIdle', 24, true)
    setScrollFactor('ghostboo2', 0.8, 0.8)
    addLuaSprite('ghostboo2')

    makeAnimatedLuaSprite('ghostboo3', 'stages/IHY/Luigi_HY_BG_Assetss', 1450, 333)
    addAnimationByPrefix('ghostboo3', 'idle', 'GhostIdle', 24, true)
    setScrollFactor('ghostboo3', 0.8, 0.8)
    addLuaSprite('ghostboo3')

    makeAnimatedLuaSprite('deadmario1', 'stages/IHY/Luigi_HY_BG_Assetss', 100, 352)
    addAnimationByPrefix('deadmario1', 'hi', 'MarioIntro', 24, false)
    addAnimationByPrefix('deadmario1', 'idle', 'MarioIdle', 24, false)
    addLuaSprite('deadmario1')

    makeAnimatedLuaSprite('deadmario2', 'stages/IHY/Luigi_HY_BG_Assetss', 1360, 352)
    addAnimationByPrefix('deadmario2', 'hi', 'MarioIntro', 24, false)
    addAnimationByPrefix('deadmario2', 'idle', 'MarioIdle', 24, false)
    addLuaSprite('deadmario2')
    
    makeLuaSprite('overlayGlow', 'stages/IHY/asset_deg', 260, 280)
    setObjectCamera('overlayGlow', 'camHUD')
    setGraphicSize('overlayGlow', getProperty('overlayGlow.width') * 4, getProperty('overlayGlow.height') * 4, false)
    addLuaSprite('overlayGlow',true)
    setProperty('overlayGlow.alpha', 1)
    startTween('overlayGlowing', 'overlayGlow', {alpha = 0.5}, 0.5, {type = "pingpong"})

    makeLuaSprite('blackBar', nil)
    makeGraphic('blackBar', screenWidth, screenHeight, '000000')
    screenCenter('blackBar')
    setObjectCamera('blackBar', 'camOther')
    addLuaSprite('blackBar')

    makeLuaSprite('startBf', 'modstuff/hatestart')
    setGraphicSize('startBf', getProperty('startBf.width') * 3, getProperty('startBf.height') * 3)
    setProperty('startBf.antialiasing', false)
    screenCenter('startBf')
    setObjectCamera('startBf', 'camOther')
    addLuaSprite('startBf')

    setProperty('deadmario1.alpha', 0.001)
    setProperty('deadmario2.alpha', 0.001)
    setProperty('ghostboo1.alpha', 0.001)
    setProperty('ghostboo2.alpha', 0.001)
    setProperty('ghostboo3.alpha', 0.001)
    setProperty('sign.alpha', 0.001)

    setProperty('camHUD.alpha', 0)
end
function onSongStart()
    doTweenAlpha('startbf', 'startBf', 0, 1, 'quadOut')
    doTweenAlpha('blackBarThingie', 'blackBar', 0, 1, 'quadOut')
    doTweenAlpha('camHUD', 'camHUD', 1, 1, 'quadOut')
end
function onCountdownTick(c)
    if c == 0 then
        playSound('smw_coin', 1)
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
    if n == 'Triggers Universal' or n == 'Triggers I Hate You' then
        if v1 == '0' then
            startTween('boo1', 'ghostboo1', {alpha = 1, x = -300}, 2, {ease = 'expoOut'})
            startTween('boo2', 'ghostboo2', {alpha = 1, x = 1300}, 3, {ease = 'expoOut'})
            startTween('boo3', 'ghostboo3', {alpha = 1, x = 1250}, 2.5, {ease = 'expoOut'})
        end
        if v1 == '1' then
            setProperty('sign.alpha', 1)
            cameraShake('camGame', 0.05, 0.2)
        end
        if v1 == '2' then
            setProperty('deadmario1.alpha', 1)
            playAnim('deadmario1', 'hi', true)
        end
        if v1 == '3' then
            setProperty('deadmario2.alpha', 1)
            playAnim('deadmario2', 'hi', true)
        end
        if v1 == '5' then
            setProperty('bfCape.visible', false)
            triggerEvent('Play Animation', 'prejump', 'boyfriend')
        end
      
        if v1 == '9' then
            setVar('camMove', false)
            startTween('camMovingWee', 'camFollow', {x = getVar('posValDad')[1], y = getVar('posValDad')[2]}, 2.5, {ease = 'cubeInOut'})
        end
        if v1 == '10' then
            setProperty('camZooming', false)
            setVar('camMoveZoom', false)
            startTween('camMovingWee', 'camFollow', {y = getVar('posValDad')[2] + 250}, 10, {ease = 'cubeInOut'})
            doTweenZoom('camo', 'camGame', 1, 10, 'cubeInOut')
        end
        if v1 == '11' then
            setProperty('blackBar.alpha', 1)
        end
    end
end


function onTimerCompleted(t)
    if t == 'ok' then
        setProperty('bfCape.visible', true)
        setProperty('bfCape.x', getProperty('boyfriendGroup.x') + 260)
    end
    if t == 'hefell' then
        triggerEvent('Play Animation', 'hand', 'dad')
        setProperty('dadGroup.x', -1200)
        setProperty('dadGroup.y', 500)
        setProperty('dadGroup.angle', 0)
        startTween('wha', 'dadGroup', {y = 800}, 2, {startDelay = 0.3})
    end
end

function onBeatHit()
    if (curBeat >= 320 and curBeat % 2 == 0) then
        playAnim('deadmario1', 'idle', true)
        setProperty('deadmario1.offset.x', -55)
    end
    if (curBeat >= 330 and curBeat % 2 == 0) then
        playAnim('deadmario2', 'idle', true)
        setProperty('deadmario2.offset.x', -55)
    end
end