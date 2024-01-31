import objects.BGSprite;
import flixel.effects.FlxFlicker;
import objects.HealthIcon;


var starmanPOW;
var peachCuts;
var blackBarThingie;
var platform2;
var starmanGF;

var iconGF;

var eventTweens = [];
var eventTimers = [];
var extraTween = [];
function onCreate(){
    for (n in unspawnNotes){
        if (n.noteType == 'Yoshi Note') n.noAnimation = true;
    }

    iconGF = new HealthIcon('johndick', false);


    game.addCharacterToList('yoshi-exe', 2);
    game.addCharacterToList('mariohorror-melt', 1);

    var sky:BGSprite = new BGSprite('stages/EXE1/starman/SS_sky', -1100, -600, 0.1, 0.1);
    sky.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(sky);

    var castillo:BGSprite = new BGSprite('stages/EXE1/starman/SS_castle', -1125, -600, 0.2, 0.2);
    castillo.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(castillo);

    var fireL:BGSprite = new BGSprite('stages/EXE1/starman/Starman_BG_Fire_Assets', -1400, -850, 0.4, 0.4, ['fire anim effects'], true);
    fireL.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(fireL);

    var fireR:BGSprite = new BGSprite('stages/EXE1/starman/Starman_BG_Fire_Assets', 700, -850, 0.4, 0.4, ['fire anim effects'], true);
    fireR.animation.addByIndices('delay', 'fire anim effects', [8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7], "", 24, true);
    fireR.antialiasing = ClientPrefs.data.antialiasing;
    fireR.flipX = true;
    addBehindGF(fireR);
    fireR.animation.play('delay');

    var platform0:BGSprite = new BGSprite('stages/EXE1/starman/SS_farplatforms', -950, -600, 0.55, 0.55);
    platform0.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(platform0);

    starmanPOW = new BGSprite('stages/EXE1/starman/SS_POWblock', 835, 610, 0.55, 0.55);
    starmanPOW.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(starmanPOW);

    var platform1:BGSprite = new BGSprite('stages/EXE1/starman/SS_midplatforms', -850, -600, 0.65, 0.65);
    platform1.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(platform1);

    var floor:BGSprite = new BGSprite('stages/EXE1/starman/SS_floor', -750, -600, 1, 1);
    floor.antialiasing = ClientPrefs.data.antialiasing;
    addBehindDad(floor);

    starmanGF = new BGSprite('characters/SS_GF_scared_Assets', 1900, 425, 1, 1, ["GF Dancing Beat"], false);
    starmanGF.animation.addByIndices('danceRight', 'GF Dancing Beat', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], "", 24, false);
    starmanGF.animation.addByIndices('danceLeft', 'GF Dancing Beat', [15,16,17,18,19,20,21,22,23,24,25,28,29], "", 24, false);
    starmanGF.animation.addByPrefix('sad', "gf sad", 24, false);
    starmanGF.antialiasing = ClientPrefs.data.antialiasing;
    addBehindDad(starmanGF);

    peachCuts = new BGSprite('characters/Peach_EXE_Cuts_New', -160, -100, 1, 1, ["PeachFalling"], true);
    peachCuts.animation.addByPrefix('floats', "PeachFalling1", 24, true);
    peachCuts.animation.addByPrefix('fall', "PeachFalling2", 24, false);
    peachCuts.animation.addByPrefix('dies', "PeachDIES", 24, false);
    peachCuts.antialiasing = ClientPrefs.data.antialiasing;
    peachCuts.alpha = 0.001;
    addBehindDad(peachCuts);

    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.scrollFactor.set(0, 0);
    blackBarThingie.visible = false;
    addBehindDad(blackBarThingie);

    platform2 = new BGSprite('stages/EXE1/starman/SS_foreground', -1100, -600, 1.3, 1.3);
    platform2.antialiasing = ClientPrefs.data.antialiasing;
    add(platform2);


    return;
}

function onUpdate(){
    iconGF.x = iconP2.x - 75;
    iconGF.scale.set(iconP2.scale.x - 0.1, iconP2.scale.y - 0.1);

    iconGF.animation.curAnim.curFrame = iconP2.animation.curAnim.curFrame;
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Triggers Universal') {
        var trigger:Float = Std.parseFloat(v1);
        var trigger2:Float = Std.parseFloat(v2);
        if (Math.isNaN(trigger))
            trigger = 0;
        if (Math.isNaN(trigger2))
            trigger2 = 0;

        switch(trigger)
        {
            case 0:
                //96
                setVar('posValBF', [1050, getVar('posValBF')[1]]);
            case 1:
                //100
                setVar('posValBF', [1550, getVar('posValBF')[1]]);
            case 2:
                //132
                game.uiGroup.add(iconGF);
                iconGF.y = (!ClientPrefs.data.downScroll ? 820 : -150);
                eventTweens.push(FlxTween.tween(iconGF, {y: iconP2.y - (!ClientPrefs.data.downScroll ? 35 : -25)}, 3, {ease: FlxEase.expoOut}));
                eventTweens.push(FlxTween.tween(gfGroup, {y: 0}, 3, {ease: FlxEase.expoOut, onComplete: function(twn:FlxTween)
                    {
                        extraTween.push(FlxTween.tween(gfGroup, {y: gfGroup.y - 80}, 2, {ease: FlxEase.quadInOut, type: 4}));
                    }}));
                extraTween.push(FlxTween.tween(gfGroup, {x: gfGroup.x - 100}, 3, {ease: FlxEase.quadInOut, type: 4}));
                setVar('posValGF', [850, getVar('posValGF')[1]]);
            case 3:
                //196
                setVar('posValGF', [550, getVar('posValGF')[1]]);
            case 4:
                //256
                var dadx:Float = dadGroup.x;
                var dady:Float = dadGroup.y;
                for (tween in extraTween)
                    {
                        tween.cancel();
                    }
                extraTween.push(FlxTween.tween(iconGF, {y: (!ClientPrefs.data.downScroll ? 820 : -150)}, 1.5, {ease: FlxEase.expoIn}));
                extraTween.push(FlxTween.tween(gfGroup, {x: 3500}, 1.5, {ease: FlxEase.quadInOut}));
                extraTween.push(FlxTween.tween(gfGroup, {y: -400}, 1.5, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween)
                    {
                        gfGroup.scrollFactor.set(0.55, 0.55);
                        game.triggerEvent('Play Animation', 'prepow', 'gf');
                        gfGroup.x = 685;
                        gfGroup.y = -1200;
                        extraTween.push(FlxTween.tween(gfGroup, {y: 20}, 0.20, {startDelay: 1.04, onComplete: function(twn:FlxTween)
                            {
                                game.triggerEvent('Screen Shake','0.8, 0.02','');
                                game.triggerEvent('Play Animation', 'pow', 'gf');
                                game.triggerEvent('Play Animation', 'xd', 'dad');
                                starmanPOW.visible = false;
                                extraTween.push(FlxTween.tween(dadGroup, {y: 1500}, 0.6, {ease:FlxEase.quadIn, onComplete: function(twn:FlxTween)
                                    {
                                        dadGroup.x = dadx;
                                        dadGroup.y = dady;
                                        game.triggerEvent('Change Character', '1', 'peach-exe');
                                        dad.visible = false;
                                        iconGF.changeIcon('yoshiex');
                                        iconGF.y = iconP2.y - (!ClientPrefs.data.downScroll ? 35 : -25);
                                    }}));
                            }}));
                    }}));
            case 5:
                //262
                setVar('dadZoom', 0.7);
                setVar('bfZoom', 0.7);
                setVar('posValDad', [getVar('posValDad')[0], 800]);
            case 6:
                //266
                extraTween.push(FlxTween.tween(camFollow, {x: 550, y: 250}, 1.25, {startDelay: 0.25, ease: FlxEase.quadInOut}));
                extraTween.push(FlxTween.tween(camGame, {zoom: 0.65}, 1.5, {ease: FlxEase.quadInOut}));
                setVar('camMove', false);
                setVar('camMoveZoom', false);
            case 7:
                //269
                // extraTween.push(FlxTween.tween(camFollowPos, {x: 1550, y: 800}, 1.38, {ease: FlxEase.expoIn}));
                setVar('camMoveZoom', true);
                setVar('dadZoom', 0.6);
                setVar('bfZoom', 0.6);
                peachCuts.x = -2000;
                peachCuts.y = -700;
                peachCuts.alpha = 1;
                peachCuts.animation.play('floats');
                extraTween.push(FlxTween.tween(peachCuts, {y: -380}, 1.25, {ease: FlxEase.quadInOut}));
                extraTween.push(FlxTween.tween(peachCuts, {x: -235}, 1.5, {ease: FlxEase.backOut, onComplete: function(twn:FlxTween)
                    {
                        extraTween.push(FlxTween.tween(peachCuts, {y: -200}, 0.4, {startDelay: 0.1, ease: FlxEase.backIn, onComplete: function(twn:FlxTween)
                            {
                                peachCuts.animation.play('fall');
                                eventTimers.push(new FlxTimer().start(0.5833, function(tmr:FlxTimer)
                                    {
                                        peachCuts.visible = false;
                                        dad.visible = true;
                                    }));
                            }}));
                    }}));
            case 8:
                //273
                extraTween.push(FlxTween.tween(camFollow, {x: getVar('posValBF')[0], y: getVar('posValBF')[1]}, 1.875, {ease: FlxEase.quadInOut}));
                setVar('camMove', true);
                setVar('posValDad', [getVar('posValDad')[0], 250]);
            case 9:
                //336
                setVar('dadZoom', 0.5);
                setVar('bfZoom', 0.5);
                game.defaultCamZoom = 0.5;
            case 10:
                //391
                eventTimers.push(new FlxTimer().start(1.875, function(tmr:FlxTimer)
                    {
                        dad.visible = false;
                        peachCuts.visible = true;
                        peachCuts.animation.play('dies');
                        game.triggerEvent('Play Animation', 'duro', 'gf');
                        peachCuts.x = -500;
                        peachCuts.y = -275;

                        eventTimers.push(new FlxTimer().start(2.5, function(tmr:FlxTimer)
                            {
                                FlxFlicker.flicker(peachCuts, 2, 0.12, false);
                            }));
                    }));
                setVar('camMove', false);
                setVar('camMoveZoom', false);
                extraTween.push(FlxTween.tween(camFollow, {x: getVar('posValDad')[0], y: getVar('posValDad')[1] + 75}, 2.5, {ease: FlxEase.quadInOut}));
            case 11:
                //396
                eventTimers.push(new FlxTimer().start(1.875, function(tmr:FlxTimer)
                    {
                        setVar('dadZoom', 0.6);
                        setVar('bfZoom', 0.6);        
                        setVar('posValBF', [1200, getVar('posValBF')[1]]);
                        game.triggerEvent('Play Animation', 'death', 'gf');
                        extraTween.push(FlxTween.tween(iconGF, {alpha: 0}, 0.75, {ease: FlxEase.expoIn}));
                        eventTimers.push(new FlxTimer().start(2.0833, function(tmr:FlxTimer)
                            {
                                gfGroup.visible = false;
                            }));
                    }));
                extraTween.push(FlxTween.tween(camFollow, {x: getVar('posValDad')[0] + 150}, 2, {ease: FlxEase.quadInOut}));
                extraTween.push(FlxTween.tween(camGame, {zoom: getVar('dadZoom') + 0.15}, 2, {ease: FlxEase.quadInOut}));
                // starmanPOW.visible = false;
            case 12:
                //404
                // BF_ZOOM = 0.8;
                // BF_CAM_X = 1550;
                // defaultCamZoom = 0.8;
                dad.visible = true;
                game.triggerEvent('Change Character', '1', 'mariohorror-melt');
                game.triggerEvent('Play Animation', 'jump', 'dad');
                dad.x -= 800;
                dad.y += 1200;
                game.defaultCamZoom = 0.5;
                extraTween.push(FlxTween.tween(camGame, {zoom: 0.5}, 0.5, {ease: FlxEase.quadInOut}));
                eventTweens.push(FlxTween.tween(dad, {x: dad.x + 800}, .95, {startDelay: 0.8, ease: FlxEase.linear}));
                eventTweens.push(FlxTween.tween(dad, {y: dad.y - 2200}, 0.6, {startDelay: 0.8, ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
                    {
                        game.triggerEvent('Play Animation', 'fall', 'dad');
                        eventTweens.push(FlxTween.tween(dad, {y: dad.y + 1000}, 0.35, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween)
                            {
                                game.triggerEvent('Play Animation', 'singDOWN', 'dad');
                                setVar('camMove', true);
                                setVar('camMoveZoom', true);                
                            }}));
                    }}));
            case 13:
                //406 this does nothing lololol
                // BF_ZOOM = 0.9;
                // BF_CAM_X = 1650;
                // defaultCamZoom = 0.9;
            case 14:
                //408
                setVar('posValBF', [1550, getVar('posValBF')[1]]);
                setVar('bfZoom', 0.5);
                //peachCuts.visible = false;
            case 16:
                //512
                extraTween.push(FlxTween.tween(camFollow, {x: 550}, 1, {ease: FlxEase.expoOut}));
                extraTween.push(FlxTween.tween(camFollow, {y: 250}, 1, {ease: FlxEase.expoOut}));

                extraTween.push(FlxTween.tween(dadGroup, {alpha: 0}, 2, {startDelay: 1.875}));
                extraTween.push(FlxTween.tween(camHUD, 	{alpha: 0}, 2, {startDelay: 1.875}));

                //3,875
            case 17:
                //514
                setVar('camMoveZoom', false);
                game.defaultCamZoom = 0.7;
                extraTween.push(FlxTween.tween(camGame, {zoom: 0.7}, 3, {ease: FlxEase.linear}));
                
                boyfriendGroup.visible = false;
                blackBarThingie.visible = true;
                platform2.visible = false;
                FlxG.camera.flash(FlxColor.RED, 0.5);
                game.triggerEvent('Screen Shake','3.8, 0.01','');
        }
    }
}

function onBeatHit(){
    if (curBeat % 2 == 0){
        if (starmanGF.animation.curAnim.name != 'hey' || (starmanGF.animation.curAnim.name == 'hey' && starmanGF.animation.curAnim.finished)){
            starmanGF.animation.play('danceRight', true);
        }
    }
    else{
        starmanGF.animation.play('danceLeft', true);
    }
    return;
}

function opponentNoteHit(note){
    if (note.noteType == 'GF Duet' || note.noteType == 'Yoshi Note'){
        gf.playAnim(game.singAnimations[note.noteData], true);
        gf.holdTimer = 0;
    }
}