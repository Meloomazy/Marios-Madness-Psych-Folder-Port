import objects.BGSprite;
import objects.HealthIcon;
import flixel.text.FlxText;
import Type;

var lluvia;
var blackBarThingie;
var bfcolgao;
var canFade = false;

var eventTweens = [];
var eventTimers = [];
var extraTween = [];
var camEst;

var mario;
var iconMario;
function onCreate(){
    game.skipCountdown = true;
    FlxG.cameras.remove(game.camHUD,false);
    FlxG.cameras.remove(game.camOther,false);
    camEst = new FlxCamera();
    camEst.bgColor = 0x00;
    FlxG.cameras.add(camEst,false);
    FlxG.cameras.add(game.camHUD,false);
    FlxG.cameras.add(game.camOther,false);

    var bg:BGSprite = new BGSprite('stages/LuigiBeta/Skybox', -1200, -850, 0.2, 0.2);
    bg.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(bg);

    var scarymansion:BGSprite = new BGSprite('stages/LuigiBeta/BackBG', -1200, -850, 0.8, 0.8);
    scarymansion.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(scarymansion);

    mario = new Character(0, 0, 'mario-alone');
    mario.scale.set(0.2, 0.2);
    mario.scrollFactor.set(0.8, 0.8);
    mario.alpha = 0.000001;
    mario.x = 310;
    mario.y = -360;
    addBehindGF(mario);

    iconMario = new HealthIcon('alonemario', false);
	iconMario.alpha = 0;
    iconMario.camera = camHUD;
	add(iconMario);


    var betafire1:BGSprite = new BGSprite('stages/LuigiBeta/Alone_Fire', -320, -630, 0.8, 0.8, ['fire'], true);
    betafire1.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(betafire1);

    var betafire2:BGSprite = new BGSprite('stages/LuigiBeta/Alone_Fire', 1270, -630, 0.8, 0.8, ['fire'], true);
    betafire2.antialiasing = ClientPrefs.data.antialiasing;
    betafire2.flipX = true;
    addBehindGF(betafire2);

    var scaryfloor:BGSprite = new BGSprite('stages/LuigiBeta/FrontBG', -1200, -850);
    scaryfloor.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(scaryfloor);

    lluvia = new BGSprite('stages/LuigiBeta/old/Beta_Luigi_Rain_V1', -170, 50, 0, 0, ['RainLuigi'], true);
    lluvia.setGraphicSize(Std.int(lluvia.width * 1.7));
    lluvia.alpha = 0;
    lluvia.antialiasing = ClientPrefs.data.antialiasing;
    lluvia.cameras = [camEst];
    add(lluvia);

    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.cameras = [camEst];
    blackBarThingie.scrollFactor.set(0, 0);
    add(blackBarThingie);

    var fogblack:FlxSprite = new FlxSprite().loadGraphic(Paths.image('modstuff/126'));
    fogblack.antialiasing = ClientPrefs.antialiasing;
    fogblack.cameras = [camEst];
    fogblack.alpha = 0.8;
    fogblack.screenCenter();
    add(fogblack);

    bfcolgao = new FlxSprite(700, -100);
    bfcolgao.frames = Paths.getSparrowAtlas('modstuff/Beta_BF_Hang');
    bfcolgao.animation.addByPrefix('idle', "BFHang", 24);
    bfcolgao.antialiasing = ClientPrefs.antialiasing;
    bfcolgao.cameras = [camEst];
    bfcolgao.alpha = 0;
    add(bfcolgao);

    return;
}

function onCreatePost(){
    uiGroup.alpha = 0;
    boyfriendGroup.alpha = 0;
    gfGroup.alpha = 0;
    game.health = 2;


    for (n in game.unspawnNotes){
        if (n.noteType == 'Yoshi Note'){
            n.visible = false; 
            n.noAnimation = true;
        }
    }
    return;
}

function onSongStart(){
    camGame.zoom = 1.3;

    eventTweens.push(FlxTween.tween(camGame, {zoom: 0.8}, 3.7, {ease: FlxEase.quadOut}));
    eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: 0.5}, 3.5, {startDelay: 1, ease: FlxEase.quadInOut}));

    extraTween.push(FlxTween.tween(boyfriendGroup, {y: boyfriendGroup.y - 20}, 3, {ease: FlxEase.quadInOut, type: 4}));
    extraTween.push(FlxTween.tween(boyfriendGroup, {x: boyfriendGroup.x + 40}, 5, {ease: FlxEase.quadInOut, type: 4}));

    extraTween.push(FlxTween.tween(gf, {y: gfGroup.y + 40}, 2, {startDelay: 0.2, ease: FlxEase.quadInOut, type: 4}));
    extraTween.push(FlxTween.tween(gf, {x: gfGroup.x - 20}, 4, {startDelay: 0.2, ease: FlxEase.quadInOut, type: 4}));
    
    return;
}

function onUpdate(){
    if (canFade){
        boyfriendGroup.alpha = game.health / 2;
        if(game.health > 1.8){
            boyfriendGroup.alpha = 0.9;
        }else if(game.health < 0.4){
            boyfriendGroup.alpha = 0.2;
        }
    }
    if (!mario.stunned && mario.holdTimer > Conductor.stepCrochet * 0.0011 * mario.singDuration && StringTools.startsWith(mario.animation.curAnim.name, 'sing'))
        {
            mario.dance();
        }
    iconMario.x = iconP2.x -70;
    iconMario.scale.set(iconP1.scale.x - 0.2, iconP1.scale.y - 0.2);
    iconMario.animation.curAnim.curFrame = iconP2.animation.curAnim.curFrame;
    return;
}

function onStepHit(){
    if (lluvia.alpha != 0){
        game.triggerEvent('Triggers Alone', '3', '');
    }

    return;
}

function onBeatHit(){
	if (curBeat % mario.danceEveryNumBeats == 0 && mario.animation.curAnim != null && !StringTools.startsWith(mario.animation.curAnim.name, 'sing') && !mario.stunned)
	{
		mario.dance();
	}
    return;
}
function onEvent(n,v1,v2){
    if (n == 'Triggers Universal'){
        var songName = PlayState.SONG.song;
        game.triggerEvent('Triggers ' + songName, '' + v1, '' + v2);
    }
    if (n == 'Triggers Alone'){
        var triggerMR:Float = Std.parseFloat(v1);
        if (Math.isNaN(triggerMR))
            triggerMR = 0;
        switch (triggerMR)
        {
            case 0:
                FlxG.camera.flash(FlxColor.WHITE, 1);
                FlxG.sound.play(Paths.sound('thunder_1'));
                bfcolgao.animation.play('idle');
                bfcolgao.alpha = 1;
                eventTweens.push(FlxTween.tween(bfcolgao, {alpha: 0}, 2, {ease: FlxEase.quadOut}));
                eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: 0}, 5));
                eventTweens.push(FlxTween.tween(lluvia, {alpha: 0.6}, 5));
            case 1:
                FlxG.camera.flash(FlxColor.WHITE, 1);
                FlxG.sound.play(Paths.sound('thunder_1'));
            case 2:
                FlxG.camera.flash(FlxColor.WHITE, 1);
                FlxG.sound.play(Paths.sound('thunder_1'));
                lluvia.visible = true;
            case 3:
                var gota:BGSprite = new BGSprite('stages/LuigiBeta/gota', 1270, 700, 1, 1, ['rain'], false);
                gota.antialiasing = ClientPrefs.data.antialiasing;
                gota.x = FlxG.random.int(0, 1270);
                gota.y = FlxG.random.int(400, 1000);
                if(gota.y > 550){
                    add(gota);
                }else{
                    insert(members.indexOf(gfGroup) - 1, gota);
                }
                
                gota.alpha = 0.4;
                gota.dance(true);

                eventTweens.push(FlxTween.tween(gota, {alpha: 0}, 2, {startDelay: 0.3, onComplete: function(twn:FlxTween)
                {
                    gota.destroy();

                }}));
            case 4:
                eventTweens.push(FlxTween.tween(uiGroup,         {alpha: 1}, 2));
            case 5:
                eventTweens.push(FlxTween.tween(uiGroup,         {alpha: 0}, 2));
            case 6:
                eventTweens.push(FlxTween.tween(gf,      {alpha: 0.8}, 2));
                eventTweens.push(FlxTween.tween(boyfriendGroup, {alpha: 0.8}, 2, {onComplete: function(twn:FlxTween)
                    {
                        canFade = true;
                    }}));
            case 7:
                //alone mario
                
                eventTimers.push(new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        mario.alpha = 0;
                        iconMario.y = iconP2.y - (!ClientPrefs.data.downScroll ? 15 : -15);
                        eventTweens.push(FlxTween.tween(iconMario, {alpha: 0.9}, 2, {ease: FlxEase.quadOut}));
                        eventTweens.push(FlxTween.tween(mario, {alpha: 0.9}, 2, {ease: FlxEase.quadOut}));
                        eventTweens.push(FlxTween.tween(mario.scale, {x: 1, y: 1}, 3, {ease: FlxEase.quadOut}));
                        eventTweens.push(FlxTween.tween(mario.scrollFactor, {x: 0.95, y: 0.95}, 3, {ease: FlxEase.quadOut}));
                        eventTweens.push(FlxTween.tween(mario, {x: 630, y: -420}, 1.5, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween)
                            {
                                eventTweens.push(FlxTween.tween(mario, {x: 600, y:  -360}, 1.5, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween)
                                    {
                                        eventTweens.push(FlxTween.tween(mario, {x: mario.x - 550}, 5, {ease: FlxEase.quadInOut, type: 4}));
                                        eventTweens.push(FlxTween.tween(mario, {y: mario.y + 100}, 1.75, {ease: FlxEase.quadInOut, type: 4}));
                                    }}));
                            }}));
                    }));

                game.triggerEvent('Set Cam Zoom', '0.55', '');
                game.triggerEvent('Set Cam Pos', '720, 75', 'dad');
                setVar('posValDad', [720, 75]);
                game.callOnLuas('onSectionHit', []);
                setVar('camMove', false);
                eventTweens.push(FlxTween.tween(camGame, {zoom: 0.65}, 2, {ease: FlxEase.quadInOut}));
                eventTweens.push(FlxTween.tween(camFollow, {x: getVar('posValDad')[0], y: getVar('posValDad')[1] - 175}, 2, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween)
                    {
                        game.triggerEvent('Set Cam Pos', '720, 75', 'dad');
                        setVar('posValDad', [720, 75]);        
                        setVar('camMove', true);
                    }}));
            case 8:
                eventTweens.push(FlxTween.tween(mario, {y: -900}, 1.75, {ease: FlxEase.cubeIn}));
                eventTweens.push(FlxTween.tween(mario, {alpha: 0}, 1.75, {ease: FlxEase.cubeIn}));
                eventTweens.push(FlxTween.tween(iconMario, {alpha: 0}, 1.75, {ease: FlxEase.quadInOut}));
            case 10:
                setVar('posValDad', [420, 450]);
                game.triggerEvent('Set Cam Zoom', '0.8', '');
            case 11:
                eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: 0.3}, 5));

                eventTweens.push(FlxTween.tween(gf,      {alpha: 0}, 2.4));
                eventTweens.push(FlxTween.tween(boyfriendGroup, {alpha: 0}, 2.4, {onComplete: function(twn:FlxTween)
                    {
                        canFade = false;
                    }}));
            case 12:
                eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: 1}, 2));
            case 13:
                for (i in 0...v2.length)
                    {
                        var textLetter:String = v2.charAt(i);
                        var xPosition:Float = 300 + i * 5;

                        var ghostText:FlxText = new FlxText(xPosition, 520, 720, '', 120);
                        ghostText.setFormat(Paths.font("vcr.ttf"), 30, 0xFF198C0E, 'center', Type.resolveEnum('flixel.text.FlxTextBorderStyle').OUTLINE, FlxColor.BLACK);
                        ghostText.cameras = [camHUD];
                        ghostText.borderSize = 1.25;
                        ghostText.alpha = 0;
                        ghostText.y += 40;
                        ghostText.ID = i;
                        add(ghostText);
            
                        for (p in 0...v2.length)
                        {
                            if (p != i) ghostText.text += '  ';
                            else ghostText.text = textLetter;
                        }
            
                        extraTween.push(FlxTween.tween(ghostText, { y: (ghostText.y - 40) - FlxG.random.int(0, 5), alpha: 1, angle: 0 }, FlxG.random.float(1, 1.8), { ease: FlxEase.expoOut }));
                        extraTween.push(FlxTween.tween(ghostText, { y: ghostText.y + 40, alpha: 0 }, FlxG.random.float(1.4, 1.6), {
                            startDelay: (3 * (1 / (Conductor.bpm / 60))),
                            ease: FlxEase.cubeIn,
                            onComplete: function (twn:FlxTween)
                            {
                                ghostText.destroy();
                            }
                        }));
                    }
        }
    }
}

function opponentNoteHit(no){
    if (no.noteType == 'Yoshi Note' || no.noteType == 'GF Duet'){
        game.opponentStrums.members[no.noteData].playAnim('static', true); // it doesn't work for some reason,.,,. - meloom
        mario.playAnim(game.singAnimations[no.noteData], true);
        mario.holdTimer = 0;
    }
    return;
}