
var eventTweens =[];
var extraTween =[];
var lavaTween:FlxTween;
var ihyLava;
function onCreatePost(){
    if (ClientPrefs.data.lowQuality)
        {
            ihyLava = new FlxSprite(-18, 716);
            ihyLava.frames = Paths.getSparrowAtlas('modstuff/lava');
            ihyLava.animation.addByPrefix('idle', "lava brota", 4);
            ihyLava.setGraphicSize(Std.int(ihyLava.width * 8));
            ihyLava.antialiasing = false;
            ihyLava.updateHitbox();
			insert(members.indexOf(game.uiGroup), ihyLava);
        }
        else
        {
            ihyLava = new FlxSprite(-18, 750);
            ihyLava.frames = Paths.getSparrowAtlas('modstuff/Luigi_IHY_Background_Assets_Lava');
            ihyLava.animation.addByPrefix('idle', "Lava", 12);
            ihyLava.setGraphicSize(Std.int(ihyLava.width * 1.3));
            ihyLava.antialiasing = ClientPrefs.data.antialiasing;
			insert(members.indexOf(game.uiGroup), ihyLava);
        }

        ihyLava.animation.play('idle');
        ihyLava.cameras = [camHUD];
        ihyLava.updateHitbox();

        if (ClientPrefs.data.downScroll)
        {
            if (ClientPrefs.data.lowQuality)
            {
                ihyLava.y = -716;
            }
            else
            {
                ihyLava.y = -440;
            }
            ihyLava.flipY = true;
        }
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Sacar Lava'){
        var lavacord:Float = Std.parseFloat(v1);
        var lavachange:Float = Std.parseFloat(v2);
        if (Math.isNaN(lavachange))
            lavachange = 0;

        if (!ClientPrefs.data.lowQuality)
        {
            if (Math.isNaN(lavacord))
                lavacord = 730;
        }
        else
        {
            if (Math.isNaN(lavacord))
                lavacord = 716;
        }

        if (lavachange == 0)
        {
            if (!ClientPrefs.data.downScroll)
            {
                eventTweens.push(FlxTween.tween(ihyLava, {y: lavacord}, 0.25, {ease: FlxEase.quadOut}));
            }
            else
            {
                if (!ClientPrefs.data.lowQuality)
                {
                    eventTweens.push(FlxTween.tween(ihyLava, {y: lavacord * -1 + 350}, 0.25, {ease: FlxEase.quadOut}));
                }
                else
                {
                    eventTweens.push(FlxTween.tween(ihyLava, {y: lavacord * -1 + 50}, 0.25, {ease: FlxEase.quadOut}));
                }
            }
        }

        if (lavachange == 1)
        {
            if (!ClientPrefs.data.downScroll)
            {
                

                lavaTween = FlxTween.tween(ihyLava, {y: lavacord}, 2, {ease: FlxEase.quadInOut, type: 4});
            }
            else
            {
                if (!ClientPrefs.data.lowQuality){
                lavaTween = FlxTween.tween(ihyLava, {y: lavacord * -1 + 350}, 2, {ease: FlxEase.quadInOut, type: 4});
                }else{
                lavaTween = FlxTween.tween(ihyLava, {y: lavacord * -1 + 50}, 2, {ease: FlxEase.quadInOut, type: 4});
                }
            }
        }
        if (lavachange == 2)
        {
            if (!ClientPrefs.data.downScroll)
            {
                eventTweens.push(FlxTween.tween(ihyLava, {y: lavacord}, 5, {ease: FlxEase.quadInOut}));
            }
            else
            {
                if (!ClientPrefs.data.lowQuality){
                eventTweens.push(FlxTween.tween(ihyLava, {y: lavacord * -1 + 350}, 5, {ease: FlxEase.quadInOut}));
                }else{
                eventTweens.push(FlxTween.tween(ihyLava, {y: lavacord * -1 + 50}, 5, {ease: FlxEase.quadInOut}));
                }
            }
        }
        if (lavachange == 3)
        {
            lavaTween.cancel();
        }
    }
    if (n == 'Triggers Universal' || n == 'Triggers I Hate You'){
        var triggerHate:Float = Std.parseFloat(v1);
        if (Math.isNaN(triggerHate))
            triggerHate = 0;
        switch (triggerHate)
        {
            case 6:
                game.triggerEvent('Play Animation', 'spin', 'boyfriend');
                eventTweens.push(FlxTween.tween(boyfriendGroup, {y: -100}, 0.2, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
                    {
                        eventTweens.push(FlxTween.tween(boyfriendGroup, {y: 60}, 0.2, {ease: FlxEase.quadIn}));
                    }}));


                eventTweens.push(FlxTween.tween(boyfriendGroup, {x: 50}, 0.4, {onComplete: function(twn:FlxTween)
                    {
                        game.triggerEvent('Play Animation', 'attack', 'boyfriend');
                        game.triggerEvent('Play Animation', 'fall', 'dad');
                        game.triggerEvent('Screen Shake', '0.15, 0.007', '0.15, 0.007');

                        extraTween.push(FlxTween.tween(dadGroup, {x: -1600}, 1.5));
                        extraTween.push(FlxTween.tween(dadGroup, {angle: -67}, 1.5, {ease: FlxEase.quadOut}));
                        extraTween.push(FlxTween.tween(dadGroup, {y: -300}, 0.6, {ease: FlxEase.cubeOut, onComplete: function(twn:FlxTween)
                            {
                                extraTween.push(FlxTween.tween(dadGroup, {y: 1900}, 0.9, {ease: FlxEase.quadIn}));

                                new FlxTimer().start(0.19, function(tmr:FlxTimer)
                                    {
                                        game.getLuaObject('bfCape').visible = true;
                                        game.getLuaObject('bfCape').x = boyfriendGroup.x + 260;
                                    });
                            }}));
                    }}));

                    new FlxTimer().start((7 * (1 / (Conductor.bpm / 60))), function(tmr:FlxTimer)
                        {
                            for (tween in extraTween)
                                {
                                    tween.cancel();
                                }
                            game.triggerEvent('Play Animation', 'hand', 'dad');
                            dadGroup.setPosition(-1200, 500);
                            dadGroup.angle = 0;
                            eventTweens.push(FlxTween.tween(dadGroup, {y: 800}, 2, {startDelay: 0.3, onComplete: function(twn:FlxTween)
                                {
                                    dadGroup.visible = false;
                                }}));
                        });
                    }
    }
    return;
}