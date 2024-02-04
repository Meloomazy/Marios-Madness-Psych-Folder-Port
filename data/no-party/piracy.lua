function onCreatePost()
    setProperty('introSoundsSuffix', '-null')
    for i = 0,3 do
        setPropertyFromGroup('opponentStrums', i, 'x', -9999)
        setPropertyFromGroup('playerStrums', i, 'x', 420 + (112 * i))
    end
end

function onSongStart()
    triggerEvent('Show Song', '0', '')
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