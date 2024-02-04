function onCreate()
    setProperty('introSoundsSuffix', '-null')
    for n = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', n, 'noteType') == 'Ring Note' then
            setPropertyFromGroup('unspawnNotes', n, 'texture', 'ringNES_NOTE_assets')
        end
    end
    setProperty('boyfriend.x', 945.5)
    setProperty('boyfriend.y', 542)

    setProperty('gf.x', 1018)
    setProperty('gf.y', 521.5)

    setProperty('dad.x', getProperty('dad.x') - 1)
    setProperty('dad.y', getProperty('dad.y') - 1)
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