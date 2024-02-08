import objects.BGSprite;

using StringTools;

var useShader = !getModSetting('noShaders');

var test3;
var test5;
var oldTv;
var bright;

var promoBGSad;
var promoBG;
var promoDesk;
var darkFloor;
var bgLuigi;
var bgPeach;
var stanlines;

var blackBarThingie;
var tvTransition;

var stantext = 1;
var tilt = 0;

var eventTweens = [];
var extraTween = [];

function onCreate(){
    game.addCharacterToList('stanley', 1);

    promoBGSad = new BGSprite('stages/promo/promobg', 0, 19, 1, 1, ['bg depression'], true);
    promoBGSad.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(promoBGSad);
    promoBGSad.alpha = 0.001;

    promoBG = new BGSprite('stages/promo/promobg', 0, 19, 1, 1, ['bg normal'], true);
    promoBG.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(promoBG);

    promoDesk = new BGSprite('stages/promo/promodesk', 740, 552, 1, 1, ['Promario desk static'], true);
    promoDesk.animation.addByPrefix('stat', 'Promario desk static', 24, true);
    promoDesk.animation.addByPrefix('luigi', 'Promario desk luigi', 24, true);
    promoDesk.animation.addByPrefix('flash', 'Promario desk flash', 24, false);
    promoDesk.antialiasing = ClientPrefs.data.antialiasing;
    addBehindDad(promoDesk);

    darkFloor = new BGSprite('stages/promo/wood floor', 600, 800, 1, 1);
    darkFloor.antialiasing = ClientPrefs.data.antialiasing;
    darkFloor.alpha = 0.001;
    addBehindGF(darkFloor);

    bgLuigi = new BGSprite('stages/promo/promo_luigi', 200, 275, 1, 1, ['luigi idle right'], false);
    bgLuigi.animation.addByPrefix('idle', 'luigi idle right', 24, false);
    bgLuigi.animation.addByPrefix('idle-alt', 'luigi idle left', 24, false);
    bgLuigi.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(bgLuigi);
    bgLuigi.alpha = 0;

    bgPeach = new BGSprite('stages/promo/promo_peach', 1225, 225, 1, 1, ['peach idle right'], false);
    bgPeach.animation.addByPrefix('idle', 'peach idle right', 24, false);
    bgPeach.animation.addByPrefix('idle-alt', 'peach idle left', 24, false);
    bgPeach.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(bgPeach);
    bgPeach.alpha = 0;

    stanlines = new BGSprite('stages/promo/stanley_lines', 550, 500, 1, 1, ['lines'], false);
    stanlines.animation.addByIndices('line1', 'lines', [0], "", 24, true);
    stanlines.animation.addByIndices('line2', 'lines', [1], "", 24, true);
    stanlines.animation.addByIndices('line3', 'lines', [2], "", 24, true);
    stanlines.animation.addByIndices('line4', 'lines', [3], "", 24, true);
    stanlines.animation.addByIndices('line5', 'lines', [4], "", 24, true);
    stanlines.animation.addByIndices('line6', 'lines', [5], "", 24, true);
    stanlines.animation.addByIndices('line7', 'lines', [6], "", 24, true);
    stanlines.animation.addByIndices('line8', 'lines', [7], "", 24, true);
    stanlines.antialiasing = ClientPrefs.data.antialiasing;
    stanlines.alpha = 0.001;
    add(stanlines);

    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.alpha = 0;
    blackBarThingie.cameras = [getVar('camEst')];
    addBehindGF(blackBarThingie);

    tvTransition = new BGSprite('stages/promo/tv_trans', 0, 0, 1, 1, ['transition'], false);
    tvTransition.animation.addByPrefix('dothething', 'transition', 24, false);
    tvTransition.antialiasing = ClientPrefs.data.antialiasing;
    tvTransition.cameras = [getVar('camEst')];
    tvTransition.alpha = 0.001;
    addBehindGF(tvTransition);



    return;
}

function onCreatePost(){
    camFollow.setPosition(804, 742);
    FlxG.camera.snapToTarget();

    iconP1.flipX = healthBar.flipX = iconP2.flipX = true;
    game.updateIconsPosition = function(){
        var barCenter = healthBar.leftBar.x + FlxMath.lerp(0, healthBar.barWidth, healthBar.percent / 100) + healthBar.barOffset.x;
		iconP1.x = barCenter - (150 * iconP1.scale.x) / 2 - 46;
		iconP2.x = barCenter + (150 * iconP2.scale.x) / 2 - 116;

        
        //iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		//iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);
    }
    if (useShader){
        game.initLuaShader('test3');
        game.initLuaShader('test5');
        game.initLuaShader('oldTvEffect');
        game.initLuaShader('brightness');

        test3 = game.createRuntimeShader('test3');
        test5 = game.createRuntimeShader('test5');
        oldTv = game.createRuntimeShader('oldTvEffect');
        bright = game.createRuntimeShader('brightness');
        bright.setFloat('brightness', 1);
        bright.setFloat('contrast', 1);


        var sh = [new ShaderFilter(bright),new ShaderFilter(test3),new ShaderFilter(oldTv), new ShaderFilter(test5)];
        game.camGame.filters = sh;
        game.camHUD.filters = sh;
        getVar('camEst').filters = sh;
    }
    return;
}

var g = 0;
function onUpdate(e){
    g += e;
    test3.setFloat('time', g);
    oldTv.setFloat('iTime', g);
    return;
}

function onBeatHit(){
    if (dad.curCharacter == 'stanley'){
        if (curBeat % 2 == 0){
            if (!dad.animation.curAnim.name.startsWith("sing"))
                dad.animation.play('idle', true);

            bgLuigi.animation.play('idle', true);
            bgPeach.animation.play('idle', true);

            camGame.flashSprite.rotation = -tilt;
            eventTweens.push(FlxTween.tween(camGame.flashSprite, {rotation: 0}, (1 * (1 / (Conductor.bpm / 60))) - 0.05, {ease: FlxEase.quadIn}));
        }
        if (curBeat % 4 == 0){
            if (!dad.animation.curAnim.name.startsWith("sing"))
                dad.animation.play('idle-alt', true);

            bgLuigi.animation.play('idle-alt', true);
            bgPeach.animation.play('idle-alt', true);

            camGame.flashSprite.rotation = tilt;
            eventTweens.push(FlxTween.tween(camGame.flashSprite, {rotation: 0}, (1 * (1 / (Conductor.bpm / 60))) - 0.05, {ease: FlxEase.quadIn}));
        }
    }
    return;
}

function onEvent(n,v1,v2){
    if (n == 'setProperty'){
        if (v1 == 'cameraTilt'){
            tilt = Std.parseFloat(v2);
        }
    }
    if (n == 'Triggers Promotion' || n == 'Triggers Universal'){
        var triggerMR:Float = Std.parseFloat(v1);
        switch (triggerMR){
            case 0:
                tvTransition.animation.play('dothething');
                tvTransition.alpha = 1;
                new FlxTimer().start(0.08, function(tmr:FlxTimer){
                    blackBarThingie.alpha = 1;
                    camHUD.alpha = 0;
                });
            case 1:
                promoBG.alpha = 0;
                promoBGSad.alpha = 0;
                promoDesk.alpha = 0;
                boyfriend.alpha = 0;
                gf.alpha = 0;

                darkFloor.alpha = 1;

                setVar('dadZoom', 0.7);
                setVar('bfZoom', 0.7);

                stanlines.alpha = 0;

                if (game.health > 1)
                    game.health = 1;

                game.triggerEvent('Change Character', '1', 'stanley');
                dad.x = 697;
                dad.y = 215;

                eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: 0}, 4, {ease: FlxEase.quadInOut}));
                eventTweens.push(FlxTween.tween(camHUD, {alpha: 1}, 4, {ease: FlxEase.quadInOut}));
            case 2:
                eventTweens.push(FlxTween.tween(bgLuigi, {alpha: 1}, 0.4, {ease: FlxEase.quadInOut}));
            case 3:
                eventTweens.push(FlxTween.tween(bgPeach, {alpha: 1}, 0.4, {ease: FlxEase.quadInOut}));
            case 4:
                stanlines.alpha = 1;
                stanlines.animation.play('line' + stantext, true);
                stantext += 1;
                stanlines.angle = FlxG.random.int(30, -30);
                stanlines.x = 550;
                stanlines.y = 500;
                if (FlxG.random.int(0, 100) > 50)
                    eventTweens.push(FlxTween.tween(stanlines, {x: stanlines.x - 150}, (2 * (1 / (Conductor.bpm / 60))) - 0.05, {ease: FlxEase.quadOut}));
                else
                    eventTweens.push(FlxTween.tween(stanlines, {x: stanlines.x + 150}, (2 * (1 / (Conductor.bpm / 60))) - 0.05, {ease: FlxEase.quadOut}));
                if (FlxG.random.int(0, 100) > 50)
                    eventTweens.push(FlxTween.tween(stanlines, {y: stanlines.y - 75}, (2 * (1 / (Conductor.bpm / 60))) - 0.05, {ease: FlxEase.quadOut}));
                else
                    eventTweens.push(FlxTween.tween(stanlines, {y: stanlines.y + 75}, (2 * (1 / (Conductor.bpm / 60))) - 0.05, {ease: FlxEase.quadOut}));

                FlxTween.tween(stanlines, {alpha: 0}, (1 * (1 / (Conductor.bpm / 60))) - 0.05, {startDelay: (1 * (1 / (Conductor.bpm / 60)))});
            case 5:
                setVar('camMove', false);
                game.triggerEvent('Play Animation', 'depression', 'dad');
                dad.idleSuffix = '-alt';
                extraTween.push(FlxTween.tween(camFollow, {x: 1009, y:544}, 3, {ease: FlxEase.quadInOut, onComplete: () -> setVar('camMove', true)}));
                promoDesk.animation.play('flash', true);
                new FlxTimer().start(0.3, function(tmr:FlxTimer){
                    promoDesk.animation.play('luigi', true);
                    new FlxTimer().start(0.8, function(tmr:FlxTimer)
                    {
                        promoBGSad.alpha = 1;
                        eventTweens.push(FlxTween.tween(promoBG, {alpha: 0}, 1, {ease: FlxEase.quadInOut}));
                    });
                });
            case 6:
                for (tween in extraTween)
                    {
                        tween.cancel();
                    }
            case 7:
                eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: 1}, 4));
                eventTweens.push(FlxTween.tween(camHUD, {alpha: 0}, 4));
        }
    }
    return;
}