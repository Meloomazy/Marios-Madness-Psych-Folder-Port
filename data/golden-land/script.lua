function onCreatePost()
    setProperty('introSoundsSuffix', '-null')
end

function onCountdownTick(c)
    if c == 1 then
        setProperty('countdownReady.visible', false)
    elseif c == 2 then
        setProperty('countdownSet.visible', false)
    elseif c == 3 then
        setProperty('countdownGo.visible', false)
    end
end