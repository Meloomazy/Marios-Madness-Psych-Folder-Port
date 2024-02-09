local strumsPosX = {}
local strumsPosY = {}
function onCreatePost()
    addHaxeLibrary('LuaUtils','psychlua')
    for i = 0, getProperty('playerStrums.length')-1 do
        setPropertyFromGroup('playerStrums', i, 'x', _G['defaultOpponentStrumX'..i])
    end
    for i = 0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums', i, 'x', _G['defaultPlayerStrumX'..i])
    end
end
--local mult = (112 * (i % 4))
function onStepHit()
    if not getModSetting('noModcharts') then
        if curStep == 460 then
            for i = 0,3 do
                startTween('OPlolAlpha'..i, 'opponentStrums.members['..i..']', {alpha = 0}, 0.8, {ease = 'backInOut'})
                startTween('lolX'..i, 'playerStrums.members['..i..']', {x = _G['defaultPlayerStrumX'..i]}, 0.8, {ease = 'backInOut'})
            end
        end
        if curStep == 518 then
            for i = 0,3 do
                startTween('lolAlpha'..i, 'playerStrums.members['..i..']', {alpha = 0}, 0.3, {ease = 'quadInOut'})
            end
        end
        if curStep == 524 then
            for i = 0,3 do
                setPropertyFromGroup('playerStrums', i, 'x', _G['defaultOpponentStrumX'..i])
                startTween('lolAlpha'..i, 'playerStrums.members['..i..']', {alpha = 1}, 0.6, {ease = 'quadInOut'})
            end
        end
        if curStep == 668 or curStep == 732 or curStep == 1228 then
            for i = 0,3 do
                startTween('lolX'..i, 'playerStrums.members['..i..']', {x = _G['defaultPlayerStrumX'..i]}, 0.8, {ease = 'backInOut'})
            end
        end
        if curStep == 700 or curStep == 908 then
            for i = 0,3 do
                startTween('lolX'..i, 'playerStrums.members['..i..']', {x = _G['defaultOpponentStrumX'..i]}, 0.8, {ease = 'backInOut'})
            end
        end
        if curStep == 1312 then
            for i = 0,3 do
                startTween('lolAlpha'..i, 'opponentStrums.members['..i..']', {alpha = 0}, 0.8, {ease = 'quadInOut'})
            end
        end
    end
end
