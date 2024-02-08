import objects.HealthIcon;
import objects.BGSprite;
import flixel.addons.display.FlxBackdrop;


var iconP3;

var castleFloor;
var castleCeiling;
var meatfog;
var hallTLL1;
var hallTLL2;
var hallTLL3;
var fgTLL;

var blackBarThingie;
var gunAmmo;

var streetGroup = [];
var meatworldGroup = [];
var meatForeGroup = [];

var eventTweens = [];
var streetFore;
function onCreate(){
    castleFloor = new BGSprite('stages/TooLateBG/feet/Overdue_Final_BG_floorfixed', -1500, 650, 1, 1, ['Floor']);
    castleFloor.animation.addByPrefix('idle', "Floor", 24, false);
    castleFloor.animation.addByPrefix('loop', "Floor", 24, true);
    castleFloor.animation.play('idle');
    castleFloor.alpha = 0;
    addBehindGF(castleFloor);

    castleCeiling = new BGSprite('stages/TooLateBG/feet/Overdue_Final_BG_topfixed', -1500, -1100, 1, 1, ['Top']);
    castleCeiling.animation.addByPrefix('idle', "Top", 24, false);
    castleCeiling.animation.addByPrefix('loop', "Top", 24, true);
    castleCeiling.animation.play('idle');
    castleCeiling.alpha = 0;
    addBehindGF(castleCeiling);

    var street1 = new BGSprite('stages/TooLateBG/street/BackTrees', -1400, -550, 0.95, 0.95);
    streetGroup.push(street1);
    addBehindGF(street1);

    var street2 = new BGSprite('stages/TooLateBG/street/Front Trees', -1400, -550, 1.05, 1.05);
    streetGroup.push(street2);
    addBehindGF(street2);

    var street3 = new BGSprite('stages/TooLateBG/street/Road', -1400, -550, 1, 1);
    streetGroup.push(street3);
    addBehindGF(street3);

    var street4 = new BGSprite('stages/TooLateBG/street/car', -1400, -550, 1, 1);
    streetGroup.push(street4);
    addBehindGF(street4);

    streetFore = new BGSprite('stages/TooLateBG/street/Foreground Trees', -1600, -550, 1.2, 1);
    add(streetFore);

    var meat1b = new BGSprite('stages/TooLateBG/meat/TL_Meat_Sky', -2350, -1300, 0.2, 0.2);
    meat1b.ID = 0;
    meat1b.scale.set(4, 4);
    meat1b.setPosition(meat1b.x + (meat1b.width / 4), meat1b.y + (meat1b.height / 4));
    meatworldGroup.push(meat1b);
    addBehindGF(meat1b);

    var meat2b = new BGSprite('stages/TooLateBG/meat/TL_Meat_FarBG', -2350, -1350, 0.4, 0.4);
    meat2b.ID = 0;
    //meat2b.scale.set(2, 2);
    meat2b.setPosition(meat2b.x + (meat2b.width / 2), meat2b.y + (meat2b.height / 2));
    meatworldGroup.push(meat2b);
    addBehindGF(meat2b);

    var meat3b = new BGSprite('stages/TooLateBG/meat/TL_Meat_MedBG', -2350, -1350, 0.6, 0.6);
    meat3b.ID = 0;
    //meat3b.scale.set(2, 2);
    meat3b.setPosition(meat3b.x + (meat3b.width / 2), meat3b.y + (meat3b.height / 2));
    meatworldGroup.push(meat3b);
    addBehindGF(meat3b);

    var meat4b = new BGSprite('stages/TooLateBG/meat/TL_Meat_BG', -2350, -1350, 0.8, 0.8);
    meat4b.ID = 0;
    meat4b.scale.set(2, 2);
    meat4b.setPosition(meat4b.x + (meat4b.width / 2), meat4b.y + (meat4b.height / 2));
    meatworldGroup.push(meat4b);
    addBehindGF(meat4b);

    var meat5b = new BGSprite('stages/TooLateBG/meat/TL_Meat_Ground', -2350, -1350, 1, 1);
    meat5b.ID = 0;
    //meat5b.scale.set(2, 2);
    meatworldGroup.push(meat5b);
    addBehindGF(meat5b);

    var meat6b = new BGSprite('stages/TooLateBG/meat/TL_Meat_Pupil', 530, -100, 1, 1);
    meat6b.ID = 1;
    meatworldGroup.push(meat6b);
    addBehindGF(meat6b);

    var meat1f = new BGSprite('stages/TooLateBG/meat/TL_Meat_FG_string', -2350 + 3660, -1350 + 395, 1.15, 1.15);
    meat1f.ID = 0;
    meat1f.scale.set(2, 2);
    meatForeGroup.push(meat1f);
    add(meat1f);

    var meat2f = new BGSprite('stages/TooLateBG/meat/TL_Meat_FG_bottomteeth', -2350 + 1245, -1350 + 1969 + 750, 1.15, 1.15);
    meat2f.ID = 1;
    meat2f.scale.set(2, 2);
    meatForeGroup.push(meat2f);
    add(meat2f);

    var meat3f = new BGSprite('stages/TooLateBG/meat/TL_Meat_FG_topteeth', -2350 + 879, -1350, 1.15, 1.15);
    meat3f.ID = 0;
    meatForeGroup.push(meat3f);
    add(meat3f);

    var meat4f = new BGSprite('stages/TooLateBG/meat/TL_Meat_FG_topteeth2', -2350 + 921, -1350 + 411 - 1300, 1.15, 1.15);
    meat4f.ID = 2;
    meatForeGroup.push(meat4f);
    add(meat4f);

    var meat5f = new BGSprite('stages/TooLateBG/meat/TL_Meat_CloseFG', -2280, -1350 - 50, 1.35, 1.35);
    meat5f.ID = 0;
    meat5f.scale.set(2, 2);
    meatForeGroup.push(meat5f);
    add(meat5f);


    for (meat in meatworldGroup) meat.alpha = 0.001;
    for (meat in meatForeGroup) meat.alpha = 0.001;

    var fogblack:FlxSprite = new FlxSprite().loadGraphic(Paths.image('modstuff/126'));
    fogblack.antialiasing = ClientPrefs.data.antialiasing;
    fogblack.cameras = [getVar('camEst')];
    fogblack.alpha = 1;
    fogblack.screenCenter();
    addBehindGF(fogblack);

    meatfog = new BGSprite('stages/TooLateBG/meat/TL_Meat_Fog', 0, 0, 0, 0);
    meatfog.antialiasing = ClientPrefs.data.antialiasing;
    meatfog.cameras = [getVar('camEst')];
    meatfog.alpha = 0;
    meatfog.screenCenter();
    add(meatfog);

    hallTLL1 = new FlxBackdrop(0x01, -1170);
    hallTLL1.frames = Paths.getSparrowAtlas('stages/TooLateBG/Too_Late_Luigi_Hallway');
    hallTLL1.animation.addByPrefix('idle', "tll idle",   24, false);
    hallTLL1.animation.addByPrefix('singUP', "tll up", 	 24, false);
    hallTLL1.animation.addByPrefix('singDOWN', "tll down",   24, false);
    hallTLL1.animation.addByPrefix('singLEFT', "tll left",   24, false);
    hallTLL1.animation.addByPrefix('singRIGHT', "tll right", 24, false);
    hallTLL1.animation.play('idle', true);
    hallTLL1.updateHitbox();
    hallTLL1.antialiasing = true;
    hallTLL1.velocity.set(-2800, 0);
    hallTLL1.alpha = 0.001;

    hallTLL2 = new FlxBackdrop(0x01, -1170);
    hallTLL2.frames = Paths.getSparrowAtlas('stages/TooLateBG/Too_Late_Luigi_Hallway');
    hallTLL2.animation.addByPrefix('idle', "tll idle",   24, false);
    hallTLL2.scale.set(0.8, 0.8);
    hallTLL2.updateHitbox();
    hallTLL2.antialiasing = true;
    hallTLL2.velocity.set(-2240, 0);
    hallTLL2.alpha = 0.001;
    hallTLL2.color = 0xFF979797;

    hallTLL3 = new FlxBackdrop(0x01, -1170);
    hallTLL3.frames = Paths.getSparrowAtlas('stages/TooLateBG/Too_Late_Luigi_Hallway');
    hallTLL3.animation.addByPrefix('idle', "tll idle",  24, false);
    hallTLL3.scale.set(0.6, 0.6);
    hallTLL3.updateHitbox();
    hallTLL3.antialiasing = true;
    hallTLL3.velocity.set(-1680, 0);
    hallTLL3.alpha = 0.001;
    hallTLL3.color = 0xFF696969;
    addBehindBF(hallTLL3);
    addBehindBF(hallTLL2);
    addBehindBF(hallTLL1);

    fgTLL = new FlxBackdrop(Paths.image('stages/TooLateBG/feet/FG_Too_Late_Luigi'), 0x01, 1545);
    fgTLL.updateHitbox();
    fgTLL.antialiasing = true;
    fgTLL.velocity.set(-3920, 0);
    fgTLL.alpha = 0.001;
    add(fgTLL);
    
    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.scrollFactor.set(0, 0);
    blackBarThingie.cameras = [getVar('camEst')];
    blackBarThingie.alpha = 0.000001;
    add(blackBarThingie);

    gunAmmo = new BGSprite('stages/TooLateBG/street/Bullet Ammo', 50, 850, 1, 1, ['Bullet Ammo 3']);
    gunAmmo.animation.addByPrefix('Bullet 3', 'Bullet Ammo 3', 5, false);
    gunAmmo.animation.addByPrefix('Bullet 2', 'Bullet Ammo 2', 5, false);
    gunAmmo.animation.addByPrefix('Bullet 1', 'Bullet Ammo 1', 5, false);
    gunAmmo.animation.addByPrefix('Bullet 0', 'Bullet Ammo 0', 5, false);
    gunAmmo.antialiasing = ClientPrefs.data.antialiasing;
    gunAmmo.cameras = [getVar('camEst')];
    gunAmmo.scale.set(0.65, 0.65);
    gunAmmo.updateHitbox();
    gunAmmo.alpha = 0.8;
    addBehindGF(gunAmmo);
    return;
}
var BF_OGX;
var BF_OGY;

function onCreatePost(){
    BF_OGX = boyfriendGroup.x;
    BF_OGY = boyfriendGroup.y;

    iconP3 = new HealthIcon('latemario', true);
	iconP3.y = healthBar.y - 125;
	iconP3.alpha = 0;
	game.uiGroup.add(iconP3);

    gf.alpha = 0.001;

    for (n in game.unspawnNotes){
        if (n.noteType == 'Bullet') n.noAnimation = true;
    }
    return;
}

function onUpdate(elapsed){
    iconP3.x = game.iconP1.x - 30;
    iconP3.scale.x = iconP1.scale.x - 0.2;
    iconP3.scale.y = iconP1.scale.y - 0.2;
    iconP3.updateHitbox();

    return;
}

function goodNoteHit(note){
    if (note.noteType == 'GF Duet'){
        game.gf.playAnim(game.singAnimations[note.noteData], true);
        game.gf.holdTimer = 0;
    }
    if (note.noteType == 'Bullet'){
        game.boyfriend.playAnim('singUP-alt', true);
        game.boyfriend.holdTimer = 0;
    }

    return;
}
var poison;
function onEvent(n,v1,v2){
    if (n == 'Triggers Universal' || n == 'Triggers Overdue'){
        var trigger:Float = Std.parseFloat(v1);
        if (Math.isNaN(trigger))
            trigger = 0;
        switch (trigger)
        {
            case 0:
                var alphaNew:Float = Std.parseFloat(v2);
                if (Math.isNaN(alphaNew))
                    alphaNew = 0.8;
                blackBarThingie.visible = true;
                eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: alphaNew}, 1));
                if(alphaNew != 0){
                    game.triggerEvent('Screen Shake','2, 0.002','2.2, 0.002');
                }
            case 1:
                var poisonNew:Float = Std.parseFloat(v2);
                if (Math.isNaN(poisonNew))
                    poisonNew = 0;
                poison = poisonNew;
            case 2:
                setVar('camMove', false);
                eventTweens.push(FlxTween.tween(camFollow, {x: -80, y: 450}, 1.64, {ease: FlxEase.expoInOut, onComplete: () -> setVar('camMove', true)}));
            case 3:
                setVar('camMove', false);
                eventTweens.push(FlxTween.tween(camGame, {zoom: 0.75}, 0.4, {ease: FlxEase.cubeInOut}));
                for (meat in meatworldGroup) meat.alpha = 1;
                for (meat in meatForeGroup){
                    meat.alpha = 1;
                    switch(meat.ID){
                        case 1:
                            eventTweens.push(FlxTween.tween(meat, {y: (-1350 + 1969 - 400) + (meat.height / 2)}, 0.3, {ease: FlxEase.cubeIn}));
                        case 2:
                            eventTweens.push(FlxTween.tween(meat, {y: -1350 + 411 - 400}, 0.3, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween){
                                FlxG.sound.play(Paths.sound('teethslam'), 0.5);
                            }}));
                    }
                }
            case 4:
                for (street in streetGroup){ 
                    street.visible = false;
                }
                streetFore.visible = false;

                boyfriendGroup.setPosition(950, 200);
                dadGroup.setPosition(-250, 225);

                setVar('camMove', true);
                setVar('camMoveZoom', true);
                setVar('dadZoom', 0.45);
                setVar('bfZoom', 0.35);

                for (meat in meatworldGroup) meat.alpha = 1;
                for (meat in meatForeGroup){
                    meat.alpha = 1;
                    switch(meat.ID){
                        case 1:
                            eventTweens.push(FlxTween.tween(meat, {y: (-1350 + 1969) + (meat.height / 2)}, 0.4, {ease: FlxEase.cubeInOut}));
                            eventTweens.push(FlxTween.tween(meatfog, {alpha: 0.6}, 0.4, {ease: FlxEase.cubeInOut}));
                        case 2:
                            eventTweens.push(FlxTween.tween(meat, {y: -1350 + 411 - 1300}, 0.4, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween){
                                meat.visible = false;
                            }}));
                    }
                }
            case 5:
                gfGroup.x = 900;
                setVar('dadZoom', 0.4);
                setVar('bfZoom', 0.5);
                setVar('posValBF', [1000, 450]);
                eventTweens.push(FlxTween.tween(gfGroup, {y: gfGroup.y + 40}, 2, {startDelay: 0.2, ease: FlxEase.quadInOut, type: 4}));
                eventTweens.push(FlxTween.tween(gfGroup, {x: gfGroup.x - 30}, 4, {startDelay: 0.2, ease: FlxEase.quadInOut, type: 4}));
                eventTweens.push(FlxTween.tween(camFollow, {x: getVar('posValBF')[0], y: getVar('posValBF')[1]}, 5, {ease: FlxEase.sineInOut}));
                eventTweens.push(FlxTween.tween(camGame, {zoom: getVar('bfZoom')}, 5, {ease: FlxEase.sineInOut}));
                eventTweens.push(FlxTween.tween(gf, {alpha: 0.7}, 5));
                eventTweens.push(FlxTween.tween(iconP3, {alpha: 0.7}, 5));
            case 6:
                eventTweens.push(FlxTween.tween(castleFloor, {alpha: 1}, 10));
                eventTweens.push(FlxTween.tween(castleCeiling, {alpha: 1}, 10));
                castleFloor.x = -1000;
                castleCeiling.x = -1000;
                castleFloor.y = 1000 - 350;
                castleCeiling.y = -750 - 350;
                castleFloor.alpha = 1;
                castleCeiling.alpha = 1;

                castleFloor.animation.play('idle');
                castleCeiling.animation.play('idle');

                for (meat in meatworldGroup) eventTweens.push(FlxTween.tween(meat, {alpha: 0}, 10));
                for (meat in meatForeGroup) eventTweens.push(FlxTween.tween(meat, {alpha: 0}, 10));
                eventTweens.push(FlxTween.tween(meatfog, {alpha: 0}, 10));
            case 7:
                dadGroup.y = 150;
                eventTweens.push(FlxTween.tween(dadGroup, {x: -2350}, 0.8));
                gf.visible = false;

                hallTLL1.y = -850 - 350;
                hallTLL2.y = -600 - 350;
                hallTLL3.y = -350 - 350;
                fgTLL.y = -600 - 350;
                fgTLL.scrollFactor.set(1.4, 1.4);
                game.triggerEvent('Change Character', '0', 'pico_run');
                game.triggerEvent('Set Cam Pos', '1000, 500', 'bf');
                game.triggerEvent('Set Cam Pos', '1000, 150', 'dad');
                game.triggerEvent('Set Cam Zoom', '0.5', 'bf');
                game.triggerEvent('Set Cam Zoom', '0.35', 'dad');
                game.triggerEvent('fuckoff', '', '');
                boyfriendGroup.setPosition(BF_OGX - 150, BF_OGY);

                hallTLL1.animation.play('idle');
                eventTweens.push(FlxTween.tween(hallTLL1, {alpha: 1}, 0.2));

                hallTLL2.animation.play('idle');
                eventTweens.push(FlxTween.tween(hallTLL2, {alpha: 1}, 0.2));

                hallTLL3.animation.play('idle');
                eventTweens.push(FlxTween.tween(hallTLL3, {alpha: 1}, 0.2));

                eventTweens.push(FlxTween.tween(fgTLL, {alpha: 1}, 1.5));

                castleFloor.animation.play('loop', true);
                castleCeiling.animation.play('loop', true);

                healthBar.flipX = true;
                iconP1.flipX = true;
            case 8:
                eventTweens.push(FlxTween.tween(hallTLL1, {alpha: 0}, 1.5));
                eventTweens.push(FlxTween.tween(hallTLL2, {alpha: 0}, 1.5));
                eventTweens.push(FlxTween.tween(hallTLL3, {alpha: 0}, 1.5));
                eventTweens.push(FlxTween.tween(fgTLL, {alpha: 0}, 1.5));
                eventTweens.push(FlxTween.tween(iconP2, {alpha: 0}, 1.5));
            case 9:
                camGame.alpha = 0;
                camHUD.alpha = 0;
            case 10:
                eventTweens.push(FlxTween.tween(gunAmmo, {y: 450}, 3, {ease: FlxEase.expoOut}));
                eventTweens.push(FlxTween.tween(gunAmmo, {alpha: 0.2}, 3, {startDelay: 5, ease: FlxEase.quadInOut}));
            case 12:
                eventTweens.push(FlxTween.tween(boyfriendGroup, {x: boyfriendGroup.x + 200}, 6, {ease: FlxEase.quadInOut, type: 4}));
            case 13:
                eventTweens.push(FlxTween.tween(gunAmmo, {alpha: 0}, 0.5, {ease: FlxEase.quadOut}));
                eventTweens.push(FlxTween.tween(iconP3, {alpha: 0}, 0.5));
            case 14:
                setVar('posValBF', [675, 600]);
                setVar('bfZoom', 0.45);
                setVar('camMove', false);
                setVar('camMoveZoom', false);
                eventTweens.push(FlxTween.tween(camFollow, {x: getVar('posValBF')[0], y: getVar('posValBF')[1]}, 1.1, {ease: FlxEase.quadInOut}));
                eventTweens.push(FlxTween.tween(camGame, {zoom: getVar('bfZoom')}, 0.7, {ease: FlxEase.quadInOut}));
                eventTweens.push(FlxTween.tween(game, {defaultCamZoom: getVar('bfZoom')}, 0.7, {ease: FlxEase.quadInOut}));
            case 15:
                setVar('bfZoom', 0.25);
                setVar('dadZoom', 0.25);
                setVar('posValDad', [500, 150]);
                setVar('posValBF', [1000, 350]);
            case 16:
                setVar('bfZoom', 0.35);
                setVar('dadZoom', 0.35);
                setVar('posValDad', [300, 300]);
                setVar('posValBF', [900, 500]);
        }
    }
    return;
}