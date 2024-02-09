function onCreatePost()
    makeAnimatedLuaSprite('bfCape', 'characters/MM_IHY_Boyfriend_AssetsFINAL', 1130, (songPath == 'i-hate-you' and 520 or 710))
    addAnimationByPrefix('bfCape', 'idle', 'Capejajacomoelcharter', 24, true)
    addAnimationByPrefix('bfCape', 'miss', 'CapeFail')
    addLuaSprite('bfCape')
    setObjectOrder('bfCape', getObjectOrder('boyfriendGroup')-1)
    playAnim('bfCape', 'idle', true)
end

function noteMiss(id, dir, typ, sus)
    if not sus then
        playAnim('bfCape', 'miss')
    end
end
function goodNoteHit(id, dir, typ, sus)
    if not sus then
        playAnim('bfCape', 'idle')
    end
end


function onUpdate()
    if (getProperty('bfCape.holdTimer') > stepCrochet * 0.0011 * getProperty('boyfriend.singDuration') and stringStartsWith(getProperty('bfCape.animation.curAnim.name'), 'sing')) then
        playAnim('bfCape', 'idle')
    end
end