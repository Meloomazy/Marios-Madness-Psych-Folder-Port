import objects.BGSprite;

var faropapu;
var whiteThingie;
var trueno;
var seaweed1;
var seaweed2;
var lospapus;
var atrasarboleda;
var aas;
var seaweed3;
var sopapo;
var casa0;
var casa1;
var casa2;
var s3;
var s2;
var glitch0;
var glitch1;
var glitch2;
var glitch3;
var cososuelo;
var leaf0;
var leaf1;
var leaf2;
var bola0;
var bola1;
var lluvia;
var fogred;
var fresco;
var blackBarThingie;
var startbf;

var eventTweens = [];
var extraTween = [];
var eventTimers = [];
var casa = 300;
function onCreate(){
    if (Paths.formatToSongPath(game.songName.toLowerCase()) == 'dark-forest'){
        game.addCharacterToList('peachtalk1', 1);
        game.addCharacterToList('peachtheG', 1);    
    }

    faropapu = new FlxSprite(-1200, -500, Paths.image('stages/Coronation/firstpart/FondoFondo'));
    faropapu.antialiasing = true;
    faropapu.scrollFactor.set(0.5, 0.5);
    faropapu.updateHitbox();
    addBehindGF(faropapu);

    whiteThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    whiteThingie.setGraphicSize(Std.int(whiteThingie.width * 10));
    whiteThingie.alpha = 0;
    addBehindGF(whiteThingie);

    trueno = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', 180, -600, 0.7, 0.7, ['AAARayo'], false);
    trueno.animation.addByPrefix('rayo', 'AAARayo', 24, false);
    trueno.antialiasing = ClientPrefs.data.antialiasing;
    trueno.visible = false;
    addBehindGF(trueno);

    seaweed1 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', 520, -50, 1, 1, ['Leave0'], true);
    seaweed1.antialiasing = ClientPrefs.data.antialiasing;
    seaweed1.visible = false;
    seaweed1.color = 0xFFB8837F;
    seaweed1.scale.set(1.2, 1.2);
    seaweed1.updateHitbox();
    addBehindGF(seaweed1);

    seaweed2 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', 1420, -150, 1, 1, ['Leave0'], true);
    seaweed2.antialiasing = ClientPrefs.data.antialiasing;
    seaweed2.visible = false;
    seaweed2.color = 0xFFB8837F;
    seaweed2.scale.set(1.2, 1.2);
    seaweed2.updateHitbox();
    addBehindGF(seaweed2);

    lospapus = new FlxSprite(-1200, -500, Paths.image('stages/Coronation/firstpart/Arboles'));
    lospapus.antialiasing = true;
    lospapus.scrollFactor.set(1, 1);
    lospapus.updateHitbox();
    addBehindGF(lospapus);

    atrasarboleda = new FlxSprite(-1200, -500, Paths.image('stages/Coronation/firstpart/AtrasArboles'));
    atrasarboleda.antialiasing = true;
    atrasarboleda.scrollFactor.set(1, 1);
    atrasarboleda.updateHitbox();
    addBehindGF(atrasarboleda);

    aas = new FlxSprite(-1200, -500, Paths.image('stages/Coronation/firstpart/asdas'));
    aas.antialiasing = true;
    aas.scrollFactor.set(1, 1);
    aas.updateHitbox();
    addBehindGF(aas);

    seaweed3 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', 820, 350, 1, 1, ['Leave0'], true);
    seaweed3.antialiasing = ClientPrefs.data.antialiasing;
    seaweed3.visible = false;
    seaweed3.color = 0xFFB8837F;
    seaweed3.scale.set(1.2, 1.2);
    seaweed3.updateHitbox();
    addBehindGF(seaweed3);

    sopapo = new FlxSprite(-1200, -500, Paths.image('stages/Coronation/firstpart/Stage'));
    sopapo.antialiasing = true;
    sopapo.scrollFactor.set(1, 1);
    sopapo.updateHitbox();
    addBehindGF(sopapo);

    casa0 = new FlxSprite(-1200, casa + -2800, Paths.image('stages/Coronation/secondpart/BGforBG'));
    casa0.antialiasing = true;
    casa0.scrollFactor.set(0.5, 0.5);
    casa0.updateHitbox();
    casa0.visible = false;
    addBehindGF(casa0);

    casa1 = new FlxSprite(-1200, casa + -4800, Paths.image('stages/Coronation/secondpart/TreeHouse'));
    casa1.antialiasing = true;
    casa1.scrollFactor.set(1, 1);
    casa1.updateHitbox();
    addBehindGF(casa1);

    casa2 = new BGSprite('stages/Coronation/secondpart/CoroDay_DeadMario', 400, casa + -3600, 1, 1, ['Deadstages'], true);
    casa2.antialiasing = ClientPrefs.data.antialiasing;
    casa2.animation.addByPrefix('idle', "DeadMario", 24, false);
    addBehindGF(casa2);

    var nerve0:BGSprite = new BGSprite('stages/Coronation/secondpart/thenerve', -400, casa + -2500, 1, 1);
    nerve0.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(nerve0);

    var nerve1:BGSprite = new BGSprite('stages/Coronation/secondpart/thenerve', 400, casa + -2500, 1, 1);
    nerve1.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(nerve1);

    var nerve2:BGSprite = new BGSprite('stages/Coronation/secondpart/thenerve', 800, casa + -2500, 1, 1);
    nerve2.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(nerve2);

    var nerve3:BGSprite = new BGSprite('stages/Coronation/secondpart/thenerve', 2400, casa + -2500, 1, 1);
    nerve3.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(nerve3);

    var nerve4:BGSprite = new BGSprite('stages/Coronation/secondpart/thenerve', 0, casa + -2500, 1, 1);
    nerve0.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(nerve0);

    var nerve5:BGSprite = new BGSprite('stages/Coronation/secondpart/thenerve', 600, casa + -2500, 1, 1);
    nerve1.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(nerve1);

    eventTweens.push(FlxTween.tween(nerve0, {y: -5000}, 4.5, {type: 2, loopDelay: 0.2}));
    eventTweens.push(FlxTween.tween(nerve1, {y: -5000}, 4, {type: 2, loopDelay: 0.3}));
    eventTweens.push(FlxTween.tween(nerve2, {y: -5000}, 3, {type: 2, loopDelay: 0.6}));
    eventTweens.push(FlxTween.tween(nerve3, {y: -5000}, 3, {type: 2, loopDelay: 0.5}));
    eventTweens.push(FlxTween.tween(nerve4, {y: -5000}, 4, {type: 2, loopDelay: 0.4}));
    eventTweens.push(FlxTween.tween(nerve5, {y: -5000}, 3, {type: 2, loopDelay: 0.2}));

    eventTweens.push(FlxTween.tween(nerve0, {x: -450}, 0.4, {type: 4}));
    eventTweens.push(FlxTween.tween(nerve1, {x: 350}, 0.2, {type: 4}));
    eventTweens.push(FlxTween.tween(nerve2, {x: 850}, 0.3, {type: 4}));
    eventTweens.push(FlxTween.tween(nerve3, {x: 250}, 3.5, {type: 4}));
    eventTweens.push(FlxTween.tween(nerve4, {x: 50}, 0.3, {type: 4}));
    eventTweens.push(FlxTween.tween(nerve5, {x: 750}, 0.45, {type: 4}));

    s3 = new FlxSprite(-1200, casa + -4500, Paths.image('stages/Coronation/secondpart/TransitionTop'));
    s3.scrollFactor.set(1.3, 1.3);
    s3.updateHitbox();
    addBehindGF(s3);

    s2 = new FlxSprite(-1200, casa + -2500, Paths.image('stages/Coronation/secondpart/TransitionBottom'));
    s2.scrollFactor.set(1.3, 1.3);
    s2.updateHitbox();
    addBehindGF(s2);

    //glitches

    glitch0 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', 400, 200, 1.3, 1.3, ['glitch2'], true);
    glitch0.antialiasing = ClientPrefs.data.antialiasing;
    glitch0.visible = false;
    glitch0.color = 0xFFB8837F;
    glitch0.scale.set(2, 2);
    glitch0.updateHitbox();
    add(glitch0);

    glitch1 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', 1500, 400, 1, 1, ['glitch2'], false);
    glitch1.animation.addByPrefix('idle', 'glitch2', 16, true);
    glitch1.animation.play('idle');
    glitch1.antialiasing = ClientPrefs.data.antialiasing;
    glitch1.visible = false;
    glitch1.color = 0xFFB8837F;
    glitch1.scale.set(4, 3);
    glitch1.updateHitbox();
    add(glitch1);

    glitch2 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', -500, 600, 1.1, 1.1, ['glitchcausa'], false);
    glitch2.animation.addByPrefix('idle', 'glitchcausa', 20, true);
    glitch2.animation.play('idle');
    glitch2.antialiasing = ClientPrefs.data.antialiasing;
    glitch2.visible = false;
    glitch2.color = 0xFFB8837F;
    glitch2.scale.set(2, 6);
    glitch2.updateHitbox();
    add(glitch2);

    glitch3 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', -200, 1200, 1.2, 1.2, ['glitchcausa'], false);
    glitch3.animation.addByPrefix('idle', 'glitchcausa', 15, true);
    glitch3.animation.play('idle');
    glitch3.antialiasing = ClientPrefs.data.antialiasing;
    glitch3.visible = false;
    glitch3.color = 0xFFB8837F;
    glitch3.scale.set(5, 3);
    glitch3.updateHitbox();
    add(glitch3);

    cososuelo = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', 1700, 400, 1, 1, ['har'], true);
    cososuelo.antialiasing = ClientPrefs.data.antialiasing;
    cososuelo.visible = false;
    cososuelo.color = 0xFFB8837F;
    cososuelo.scale.set(2.5, 2.5);
    cososuelo.updateHitbox();
    add(cososuelo);

    leaf0 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', 0, -700, 1.3, 1, ['Leavehar'], true);
    leaf0.antialiasing = ClientPrefs.data.antialiasing;
    leaf0.visible = false;
    leaf0.scale.set(1.5, 1.5);
    leaf0.updateHitbox();
    add(leaf0);

    leaf1 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', -400, -700, 1.3, 1, ['Leavehar'], true);
    leaf1.antialiasing = ClientPrefs.data.antialiasing;
    leaf1.visible = false;
    leaf1.scale.set(1.5, 1.5);
    leaf1.updateHitbox();
    add(leaf1);

    leaf2 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', 600, -700, 1.3, 1, ['Leavehar'], true);
    leaf2.antialiasing = ClientPrefs.data.antialiasing;
    leaf2.visible = false;
    leaf2.scale.set(1.5, 1.5);
    leaf2.updateHitbox();
    add(leaf2);

    eventTweens.push(FlxTween.tween(leaf0, {y: 1500, x: leaf0.x + 500}, 1.3, {type: 2, loopDelay: 0.3}));
    eventTweens.push(FlxTween.tween(leaf1, {y: 1500, x: leaf1.x + 500}, 1, {type: 2}));
    eventTweens.push(FlxTween.tween(leaf2, {y: 1500, x: leaf2.x + 500}, 1, {type: 2, loopDelay: 0.6}));

    bola0 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', 1000, -700, 1.3, 1.3, ['bobol'], true);
    bola0.antialiasing = ClientPrefs.data.antialiasing;
    bola0.visible = false;
    bola0.scale.set(1.5, 1.5);
    bola0.updateHitbox();
    add(bola0);

    bola1 = new BGSprite('stages/Coronation/thirdpart/Coronation_Peach_misc_Assets', 300, -700, 1.3, 1.3, ['bobol'], true);
    bola1.antialiasing = ClientPrefs.data.antialiasing;
    bola1.visible = false;
    bola1.scale.set(1.5, 1.5);
    bola1.updateHitbox();
    add(bola1);


    eventTweens.push(FlxTween.tween(bola0, {x: 1100}, 0.5, {ease: FlxEase.quadInOut, type: 4}));
    eventTweens.push(FlxTween.tween(bola1, {x: 400}, 0.5, {ease: FlxEase.quadInOut, type: 4}));
    eventTweens.push(FlxTween.tween(bola0, {y: 1500}, 4, {type: 2, loopDelay: 1}));
    eventTweens.push(FlxTween.tween(bola1, {y: 1500}, 4, {type: 2, loopDelay: 0.6}));
    

    //seaweed.color = 0xFF595959;
    //seaweed2.color = 0xFF595959;
    //seaweed3.color = 0xFF595959;

    lluvia = new BGSprite('stages/LuigiBeta/old/Beta_Luigi_Rain_V1', -170, 50, 1, 1, ['RainLuigi'], true);
    lluvia.setGraphicSize(Std.int(lluvia.width * 1.7));
    lluvia.alpha = 0.6;
    lluvia.visible = false;
    lluvia.antialiasing = ClientPrefs.data.antialiasing;
    lluvia.cameras = [getVar('camEst')];
    addBehindGF(lluvia);

    fogred = new FlxSprite().loadGraphic(Paths.image('modstuff/232'));
    fogred.antialiasing = ClientPrefs.data.antialiasing;
    fogred.cameras = [getVar('camEst')];
    fogred.alpha = 0;
    fogred.screenCenter();
    addBehindGF(fogred);

    fresco = new BGSprite('characters/Coronation_Peach_Dialogue2', 180, -740, 1, 1, ['Peach'], false);
    fresco.animation.addByPrefix('llevar', 'Peach', 24, false);
    fresco.antialiasing = ClientPrefs.data.antialiasing;
    fresco.color = 0xFF93ADB5;
    fresco.alpha = 0.00001;
    add(fresco);

    camHUD.alpha = 0;
    return;
}
function onSongStart(){
    eventTweens.push(FlxTween.tween(startbf, {alpha: 0}, 1, {ease:FlxEase.quadOut}));
    eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: 0}, 1, {ease:FlxEase.quadOut}));
    return;
}
var enemyX;
var enemyY;
function onCreatePost(){
    var colornew:Int = 0xFF93ADB5;
    dadGroup.color = colornew;
    gfGroup.color = colornew;
    boyfriendGroup.color = colornew;

    enemyY = dad.y;
    enemyX = dad.x;

    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.alpha = 1;
    blackBarThingie.cameras = [getVar('camEst')];
    add(blackBarThingie);

    startbf = new FlxSprite().loadGraphic(Paths.image('modstuff/hatestart'));
    startbf.setGraphicSize(Std.int(startbf.width * 3));
    startbf.antialiasing = false;
    startbf.cameras = [getVar('camEst')];
    startbf.alpha = 0;
    setVar('startbf', startbf);
    startbf.updateHitbox();
    startbf.screenCenter();
    add(startbf);

    camFollow.setPosition(1020, 750);
    FlxG.camera.snapToTarget();
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Triggers Dark Forest' || n == 'Triggers Universal'){
        var trigger:Float = Std.parseFloat(v1);
        if (Math.isNaN(trigger))
            trigger = 0;
        switch (trigger)
        {
            case 0: //cutscene part 1
                game.triggerEvent('Change Character', '1', 'peachtalk1');
                game.triggerEvent('Play Animation', 'talk', 'Dad');
            case 1: //GO TO THE TREEHOUSE
                for (tween in extraTween) tween.cancel();
                game.triggerEvent('Change Character', '1', 'peachthe');

                casa0.visible = true;
                setVar('camMove', true);
                setVar('camMoveZoom', true);

                var color1:Int = 0xFFBECDD4;
                dadGroup.color = 0xFF758186;
                boyfriendGroup.color = color1;
                game.getLuaObject('bfCape').color = color1;

                boyfriendGroup.visible = true;
                dad.visible = true;
                game.getLuaObject('bfCape').visible = true;
                dadGroup.y += -3750;
                boyfriendGroup.y = -3800;
                game.getLuaObject('bfCape').y = boyfriendGroup.y + 460;

                setVar('posValDad', [getVar('posValDad')[0], -3450]);
                setVar('posValBF', [getVar('posValBF')[0], -3450]);

                eventTweens.push(FlxTween.tween(camGame, {zoom: 0.65}, 1.4, {ease:FlxEase.sineOut}));

                eventTweens.push(FlxTween.tween(boyfriendGroup, {y: -3550}, 1, {startDelay: 0.5 * (1 / (Conductor.bpm / 60)), ease: FlxEase.bounceOut}));
                eventTweens.push(FlxTween.tween(game.getLuaObject('bfCape'), {y: -3090}, 1, {startDelay: 0.5 * (1 / (Conductor.bpm / 60)), ease: FlxEase.bounceOut}));

                enemyY = dadGroup.y;
                enemyX = dadGroup.x;

                eventTweens.push(FlxTween.tween(lluvia, {alpha: 0}, 0.5, {ease: FlxEase.quadOut}));

                eventTimers.push(new FlxTimer().start(0.2, function(tmr:FlxTimer)
                {
                    extraTween.push(FlxTween.tween(dadGroup, {x: enemyX - 220}, 4, {ease: FlxEase.quadInOut, type: 4}));
                    extraTween.push(FlxTween.tween(dadGroup, {y: enemyY + 100}, 1.4, {ease: FlxEase.quadInOut, type: 4}));
                }));
            case 2: //THIRD ACT
                var color1:Int = 0xFFB8837F;
                var color2:Int = 0xFFFF8B82;
                game.triggerEvent('Change Character', '1', 'peachtheG');

                for (tween in extraTween) tween.cancel();
                for (glitch in [glitch0, glitch1, glitch2, glitch3]) glitch.visible = true;
                for (seaweed in [seaweed1, seaweed2, seaweed3]) seaweed.visible = true;
                for (leaf in [leaf0, leaf1, leaf2]) leaf.visible = true;
                for (bola in [bola0, bola1]) bola.visible = true;
                cososuelo.visible = true;
                fresco.visible = false;

                dad.color = color1;
                gfGroup.color = color1;
                boyfriendGroup.color = color1;
                game.getLuaObject('bfCape').color = color1;

                dadGroup.y = -200;
                dad.x = 100;
                boyfriendGroup.y = 250;
                game.getLuaObject('bfCape').y = boyfriendGroup.y + 460;
                
                enemyY = dadGroup.y;
                enemyX = dadGroup.x;

                eventTimers.push(new FlxTimer().start(0.2, function(tmr:FlxTimer)
                {
                    extraTween.push(FlxTween.tween(dadGroup, {x: enemyX - 220}, 4, {ease: FlxEase.quadInOut, type: 4}));
                    extraTween.push(FlxTween.tween(dadGroup, {y: enemyY - 100}, 1.4, {ease: FlxEase.quadInOut, type: 4}));
                }));
                eventTweens.push(FlxTween.tween(fogred, {alpha: 0.8}, 0.5, {ease: FlxEase.quadOut}));
            case 3:
                if (ClientPrefs.data.flashing){
                    FlxG.camera.flash(FlxColor.WHITE, 1);
                    lluvia.visible = true;
                }
            case 4:
                if (ClientPrefs.data.flashing){
                    var colornew:Int = 0xFF353F42; // color char when thunder
                    var bgnew:Int = 0xFF808080; // color bg when thunder
                    var colorback:Int = 0xFF93ADB5; // color char when finish
                    trueno.visible = true;
                    trueno.animation.play('rayo');
                    trueno.x = FlxG.random.float(-180, 600);
                    trueno.flipX = FlxG.random.bool(50);
                    FlxG.sound.play(Paths.sound('smw_thunder' + FlxG.random.int(1, 3)));

                    eventTimers.push(new FlxTimer().start(0.2917, () -> trueno.visible = false));

                    eventTweens.push(FlxTween.color(dad, 1.3, colornew, colorback, {startDelay: 0.2, ease: FlxEase.quadOut}));
                    eventTweens.push(FlxTween.color(gfGroup, 1.3, colornew, colorback, {startDelay: 0.2, ease: FlxEase.quadOut}));
                    eventTweens.push(FlxTween.color(boyfriendGroup, 1.3, colornew, colorback, {startDelay: 0.2, ease: FlxEase.quadOut}));
                    eventTweens.push(FlxTween.color(game.getLuaObject('bfCape'), 1.3, colornew, colorback, {startDelay: 0.2, ease: FlxEase.quadOut}));

                    eventTweens.push(FlxTween.color(lospapus, 1.3, bgnew, FlxColor.WHITE, {startDelay: 0.2, ease: FlxEase.quadOut}));
                    eventTweens.push(FlxTween.color(atrasarboleda, 1.3, bgnew, FlxColor.WHITE, {startDelay: 0.2, ease: FlxEase.quadOut}));
                    eventTweens.push(FlxTween.color(aas, 1.3, bgnew, FlxColor.WHITE, {startDelay: 0.2, ease: FlxEase.quadOut}));
                    eventTweens.push(FlxTween.color(sopapo, 1.3, bgnew, FlxColor.WHITE, {startDelay: 0.2, ease: FlxEase.quadOut}));
                    eventTweens.push(FlxTween.color(s3, 1.3, bgnew, FlxColor.WHITE, {startDelay: 0.2, ease: FlxEase.quadOut}));
                    eventTweens.push(FlxTween.color(s2, 1.3, bgnew, FlxColor.WHITE, {startDelay: 0.2, ease: FlxEase.quadOut}));

                    game.triggerEvent('Screen Shake', '0.15, 0.03', '');
                }
            case 5:
                var color2:Int = 0xFFFF8B82;
                setVar('posValDad', [getVar('posValDad')[0], 150]);
                setVar('posValBF', [getVar('posValBF')[0], 550]);
                setVar('camMove',false);
                eventTweens.push(FlxTween.tween(camFollow, {y: 150}, (5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.cubeInOut}));

                eventTweens.push(FlxTween.color(faropapu, 1.3, FlxColor.WHITE, color2, {startDelay: 0.2, ease: FlxEase.quadOut}));
                eventTweens.push(FlxTween.color(lospapus, 1.3, FlxColor.WHITE, color2, {startDelay: 0.2, ease: FlxEase.quadOut}));
                eventTweens.push(FlxTween.color(atrasarboleda, 1.3, FlxColor.WHITE, color2, {startDelay: 0.2, ease: FlxEase.quadOut}));
                eventTweens.push(FlxTween.color(aas, 1.3, FlxColor.WHITE, color2, {startDelay: 0.2, ease: FlxEase.quadOut}));
                eventTweens.push(FlxTween.color(sopapo, 1.3, FlxColor.WHITE, color2, {startDelay: 0.2, ease: FlxEase.quadOut}));
                eventTweens.push(FlxTween.color(s3, 1.3, FlxColor.WHITE, color2, {startDelay: 0.2, ease: FlxEase.quadOut}));
                eventTweens.push(FlxTween.color(s2, 1.3, FlxColor.WHITE, color2, {startDelay: 0.2, ease: FlxEase.quadOut}));
                eventTweens.push(FlxTween.color(lluvia, 0.5, 0x00000000, FlxColor.BLACK, {startDelay: 0.7, ease: FlxEase.quadOut}));

            case 6:
                setVar('camMove',true);
                // there, for loop - meloom
                for (glitch in [glitch0, glitch1, glitch2, glitch3]){
                    glitch.x = FlxG.random.float(-200, 1500);
                    glitch.y = FlxG.random.float(200, 1200);
                    glitch.scale.set(FlxG.random.float(1, 5), FlxG.random.float(1, 5));
                }
            case 7:
                var gota:BGSprite = new BGSprite('stages/LuigiBeta/gota', 1270, 700, 1, 1, ['rain'], false);
                gota.antialiasing = ClientPrefs.data.antialiasing;
                gota.x = FlxG.random.int(-300, 2070);
                gota.y = FlxG.random.int(800, 1000);
                if(v2 == '1') gota.color = 0xFF000000;
                if(gota.y > 950){
                    add(gota);
                }else{
                    insert(members.indexOf(gfGroup) - 1, gota);
                }
                
                gota.alpha = 0.4;
                gota.dance(true);

                eventTweens.push(FlxTween.tween(gota, {alpha: 0}, 2, {startDelay: 0.3, onComplete: () -> gota.destroy()}));
            case 8:
                setVar('camMove', false);
                setVar('camMoveZoom', false);

                eventTweens.push(FlxTween.tween(camGame, {zoom: 0.8}, 1.5, {ease:FlxEase.cubeInOut}));
                eventTweens.push(FlxTween.tween(camFollow, {x: getVar('posValDad')[0], y: getVar('posValDad')[1]}, 1.5, {ease:FlxEase.cubeInOut}));
            case 9:
                setVar('camMove', true);
                setVar('camMoveZoom', true);
            case 10:
                extraTween.push(FlxTween.tween(dadGroup, {x: enemyX - 220}, 4, {ease: FlxEase.quadInOut, type: 4}));
                extraTween.push(FlxTween.tween(dadGroup, {y: enemyY + 100}, 1.4, {ease: FlxEase.quadInOut, type: 4}));
            case 11:
                eventTweens.push(FlxTween.tween(camFollow, {x: getVar('posValBF')[0], y: getVar('posValBF')[1]}, (2 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.cubeInOut}));
            case 12:
                setVar('camMove', false);
                setVar('camMoveZoom', false);
                dad.visible = false;
                boyfriendGroup.visible = false;
                game.getLuaObject('bfCape').visible = false;
                fresco.alpha = 1;
                fresco.animation.play('llevar');
            case 13:
                eventTweens.push(FlxTween.tween(fresco, {y: -865}, (3 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadIn}));
                eventTweens.push(FlxTween.tween(camFollow, {y: -3250}, (4 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoInOut}));
            case 14:
                blackBarThingie.alpha = 1;
        }
    }
    return;
}
function onPause(){
    for (t in extraTween) t.active = false;
    return;
}

function onResume(){
    for (t in extraTween) t.active = true;
    return;
}