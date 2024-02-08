import flixel.addons.display.FlxBackdrop;
import openfl.Lib;

var headBG;
var blackBarThingie;

var funyBop = false;

var curGlitch = 0;
var splitWin = 1;
var limitSplit = 1;

var stronkLerp = 0;
var glitchBop = true;

var eventTimers = [];
var eventTweens = [];

game.initLuaShader('multisplit');
game.initLuaShader('angel');
var split = game.createRuntimeShader('multisplit');
var wav = game.createRuntimeShader('angel');
function onCreate(){
    headBG = new FlxBackdrop(Paths.image('stages/virtual/headbg'), 0x11, 0, 1);
    headBG.scale.set(1.5, 1.5);
    headBG.updateHitbox();
	addBehindGF(headBG);
    headBG.alpha = 0.001;

    split.setFloat('multi', 1);


    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.scrollFactor.set(0, 0);
    blackBarThingie.alpha = 0;
    blackBarThingie.cameras = [camOther];
    add(blackBarThingie);
    return;
}

var g = 0;
var revr = false;

function onUpdate(el){
    g += el;
    
    stronkLerp = FlxMath.lerp(0, stronkLerp, FlxMath.bound(1 - (el * 9 * game.playbackRate), 0, 1));
    wav.setFloat('stronk', stronkLerp);
    wav.setFloatArray('pixel', [1, 1]);
    wav.setFloat('time', g);

    if (splitWin == 1)
        revr = false;
    else if (splitWin == limitSplit)
        revr = true;


    return;
}
function onBeatHit(){
    if (glitchBop){
        if (curBeat % curGlitch == 0){
            if (revr){
                splitWin -= 1;
                game.camGame.flashSprite.scaleX = -1;
            }else{
                splitWin += 1;
                game.camGame.flashSprite.scaleX = 1;
            }
            stronkLerp += 0.25;
            split.setFloat('multi', splitWin);
        }
    }
    if (curBeat % 4 == 0){
        IMINYOURHEAD();
    }
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Add Camera Zoom') IMINYOURHEAD();
    if (n == 'Alt Idle Animation') iconP1.changeIcon('bfvsad');

    if (n == 'Triggers Universal' || n == 'Triggers Paranoia'){
        var trigger:Float = Std.parseFloat(v1);
        if (Math.isNaN(trigger))
            trigger = 0;
        switch (trigger)
        {
            case 1:
                setVar('camMove', true);
                setVar('camMoveZoom', true);
                game.getLuaObject('fakeGF').visible = false;
                blackBarThingie.alpha = 0;
                camHUD.alpha = 1;
            case 2:
                blackBarThingie.alpha = 1;
            case 3:
                var turtle = game.getLuaObject('koop1');
                var turtle2 = game.getLuaObject('koop2');
                turtle.offset.x = 130;
                turtle2.offset.x = 40;
                turtle.alpha = 1;
                turtle2.alpha = 1;
                turtle.animation.play('glitch');
                turtle2.animation.play('glitch');
                eventTimers.push(new FlxTimer().start(0.8, function(tmr:FlxTimer)
                    {
                        turtle.animation.play('idle');
                        turtle2.animation.play('idle');
                        turtle.offset.x = 0;
                        turtle2.offset.x = 0;
                    }));
            case 4:
                blackBarThingie.alpha = 0;
            case 6:
                setVar('camMove', false);
                setVar('camMoveZoom', false);
                game.getLuaObject('koop1').animation.play('in', true, true, 10);
                game.getLuaObject('koop2').animation.play('in', true, true, 10);
                eventTimers.push(new FlxTimer().start(0.41, function(tmr:FlxTimer)
                    {
                        game.getLuaObject('koop1').visible = false;
                        game.getLuaObject('koop2').visible = false;
                    }));
                eventTweens.push(FlxTween.tween(game.getLuaObject('WallBg'), {alpha: 0}, 0.5, {startDelay: 0.2, ease: FlxEase.sineIn}));
                eventTweens.push(FlxTween.tween(camFollow, {x: 1200, y: 60}, 0.7, {ease: FlxEase.quadOut}));
                eventTweens.push(FlxTween.tween(camGame, {zoom: 1.4}, 4, {ease: FlxEase.quadIn}));
                eventTweens.push(FlxTween.tween(game, {defaultCamZoom: 1.4}, 4, {ease: FlxEase.quadIn}));
                eventTimers.push(new FlxTimer().start(1, function(tmr:FlxTimer)
                {                    
                    game.getLuaObject('fakeGF').alpha = 1;
                    game.getLuaObject('fakeGF').animation.play('dies');
                }));
        }
        if (v1 == '4'){
            funyBop = true;
            IMINYOURHEAD();
        }
        if (v1 == '45'){
            FlxTween.tween(Lib.application.window, {x: getVar('winX') - 200}, 3, {ease: FlxEase.sineInOut, onComplete: function(){
                eventTweens.push(FlxTween.tween(Lib.application.window, {x: Lib.application.window.x + 400}, 5, {ease: FlxEase.sineInOut, startDelay: 0.5, type: 4}));
            }});
        }
        if (v1 == '8'){
            curGlitch = Std.int(v2);
            game.camHUD.filters = [new ShaderFilter(wav)];
            game.camGame.filters = [new ShaderFilter(wav), new ShaderFilter(split)];        
            if (v2 == '0'){
                for (t in eventTweens) t.cancel();
                split.setFloat('multi', 1);
                game.camHUD.filters = [];
                game.camGame.filters = [];            
            }
        }
        if (v1 == '9'){
            limitSplit = Std.int(v2);
        }
    }
    return;
}


var funnyTween1:FlxTween;
var funnyTween2:FlxTween;
function IMINYOURHEAD(){
    if (funyBop){
        headBG.velocity.y = 1000;
        headBG.alpha = 1;

        if(funnyTween1 != null)
            funnyTween1.cancel();

        funnyTween1 = FlxTween.tween(headBG.velocity, {y: 0}, 0.4, {
            ease: FlxEase.quadOut,
            onComplete: function(twn:FlxTween) {
                funnyTween1 = null;
            }
        });

        if(funnyTween2 != null)
            funnyTween2.cancel();
        funnyTween2 = FlxTween.tween(headBG, {alpha: 0.25}, 0.4, {
            ease: FlxEase.quadOut,
            onComplete: function(twn:FlxTween) {
                funnyTween2 = null;
            }
        });
    }
}