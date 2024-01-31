-- uh silly subtitle/lyric thing i did long ago that didn't get used

local totalText = 0
function onEvent(n,v1,v2)
    if n == "Meloom's Subtitle" then
        totalText = totalText + 1
        local vals = stringSplit(v2, ', ')
        local tag = 'SubTextB'..totalText
        makeLuaText(tag, v1, 0, 0, (downscroll and 560 or 150))
        setTextBorder(tag, 0.8, '000000')
        setTextSize(tag, 30)
        addLuaText(tag)
        setProperty(tag..'.alpha', 0.001)
        setProperty(tag..'.x', (screenWidth - getProperty(tag..'.width')) / vals[1])

        doTweenAlpha('SubTextTA'..totalText, tag, 1, 0.788, 'cubeOut')
        doTweenY('SubTextTY'..totalText, tag, (downscroll and 520 or 200), 0.786, 'quartOut')
        runTimer('SubTextTimer'..totalText, vals[2])
    end
end

function onTimerCompleted(t)
    for b = 1,totalText do
        local tag = 'SubTextB'..b
        if t == 'SubTextTimer'..b then
            doTweenY('SubTextTY'..b, tag, (downscroll and 560 or 150), 0.586, 'quartIn')
            doTweenAlpha('SubTextTA'..b, tag, 0, 0.488, 'cubeIn')
        end
    end
end
