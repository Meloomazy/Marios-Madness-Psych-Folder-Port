import objects.BGSprite;
import flixel.text.FlxText;
import flixel.effects.FlxFlicker;

var eventTweens = [];
var eventTimers = [];

var building;
var bgstars;
var platformlol;
var pixelLights;

var ringcount;
var scoreNES;
var countmix;

var rings = 0;
var nodamage = false;
function onCreate(){    
    var bg = new BGSprite('stages/Somari/somari_stag1', 256, 222, 0, 0);
    bg.scale.set(4, 4);
    bg.antialiasing = false;
    bg.updateHitbox();

    building = new BGSprite('stages/Somari/buildings_papu', 256, 222, 0, 0, ['buildings papu color'], true);
    building.animation.addByPrefix('idle', 'buildings papu color', 1, true);
    building.animation.play('idle');
    building.scale.set(4, 4);
    building.antialiasing = false;
    building.updateHitbox();

    bgstars = new BGSprite('stages/Somari/bgstars', 256, 222, 0, 0, ['bgstars flash'], true);
    bgstars.animation.addByPrefix('idle', 'bgstars flash', 5, true);
    bgstars.animation.play('idle');
    bgstars.scale.set(4, 4);
    bgstars.antialiasing = false;
    bgstars.updateHitbox();
    // bgstars.velocity.set(-40, 0);

    addBehindGF(bgstars);
    addBehindGF(building);
    addBehindGF(bg);

    eventTweens.push(FlxTween.tween(bgstars, {x: bgstars.x - 1388}, 30, {type: 2}));

    platformlol = new BGSprite('stages/Somari/platform', 922.5, 593, 1, 1);
    platformlol.scale.set(4, 4);
    platformlol.updateHitbox();
    platformlol.antialiasing = false;
    add(platformlol);

    ringcount = new FlxText(-115, 720, FlxG.width, '00', 24);
    ringcount.setFormat(Paths.font("mariones.ttf"), 40, FlxColor.WHITE, 'right');
    ringcount.antialiasing = false;
    ringcount.cameras = [camHUD];
    add(ringcount);
    if (ClientPrefs.data.downScroll) ringcount.y = 20;

    scoreNES = new FlxText(115, 720, FlxG.width, '000000', 24);
    scoreNES.setFormat(Paths.font("mariones.ttf"), 40, FlxColor.WHITE, 'left');
    scoreNES.antialiasing = false;
    scoreNES.cameras = [camHUD];
    add(scoreNES);
    if (ClientPrefs.data.downScroll) scoreNES.y = 20;

    var	ringicon:BGSprite = new BGSprite('stages/Somari/image', 1020, ringcount.y, 1, 1);
    ringicon.scale.set(8, 8);
    ringicon.updateHitbox();
    ringicon.antialiasing = false;
    ringicon.cameras = [camHUD];
    add(ringicon);

    pixelLights = new BGSprite('stages/Somari/spot', 370.5, 321, 1, 1, ['spot 3']);
    pixelLights.animation.addByPrefix('double', 'spot 3', 1, true);
    pixelLights.animation.addByPrefix('full', 'spot 0', 1, true);
    pixelLights.animation.addByPrefix('left', 'spot 1', 1, true);
    pixelLights.animation.addByPrefix('right', 'spot 2', 1, true);
    pixelLights.animation.play('double');
    pixelLights.scale.set(4, 4);
    pixelLights.updateHitbox();
    pixelLights.antialiasing = false;
    pixelLights.visible = false;
    add(pixelLights);


    countmix = new FlxSprite().loadGraphic(Paths.image('pixelUI/countdown'));
    countmix.width = countmix.width / 4;
    countmix.height = countmix.height / 2;
    countmix.loadGraphic(Paths.image('pixelUI/countdown'), true, Math.floor(countmix.width), Math.floor(countmix.height));
    countmix.scale.set(6, 6);
    countmix.antialiasing = false;
    countmix.visible = false;
    countmix.cameras = [camHUD];
    countmix.updateHitbox();
    countmix.screenCenter();
    countmix.animation.add("3", [0, 4], 10, true);
    countmix.animation.add("2", [1, 5], 10, true);
    countmix.animation.add("1", [2, 6], 10, true);
    countmix.animation.add("go", [3, 7], 10, true);
    add(countmix);

    return;
}
var startedCountdown = false;
var m = false;
function onStartCountdown(){
    startedCountdown = false;
    if (!m){
        m = true;
        eventTimers.push(new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            FlxG.sound.play(Paths.sound('mixcountdown'), 0.6);
            countmix.animation.play("3");
            countmix.visible = true;
        }));
        eventTimers.push(new FlxTimer().start(2.4, function(tmr:FlxTimer)
        {
            startedCountdown = true;
            game.startCountdown();
            for (strum in game.strumLineNotes) {
                strum.y = ClientPrefs.data.downScroll ? 960 - 300 : 50;
                strum.x += 30;
            }
            for (pl in game.playerStrums){
                pl.x -= 45;
            }
        }));
        eventTimers.push(new FlxTimer().start(2, function(tmr:FlxTimer)
        {
            FlxG.sound.play(Paths.sound('mixcountdown'), 0.6);
            countmix.animation.play("2");
        }));
        eventTimers.push(new FlxTimer().start(3, function(tmr:FlxTimer)
        {
            FlxG.sound.play(Paths.sound('mixcountdown'), 0.6);
            countmix.animation.play("1");
        }));
        eventTimers.push(new FlxTimer().start(4, function(tmr:FlxTimer)
        {
            FlxG.sound.play(Paths.sound('mixcountdownend'), 0.6);
            countmix.animation.play("go");
        }));
        eventTimers.push(new FlxTimer().start(5, function(tmr:FlxTimer)
        {
            remove(countmix);
            countmix.destroy();
        }));
    }
}

function onCreatePost(){
    uiGroup.visible = false;
    FlxG.camera.target = null;

    FlxTween.tween(platformlol, {y: platformlol.y - 126}, 3, {type: 4, loopDelay: 1});
    FlxTween.tween(boyfriend, {y: boyfriend.y - 126}, 3, {type: 4, loopDelay: 1});
    FlxTween.tween(gf, {y: gf.y - 126}, 3, {type: 4, loopDelay: 1});
    return;
}

function goodNoteHit(note){
    scoreNES.text = formatMario(game.songScore, 6);
    if (note.noteType == 'Ring Note'){
        var extrazero = '0';
        rings += 1;
        if(rings < 10){
            extrazero = '0';
        }
        else{
            extrazero = '';
        }
        ringcount.text = extrazero + rings;
        FlxG.sound.play(Paths.sound('ringhit'));
    }

    return;
}

function noteMiss(note){
    if (!note.isSustainNote){
        if(rings == 0){
            FlxG.sound.play(Paths.sound('ringout'));
            if (!nodamage) game.health = 0;
        }
        else{
            game.health = 2;
            FlxFlicker.flicker(boyfriendGroup, 3, 0.2, true);
            FlxG.sound.play(Paths.sound('ringloss'));
            eventTimers.push(new FlxTimer().start(0.5, function(tmr:FlxTimer){
                boyfriend.dance();
            }));
        }
        if (gf.curCharacter == 'eeveefriend')
            {
                gf.playAnim('sad' + FlxG.random.int(1, 4));
                gf.specialAnim = true;
                eventTimers.push(new FlxTimer().start(1, function(tmr:FlxTimer){
                    gf.dance();
                    gf.specialAnim = false;        
                }));
            }
        if(rings > 5){
            rings = Std.int(rings / 2);
        }else{
            rings = 0;
        }
        boyfriend.playAnim('hit', true);
        nodamage = true;

        eventTimers.push(new FlxTimer().start(3, function(tmr:FlxTimer){
            nodamage = false;
        }));
        ringcount.text = '00';
    }
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Triggers Universal' || n == 'Triggers MARIO SING AND GAME RYTHM 9'){
        if (v1 == '1'){
            if(v2 == 'none'){
                pixelLights.visible = false;
                remove(bgstars);
                insert(members.indexOf(building) - 1, bgstars);
            }else{
                pixelLights.visible = true;
                pixelLights.animation.play(v2);
                if(v2 == 'full'){
                    remove(bgstars);
                    insert(members.indexOf(pixelLights) + 1, bgstars);
                }else{
                    remove(bgstars);
                    insert(members.indexOf(building) - 2, bgstars);
                }
            }
        }
    }

    return;
}


function formatMario(num:Float, size:Int):String {
    var finalVal:String = "";
    var stringNum:String = Std.string(Math.round(num));

    for (zero in 0...(size - stringNum.length))
        finalVal += "0";

    finalVal += stringNum;

    return finalVal;
}