local totalBeat = 0
local totalShake = 0
local timeBeat = 1
local gameZ = 0.015
local hudZ = 0.03
local gameShake = 0.003
local hudShake = 0.003
local shakeTime = false

setVar('curBuild', buildTarget)

local months = {
    "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"
}
local now = os.date("*t")
local date = string.format("%s %02d %d", months[now.month], now.day, now.year)

function onCreatePost()
    makeLuaText('subtitleText', '', 1280, 0, screenHeight / 1.4)
    setTextAlignment('subtitleText', 'center')
    setObjectCamera('subtitleText', 'camOther')
    setTextSize('subtitleText', 30)
    setTextBorder('subtitleText', 0.5, '000000')
    setObjCamEst('subtitleText')
    addLuaText('subtitleText')

    setTextSize('timeTxt', 22)
    setTextSize('scoreTxt', 17)
    setTextFont('scoreTxt', 'Pixel NES.otf')
    setTextFont('timeTxt', 'mario2.ttf')
    setProperty('scoreTxt.offset.y', 10)

    if songPath == 'powerdown' then
        setTextFont('subtitleText', 'mariones.ttf')
        setTextSize('subtitleText', 30)
    elseif songPath == 'i-hate-you' then
        if downscroll then setProperty('timeTxt.y', screenHeight - 75) end
        setProperty('timeBar.visible', false)
    end

    loadGraphic('healthBar.bg', songPath == 'golden-land' and 'GBhealthBarNEW' or 'healthBarNEW')
    setProperty('healthBar.bg.offset.x', 45)
    setProperty('healthBar.bg.offset.y', 7)


    local warnText = [[
                            !! Warning !!
                    You are using version ]]..version..[[
            You may got some errors & some song doesn't work properly.
                    Please use version aleast 0.7.2 or above
    ]]
    if version < '0.7.2' then
        debugPrint(warnText, 'orange')
    end
end

function onUpdatePost()
    setProperty('iconP1.offset.x', 0 * (getProperty('iconP1.scale.x') / 3))
    setProperty('iconP2.offset.x', 0 * (getProperty('iconP2.scale.x') / 3))
    if songPath == 'i-hate-you' then
        setTextString('timeTxt', 'TIME\n'..math.floor((songLength - getSongPosition()) / 1000))
    end
end

function onEvent(n, v1, v2)
    if n == 'Add Subtitle' then
        setTextString('subtitleText', v1)
        if v2 == '' then
            setTextColor('subtitleText', 'ffffff')
        elseif songPath == 'all-stars' then
            setTextColor('subtitleText', '880808')
        else
            setTextColor('subtitleText', colorFromString(v2))
        end
    end

    if n == 'Camera Zoom Chain' then
        local split1 = splitter(v1, ',')
        local gameZoom = tonumber(split1[1])
        local hudZoom = tonumber(split1[2])

        if not gameZoom or gameZoom == 0 then gameZ = 0.015 end
        if not hudZoom or hudZoom == 0 then hudZ = 0.03 end
        if tonumber(#split1) == 4 then
            local shGame = tonumber(split1[3])
            local shHUD = tonumber(split1[4])

            if shGame and shGame ~= 0 then gameShake = shGame end
            if shHUD and shHUD ~= 0 then hudShake = shHUD end
            shakeTime = true
        else
            shakeTime = false
        end

        local split2 = splitter(v2, ',')
        local toBeat = tonumber(split2[1])
        local tiBeat = tonumber(split2[2])

        if not toBeat or toBeat == 0 then toBeat = 4 end
        if not tiBeat or tiBeat == 0 then tiBeat = 1 end

        totalBeat = toBeat
        timeBeat = tiBeat
    end

    if n == 'Screen Shake Chain' then
        local split1 = splitter(v1, ',')
        local gmShake = tonumber(split1[1])
        local hdShake = tonumber(split1[2])

        if not gmShake and gmShake == 0 then gameShake = gmShake end
        if not hdShake and hdShake == 0 then hudShake = hdShake end

        local toBeat = tonumber(v2)
        if not toBeat or toBeat == 0 then totalShake = 4 end

        totalShake = toBeat
    end
end

function onBeatHit()
    scaleObject('iconP1',1.1, 1.1)
	scaleObject('iconP2',1.1, 1.1)

	doTweenX('iconP1ScaleX','iconP1.scale',1,(0.5 * (1 / (curBpm / 60))),'cubeOut')
    doTweenX('iconP2ScaleX','iconP2.scale',1,(0.5 * (1 / (curBpm / 60))),'cubeOut')
	doTweenX('iconP1ScaleY','iconP1.scale',1,(0.5 * (1 / (curBpm / 60))),'cubeOut')
    doTweenX('iconP2ScaleY','iconP2.scale',1,(0.5 * (1 / (curBpm / 60))),'cubeOut')

    if totalBeat > 0 then
        if curBeat % timeBeat == 0 then
            triggerEvent('Add Camera Zoom', tostring(gameZ), tostring(hudZ))
            totalBeat = totalBeat - 1

            if shakeTime then
                local duration = ((1 / (curBpm / 60)) / 2) * timeBeat
                cameraShake('camHUD', hudShake, duration)
                cameraShake('camGame', gameShake, duration)
            end
        end
    end

    if totalShake > 0 then
        totalShake = totalShake - 1
        local duration = 1 / (curBpm / 60)
        cameraShake('camHUD', hudShake, duration)
        cameraShake('camGame', gameShake, duration)
    end
end

function splitter(inputstr, sep)
    local t = {}
    for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
        table.insert(t, str)
    end
    return t
end

function colorFromString(colorName) -- silly stuff
    local colors = {
        red = "FF0000",
        green = "00FF00",
        blue = "0000FF",
        yellow = "FFFF00",
        orange = "FFA500",
        purple = "800080",
        pink = "FFC0CB",
        black = "000000",
        white = "FFFFFF"
    }
    local hexColor = colors[colorName:lower()]
    if hexColor then return hexColor else return nil end
end