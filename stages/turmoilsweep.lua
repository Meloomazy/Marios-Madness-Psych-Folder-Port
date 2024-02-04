function onCreate()
    setProperty('skipCountdown', true)
    makeLuaSprite('farTree', 'stages/Turmoil/ThirdBGTrees', -1300, -750)
    setScrollFactor('farTree', 0.5, 0.5)
    addLuaSprite('farTree')

    makeLuaSprite('backTree', 'stages/Turmoil/SecondBGTrees', -1300, -750)
    setScrollFactor('backTree', 0.8, 0.8)
    addLuaSprite('backTree')

    makeLuaSprite('floor', 'stages/Turmoil/MainFloorAndTrees', -1300, -750)
    addLuaSprite('floor')

    makeLuaSprite('treeLeaves', 'stages/Turmoil/TreeLeaves', -1300, -350)
    setScrollFactor('treeLeaves', 1.9, 1.9)
    addLuaSprite('treeLeaves')

    makeLuaSprite('foreground', 'stages/Turmoil/TreesForeground', -1300, -350)
    setScrollFactor('foreground', 1.4, 1.4)
    addLuaSprite('foreground')

    makeLuaSprite('vignette', 'modstuff/126')
    screenCenter('vignette')
    addLuaSprite('vignette')

    makeLuaSprite('blackBar', nil)
    makeGraphic('blackBar', screenWidth, screenHeight, '000000')
    screenCenter('blackBar')
end
function onCreatePost()
    setProperty('camHUD.alpha', 0)
    addLuaSprite('blackBar')
    setObjCamEst('vignette')
    setObjCamEst('blackBar')
end
function onSongStart()
    startTween('blackbarAlpha', 'blackBar', {alpha = 0}, 4, {startDelay = 1, ease = 'quadInOut'})
    startTween('buttonwarnAlpha', 'buttonwarn', {alpha = 0}, 2, {startDelay = 3, ease = 'quadInOut'})
end


function onEvent(n,v1,v2)
    if n == 'Triggers Universal' or n == 'Triggers Last Course' then
        v1 = tonumber(v1)
        if v1 == 0 then
            setVar('camMoveZoom', false)
            setProperty('camGame.zoom', 1.2)
            setVar('bfZoom', 1.2)
            setVar('dadZoom', 1.2)
            setProperty('defaultCamZoom', 1.2)
            doTweenZoom('camGameZoom','camGame', 1, 5, 'cubeInOut')
        end
        if v1 == 2 then
            setVar('camMove', false)
            setVar('bfZoom', 0.9)
            setVar('dadZoom', 0.9)
            setProperty('defaultCamZoom',0.9)
            doTweenZoom('camGameZoom','camGame', 0.9, 6.4, 'cubeInOut')
            doTweenX('camFollowX', 'camFollow', 420, 5, 'cubeInOut')
            doTweenX('camFollowY', 'camFollow', 500, 5, 'cubeInOut')
        end
        if v1 == 3 then
            setVar('camMoveZoom', true)
            setVar('camMove', true)
        end
        if v1 == 4 then
            setVar('posValBF', {600, getVar('posValBF')[2]})
        end
        if v1 == 5 then
            setVar('posValBF', {970, getVar('posValBF')[2]})
        end
        if v1 == 6 then
            setVar('camMove', false)
            doTweenX('camFollowX', 'camFollow', 720, 0.42, 'cubeIn')
            doTweenX('camFollowY', 'camFollow', 500, 0.42, 'cubeIn')
        end
        if v1 == 7 then
            triggerEvent('Set Cam Zoom', '0.75', '')
            doTweenZoom('camGameZoom','camGame', 0.75, 0.4, 'cubeOut')
        end
        if v1 == 8 then
            setVar('camMove', true)
        end
    end
end