precacheSound('TURMOIL-LENGUETAZO')
function onCreate()
    setProperty('guitarHeroSustains', false)
    
    makeAnimatedLuaSprite('buttonwarn', 'stages/Turmoil/button', 30, 550)
    addAnimationByPrefix('buttonwarn', 'press', 'button press', 24, false)
    addAnimationByPrefix('buttonwarn', 'nopress', 'button no press', 24, false)
    scaleObject('buttonwarn', 0.25, 0.25)
    addLuaSprite('buttonwarn')

    makeLuaSprite('warn', 'stages/Turmoil/Turmoil_HARHARHARHAR', 0)
    screenCenter('warn')
    setProperty('warn.alpha', 0.001)
    addLuaSprite('warn')
end
function onCreatePost()
    setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup') + 1)
    setObjCamEst('warn')
    setObjCamEst('buttonwarn')
end
function opponentNoteHit()
    if getHealth() > 0.4 then
        setHealth(getHealth()-0.015)
    end
end
function onEvent(n,v1,v2)
    if n == 'Turmoil Attack' and not getModSetting('noMechs') then
        dodged = false
        runHaxeCode([[
            var eventTweens = [];
            var eventTimers = [];
            var warning = game.getLuaObject('warn');
            var buttonxml = game.getLuaObject('buttonwarn');
 
            FlxG.sound.play(Paths.sound('warningT2'));

            warning.alpha = 1;
            var wary:Float = warning.y;
            warning.y = wary - 50;
            warning.scale.set(0.7, 0.7);
            eventTweens.push(FlxTween.tween(warning, {y: wary, alpha: 0.2}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.expoOut}));
            eventTweens.push(FlxTween.tween(buttonxml, {alpha: 1}, 0.2, {ease: FlxEase.quadOut}));
    
            eventTimers.push(new FlxTimer().start(((1 / (Conductor.bpm / 60))), function(tmr:FlxTimer)
            {
                FlxG.sound.play(Paths.sound('warningT2'));
                warning.alpha = 1;
                eventTweens.push(FlxTween.tween(warning.scale, {y: 0.8, x: 0.8}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.elasticOut}));
                eventTweens.push(FlxTween.tween(warning, {alpha: 0.2}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadOut}));
            }));
    
            eventTimers.push(new FlxTimer().start(((2 / (Conductor.bpm / 60))), function(tmr:FlxTimer)
            {
                FlxG.sound.play(Paths.sound('warningT2'));
                warning.alpha = 1;
                eventTweens.push(FlxTween.tween(warning.scale, {y: 1, x: 1}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.elasticOut}));
                eventTweens.push(FlxTween.tween(warning, {alpha: 0}, 0.5 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadOut}));
            }));
    
            eventTimers.push(new FlxTimer().start(0.2083 - (3 * (1 / (Conductor.bpm / 60))), function(tmr:FlxTimer)
            {
                game.triggerEvent('Play Animation', 'preattack', 'dad');
            }));
    
            eventTimers.push(new FlxTimer().start((3 * (1 / (Conductor.bpm / 60))), function(tmr:FlxTimer)
            {
                game.triggerEvent('Play Animation', 'attack', 'dad');
                FlxG.sound.play(Paths.sound('TURMOIL-LENGUETAZO'));
                game.triggerEvent('Screen Shake', '0.15, 0.007', '0.15, 0.007');
    
                eventTimers.push(new FlxTimer().start(0.0483, function(tmr:FlxTimer)
                {
                   
                }));
    
                eventTweens.push(FlxTween.tween(buttonxml, {alpha: 0}, 0.5 * (1 / (Conductor.bpm / 60)), {startDelay: 0.5, ease: FlxEase.quadOut}));
            }));
        ]])
        playAnim('buttonwarn', 'nopress', true)
        runTimer('startAttack', 1)
    end
end
startDodge = false
dodged = false
function onUpdate()
    if startDodge then
        if keyboardJustPressed('SPACE') and not botPlay then
            dodge()
        end
    end
end

function onTimerCompleted(t)
    if t == 'startAttack' then
        runTimer('attackEnd', 0.3)
        startDodge = true
        if botPlay then
            dodge()
        end
    end
    if t == 'attackEnd' then
        startDodge = false
        if not dodged then
            setHealth(getHealth()-1)
            playAnim('boyfriend', 'singRIGHTmiss', true)
            setProperty('boyfriend.specialAnim', true)    
        end
    end
end

function dodge()
    dodged = true
    playAnim('buttonwarn', 'press', true)
    playAnim('boyfriend', 'dodge', true)
    setProperty('boyfriend.specialAnim', true)
end
