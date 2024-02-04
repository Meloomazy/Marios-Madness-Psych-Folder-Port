import flixel.addons.display.FlxBackdrop;

// shader stuff lmao
var useShader = !getModSetting('noShaders');
var test3;
var test5;
var test9;
var angel;
//

var birdUp:FlxSprite;
var laki:FlxSprite;

var lightningL:FlxSprite;
var lightningR:FlxSprite;

var fellas1:FlxBackdrop;
var fellas2:FlxBackdrop;

var fellasCam;
var hitboxIcon:FlxSprite;

function onCreatePost(){ 
    FlxG.cameras.remove(game.camHUD,false);
    FlxG.cameras.remove(game.camOther,false);
    fellasCam = new FlxCamera();
    fellasCam.bgColor = 0x00;
    FlxG.cameras.add(fellasCam,false);
    FlxG.cameras.add(game.camHUD,false);
    FlxG.cameras.add(game.camOther,false);
    
    birdUp = new FlxSprite(1180,720);
	birdUp.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
	birdUp.animation.addByPrefix('bird', 'Bird Up', 24, false);
    birdUp.animation.play('bird');
    birdUp.visible = false;
    add(birdUp);

    laki = new FlxSprite(-300,720);
	laki.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
	laki.animation.addByPrefix('laki', 'Lakitu', 24, false);
    laki.animation.play('laki');
    laki.visible = false;
    add(laki);
    
	lightningL = new FlxSprite(150,-100);
	lightningL.frames = Paths.getSparrowAtlas('stages/beatus/ycbu_lightning');
	lightningL.animation.addByPrefix('idle', 'lightning', 12, true);
    lightningL.animation.play('idle');
	lightningL.cameras = [fellasCam];
    add(lightningL);

    lightningR = new FlxSprite(950,-100);
	lightningR.frames = Paths.getSparrowAtlas('stages/beatus/ycbu_lightning');
	lightningR.animation.addByPrefix('idle', 'lightning', 12, true);
    lightningR.animation.play('idle');
	lightningR.cameras = [fellasCam];
    add(lightningR);

    fellas1 = new FlxBackdrop(null, 0x10, 0, 0);
    fellas1.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
	fellas1.animation.addByPrefix('suit', 'Rotat e', 28, true);
    fellas1.animation.addByPrefix('birdup', 'Bird Up', 24, false);
    fellas1.animation.addByPrefix('lakitu', 'Lakitu', 24, false);
    fellas1.animation.play('suit');
    fellas1.velocity.set(0, 800);
    fellas1.scale.set(0.6, 0.6);
    fellas1.cameras = [fellasCam];
	add(fellas1);

    fellas2 = new FlxBackdrop(null, 0x10, 0, 0);
    fellas2.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
	fellas2.animation.addByPrefix('suit', 'Rotat e', 28, true);
    fellas2.animation.addByPrefix('birdup', 'Bird Up', 24, false);
    fellas2.animation.addByPrefix('lakitu', 'Lakitu', 24, false);
    fellas2.animation.play('suit');
    fellas2.flipX = true;
    fellas2.velocity.set(0, -800);
    fellas2.scale.set(0.6, 0.6);
    fellas2.cameras = [fellasCam];
	add(fellas2);

    hitboxIcon = new FlxSprite().makeGraphic(60, 60, FlxColor.WHITE);
    hitboxIcon.camera = game.camHUD;
    hitboxIcon.alpha = 0;
    add(hitboxIcon);

    lightningL.visible = false;

    if (useShader){
        game.initLuaShader('angel');
        game.initLuaShader('test3');
        game.initLuaShader('test5');
        game.initLuaShader('test9');
        test9 = game.createRuntimeShader('test9');
        test9.setFloat('amount', 0.5);
        test3 = game.createRuntimeShader('test3');
        test5 = game.createRuntimeShader('test5');
        angel = game.createRuntimeShader('angel');

        game.camGame.filters = [new ShaderFilter(angel), new ShaderFilter(test3), new ShaderFilter(test5)];
        game.camHUD.filters = [new ShaderFilter(test3), new ShaderFilter(test5)];
        fellasCam.filters = [new ShaderFilter(angel),new ShaderFilter(test3), new ShaderFilter(test5)];
        //game.camOther.filters = [new ShaderFilter(test3), new ShaderFilter(test5)];
    }
    return;
}
var offsetL = [0,0];
var lol = 0;
var ps = 0;
var st = 0;
var endBeat = false;
var dontMiss = false;
var step = 0;
function onUpdate(el){
    lol += el;
    if (useShader){
        test3.setFloat('time', lol);
        ps = FlxMath.lerp(1, ps, Math.exp(-el * 6));
        st = FlxMath.lerp(0, st, Math.exp(-el * 6));
        angel.setFloat('stronk', st);
        angel.setFloatArray('pixel', [ps, ps]);
        angel.setFloat('iTime', (Conductor.songPosition / 1000));
    }

    hitboxIcon.x = game.iconP1.x + 40;
    hitboxIcon.y = game.iconP1.y + 25;

    fellas1.x = (lightningL.x - 200 + offsetL[0]);
    fellas2.x = (lightningR.x - 200 + offsetL[1]);
    fellas1.visible = fellas2.visible = lightningR.visible = lightningL.visible;
    return;
}
var speedF = false;
var flipF = true;

var strum1Fade = false;
var uiFade = false;
var curLevel = 1;
function onEvent(n, v1, v2) {
    if (n == 'random bs'){
        if (v1 == 'yip'){
            birdUp.visible = laki.visible = false;
        }

        if (v1 == 'we are'){
            birdUp = new FlxSprite(1180,720);
            birdUp.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
            birdUp.animation.addByPrefix('bird', 'Bird Up', 24, false);
            birdUp.animation.play('bird');
        
            laki = new FlxSprite(-300,720);
            laki.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
            laki.animation.addByPrefix('laki', 'Lakitu', 24, false);
            laki.animation.play('laki');
            addBehindGF(laki);
            addBehindGF(birdUp);

            birdUp.x = 880;
            birdUp.y = 100;
            laki.x = 50;
            laki.y = 70;
            game.dad.alpha = 1;
            getVar('ycbu_hunter').alpha = 1;
            getVar('ycbu_hunter').x = game.dad.x - 480;
            getVar('ycbu_hunter').y = game.dad.y + 70;
            getVar('ycbu_bowser').x = 720;
            getVar('ycbu_bowser').y = 120;
        }
        if (v1 == 'score bowser'){
            getVar('ycbu_bowser').alpha = 1;
            getVar('ycbu_bowser').x = game.dad.x;
            getVar('ycbu_bowser').y = game.dad.y + 250;

            FlxTween.tween(getVar('ycbu_bowser'), {y: 120}, 1.2, {ease: FlxEase.quartOut});

        }
        if (v1 == 'score'){
            remove(birdUp);
            remove(laki);
        }
        if (v1 == 'world lakitu'){
            laki.x = game.dad.x;
            laki.y = game.dad.y + 620;

            FlxTween.tween(laki, {y: game.dad.y}, 1, {ease: FlxEase.quartOut});
        }
        if (v1 == 'world'){
            birdUp.visible = false;
            birdUp.x = game.dad.x + 150;
            birdUp.y = 0;
        }
        if (v1 == 'robot birdup'){
            birdUp.x = game.dad.x;
            birdUp.y = game.dad.y + 420;

            FlxTween.tween(birdUp, {y: game.dad.y}, 1, {ease: FlxEase.quartOut});
        }
        if (v1 == 'zapper duck'){
            getVar('ycbu_hunter').x = game.dad.x;
            getVar('ycbu_hunter').y = game.dad.y + 120;

            FlxTween.tween(getVar('ycbu_hunter'), {x: game.dad.y + 120}, 1, {ease: FlxEase.quartOut});
        }
        if (v1 == 'duo'){
            var ylol = game.dad.y;
            game.dad.y += 900;
            game.dad.alpha = 1;
            FlxTween.tween(getVar('ycbu_hunter'), {x: getVar('ycbu_hunter').x - 400}, 1, {ease: FlxEase.quartOut});
            FlxTween.tween(game.dad, {y: ylol}, 0.8, {ease: FlxEase.backOut});
        }
        if (v1 == 'end bowser'){
            getVar('ycbu_bowser').setPosition(1180, 1220);
            FlxTween.tween(getVar('ycbu_bowser'), {alpha: 1, x: 680, y: 120}, 1.2, {ease: FlxEase.quartOut});
        }
        if (v1 == 'end suit') endBeat = true;
        if (v1 == 'hunter dog'){
            getVar('ycbu_bowser').x = game.dad.x;
            getVar('ycbu_bowser').y = game.dad.y;
            getVar('ycbu_hunter').x = game.dad.x;
            getVar('ycbu_hunter').y = game.dad.y + 120;
        }

        if (v1 == 'bye'){
            getVar('ycbu_bowser').setPosition(680, 1220);
            getVar('ycbu_hunter').setPosition(-300, 1220);
            laki.visible = birdUp.visible = true;
        }
        if (v1 == 'beat me')
            FlxTween.tween(laki, {x: 0, y: 420}, 1.5, {ease: FlxEase.quartOut});
        if (v1 == 'beat you')
            FlxTween.tween(getVar('ycbu_bowser'), {x: 680, y: 120}, 1.5, {ease: FlxEase.quartOut});
        if (v1 == 'beat nint')
            FlxTween.tween(birdUp, {x: 880, y: 420}, 1.5, {ease: FlxEase.quartOut});
        if (v1 == 'beat sega')
            FlxTween.tween(getVar('ycbu_hunter'), {x: -300, y: 120}, 1.5, {ease: FlxEase.quartOut});
        if (v1 == 'beat idk'){
            laki.visible = birdUp.visible = false;
            getVar('ycbu_hunter').alpha = 0;
            getVar('ycbu_bowser').alpha = 0;
        }
    }
    if (n == 'Triggers Unbeatable'){
        if (v1 == '3'){
            if (game.health > 0.2 && !getModSetting('noMechs')) game.health -= 0.1; // its fair?
            hitboxIcon.alpha = 1;
            new FlxTimer().start(0.05, function(tmr:FlxTimer) {
                hitboxIcon.alpha = 0;
            });
            game.iconP1.colorTransform.redMultiplier = game.iconP1.colorTransform.greenMultiplier = game.iconP1.colorTransform.blueMultiplier = -1;
            FlxTween.tween(game.iconP1.colorTransform, {redMultiplier: 1, blueMultiplier: 1, greenMultiplier: 1}, 0.1);
        }
    }
    if (n == 'ycbu text'){ 
        if (v2 == '2') {
            birdUp.animation.play('bird', true); 
            laki.animation.play('laki', true);
        }
        if (v2 == '4'){
            birdUp.animation.play('bird', true); 
            fellas1.animation.play('birdup', true); 
            fellas2.animation.play('birdup', true);
        }
        if (v2 == '5'){
            laki.animation.play('laki', true);
            fellas1.animation.play('lakitu', true);
            fellas2.animation.play('lakitu', true);
        }
    }
    if (n == 'Triggers Universal'){
        if (v1 == '2'){
			getVar('titleText').text = 'Unbeatable(Level 2)';
			getVar('autorText').text = 'scrumbo_';
        }
        if (v1 == '11'){
            if (v2 == '4'){
                getVar('titleText').text = 'Unbeatable(Level 3)';
                getVar('autorText').text = 'theWAHbox ft. RedTV53';
            }                
        }
        if (v1 == '17'){
            if (v2 == '2'){
                getVar('titleText').text = 'Unbeatable(Level 4)';
                getVar('autorText').text = 'RedTV53 ft. FriedFrick';
            }                
        }
        if (v1 == '28') {
            switch(v2){
                case '3':
                    if (fellas1.animation.curAnim.name == 'suit'){
                        st = 0.1;
                    }
                    FlxTween.tween(fellas1, {y: fellas1.y + (250 * (fellas1.velocity.y / Math.abs(fellas1.velocity.y)))}, 0.25, {ease: FlxEase.quadOut});
                    FlxTween.tween(fellas2, {y: fellas2.y + (250 * (fellas2.velocity.y / Math.abs(fellas2.velocity.y)))}, 0.25, {ease: FlxEase.quadOut});
                case '4':
                    fellas1.velocity.y /= Math.abs(fellas1.velocity.y);
                    fellas2.velocity.y /= Math.abs(fellas2.velocity.y);
                case '5':
                    fellas1.velocity.y *= 620;
                    fellas2.velocity.y *= 620;
            }
        }
    }
    if (n == 'fellas thing') {
        if (v1 == 'visible') {
            if (curStep < 1714) dontMiss = !dontMiss;
            game.triggerEvent('ycbu text', '', '');
            lightningL.visible = !lightningL.visible;
            st = 0.325;
            if (v2 != null){
                if (v2 == 'lakitu' || v2 == 'birdup'){
                    offsetL = [80,50];
                    fellas1.spacing.set(0, 140);
                    fellas2.spacing.set(0, 140);
                }else{
                    offsetL = [0,0];
                    fellas1.spacing.set(0, 0);
                    fellas2.spacing.set(0, 0);
                }
                fellas1.animation.play(v2, true);
                fellas2.animation.play(v2, true);
            }
            fellas1.velocity.y = 600;
            fellas2.velocity.y = -600;
        }
        if (v1 == 'flip') {
            FlxTween.tween(lightningL, { x: (lightningL.x == 150 ? 950 : 150) }, 0.2, {ease: FlxEase.quadOut});
            FlxTween.tween(lightningR, { x: (lightningR.x == 950 ? 150 : 950) }, 0.2, {ease: FlxEase.quadOut});
        }
        if (v1 == 'speed') {
            if (Math.abs(fellas1.velocity.y) != 1 && fellas1.animation.curAnim.name == 'suit'){
                st = 0.1;
            }
            FlxTween.tween(fellas1, {y: fellas1.y + (fellas1.velocity.y)}, 0.1, {ease: FlxEase.quadOut});
            FlxTween.tween(fellas2, {y: fellas2.y + (fellas2.velocity.y)}, 0.1, {ease: FlxEase.quadOut});
            FlxTween.tween(fellas1.velocity, {y: fellas1.velocity.y * -1}, 0.1, {ease: FlxEase.quadOut});
            FlxTween.tween(fellas2.velocity, {y: fellas2.velocity.y * -1}, 0.1, {ease: FlxEase.quadOut});
        }
    }

    if (n == 'ui thing'){
        if (v1 == 'strum1'){
            if (v2 == 'fade'){
                for (i in 0...4){ 
                    FlxTween.tween(game.opponentStrums.members[i], {alpha: 0}, 1, {ease: FlxEase.cubeInOut});
                }
            }
            if (v2 == 'normal'){
                for (i in 0...4){ 
                    game.opponentStrums.members[i].alpha = 1;
                }
            }   
        }
        if (v1 == 'strum2'){
            if (v2 == 'middle'){
                for (i in 0...4){ 
                    FlxTween.tween(game.playerStrums.members[i], {x: 417 + (112 * i)}, 1, {ease: FlxEase.cubeInOut});
                }
            }
            if (v2 == 'normal'){
                for (i in 0...4){ 
                    game.playerStrums.members[i].x = 732 + (112 * i);
                }
            }        }
        if (v1 == 'ui'){
            if (v2 == 'fade'){
                uiFade = !uiFade;
                FlxTween.tween(game.uiGroup, {alpha: (uiFade ? 0 : 1)}, 1, {ease: FlxEase.cubeInOut});
            }
            if (v2 == 'normal'){
                game.uiGroup.alpha = 1;
            }
        }
    }

    return;
}

function noteMiss(note){
    if (dontMiss && !getModSetting('noMechs')) game.health = 0;
    return;
}

function onBeatHit(){
    if (endBeat){
        ps = 0.15;
        st = 0.1;
    }

    return;
}
