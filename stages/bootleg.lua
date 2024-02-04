addCharacterToList('bfcave', 0)
addCharacterToList('gfcave', 2)
addCharacterToList('grandcave', '1')
precacheImage('stages/dad7/GrandDad_BGCameo_Assets')
luaDebugMode = true
function onCreate()
    setProperty('introSoundsSuffix', '-null')

    makeLuaSprite('mainBG', nil)
    makeGraphic('mainBG', screenWidth*10, screenHeight*10, '155FD9')
    screenCenter('mainBG')
    setScrollFactor('mainBG', 0, 0)
    addLuaSprite('mainBG')

    makeLuaSprite('startButton', 'stages/dad7/start', 400, 1250)
    setProperty('startButton.antialiasing', false)
    setGraphicSize('startButton', getProperty('startButton.width') * 4, getProperty('startButton.height') * 4, false)
    addLuaSprite('startButton')

    makeLuaSprite('flintBG', 'stages/dad7/flint', 900, 250)
    setProperty('flintBG.antialiasing', false)
    setProperty('flintBG.alpha', 0.001)
    setGraphicSize('flintBG', getProperty('flintBG.width') * 12, getProperty('flintBG.height') * 12, false)
    addLuaSprite('flintBG')

    makeAnimatedLuaSprite('waterBG', 'stages/dad7/Water', 50, 1650)
    addAnimationByPrefix('waterBG', 'e', 'Water idle', 24, true)
    setProperty('waterBG.antialiasing', false)
    setProperty('waterBG.alpha', 0.001)
    setScrollFactor('waterBG', 1.4, 1)
    setGraphicSize('waterBG', getProperty('waterBG.width') * 12, getProperty('waterBG.height') * 12, false)
    addLuaSprite('waterBG')

    makeAnimatedLuaSprite('leGang', 'stages/dad7/Grand_Dad_Girlfriend_Assets_gang', getProperty('gfGroup.x') - 70, getProperty('gfGroup.y') + 110)
    addAnimationByPrefix('leGang', 'woho', 'funnygangIdle', 24, false)
    setProperty('leGang.alpha', 0.001)
    addLuaSprite('leGang')
    setObjectOrder('leGang', getObjectOrder('gfGroup')-1)

    makeLuaSprite('title', 'stages/dad7/gdtitle', -200, -1400)
    setGraphicSize('title', getProperty('title.width') * 0.8, getProperty('title.height') * 0.8, false)
    addLuaSprite('title')

    makeLuaSprite('gdad', 'stages/dad7/Hamster', 50, -1400)
    setGraphicSize('gdad', getProperty('gdad.width') * 0.8, getProperty('gdad.height') * 0.8, false)
    addLuaSprite('gdad')

    setProperty('camHUD.alpha', 0)
end
local lol = true
function onCountdownTick(c)
    if c == 1 then
        playSound('gdstart', 0.6)
        setProperty('countdownReady.visible', false)
    elseif c == 2 then
        setProperty('countdownSet.visible', false)
    elseif c == 3 then
        setProperty('countdownGo.visible', false)
    end
end

function onStartCountdown()
    setProperty('camFollow.x', 850)
    setProperty('camFollow.y', -930)

    makeLuaSprite('blackthingidk', nil)
    makeGraphic('blackthingidk', screenWidth, screenHeight, '000000')
    screenCenter('blackthingidk')
    setObjectCamera('blackthingidk', 'camOther')
    addLuaSprite('blackthingidk')
    startTween('gdadIntro1', 'blackthingidk', {alpha = 0}, 0.5, {startDelay = 1.4, ease = 'quadInOut'})
    startTween('gdadIntro2', 'camGame', {zoom = 0.6}, 2 * (1 / (curBpm / 60)), {startDelay = 1.8, ease = 'expoOut'})
end

function onBeatHit()
    playAnim('leGang', 'woho', true)
    setProperty('startButton.visible', not getProperty('startButton.visible'))
end

function onEvent(n,v1,v2)
    if n == 'Triggers Universal' or n == 'Triggers Nourishing Blood' then
        v1 = tonumber(v1)
        if v1 == 0 then
            cameraFlash('camGame', 'ffffff', 0.5)
            triggerEvent('Change Character', '0', 'bfcave')
            triggerEvent('Change Character', '2', 'gfcave')
            triggerEvent('Change Character', '1', 'grandcave')
            setProperty('flintBG.alpha', 1)
            setProperty('waterBG.alpha', 1)
            setProperty('leGang.alpha', 0)
            setProperty('boyfriendGroup.x', 1258)
            setProperty('boyfriendGroup.y', 480)
            setProperty('gfGroup.x', 593)
            setProperty('gfGroup.y', 393)
            setProperty('dadGroup.x', -1)
            setProperty('dadGroup.y', 556)

            setVar('posValDad', {160, 750})
            setVar('posValBF', {810, 750})
            setVar('bfZoom', 0.4)
            setVar('dadZoom', 0.4)
        end
        if v1 == 1 then
            triggerEvent('Change Character', '0', 'bfGD')
            triggerEvent('Change Character', '2', 'gfGD')
            triggerEvent('Change Character', '1', 'grand')
            setProperty('flintBG.alpha', 0)
            setProperty('waterBG.alpha', 0)
            setProperty('leGang.alpha', 1)
            setProperty('boyfriendGroup.x', 1270)
            setProperty('boyfriendGroup.y', 310)
            setProperty('gfGroup.x', 500)
            setProperty('gfGroup.y', 250)
            setProperty('dadGroup.x', -200)
            setProperty('dadGroup.y', 330)

            setVar('posValDad', {120, 650})
            setVar('posValBF', {1120, 750})
        end
        if v1 == 2 then
            setProperty('leGang.alpha', 1)
            scaleObject('leGang', 0.1, 0.5, false)
            startTween('theGangAppear', 'leGang.scale', {x = 1, y = 1}, 0.25, {ease = 'backOut'})
            doTweenZoom('camGameZoom', 'camGame', 0.7, 0.25, 'backOut')
            --gdRunners.visible = true
            gdRun = true
            gdRunnerRandom = {1, 2, 3, 4, 5, 6, 7}
            gdRunnerRandom = shuffleArray(gdRunnerRandom)
            table.insert(gdRunnerRandom, 8)
            table.insert(gdRunnerRandom, 9)
            table.insert(gdRunnerRandom, 10)

            for i = 1, #gdRunnerRandom do
                GrandDadRunners(getProperty('gfGroup.x') - 100, getProperty('gfGroup.y') - 280, i-1, gdRunnerRandom[i] + 1)
            end
        end
        if v1 == 3 then
            runHaxeCode([[
                var g = game.getLuaObject('gdad');
                FlxTween.tween(g, {y: -1700}, 0.15, {ease: FlxEase.sineOut});
                FlxTween.tween(g, {y: -330}, 0.25, {startDelay: 0.15, ease: FlxEase.sineIn});
                FlxTween.tween(g, {x: -400}, 0.33, {onComplete: (_) -> g.visible = false });
            ]])
        end            
        if v1 == 5 then
            blockzoom = true
        end
        if v1 == 6 then
            blockzoom = false
        end
        if v1 == 7 then
            doTweenZoom('camGameZoom', 'camGame', 0.8, 1.9 * (1 / (curBpm / 60)), 'expoIn')
            setVar('bfZoom', 0.8)
            setVar('dadZoom', 0.8)
        end
        if v1 == 4 then
            lol = false
            setVar('camMove', true)
            setVar('camMoveZoom', true)
        end
    end
end


-- its not working properly :marisad: -meloom
local GDRunners = {}
function GrandDadRunners(x, y, distancePos, animPosRand)
    local animsArray = {
        "buff luigi run",
        "bulk bogan run",
        "fella and nozomi",
        "garfield stuff",
        "marcianito",
        "pantherk walk",
        "protegent",
        "skeletor run",
        "painting",
        "bob ross stuff",
        "pacman run"
    }
    local charName = animsArray[animPosRand]
    local runSpeed = 1
    local distancePosistion
    local playedFunnyAnim = false
    if charName == "bob ross stuff" then
        x = x + 2200
        y = y + 100
    elseif charName == 'bulk bogan run' then
        x = x + 2200
        y = y - 56
    elseif charName == "buff luigi run" then
        x = x + 2200
    elseif charName == "garfield stuff" then
        x = x + 2200
        y = y - 120
    elseif charName == 'protegent' then
        x = x + 2200
        y = y - 110
    elseif charName == 'skeletor run' then
        x = x + 2200
        y = y - 90
    elseif charName == "fella and nozomi" then
        x = x - 2200
        y = y - 41
    elseif charName == "marcianito" then
        x = x - 2200
        y = y - 260
    elseif charName == 'pacman run' then
        x = x - 2200
        y = y + 521
    elseif charName == 'pantherk walk' then
        x = x - 2200
        y = y - 50
    elseif charName == "painting" then
        x = x + 2200
        y = y + 100
        distancePos = distancePos + 1
    end
    local objTag = string.gsub(charName, " ", "_")

    makeAnimatedLuaSprite(objTag, 'stages/dad7/GrandDad_BGCameo_Assets')
    if charName == 'boutta fuggin nut SHIT' then
        addAnimationByIndices(objTag, 'danceRight', 'bg dancer sketch PINK', '15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29')
    elseif charName == 'painting' then
        addAnimationByPrefix(objTag, 'paint', 'bob ross easel', 24, true)
        addAnimationByPrefix(objTag, 'bob ross stuff', 'bob ross stuff', 24, true)
        playAnim(objTag, 'bob ross stuff', true, false, 0)
        setProperty(objTag..'.alpha', 0.001)
    else
        addAnimationByPrefix(objTag, charName, charName, 24, true)
        playAnim(objTag, charName, false, false, getRandomInt(1, 10))
        if charName == 'bob ross stuff' then playAnim(objTag, charName, true, false, 0) end
    end
    y = y + getProperty(objTag..'.height') * ((distancePos * 0.08))

    scaleObject(objTag, 0.3 + (distancePos * 0.08), 0.3 + (distancePos * 0.08))

    distancePosistion = distancePos

    runSpeed = 1 * ((distancePosistion + 4) * 0.6)
    if charName == 'protegent' then runSpeed = runSpeed * 1.5 end

    setProperty(objTag..'.x', x)
    setProperty(objTag..'.y', y)
    addLuaSprite(objTag)
    setObjectOrder(objTag, getObjectOrder('leGang')-1)

    GDRunners[objTag] = {
        runSpeed = runSpeed,
        x = x,
        y = y,
        distancePosistion = distancePos,
        animPosRand = animPosRand,
        charName = charName,
        playedFunnyAnim = playedFunnyAnim
    }
end

function onUpdate(elapsed)
    if lol then
        setProperty('camFollow.x', 850)
        setProperty('camFollow.y', -930)
    end
    if gdRun then
        for objTag, runnerInfo in pairs(GDRunners) do
            if objTag == 'bob_ross_stuff' or objTag == 'bulk_bogan_run' or objTag == 'buff_luigi_run' or objTag == 'garfield_stuff' or objTag == 'protegent' or objTag == 'skeletor_run' or objTag == 'painting' then
                setProperty(objTag..'.x', getProperty(objTag..'.x') - (runnerInfo.runSpeed * elapsed) * 60)
            else
                setProperty(objTag..'.x', getProperty(objTag..'.x') + (runnerInfo.runSpeed * elapsed) * 60)
            end	

            if objTag == 'bob_ross_stuff' or objTag == 'painting' then
                if getProperty(objTag..'.animation.curAnim.curFrame') == 16 then
                    if not runnerInfo.playedFunnyAnim and 600 > getProperty(objTag..'.x') then
                        setProperty(objTag..'.offset.x', 150)
                        setProperty(objTag..'.offset.y', 270)
                        runnerInfo.runSpeed = 0
                        runTimer('funyGDAnimB', 1)
                    end
                else
                    setProperty(objTag..'.animation.curAnim.curFrame', 0)
                end
                if runnerInfo.playedFunnyAnim and getProperty(objTag..'.animation.curAnim.curFrame') == 80 then
                    setProperty(objTag..'.offset.x', 0)
                    setProperty(objTag..'.offset.y', 0)
                    if objTag == 'painting' then
                        playAnim(objTag, 'paint', true)
                        setProperty(objTag..'.offset.x', -66)
                        setProperty(objTag..'.offset.x', -66)
                        setProperty(objTag..'.alpha', 1)
                    end
                end
                if getProperty(objTag..'.animation.curAnim.curFrame') == 0 and getProperty(objTag..'.animation.curAnim.name') ~= 'paint' then
                    runnerInfo.runSpeed = 1 * ((runnerInfo.distancePosistion + 2) * 0.9)
                end
            end

            if objTag == 'garfield stuff' then
                if getProperty(objTag..'.animation.curAnim.curFrame') == 26 then
                    if not runnerInfo.playedFunnyAnim and 1000 > getProperty(objTag..'.x') then
                        runnerInfo.runSpeed = 0
                        runTimer('funyGDAnimG', 1)
                    end
                else
                    setProperty(objTag..'.animation.curAnim.curFrame', 0)
                end
                if getProperty(objTag..'.animation.curAnim.curFrame') == 0 then
                    runnerInfo.runSpeed = 1 * ((distancePosistion + 2) * 0.6)
                end
            end
        end
    end
end

function onTimerCompleted(t)
    if t == 'funyGDAnimB' then
        for objTag, runnerInfo in pairs(GDRunners) do
            if objTag == 'bob_ross_stuff' or objTag == 'painting' then
                runnerInfo.playedFunnyAnim = true
            end
        end
    end
    if t == 'funyGDAnimG' then
        for objTag, runnerInfo in pairs(GDRunners) do
            if objTag == 'garfield stuff' then
                runnerInfo.playedFunnyAnim = true
            end
        end
    end
end

function shuffleArray(array)
    local n = #array
    for i = n, 2, -1 do
        local j = getRandomInt(i, i)
        array[i], array[j] = array[j], array[i]
    end
    return array
end