addCharacterToList('mxV2', 'dad')

function onCreate()
    addHaxeLibrary('FlxText', 'flixel.text')
    setProperty('camZooming', true)
    local x, y = -1940, -1670
    if not lowQuality then
        makeAnimatedLuaSprite('amongusCloud', 'stages/MX/MX_BG_Assets_2', x + 1500, y + 100)
        setScrollFactor('amongusCloud', 0.8, 0.8)
        addAnimationByPrefix('amongusCloud', 'amongus', 'Cloud', 24, true)
        addLuaSprite('amongusCloud')

        makeAnimatedLuaSprite('bigAssBush', 'stages/MX/MX_BG_Assets_2', x + 2300, y + 1350)
        setScrollFactor('bigAssBush', 0.8, 0.8)
        addAnimationByPrefix('bigAssBush', 'what', 'BushIdle', 24, true)
        addAnimationByPrefix('bigAssBush', 'plink', 'BushBlink', 24, false)
        playAnim('bigAssBush', 'what', true)
        addLuaSprite('bigAssBush')

        runTimer('itCanBlink', getRandomInt(5, 10))
    end

    makeLuaSprite('finalStage', 'stages/MX/2', x, y)
    addLuaSprite('finalStage')

    if not lowQuality then
        makeAnimatedLuaSprite('lucasH', 'stages/MX/MX_BG_Assets_1', 1780, -130)
        addAnimationByPrefix('lucasH', 'h', 'LucasHead', 24, true)
        addLuaSprite('lucasH')

        makeAnimatedLuaSprite('lucasB', 'stages/MX/MX_BG_Assets_1', 1400, 375)
        addAnimationByPrefix('lucasB', 'b', 'Lucasody', 24, true)
        addLuaSprite('lucasB')

        makeAnimatedLuaSprite('toad', 'stages/MX/MX_BG_Assets_1', 170, 370)
        addAnimationByPrefix('toad', 't', 'ToadBody', 24, true)
        addLuaSprite('toad')
    
        makeAnimatedLuaSprite('gfBody', 'stages/MX/MX_v2_Assets_gfdiesepico', -1570, 750)
        addAnimationByPrefix('gfBody', 'dead', 'GFDieLoop', 24, true)
        addLuaSprite('gfBody')
        setProperty('gfBody.alpha', 0.001)
        setObjectOrder('gfBody', getObjectOrder('dadGroup') + 1)
    end

    makeAnimatedLuaSprite('MXDialogue', 'stages/MX/MX_Dialogue_Asseta', 0, 0)
    addAnimationByPrefix('MXDialogue', 'far', 'Innocence0', 24, false)
    screenCenter('MXDialogue')
    setProperty('MXDialogue.y', getProperty('MXDialogue.y') + 170)
    scaleObject('MXDialogue', 0.8, 0.8, false)
    setProperty('MXDialogue.alpha', 0.001)
    addLuaSprite('MXDialogue')

    makeLuaSprite('vigStage', 'stages/MX/3', x, y)
    addLuaSprite('vigStage', true)

    makeLuaSprite('fakeStage', 'stages/MX/MXBG1_2', x + 550, y + 550)
    addLuaSprite('fakeStage')

    makeLuaSprite('fakeStageLight', 'stages/MX/MXBG1_3', x + 550, y + 550)
    addLuaSprite('fakeStageLight')
    setObjectOrder('fiStage', getObjectOrder('boyfriendGroup') + 1)

    makeLuaSprite('fiStage', 'stages/MX/1', x, y)
    setProperty('fiStage.alpha', 0.001)
    addLuaSprite('fiStage')
end

function onCreatePost()
    makeLuaSprite('sky_ithink')
    makeGraphic('sky_ithink', 1280 * 7, 720 * 7, 'ffffff') 
    setScrollFactor('sky_ithink',0,0)
    screenCenter('sky_ithink')
    addLuaSprite('sky_ithink',true)
    setProperty('sky_ithink.alpha', 0.001)
    setProperty('sky_ithink.color', getColorFromHex('732E1D'))

    
    makeAnimatedLuaSprite('static', 'Mario_static')
    setGraphicSize('static', screenWidth, screenHeight)
    screenCenter('static')
    addAnimationByPrefix('static', 't', 'static play', 24, true)
    addLuaSprite('static')
    setProperty('static.alpha', 0.001)
    setObjCamEst('static')

    if not lowQuality then
        makeAnimatedLuaSprite('MXTransformation', 'stages/MX/MX_Transformation_Assets', -1200, -970)
        addAnimationByPrefix('MXTransformation', 'transform', 'MX Transformation', 24, false)
        scaleObject('MXTransformation', 0.8, 0.8)
        setProperty('MXTransformation.alpha', 0.001)
        addLuaSprite('MXTransformation', true)
    end
    setObjectOrder('fiStage', getObjectOrder('boyfriendGroup') + 1)

    runHaxeCode([[
        game.gf.x += 220;

        game.dadGroup.x -= 400;
        game.dad.x += 230;
    ]])
    setObjCamEst('MXDialogue')
end


function HA() -- i love this silly thing -meloom
    -- changed to a better one even though use haxe :troll: -tatoraa
    runHaxeCode([[
        var h:FlxText = new FlxText(iconP2.x - 50, iconP2.y, 600, 'HA!', 20);
        h.setFormat(Paths.font("mariones.ttf"), 25, FlxColor.WHITE, 'left');
        h.camera = camHUD;
        h.angle = FlxG.random.float(-20, 20);
        add(h);
        FlxTween.tween(h, {x: h.x - 50, y: h.y + (FlxG.random.bool(50) ? 25 : -25), alpha: 0}, 1, {ease: FlxEase.cubeOut, onComplete: (_) -> remove(h)});
    ]])
end

local mxlaugh = false
local isMX = false
function onUpdate()
    if not lowQuality then
        if getProperty('bigAssBush.animation.curAnim.name') == 'plink' and getProperty('bigAssBush.animation.curAnim.finished') then
            playAnim('bigAssBush', 'what', true)
            runTimer('itCanBlink', getRandomInt(5, 10))
        end
    end

    if isMX then
        local fra = getProperty('iconP2.animation.curAnim.curFrame')
        if not mxlaugh then
            if fra == 1 then
                HA()
                mxlaugh = true
            end
        else
            if fra == 0 then
                mxlaugh = false
            end
        end
    end
end

function onTimerCompleted(t)
    if t == 'itCanBlink' then
        playAnim('bigAssBush', 'plink', true)
    end
    if t == 'dial' then
        doTweenAlpha('MXDialogueAlpha', 'MXDialogue', 1, 0.6, 'sineOut')
        doTweenY('MXDialogueY', 'MXDialogue', 72, 1, 'cubeOut')
        startTween('MXDialogueScale', 'MXDialogue.scale', {x = 1, y = 1}, 1, {ease = 'cubeOut'})
    end
end
function onTweenCompleted(t)
    if t == 'MXDialogueAlphaV' then
        if not getModSetting('noVideoSprite') then startVideoSprite('mxcutscene', 'Powerdownscene') end
    end
end
function onVideoFinished(t)
    if t == 'mxcutscene' then
        setProperty('uiGroup.alpha', 1)
        setProperty('gfBody.alpha', 1)
        setProperty('fiStage.visible', false)
        cameraFlash('camGame', 'ff0000', 1)
    end
end
function onEvent(n,v1,v2)
    if n == 'Triggers Universal' then
        if v1 == '1' then
            setProperty('gfGroup.visible', false)
            startTween('MXDialogueAlphaV', 'MXDialogue', {alpha = 0}, 0.4, {ease = 'cubeOut', onComplete = 'onTweenCompleted', startDelay = 0.15})
        end
        if v1 == '2' then
        end
        if v1 == '7' and getModSetting('noVideoSprite') then
            setProperty('uiGroup.alpha', 1)
            setProperty('gfBody.alpha', 1)
            setProperty('fiStage.visible', false)
            cameraFlash('camGame', 'ff0000', 1)
        end
    end
    if n == 'Triggers Powerdown' then
        if v1 == '0' then
            doTweenAlpha('uiGroupAlpha', 'uiGroup', 0, 1, 'sineOut')
            doTweenAlpha('introTween', 'fiStage', 1, 1, 'sineOut')
            runTimer('dial', 2.1)
            playAnim('MXDialogue', 'far', true)
        end
        if v1 == '3' then
            doTweenAlpha('uiGroupAlpha', 'uiGroup', 0, 0.5, 'sineOut')
            doTweenAlpha('introTween', 'fiStage', 1, 0.5, 'sineOut')
        end
        if v1 == '4' then
            setProperty('sky_ithink.alpha', 0.5)
            doTweenAlpha('HA', 'sky_ithink', 0, 0.25)
            if v2 == '1' then
                setProperty('dad.alpha', 0)
                if not lowQuality then
                    setProperty('MXTransformation.alpha', 1)
                    playAnim('MXTransformation', 'transform', true)
                end
            end
        end
        if v1 == '5' then
            isMX = true
            triggerEvent('Show Song', '0', '')
            setHealth(1)
            doTweenAlpha('uiGroupAlpha', 'uiGroup', 1, 0.3, 'sineOut')
            removeLuaSprite('fakeStage')
            removeLuaSprite('fakeStageLight')
            doTweenAlpha('introTween', 'fiStage', 0, 0.3, 'sineOut')
            setProperty('dad.alpha', 1)
            setProperty('MXTransformation.alpha', 0)
            triggerEvent('Change Character', 'dad', 'mxV2')
            runHaxeCode([[
                game.gf.x += 220;
                game.gf.y -= 160;
                game.dad.y += 70;
            ]])
        end
        if v1 == '6' then
            doTweenAlpha('static', 'static', 1, 2.5)
        end
    end
end
