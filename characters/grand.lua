function onBeatHit()
    if (getHealth() > 1.6) then
        setProperty('iconP2.angle', -40)
        doTweenAngle('iconP2BopAngle', 'iconP2', -20, 0.5 * (1 / (curBpm / 60)), 'backOut')
	else
        setProperty('iconP2.angle', 0)
    end
end