import flixel.addons.display.FlxBackdrop;
import openfl.Lib;

var funyBop = false;
var headBG;
var curGlitch = 0;
var splitWin = 1;
var limitSplit = 1;
var stronkLerp = 0;
var glitchBop = true;

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
                splitWin -= 0.5;
                //game.camGame.flashSprite.scaleX = -1;
            }else{
                splitWin += 0.5;
                //game.camGame.flashSprite.scaleX = 1;
            }
            stronkLerp = 0.225;
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

    if (n == 'Triggers Paranoia'){
        if (v1 == '4'){
            funyBop = true;
            IMINYOURHEAD();
        }
        if (v1 == '45'){
            //FlxTween.tween(Lib.application.window, {x: getVar('winX') - 200}, 3, {ease: FlxEase.sineInOut, onComplete: function(){
               // FlxTween.tween(Lib.application.window, {x: Lib.application.window.x + 400}, 5, {ease: FlxEase.sineInOut, startDelay: 1, type: 4});
           // }});
            game.camHUD.filters = [new ShaderFilter(wav)];
            game.camGame.filters = [new ShaderFilter(wav), new ShaderFilter(split)];        
        }
    }
    if (n == 'Triggers Universal'){
        if (v1 == '8'){
            curGlitch = Std.int(v2);
            if (v2 == '0') split.setFloat('multi', 1);
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

        funnyTween1 = FlxTween.tween(headBG.velocity, {y: 0}, 0.5, {
            ease: FlxEase.cubeOut,
            onComplete: function(twn:FlxTween) {
                funnyTween1 = null;
            }
        });

        if(funnyTween2 != null)
            funnyTween2.cancel();
        funnyTween2 = FlxTween.tween(headBG, {alpha: 0.25}, 0.5, {
            ease: FlxEase.cubeOut,
            onComplete: function(twn:FlxTween) {
                funnyTween2 = null;
            }
        });
    }
}