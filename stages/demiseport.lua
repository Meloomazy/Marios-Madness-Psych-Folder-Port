local ls
local cs
setProperty('introSoundsSuffix', '-null')

function onCreatePost()
    
    startFore(1)
    setProperty('camGame.alpha',0.001)
    setProperty('camHUD.alpha',0.001)
    for i = 0, getProperty('playerStrums.length')-1 do
        setPropertyFromGroup('playerStrums', i, 'x', _G['defaultOpponentStrumX'..i])
    end
    for i = 0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums', i, 'x', _G['defaultPlayerStrumX'..i])
    end
end

function onCountdownTick(t)
    if t == 0 then 
    startVideoSprite('introVideoLmao', 'demise_cutscene')
    end
end
function onVideoFinished(t)
    if t == 'introVideoLmao' then
        cameraFlash('camGame', 'ff0000', 1)
        setProperty('camGame.alpha',1)
        setProperty('camHUD.alpha',1)
    end
end


function startFore(lastSprite)
    local coso = getRandomInt(1, 4)
    local under = ''
    ls = lastSprite
    cs = coso
    if getProperty('underfloordemise.alpha') ~= 0.001 then
        coso = getRandomInt(1, 2)
        under = 'under'
    end
    
    if coso == lastSprite then
        startFore(coso)
    else
        local foreSprite = under .. 'demFore' .. coso

        if getProperty('underfloordemise.alpha') ~= 0.001 then
            if coso ~= 3 then
                setProperty(foreSprite..'.x', -3800)
                doTweenX('foreSpriteTweenX'..coso, foreSprite, 15000, 2)
            else
                setProperty(foreSprite..'.x', -3800)
                doTweenX('foreSpriteTweenX'..coso, foreSprite, 15000, 2)
            end
            runTimer('startFore', 0.5)
        else
            setProperty(foreSprite..'.x', -3800)
            doTweenX('foreSpriteTweenX'..coso, foreSprite, 15000, 2)
            runTimer('startFore', 1)
        end
    end
end

function onTimerCompleted(t)
    if t == 'startFore' then
        startFore(cs)
    end
end
