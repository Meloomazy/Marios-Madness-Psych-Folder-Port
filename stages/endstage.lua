luaDebugMode = true
function onCreate()
    setProperty('skipCountdown', true)

    addCharacterToList('costumedark', 1)
    makeLuaSprite('mainBG', 'stages/costume/PedacitoDeGris', -1200, -770)
    setScrollFactor('mainBG', 0.5, 1)
    addLuaSprite('mainBG')

    makeLuaSprite('mainFloor', 'stages/costume/Floor and Courtains', -1200, -770)
    addLuaSprite('mainFloor')

    makeLuaSprite('table', 'stages/costume/mesa mesa mesa que mas aplauda', -1200, -770)
    addLuaSprite('table')

    makeLuaSprite('foreground', 'stages/costume/Foreground', -1400, -300)
    setScrollFactor('foreground', 1.4, 1.4)
    addLuaSprite('foreground',true)

    makeLuaSprite('lamp', 'stages/costume/Lamp', -1200, -770)
    addLuaSprite('lamp',true)
    
    makeLuaSprite('blackthingidk', nil)
    makeGraphic('blackthingidk', screenWidth*10, screenHeight*10, '000000')
    screenCenter('blackthingidk')
    addLuaSprite('blackthingidk',true)

    makeLuaSprite('endImg', 'stages/costume/end', 0, 0)
    screenCenter('endImg')
    setProperty('endImg.alpha', 0.001)
    addLuaSprite('endImg', true)

    makeLuaSprite('endText', 'stages/costume/endtext', 0, 0)
    screenCenter('endText')
    setProperty('endText.alpha', 0.001)
    addLuaSprite('endText', true)

    makeAnimatedLuaSprite('letsago', 'stages/costume/Costume_Letsago')
    addAnimationByPrefix('letsago', 'go', 'Lets A Go', 24, false)
    setProperty('letsago.alpha', 0.001)
    addLuaSprite('letsago')


    makeLuaText('scoreHealth', 'H:50\nS: 0', 1280, -100, 565)
    setTextSize('scoreHealth', 70)
    setTextAlignment('scoreHealth', 'right')
    setTextBorder('scoreHealth', 0, '000000')
    addLuaText('scoreHealth')

    makeLuaText('ratingText', '', 1280, 150, 365)
    setTextSize('ratingText', 70)
    setTextAlignment('ratingText', 'left')
    setTextBorder('ratingText', 0, '000000')
    screenCenter('ratingText')
    setProperty('ratingText.x', getProperty('ratingText.x') + 50)
    addLuaText('ratingText')

    makeLuaText('dateText', 'SEP.02 97', 1280, 65, 625)
    setTextSize('dateText', 70)
    setTextAlignment('dateText', 'LEFT')
    setTextBorder('dateText', 0, '000000')
    addLuaText('dateText')
end

function onCreatePost()
    setProperty('showRating', false)
    setProperty('showComboNum', false)

    setProperty('uiGroup.visible', false)
    setProperty('camHUD.alpha', 0)
    setObjCamEst('endImg')
    setObjCamEst('letsago')
    setObjCamEst('endText')
end

function goodNoteHitPost(id, dir, type, sus)
    if not sus then
        local rating = botplay and 'SICK' or getPropertyFromGroup('notes', id, 'rating'):upper()
        setTextString('ratingText', rating..'\n'..combo)
        runTimer('blankRating', 0.7)
    end
end

function onUpdate()
    setTextString('scoreHealth', 'H: '..(math.floor((getHealth() / 2)*100))..'\nS: '..score)
end

function onTimerCompleted(t)
    if t == 'blankRating' then
        setTextString('ratingText','')
    end
end

function onEvent(n,v1,v2)
    if n == 'Triggers Universal' or n == 'Triggers The End' then   
        v1 = tonumber(v1) 
        if v1 == 0 then
            doTweenAlpha('introEndText', 'endImg', 1, 2)
        end
        if v1 == 1 then
            doTweenAlpha('introEndTextG', 'endImg', 0, 4)
        end
        if v1 == 2 then
            setProperty('blackthingidk.alpha', 0.6)
            setProperty('camHUD.alpha', 1)
            setProperty('endImg.alpha', 0)
        end
        if v1 == 3 then
            setVar('posValDad', {200, getVar('posValDad')[2]})
        end
        if v1 == 4 then
            doTweenAlpha('blackbar', 'blackthingidk', 1, 0.8)
        end
        if v1 == 5 then
            setProperty('letsago.alpha', 1)
            playAnim('letsago', 'go', true)
        end
        if v1 == 6 then
            setProperty('letsago.alpha', 0)
            doTweenAlpha('lampT', 'lamp', 1, 0.2)
            doTweenAlpha('blackthingidk', 'blackthingidk', 0, 0.2)

            setVar('posValDad', {420, 350})
        end
        if v1 == 7 then
            doTweenAlpha('lampT', 'lamp', 0, 0.6)
            doTweenAlpha('blackthingidk', 'blackthingidk', 1, 0.6)
            doTweenAlpha('camHUDT', 'camHUD', 0, 0.6)
        end
        if v1 == 8 then
            setProperty('boyfriend.visible', false)
            setVar('posValDad', {180, getVar('posValDad')[2]})
        end
        if v1 == 9 then
            setVar('bfZoom', 1)
            setVar('dadZoom', 1)

            setProperty('foreground.visible', false)
            setProperty('mainBG.visible', false)
            setProperty('mainFloor.visible', false)
            setProperty('table.visible', false)
            setProperty('blackthingidk.alpha', 0)
        end
        if v1 == 9.5 then
            triggerEvent('Triggers Universal', '9', '')
            triggerEvent('Change Character', '1', 'costumedark')
            triggerEvent('Play Animation', 'wahoo', 'dad')
        end
        if v1 == 10 then 
            doTweenAlpha('camHUDT', 'camHUD', 1, 0.6)
            setVar('bfZoom', 1.1)
            setVar('dadZoom', 1.1)
        end
        if v1 == 11 then
            doTweenAlpha('blackbar', 'blackthingidk', 1, 0.6)
            doTweenAlpha('camHUDT', 'camHUD', 0, 1)
        end
    end
end