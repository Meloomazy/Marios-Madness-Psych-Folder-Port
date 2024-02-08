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

-- yeah i know, it's messy... -Meloom
local flipS = false
local flipA = true

local flipS2 = false
local flipS3 = false
function onStepHit()
    if curStep == 680 then
        for i = 0,3 do
            setPropertyFromGroup('playerStrums', i, 'x', 417 + (112 * (i % 4)))
            setPropertyFromGroup('opponentStrums', i, 'x', 417 + (112 * (i % 4)))
            setPropertyFromGroup('opponentStrums', i, 'y', downscroll and 50 or 570)
    
            setPropertyFromGroup('opponentStrums', i, 'alpha', 0)
            strumsPosX[i+1] = getPropertyFromGroup('playerStrums', i, 'x')
            strumsPosY[i+1] = getPropertyFromGroup('playerStrums', i, 'y')
        end
    end

    if curStep >= 720 and curStep <= 848 or curStep >= 864 and curStep <= 975 then
        if curStep % 16 == 0 then
            flipA = not flipA
        end
        if curStep % 8 == 0 then
            flipS = not flipS
            for i = 0, 3 do
                local x = strumsPosX[i+1]
                local y = getPropertyFromGroup('playerStrums', i, 'y')
                local time = 0.8
                if i == 0 then
                    x = x - 50
                elseif i == 1 then
                    x = x - 25
                elseif i == 2 then
                    x = x + 25
                elseif i == 3 then
                    x = x + 50
                end
                setPropertyFromGroup('playerStrums', i, 'x', x)
                tweenStrumsPos('lolX'..i, i, strumsPosX[i+1], y, time, 'quadOut')

                if flipS then
                    if i == 0 or i == 2 then
                        setPropertyFromGroup('playerStrums', i, 'scale.x', 1.2)
                        setPropertyFromGroup('playerStrums', i, 'scale.y', 1.2)

                        tweenStrumsScale('lolScaleXY'..i, i, 0.7, 0.7, time, 'circOut')
                        tweenStrumsAngle('lolAng'..i, i, flipA and -45 or 45, 0, time, 'circOut')
                    end
                else
                    if i == 1 or i == 3 then
                        setPropertyFromGroup('playerStrums', i, 'scale.x', 1.2)
                        setPropertyFromGroup('playerStrums', i, 'scale.y', 1.2)
    
                        tweenStrumsScale('lolScaleXY'..i, i, 0.7, 0.7, time, 'circOut')
                        tweenStrumsAngle('lolAng'..i, i, flipA and 45 or -45, 0, time, 'circOut')
                    end
                end
            end
        end
    end

    if curStep == 976 then
        doTweenX('camStrum1X', 'camStrum1', 170, 1.5, 'quadInOut')
        doTweenX('camStrum2X', 'camStrum2', -170, 1.5, 'quadInOut')
    end

    if curStep >= 976 and curStep <= 1208 then
        local time = 0.8
        if curStep % 16 == 0 then
            flipS = not flipS
            for i = 0,3 do
                if i == 0 or i == 1 then
                    tweenStrumsAngle('lolAng'..i, i, -45, 0, time, 'circOut')
                end
                if i == 2 or i == 3 then
                    tweenStrumsAngle('lolAng'..i, i, 45, 0, time, 'circOut')
                end
            end
        end
        if curStep % 16 == 8 then
            for i = 0, 3 do
                local y = strumsPosY[i+1]
                if flipS then
                    if i == 0 or i == 2 then
                        y = y - 50
                    elseif i == 1 or i == 3 then
                        y = y + 50
                    end
                else
                    if i == 0 or i == 2 then
                        y = y + 50
                    elseif i == 1 or i == 3 then
                        y = y - 50
                    end
                end
                setPropertyFromGroup('playerStrums', i, 'y', y)
                startTween('lolY'..i, 'playerStrums.members['..i..']', {y = strumsPosY[i+1]}, time, {ease = 'circOut'})
            end
        end
    end

    if curStep == 1232 then
        for i = 0,3 do
            startTween('OPlolAlpha'..i, 'opponentStrums.members['..i..']', {alpha = 0.5},  1, {ease = 'quadInOut', onComplete = 'onTweenCompleted'})
        end
    end

    if curStep == 1296 or curStep == 1304 or curStep == 1312 or curStep == 1320 or curStep == 1329 or curStep == 1336 or curStep == 1344 or curStep == 1352 then
        for i = 0,3 do
            local x = strumsPosX[i+1]
            if i == 0 then
                x = x - 55
            elseif i == 1 then
                x = x - 25
            elseif i == 2 then
                x = x + 25
            elseif i == 3 then
                x = x + 55
            end
            setPropertyFromGroup('playerStrums', i, 'x', x)
            setPropertyFromGroup('opponentStrums', i, 'x', x)
            startTween('lolX'..i, 'playerStrums.members['..i..']', {x = strumsPosX[i+1]}, 0.8, {ease = 'quadOut'})
            startTween('OPlolX'..i, 'opponentStrums.members['..i..']', {x = strumsPosX[i+1]}, 0.8, {ease = 'quadOut'})
        end
    end

    if curStep == 1360 then
        startTween('camStrum1X', 'camStrum1', {x = 0}, 0.5, {ease = 'quadOut'})
        startTween('camStrum2X', 'camStrum2', {x = 0}, 0.5, {ease = 'quadOut'})
        for i = 0,3 do
            startTween('OPlolAlpha'..i, 'opponentStrums.members['..i..']', {alpha = 0},  0.3, {ease = 'quadOut'})
            if i ~= 2 then
                startTween('lolAlpha'..i, 'playerStrums.members['..i..']', {alpha = 0},  0.3, {ease = 'quadOut'})
            end
        end
    end

    if curStep == 1374 then
        for i = 0,3 do
            startTween('lolAlpha'..i, 'playerStrums.members[2]', {alpha = 0},  0.1, {ease = 'quadOut'})
        end
    end
    if curStep == 1376 then
        for i = 0,3 do
            setPropertyFromGroup('playerStrums', i, 'alpha', 1)
        end
    end

    if curStep >= 1376 and curStep <= 1631 then
        if curStep % 8 == 0 then
            flipS3 = not flipS3
        end
        if curStep % 4 == 0 then
            flipS2 = not flipS2
            for i = 0, 3 do
                local x = strumsPosX[i+1]
                local y = strumsPosY[i+1]
                if flipS3 then
                    if i == 1 then
                        y = y - 50
                    elseif i == 2 then
                        y = y + 50
                    end
                else
                    if i == 1 then
                        y = y + 50 
                    elseif i == 2 then
                        y = y - 50
                    end
                end
                if flipS2 then
                    if i == 0 then
                        x = x - 50
                    elseif i == 3 then
                        x = x + 50
                    end
                    startTween('lolY'..i, 'playerStrums.members['..i..']', {y = strumsPosY[i+1]}, 0.1, {ease = 'circIn'})
                    startTween('lolX'..i, 'playerStrums.members['..i..']', {x = x}, 0.32, {ease = 'circOut' , startDelay = 0.1})
                else
                    startTween('lolY'..i, 'playerStrums.members['..i..']', {y = y}, 0.32, {ease = 'circOut', startDelay = 0.1})
                    startTween('lolX'..i, 'playerStrums.members['..i..']', {x = strumsPosX[i+1]}, 0.1, {ease = 'circIn'})
                end
            end
        end
    end

    if curStep == 1504 then
        for i = 0,3 do
            startTween('lolAngle'..i, 'playerStrums.members['..i..']', {angle = 360},  0.6, {ease = 'backOut'})
        end
        doTweenX('camStrum2X', 'camStrum2', -170, 1.5, 'quadInOut')
    end

    if curStep == 1632 then
        cancelTween('camStrum2X')
        for i = 0,3 do
            startTween('lolAngle'..i, 'playerStrums.members['..i..']', {angle = 0}, 2, {ease = 'expoOut'})
            startTween('lolXY'..i, 'playerStrums.members['..i..']', {x = strumsPosX[i+1], y = strumsPosY[i+1]}, 2, {ease = 'expoOut'})
        end
        doTweenX('camStrum2Xstop', 'camStrum2', 0, 2, 'expoOut')
    end

    if curStep == 1648 or curStep == 1664 or curStep == 1696 or curStep == 1712 or curStep == 1728 then
        for i = 0,3 do
            local x = strumsPosX[i+1]
            local angle = 0
            if i == 0 then
                x = x - 35
                angle = angle - 15
            elseif i == 1 then
                x = x - 15
                angle = angle - 5
            elseif i == 2 then
                x = x + 15
                angle = angle + 5
            elseif i == 3 then
                x = x + 35
                angle = angle + 15
            end
            startTween('lolXAngle'..i, 'playerStrums.members['..i..']', {x = x, angle = angle}, 0.55, {ease = 'circOut', onComplete = 'onTweenCompleted'})
        end
    end

    if curStep == 1760 then
        local y = downscroll and 570 or 50
        startTween('lolEnd0', 'playerStrums.members[0]', {y = y - 55, angle = 360, alpha = 0}, 2, {ease = 'expoOut'})
        startTween('lolEnd1', 'playerStrums.members[1]', {y = y - 55, angle = 360, alpha = 0}, 2, {ease = 'expoOut', startDelay = 0.35})
        startTween('lolEnd2', 'playerStrums.members[2]', {y = y - 55, angle = 360, alpha = 0}, 2, {ease = 'expoOut', startDelay = 0.8})
        startTween('lolEnd3', 'playerStrums.members[3]', {y = y - 55, angle = 360, alpha = 0}, 2, {ease = 'expoOut', startDelay = 0.5})
    end
end
function onTweenCompleted(t)
    if t == 'lolXAngle0' then
        for i = 0,3 do
            startTween('lolXAngle'..i, 'playerStrums.members['..i..']', {x = strumsPosX[i+1], angle = 0}, 0.3, {ease = 'circIn'})
        end
    end
    if t == 'camStrum2X' then
        startTween('camStrum1X', 'camStrum1', {x = -170}, 1.5, {ease = 'quadInOut', type = 'pingpong'})
        startTween('camStrum2X', 'camStrum2', {x = 170}, 1.5, {ease = 'quadInOut', type = 'pingpong'})
    end
end

function tweenStrumsPos(tag, id, x, y, time, ease)
    runHaxeCode([[
        var tag = ']]..tag..[[';
        var id = ]]..id..[[;
        var x = ]]..x..[[;
        var y = ]]..y..[[;
        var time = ]]..time..[[;
        var ease = ']]..ease..[[';

        if(game.modchartTweens.exists(tag)) {
			game.modchartTweens.get(tag).cancel();
			game.modchartTweens.get(tag).destroy();
			game.modchartTweens.remove(tag);
		}

        game.modchartTweens.set(tag,
        FlxTween.tween(game.playerStrums.members[id], {x: x, y: y}, time, {ease: LuaUtils.getTweenEaseByString(ease)} )
        );
    ]])
end

function tweenStrumsAngle(tag, id, from, to, time, ease)
    runHaxeCode([[
        var tag = ']]..tag..[[';
        var id = ]]..id..[[;
        var fr = ]]..from..[[;
        var tog = ]]..to..[[;
        var time = ]]..time..[[;
        var ease = ']]..ease..[[';

        if(game.modchartTweens.exists(tag)) {
			game.modchartTweens.get(tag).cancel();
			game.modchartTweens.get(tag).destroy();
			game.modchartTweens.remove(tag);
		}

        game.modchartTweens.set(tag,
        FlxTween.angle(game.playerStrums.members[id], fr, tog, time, {ease: LuaUtils.getTweenEaseByString(ease)} )
        );
    ]])
end
function tweenStrumsScale(tag, id, x, y, time, ease)
    runHaxeCode([[
        var tag = ']]..tag..[[';
        var id = ]]..id..[[;
        var x = ]]..x..[[;
        var y = ]]..y..[[;
        var time = ]]..time..[[;
        var ease = ']]..ease..[[';

        if(game.modchartTweens.exists(tag)) {
			game.modchartTweens.get(tag).cancel();
			game.modchartTweens.get(tag).destroy();
			game.modchartTweens.remove(tag);
		}

        game.modchartTweens.set(tag,
        FlxTween.tween(game.playerStrums.members[id].scale, {x: x, y: y}, time, {ease: LuaUtils.getTweenEaseByString(ease)} )
        );
    ]])
end