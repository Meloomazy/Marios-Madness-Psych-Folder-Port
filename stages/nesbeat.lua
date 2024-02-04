local smb = {'smbCastTop', 'smbCastBot', 'smbPlat', 'smbLava'}
local duck = {'sky_ithink', 'dhTree', 'dhBush', 'dhGrass'}

function onCreate()
    setProperty('guitarHeroSustains', false)
    setProperty('introSoundsSuffix', '-null')
-- super mario bros

    makeLuaSprite('smbCastTop', 'stages/beatus/castle2')
    scaleObject('smbCastTop', 5, 5)
    screenCenter('smbCastTop')
    setProperty('smbCastTop.y', getProperty('smbCastTop.y') - 650)
    setProperty('smbCastTop.antialiasing', false)
    addLuaSprite('smbCastTop')

    makeLuaSprite('smbCastBot', 'stages/beatus/castle')
    scaleObject('smbCastBot', 5, 5)
    screenCenter('smbCastBot')
    setProperty('smbCastBot.y', getProperty('smbCastBot.y') + 600)
    setProperty('smbCastBot.antialiasing', false)
    addLuaSprite('smbCastBot')

    makeLuaSprite('smbPlat', 'stages/beatus/platnes')
    scaleObject('smbPlat', 5, 5)
    screenCenter('smbPlat')
    setProperty('smbPlat.x', getProperty('smbPlat.x') + 900)
    setProperty('smbPlat.antialiasing', false)
    addLuaSprite('smbPlat')

    makeAnimatedLuaSprite('smbLava','stages/beatus/neslava')
    addAnimationByPrefix('smbLava', 'idle', 'lava hot ow ow its too hot aaa', 12, true)
    scaleObject('smbLava', 5, 5)
    screenCenter('smbLava')
    setScrollFactor('smbLava', 1.5, 0.8)
    setProperty('smbLava.y', getProperty('smbLava.y') + 940)
    setProperty('smbLava.antialiasing', false)
    addLuaSprite('smbLava')

-- hunt dog
    makeLuaSprite('sky_ithink')
    makeGraphic('sky_ithink', 1280 * 2, 720 * 2, 'ffffff') -- :sunglasses:
    screenCenter('sky_ithink')
    addLuaSprite('sky_ithink')
    setProperty('sky_ithink.color', getColorFromHex('73aafd'))

    makeLuaSprite('dhTree','stages/beatus/tree')
    scaleObject('dhTree', 6, 6)
    screenCenter('dhTree')
    setProperty('dhTree.x', getProperty('dhTree.x') - 900)
    setProperty('dhTree.y', getProperty('dhTree.y') - 20)
    setProperty('dhTree.antialiasing', false)
    addLuaSprite('dhTree')

    makeLuaSprite('dhBush','stages/beatus/arbust')
    scaleObject('dhBush', 6, 6)
    screenCenter('dhBush')
    setProperty('dhBush.x', getProperty('dhBush.x') + 940)
    setProperty('dhBush.y', getProperty('dhBush.y') + 170)
    setProperty('dhBush.antialiasing', false)
    addLuaSprite('dhBush')

    makeLuaSprite('dhGrass','stages/beatus/grass')
    scaleObject('dhGrass', 6, 6)
    screenCenter('dhGrass')
    setProperty('dhGrass.y', getProperty('dhGrass.y') + 460)
    setScrollFactor('dhGrass', 1.5, 0.8)
    setProperty('dhGrass.antialiasing', false)
    addLuaSprite('dhGrass')

-- mr sys
    makeLuaSprite('bgBar','bars')
    scaleObject('bgBar', 3, 3)
    screenCenter('bgBar')
    addLuaSprite('bgBar')

    makeAnimatedLuaSprite('clownCar','stages/beatus/Clown_Car')
    addAnimationByPrefix('clownCar', 'idle', 'clown car anim', 12, true)
    scaleObject('clownCar', 40, 40) -- huh ok
    screenCenter('clownCar')
    setProperty('clownCar.x', getProperty('clownCar.x') + 50)
    setProperty('clownCar.y', getProperty('clownCar.y') + 250)
    setProperty('clownCar.antialiasing', false)
    setProperty('clownCar.alpha', 0.001)
    addLuaSprite('clownCar')

-- finale
    makeAnimatedLuaSprite('finaleStaticDuck','stages/beatus/staticbg')
    addAnimationByPrefix('finaleStaticDuck', 'idle', 'staticbg duck', 12, true)
    scaleObject('finaleStaticDuck', 2.5, 2.5)
    screenCenter('finaleStaticDuck')
    setProperty('finaleStaticDuck.antialiasing', false)
    setProperty('finaleStaticDuck.x', getProperty('finaleStaticDuck.x'))
    setProperty('finaleStaticDuck.y', getProperty('finaleStaticDuck.y') + 100)
    setProperty('finaleStaticDuck.alpha', 0.001)
    addLuaSprite('finaleStaticDuck')

    makeAnimatedLuaSprite('finaleStaticCastle','stages/beatus/staticbg')
    addAnimationByPrefix('finaleStaticCastle', 'idle', 'staticbg castle', 12, true)
    scaleObject('finaleStaticCastle', 2.5, 2.5)
    screenCenter('finaleStaticCastle')
    setProperty('finaleStaticCastle.antialiasing', false)
    setProperty('finaleStaticCastle.x', getProperty('finaleStaticCastle.x'))
    setProperty('finaleStaticCastle.y', getProperty('finaleStaticCastle.y') + 100)
    setProperty('finaleStaticCastle.alpha', 0.001)
    addLuaSprite('finaleStaticCastle')

    makeAnimatedLuaSprite('static','stages/beatus/static')
    addAnimationByPrefix('static', 'idle', 'static idle', 12, true)
    scaleObject('static', 1.2, 1.2)
    screenCenter('static')
    setProperty('static.x', getProperty('static.x'))
    setProperty('static.y', getProperty('static.y') + 100)
    setProperty('static.antialiasing', false)
    setProperty('static.alpha', 0.001)
    addLuaSprite('static')
-- whart
    makeLuaSprite('darkbg')
    makeGraphic('darkbg', 1280 * 3, 720 * 3, 'ffffff') -- yeah
    screenCenter('darkbg')
    setProperty('darkbg.alpha',1)
    setProperty('darkbg.color', getColorFromHex('000000'))
    addLuaSprite('darkbg')

-- ui stuff
    -- maybe aruma was right, static are now transitioning...
    makeAnimatedLuaSprite('staticTrans','Mario_static')
    addAnimationByPrefix('staticTrans', 'static', 'static play', 24, true)
    setObjectCamera('staticTrans','camHUD')
    setProperty('staticTrans.alpha', 0.001)
    setGraphicSize('staticTrans', screenWidth, screenHeight)
    screenCenter('staticTrans')
    addLuaSprite('staticTrans')

    makeLuaSprite('duckCH','stages/beatus/duckCrosshair')
    setProperty('duckCH.alpha', 0.001)
    scaleObject('duckCH', 10, 10)
    screenCenter('duckCH')
    setObjectCamera('duckCH','camOther')
    setProperty('duckCH.antialiasing', false)
    addLuaSprite('duckCH')

    makeLuaText('textNint', '', 1280, 0, 0)
    setTextBorder('textNint', 0, 'ffffff')
    setTextAlignment('textNint', 'center')
    setTextFont('textNint', 'Pixel NES.otf')
    setTextSize('textNint', 165)
    screenCenter('textNint')
    setScrollFactor('textNint', 0, 0)
    addLuaText('textNint')
    setObjectCamera('textNint', 'camGame')
    setObjectOrder('textNint', getObjectOrder('gfGroup'))

-- silly nintendo intro
    makeAnimatedLuaSprite('nintIntro','stages/beatus/intro')
    addAnimationByPrefix('nintIntro', 'play', 'intro start', 24, false)
    setProperty('nintIntro.alpha', 0.001)
    scaleObject('nintIntro', 3,3)
    setScrollFactor('nintIntro', 0, 0)
    screenCenter('nintIntro')
    addLuaSprite('nintIntro')

    lofiTweensToBeCreepyTo()
    runTimer('barsMovement', 21.5)
end
local fireBarY
function onCreatePost()
    fireBarY = (downscroll and getProperty('healthBar.y') - 670 or getProperty('healthBar.y') + 570)
    triggerEvent('Camera Follow Pos', '670', '460')
    for a = 1,4 do -- but why though, why must it be 4 sprites? :sob:
        makeAnimatedLuaSprite('fireBar'..a,'stages/beatus/firebar', 70, fireBarY)
        addAnimationByPrefix('fireBar'..a, 'l', 'firebar loop', 8, false)
        setProperty('fireBar'..a..'.antialiasing', false)
        scaleObject('fireBar'..a, 6, 6)
        setObjectCamera('fireBar'..a,'camHUD')
        addLuaSprite('fireBar'..a, true)

        if a == 2 then
            setProperty('fireBar2.visible', false)
            setProperty('fireBar2.flipY', true)
        end
        if a == 3 then
            setProperty('fireBar3.visible', false)
            setProperty('fireBar3.flipX', true)
            setProperty('fireBar3.flipY', true)
        end
        if a == 4 then
            setProperty('fireBar4.visible', false)
            setProperty('fireBar4.flipX', true)
        end
    end
end
intro = true
function onStartCountdown(t)
    if intro then
        setProperty('dadGroup.visible', false)
        setProperty('camHUD.alpha', 0)
        onSectionHit()
        setProperty('dadGroup.visible')
        playSound('nintIntro', 0.4)
        setProperty('darkbg.alpha', 1)
        setProperty('nintIntro.alpha', 1)
        playAnim('nintIntro', 'play', true)
    end
end
function onSongStart()
    if intro then
        doTweenAlpha('int1', 'nintIntro', 0, 1)
    end
end
function onStepHit()
    if curStep == 20 then
        doTweenAlpha('int2', 'darkbg', 0, 10)
    end
    if curStep == 104 then
        doTweenAlpha('int3', 'camHUD', 1, 3)
    end
end

function transition(mustHit, char)
    setProperty('staticTrans.alpha', 0.7)
    doTweenAlpha('staticTransAlpha','staticTrans',0.1,0.47)

    if not char then
        setProperty('darkbg.alpha',(mustHit and 0.4 or 0))
        setProperty('boyfriendGroup.visible', mustHit)
        setProperty('gfGroup.visible', mustHit)
        setProperty('dadGroup.visible', not mustHit)
    end
end

local level = 1
function onSectionHit()
    if mustHitSection then
        if isDad then
            isDad = false
            transition(true)
        end
    else
        if not isDad then
            isDad = true
            transition(false)
        end
    end
end

local frb = 0
local bobm = 0
local duc = 0

local textBlack = false
local bowserMech = false
function onEvent(n,v1,v2)
    if n == 'Triggers Unbeatable' then
        if v1 == '3' then
            setProperty('sky_ithink.color', getColorFromHex('CF8C74'))
            runTimer('thefogiscoming', 0.18)
            cameraShake('camHUD', 0.007, 0.05, true)
            cameraShake('camGame', 0.007, 0.05, true)
        end
        if v1 == '4' then
            duc = duc + 1
            local tag = 'ducks'..duc
            local dc = getRandomInt(1, 3) - 1
            local path = {
                p1 = {x = {getProperty('dhTree.x') + 200, getProperty('dhTree.x') + 550}, y = {600, -200}, anim = 'up', flip = false},
                p2 = {x = {-400, 1450}, y = {-100, 380}, anim = 'fly', flip = false},
                p3 = {x = {1450, -400}, y = {-100, 380}, anim = 'fly', flip = true},
                p4 = {x = {1450, 400}, y = {150, -200}, anim = 'up', flip = true}
            }
            local pathNames = {} for name, _ in pairs(path) do table.insert(pathNames, name) end
            local actualPathName = pathNames[getRandomInt(1, #pathNames)]
            local actualPath = path[actualPathName]
            makeAnimatedLuaSprite(tag, 'stages/beatus/duck'..dc, actualPath.x[1], actualPath.y[1])
            addAnimationByPrefix(tag, actualPath.anim, 'duck '..actualPath.anim, 12, true)
            scaleObject(tag, 6, 6)
            setProperty(tag..'.antialiasing', false)
            setObjectOrder(tag, getObjectOrder('dhGrass'))
            addLuaSprite(tag)
            setProperty(tag..'.flipX', actualPath.flip)
            doTweenX(tag..'tweenX', tag, actualPath.x[2], 2.5, 'linear')
            doTweenY(tag..'tweenY', tag, actualPath.y[2], 2.5, 'linear')
        end
    end
    if n == 'ycbu text' then
        local valText = v1
        valText = valText:gsub(';', '\n')
        setTextString('textNint', valText)
        screenCenter('textNint')
        setTextColor('textNint', 'FFA200')
        textBlack = v2 == '1'
        runTimer('textNintColor', 0.07)
    end
    if n == 'Triggers Universal' then
        if v1 == '25s' then
            setTextString('textNint', '')
        end
        if v1 == '21' then
            bowserMech = true
            doTweenY('bowserMech', 'fireBar1', getProperty('healthBar.y') - 170, 1.2, 'backOut')
        end
        if v1 == '22' then
            bowserMech = false
            doTweenY('bowserMech', 'fireBar1', fireBarY, 1, 'backIn')
        end
        if v1 == '31' then
            local right = (v2 == '1' and true or false)
            bobm = bobm + 1
            local tag = 'bobm'..bobm
            makeLuaSprite(tag,'stages/beatus/bullet', (right and -100 or 1320), getRandomInt(40, 680))
            scaleObject(tag, 7, 7)
            setProperty(tag..'.antialiasing', false)
            setObjectCamera(tag, 'camHUD')
            addLuaSprite(tag, true)    
            setProperty(tag..'.flipX', right)
            doTweenX(tag..'tween'..bobm, tag, (right and 1320 or -100), 1.5,'linear')
        end
        if v1 == '32' then
            frb = frb + 1
            local tag = 'frb'..frb
            makeLuaSprite(tag, 'stages/beatus/fire')
            scaleObject(tag, 6, 6)
            setProperty(tag..'.antialiasing', false)
            addLuaSprite(tag)  
            if v2 == '' then
                setProperty('sky_ithink.color', getColorFromHex('FF5417'))
                doTweenColor('sky_ithink', 'sky_ithink', '000000', 0.25)    
                triggerEvent('Triggers Universal', '32', '2')
                setProperty(tag..'.x', getRandomInt(125, 275))
                setProperty(tag..'.y', 900)
            elseif v2 == '1' then
                setProperty(tag..'.x', getRandomInt(25, 350))
                setProperty(tag..'.y', 900)
            elseif v2 == '2' then
                setProperty(tag..'.x', getRandomInt(775, 1100))
                setProperty(tag..'.y', 900)
            end
            -- plan b: we are gonna use haxe because lua method didn't work - Tatoraa
            runHaxeCode([[
                var g = game.getLuaObject(']]..tag..[[');
                FlxTween.tween(g, {angle: FlxG.random.bool(50) ? 180 : -180}, (0.5 / (Conductor.bpm / 60)), {startDelay: (0.75 / (Conductor.bpm / 60)), ease: FlxEase.quadInOut});
                FlxTween.tween(g, {y: 300}, (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween){
                    FlxTween.tween(g, {y: 900}, (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween){
                       
                    }});
                }});
            ]])
        end
    end
    if n == 'random bs' then
        if v1 == 'score' then
            setProperty('bgBar.alpha',0)
        end
        if v1 == 'robot' then
            transition()      
            setProperty('ycbu_hunter.alpha', 0)
        end
        if v1 == 'zapper' then
            transition()      
            setProperty('finaleStaticDuck.alpha', 0)
            setProperty('static.alpha', 0)
            setProperty('finaleStaticCastle.alpha', 0)
            setProperty('bgBar.alpha',1)
            setProperty('ycbu_hunter.alpha', 0)
            setProperty('ycbu_bowser.alpha', 0)
        end
        if v1 == 'bglol' then
            setProperty('camHUD.visible', true)
            setProperty('gf.alpha', 1)
            setProperty('boyfriend.alpha', 1)
            setTextColor('textNint', 'ffffff')
            doTweenAlpha('iforgor', 'darkbg', 0, 0.3)
        end
        if v1 == 'we are' then
            iconTurn('sys')
            setTextString('textNint','')
            setProperty('darkbg.visible',false)
            setProperty('bgBar.visible',false)
        end
        if v1 == 'world' or v1 == 'zapper' or v1 == 'score' or v1 == 'robot' or v1 == 'we are' then
            iconTurn('sys')
            setProperty('dad.alpha', 1)
            setProperty('darkbg.visible',false)
            setTextColor('textNint', 'ffffff')
        end
        if v1 == 'beat idk' or v1 == 'robot birdup' or v1 == 'world lakitu' or v1 == 'zapper duck' or v1 == 'score' then
            setProperty('dad.alpha', 0)
            setProperty('darkbg.visible',true)
            setProperty('darkbg.alpha',1)
            setProperty('darkbg.color', getColorFromHex('ffffff'))

            setTextColor('textNint', '000000')
        end
        if v1 == 'zapper duck' then
            iconTurn('hunter')
            setHealth(1.5)
        end
        if v1 == 'robot birdup' then
            setHealth(1)
        end
        if v1 == 'world lakitu' then
            setHealth(0.5)
        end
        if v1 == 'score bowser' then
            iconTurn('bowser')
            setHealth(0.2)
        end
        if v1 == 'bye' then
            setProperty('bgBar.alpha', 0)
            setProperty('ycbu_hunter.alpha', 1)
            setProperty('ycbu_bowser.alpha', 1)
            setProperty('dad.alpha', 0)
            setProperty('gf.alpha', 0)
            setProperty('boyfriend.alpha', 0)
            setProperty('camHUD.visible', false)
        end
        if v1 == 'suit guy' then
            iconTurn('sys')
            setProperty('bgBar.alpha', 1)
            setProperty('ycbu_hunter.alpha', 0)
            setProperty('ycbu_bowser.alpha', 0)
            doTweenAlpha('hello_suitguy', 'dad', 1, 1)
        end
        if v1 == 'hunter dog' then
            iconTurn('hunter')
            setProperty('ycbu_hunter.alpha', 1)
            setProperty('ycbu_bowser.alpha', 0)
            setProperty('dad.alpha', 0)
            setProperty('finaleStaticDuck.alpha', 1)
            setProperty('static.alpha', 1)
        end
        if v1 == 'bowser' then
            iconTurn('bowser')
            setProperty('ycbu_hunter.alpha', 0)
            setProperty('ycbu_bowser.alpha', 1)
            setProperty('dad.alpha', 0)
            setProperty('finaleStaticCastle.alpha', 1)
        end
        if v1 == 'end' then
            setTextString('textNint','')
            cameraFlash('camGame','fffff', 0.2)
            setProperty('ycbu_hunter.alpha', 0)
            setProperty('ycbu_bowser.alpha', 0)
            setProperty('dad.alpha', 0)
            setProperty('finaleStaticDuck.alpha', 0)
            setProperty('static.alpha', 0)
            setProperty('finaleStaticCastle.alpha', 0)
            setProperty('bgBar.alpha', 0.15)
        end
        if v1 == 'end suit' then
            setHealth(1)
            iconTurn('sys')
            setProperty('dad.alpha', 1)
            setProperty('bgBar.alpha', 1)
        end
        if v1 == 'end duck' then
            setHealth(1.5)
            iconTurn('hunter')
            setProperty('ycbu_hunter.alpha', 1)
            setProperty('finaleStaticDuck.alpha', 1)
            setProperty('static.alpha', 1)
            setProperty('dad.alpha', 0)
            setProperty('bgBar.alpha', 1)
        end
        if v1 == 'duo' then
            iconTurn('sys')
            setHealth(1)
        end
        if v1 == 'end bowser' then
            iconTurn('bowser')
            setProperty('ycbu_bowser.alpha', 1)
            setProperty('finaleStaticCastle.alpha', 1)
        end
        if v1 == 'duckCrosshair' then
            if v2 == 'lol' then
                setProperty('camGame.visible',false)
                setProperty('camHUD.visible',false)
                setProperty('duckCH.alpha', 1)
                setProperty('duckCH.color', (getProperty('duckCH.color') == getColorFromHex('FF0000') and getColorFromHex('FFFFFF') or getColorFromHex('FF0000')))
            else
                removeLuaSprite('duckCH', false)
                setProperty('camGame.visible',true)
                setProperty('camHUD.visible',true)
            end
        end
        if v1 == 'bowserClownCar' then
            for o = 1, #smb do
                removeLuaSprite(smb[o], false)
            end
            for o = 1, #duck do
                removeLuaSprite(duck[o], false)
            end
            runTimer('clowncar',0.2)
        end
        if v1 == 'beat me' then
        end
    end
    if n == 'level' then
        level = tonumber(v1)
        if v1 == '2' then
            runTimer('holdDuckHunt',1)
        end
        if v1 == '3' then
            runTimer('holdSMB',0.3)
        end
    end
end
function onTimerCompleted(t)
    if t == 'barsMovement' then
        lofiTweensToBeCreepyTo()
    end
    if t == 'thefogiscoming' then
        setProperty('sky_ithink.color', getColorFromHex('73aafd'))
    end
    if t == 'textNintColor' then
        setTextColor('textNint', (textBlack and '000000' or 'ffffff'))
    end
    if t == 'clowncar' then
        setProperty('clownCar.alpha', 1)
        setProperty('bgBar.alpha', 0.3)
        startTween('clownCarBIGASS','clownCar.scale', {x = 1, y = 1}, 3, {ease = 'expoOut'})
        doTweenY('clowCarMOVEYOUBIGASS', 'clownCar', -600, 3, 'expoInOut')
    end
    if t == 'holdDuckHunt' then
        doTweenAlpha('bgBarDuckHunt','bgBar',0,1)
    end
    if t == 'holdSMB' then
        doTweenY('dhTreeY','dhTree', getProperty('dhTree.y') + 1000, 2, 'quadOut')
        doTweenY('dhBushY','dhBush', getProperty('dhBush.y') + 1000, 2, 'quadOut')
        doTweenY('dhGrassY','dhGrass', getProperty('dhGrass.y') + 1000, 2, 'quadOut')
        doTweenAlpha('dhSkyAlpha','sky_ithink', 0, 2, 'quadOut')
        runTimer('smbStage', 0.5)
    end
    if t == 'smbStage' then
        doTweenY('smbCastTopY','smbCastTop', -130, 2, 'expoOut')
        doTweenY('smbCastBotY','smbCastBot', -140, 2, 'expoOut')
        doTweenX('smbPlatX', 'smbPlat', 610, 2.2, 'expoOut')
    end
end
function onTweenCompleted(t)
    if t == 'iforgor' then
        setProperty('darkbg.color', getColorFromHex('000000'))
    end

    for b = 1,duc do
        local tag = 'ducks'..b
        if t == 'ducks'..b..'tweenX' then
            removeLuaSprite(tag)
        end
    end
    if t == 'smbLavaYlmoa' then
        setProperty('sky_ithink.alpha', 1)
        setObjectOrder('sky_ithink', getObjectOrder('smbCastTop'))
        setProperty('sky_ithink.color', getColorFromHex('000000'))

        startTween('smbLavaYReal','smbLava', {y = 760}, 2, {ease = 'elasticInOut', startDelay = 0.5})
    end
    if t == 'smbCastBotY' then
        doTweenY('smbLavaYlmoa','smbLava', 500, 1.3, 'cubeInOut')
    end
    if t == 'smbPlatX' then
        startTween('smbPlatMoving','smbPlat', {x = 860}, 2, {type = "PINGPONG", startDelay = 1.2})
    end
    if t == 'bgBarDuckHunt' then
        doTweenX('dhTreeX','dhTree', 33, 1.8, 'cubeOut')
        doTweenX('dhBushX','dhBush', 772, 1.8, 'cubeOut')
    end
end
function onUpdate()
    local fireBarProperties = {
        {'fireBar1', 'fireBar2', true, 2},
        {'fireBar2', 'fireBar3', false, 0},
        {'fireBar3', 'fireBar4', true, 1},
        {'fireBar4', 'fireBar1', false, 0},
    }

    for _, properties in ipairs(fireBarProperties) do
        local currentBar, nextBar, force = unpack(properties)

        if getProperty(currentBar .. '.animation.curAnim.finished') and getProperty(currentBar .. '.visible') then
            setProperty(currentBar .. '.visible', false)
            setProperty(nextBar .. '.visible', true)
            playAnim(nextBar, 'l', true, force, fr)
        end
    end

    for i = 2,4 do
        setProperty('fireBar'..i..'.y', getProperty('fireBar1.y'))
    end

    if bowserMech then
        runHaxeCode([[
            if (FlxG.pixelPerfectOverlap(game.modchartSprites.get('fireBar1'), game.iconP1) && !getModSetting('noMechs')){
                setVar('icAng', getVar('icAng') - 0.4);
                if (getVar('icAng') < 4) setVar('icAng', 4);
                game.iconP1.angle = 8 * Math.sin(Conductor.songPosition/getVar('icAng'));
                game.health -= 0.01;
                game.iconP1.color = 0x3E3E3E;
            }else{
                game.iconP1.angle = 0;
                setVar('icAng', 10);
                game.iconP1.color = 0xffffff;
            }
        ]])
    end
end

-- tween abomination -Tatoraa
function lofiTweensToBeCreepyTo()
    runHaxeCode([[
        var nesTweens = [];
        var sprite = game.getLuaObject('bgBar');

        var tempx = sprite.x;
		// this tween chain is an abomination
		nesTweens.push(FlxTween.tween(sprite, {x: tempx + 420, angle: -35}, 4.0, {
			onComplete: function(tween:FlxTween)
			{
				nesTweens.push(FlxTween.tween(sprite, {angle: 20}, 2.0, {
					onComplete: function(tween:FlxTween)
					{
						nesTweens.push(FlxTween.tween(sprite, {x: tempx + 400, angle: 30}, 2.0, {
							onComplete: function(tween:FlxTween)
							{
								nesTweens.push(FlxTween.tween(sprite, {x: tempx + 420, angle: 0}, 2.0, {
									onComplete: function(tween:FlxTween)
									{
										nesTweens.push(FlxTween.tween(sprite, {x: tempx + 520, angle: -15}, 3.0, {
											onComplete: function(tween:FlxTween)
											{
												nesTweens.push(FlxTween.tween(sprite, {angle: 10}, 1.5, {
													onComplete: function(tween:FlxTween)
													{
														nesTweens.push(FlxTween.tween(sprite, {x: tempx - 50, angle: -40}, 5.5, {
															onComplete: function(tween:FlxTween)
															{
																nesTweens.push(FlxTween.tween(sprite, {x: tempx, angle: 0}, 1.5));
															}
														}));
													}
												}));
											}
										}));
									}
								}));
							}
						}));
					}
				}));
			}
		}));
    ]])
end