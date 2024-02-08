import flixel.addons.display.FlxBackdrop;
import objects.BGSprite;
import flixel.text.FlxText;
// demise bg
var floordemise:BGSprite;
var dembg:FlxBackdrop;
var demLevel:FlxBackdrop;
var demGround:FlxBackdrop;
var demFore1:BGSprite;
var demFore2:BGSprite;
var demFore3:BGSprite;
var demFore4:BGSprite;
var demcut1:BGSprite;
var demcut2:BGSprite;
var demcut3:BGSprite;
var demcut4:BGSprite;
var gordobondiola:BGSprite;

var underfloordemise:BGSprite;
var underroofdemise:BGSprite;
var underdemGround1:FlxBackdrop;
var underdemGround2:FlxBackdrop;
var underborderdemise:BGSprite;
var underdembg:FlxBackdrop;
var underdemLevel:FlxBackdrop;
var underdemFore1:BGSprite;
var underdemFore2:BGSprite;
var demisetran:BGSprite;
var whenyourered:FlxSprite;
var demColor:FlxSprite;
var demFlash:Bool = false;

var whiteThingie:FlxSprite;
var fogred:FlxSprite;

var extraTween = [];
var eventTweens = []; // i dont forgot anymore

var useShader = !getModSetting('noShaders');

var test3;
var test5;

function onCreate(){
    game.health = 2;
    game.gfGroup.alpha = 0.001;
    game.addCharacterToList('mx_demiseUG', 1);
    game.addCharacterToList('bf_demiseUG', 0);

    demColor = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
    demColor.setGraphicSize(Std.int(demColor.width * 10));
    demColor.scrollFactor.set(0, 0);
    demColor.color = FlxColor.BLACK;
    addBehindGF(demColor);

    dembg = new FlxBackdrop(Paths.image('stages/MX/demise/1/Demise_BG_BG2'), 0x01);
    dembg.scrollFactor.set(0.3, 0.3);
    dembg.velocity.set(100, 0);
    dembg.y -= 500;
    addBehindGF(dembg);

    demLevel = new FlxBackdrop(Paths.image('stages/MX/demise/1/Demise_BG_BGCaca'), 0x01);
    demLevel.scrollFactor.set(0.5, 0.5);
    demLevel.velocity.set(250, 0);
    demLevel.y -= 300;
    addBehindGF(demLevel);

    floordemise = new BGSprite('stages/MX/demise/1/Demise_BG_suelo', -800, 300, 1, 1, ['Floor'], false);
    floordemise.animation.addByPrefix('idle', 'Floor', 60, true);
    floordemise.antialiasing = ClientPrefs.data.antialiasing;
    floordemise.animation.play('idle');
    addBehindGF(floordemise);

    demGround = new FlxBackdrop(Paths.image('stages/MX/demise/1/Demise_BG_BG1'), 0x01, 800);
    demGround.scrollFactor.set(0.9, 0.9);
    demGround.velocity.set(3200, 0);
    demGround.y -= 70;
    addBehindGF(demGround);

    underdembg = new FlxBackdrop(Paths.image('stages/MX/demise/2/Demise_BG2_Mountains.png'), 0x01);
    underdembg.scrollFactor.set(0.3, 0.3);
    underdembg.velocity.set(100, 0);
    underdembg.y -= 500;
    addBehindGF(underdembg);

    underdemLevel = new FlxBackdrop(Paths.image('stages/MX/demise/2/Demise_BG2_BGLower.png'), 0x01);
    underdemLevel.scrollFactor.set(0.5, 0.5);
    underdemLevel.velocity.set(250, 0);
    underdemLevel.y -= 1400;
    addBehindGF(underdemLevel);

    underdemGround1 = new FlxBackdrop(Paths.image('stages/MX/demise/2/Demise_BG2_BG1'), 0x01, 6000);
    underdemGround1.scrollFactor.set(0.9, 0.9);
    underdemGround1.velocity.set(3200, 0);
    underdemGround1.y -= 800;
    addBehindGF(underdemGround1);

    underdemGround2 = new FlxBackdrop(Paths.image('stages/MX/demise/2/Demise_BG2_BG2'), 0x01, 4000);
    underdemGround2.scrollFactor.set(0.9, 0.9);
    underdemGround2.velocity.set(3200, 0);
    underdemGround2.y -= 800;
    addBehindGF(underdemGround2);

    underfloordemise = new BGSprite('stages/MX/demise/2/Demise_BG2_suelo', -800, 300, 1, 1, ['Floor'], false);
    underfloordemise.animation.addByPrefix('idle', 'Floor', 60, true);
    underfloordemise.antialiasing = ClientPrefs.data.antialiasing;
    underfloordemise.animation.play('idle');
    addBehindGF(underfloordemise);

    underroofdemise = new BGSprite('stages/MX/demise/2/Demise_BG2_techo', -800, -1050, 1, 1, ['Celling'], false);
    underroofdemise.animation.addByPrefix('idle', 'Celling', 60, true);
    underroofdemise.antialiasing = ClientPrefs.data.antialiasing;
    underroofdemise.animation.play('idle');
    addBehindGF(underroofdemise);

    whenyourered = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFD10000);
    whenyourered.setGraphicSize(Std.int(whenyourered.width * 10));
    whenyourered.alpha = 0;
    addBehindGF(whenyourered);

    demcut1 = new BGSprite('stages/MX/demise/cutscene/DemiseBF_Cutscene3', -1100, -250, 1, 1, ['Bodies'], false);
    demcut1.animation.addByPrefix('idle', 'Bodies', 21, false);
    demcut1.antialiasing = ClientPrefs.data.antialiasing;
    //demcut1.animation.play('idle');
    addBehindGF(demcut1);

    demcut2 = new BGSprite('stages/MX/demise/cutscene/DemiseBF_Cutscene2', demcut1.x + 650, demcut1.y, 1, 1, ['Bodies'], false);
    demcut2.animation.addByPrefix('idle', 'Bodies', 21, false);
    demcut2.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(demcut2);

    demcut3 = new BGSprite('stages/MX/demise/cutscene/DemiseBF_Cutscene1', demcut1.x + 1100, demcut1.y + 370, 1, 1, ['BFheadcutscene'], true);
    demcut3.animation.addByPrefix('idle', 'BFheadcutscene', 21, false);
    demcut3.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(demcut3);

    demcut4 = new BGSprite('stages/MX/demise/cutscene/DemiseBF_Cutscene4', demcut1.x + 270, demcut1.y + 30, 1, 1, ['GFHeadcutscene'], false);
    demcut4.animation.addByPrefix('idle', 'GFHeadcutscene', 21, false);
    demcut4.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(demcut4);

    demcut1.alpha = 0.001;
    demcut2.alpha = 0.001;
    demcut3.alpha = 0.001;
    demcut4.alpha = 0.001;

    gordobondiola = new BGSprite('stages/MX/demise/cutscene/MXJump', 2200, -2900, 1, 1);
    gordobondiola.antialiasing = ClientPrefs.data.antialiasing;
    addBehindGF(gordobondiola);
    
    underdembg.alpha = 0.001;
    underdemLevel.alpha = 0.001;
    underdemGround1.alpha = 0.001;
    underdemGround2.alpha = 0.001;
    underfloordemise.alpha = 0.001;
    underroofdemise.alpha = 0.001;

    demFore1 = new BGSprite('stages/MX/demise/1/Demise_BG_Foreground1', -3800, 300, 1.3, 1.3);
    demFore2 = new BGSprite('stages/MX/demise/1/Demise_BG_Foreground2', -3800, 300, 1.3, 1.3);
    demFore3 = new BGSprite('stages/MX/demise/1/Demise_BG_Foreground3', -1800, -1200, 1.3, 1.3);
    demFore4 = new BGSprite('stages/MX/demise/1/Demise_BG_Foreground4', -3800, 300, 1.3, 1.3);

    underdemFore1 = new BGSprite('stages/MX/demise/2/Demise_BG2_Foreground1', -3800, 300, 1.3, 1.3);
    underdemFore2 = new BGSprite('stages/MX/demise/2/Demise_BG2_Foreground2', -3800, 300, 1.3, 1.3);

    game.modchartSprites.set('underdemFore1', underdemFore1);
    game.modchartSprites.set('underdemFore2', underdemFore2);
    game.modchartSprites.set('demFore1', demFore1);
    game.modchartSprites.set('demFore2', demFore2);
    game.modchartSprites.set('demFore3', demFore3);
    game.modchartSprites.set('demFore4', demFore4);
    game.modchartSprites.set('underfloordemise', underfloordemise);

    demisetran = new BGSprite('stages/MX/demise/1/transition', -1600, 0);
    demisetran.cameras = [camHUD];
    demisetran.scale.set(3, 1);
    add(demisetran);

    //startFore(1);

    add(demFore1);
    add(demFore2);
    add(demFore3);
    add(demFore4);

    add(underdemFore1);
    add(underdemFore2);
    return;
}

function onCreatePost(){
    if (useShader){
        game.initLuaShader('test3');
        game.initLuaShader('test5');
        test3 = game.createRuntimeShader('test3');
        test5 = game.createRuntimeShader('test5');

        game.camGame.filters = [new ShaderFilter(test3), new ShaderFilter(test5)];
        game.camHUD.filters = [new ShaderFilter(test3), new ShaderFilter(test5)];
    }

    iconP1.flipX = true;
    iconP2.flipX = true;
    healthBar.leftToRight = false;

    game.updateIconsPosition = function(){
        iconP2.x = healthBar.x + healthBar.width - 120;
        iconP1.x = healthBar.barCenter - (150 * iconP2.scale.x) / 2 - 0 * 2;
    }

    eventTweens.push(FlxTween.tween(boyfriendGroup, {x: boyfriendGroup.x + 200}, 2, {ease: FlxEase.quadInOut, type: 4}));

    eventTweens.push(FlxTween.tween(dadGroup, {x: dadGroup.x - 200}, 2, {startDelay: 1, ease: FlxEase.quadInOut, type: 4}));
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Timebar Gimmicka'){
		var time:Float = Std.parseFloat(value1);
        if (Math.isNaN(time))
            time = 3;

        extraTween.push(FlxTween.tween(timeBarBG, {x: timeBarBG.x + 12}, 0.04, {type: 4}));
        extraTween.push(FlxTween.tween(timeBarBG, {y: timeBarBG.y + 6}, 0.02, {type: 4}));

        extraTween.push(FlxTween.tween(timeBar, {x: timeBar.x + 12}, 0.04, {type: 4}));
        extraTween.push(FlxTween.tween(timeBar, {y: timeBar.y + 6}, 0.02, {type: 4}));

        extraTween.push(FlxTween.tween(timeTxt, {x: timeTxt.x + 12}, 0.04, {type: 4}));
        extraTween.push(FlxTween.tween(timeTxt, {y: timeTxt.y + 6}, 0.02, {type: 4}));

        eventTimers.push(new FlxTimer().start(time, function(tmr:FlxTimer)
            {
                for (tween in extraTween)
                    {
                        tween.cancel();
                    }
            }));
    }
    if (n == 'Triggers Universal'){
        var triggerMX:Float = Std.parseFloat(v1);
        if (Math.isNaN(triggerMX))
            triggerMX = 0;
        switch (triggerMX)
        {
            case 0:
                var hatext:FlxText = new FlxText(900, -270, 600, 'HA!', 120);
                hatext.setFormat(Paths.font("mariones.ttf"), 120, FlxColor.WHITE, 'left');
                add(hatext);
                hatext.angle = FlxG.random.float(-20, 20);

                FlxTween.tween(hatext, {x: 500, y: ((hatext.angle * 20) - 270), alpha: 0}, 1, {ease: FlxEase.expoOut, onComplete: function(twn:FlxTween)
                    {
                        remove(hatext);
                    }});

            case 1:
                demisetran.x = -1600;
                FlxTween.tween(demisetran, {x: 2600}, 1.4);
                new FlxTimer().start(2 * (1 / (Conductor.bpm / 60)), function(tmr:FlxTimer)
                    {
                        game.triggerEvent('Change Character', '1', 'mx_demiseUG');
                        game.triggerEvent('Change Character', '0', 'bf_demiseUG');
                        underdembg.alpha = 	   	1;
                        underdemLevel.alpha =    	1;
                        underdemGround1.alpha =  	1;
                        underdemGround2.alpha =  	1;
                        underfloordemise.alpha = 	1;
                        underroofdemise.alpha =  	1;
                        dembg.alpha = 		   	0.001;
                        demLevel.alpha = 		   	0.001;
                        floordemise.alpha = 		0.001;
                        demGround.alpha = 		0.001;

                        demFore1.alpha = 			0.001;
                        demFore2.alpha = 			0.001;
                        demFore3.alpha = 			0.001;
                        demFore4.alpha = 			0.001;

                        underdemFore1.alpha = 			1;
                        underdemFore1.alpha = 			1;
                    });
            case 2:
                demisetran.x = -1600;
                FlxTween.tween(demisetran, {x: 2600}, 1.4);
                new FlxTimer().start(2 * (1 / (Conductor.bpm / 60)), function(tmr:FlxTimer)
                    {
                        game.triggerEvent('Change Character', '1', 'mx_demise');
                        game.triggerEvent('Change Character', '0', 'bf_demise');
                        underdembg.alpha = 	   	0.001;
                        underdemLevel.alpha =    	0.001;
                        underdemGround1.alpha =  	0.001;
                        underdemGround2.alpha =  	0.001;
                        underfloordemise.alpha = 	0.001;
                        underroofdemise.alpha =  	0.001;
                        dembg.alpha = 		   	1;
                        demLevel.alpha = 		   	1;
                        floordemise.alpha = 		1;
                        demGround.alpha = 		1;

                        demFore1.alpha = 			1;
                        demFore2.alpha = 			1;
                        demFore3.alpha = 			1;
                        demFore4.alpha = 			1;
                        underdemFore1.alpha = 			0;
                        underdemFore1.alpha = 			0;

                    });

            case 3:
                FlxTween.tween(whenyourered, {alpha: 1}, 1, {ease: FlxEase.quadOut});
                FlxTween.tween(underdemFore1, {alpha: 0}, 1, {ease: FlxEase.quadOut});
                FlxTween.tween(underdemFore2, {alpha: 0}, 1, {ease: FlxEase.quadOut});
                FlxTween.color(boyfriend, 	1, FlxColor.WHITE, FlxColor.BLACK, {ease: FlxEase.quadOut});
                FlxTween.color(dad,		1, FlxColor.WHITE, FlxColor.BLACK, {ease: FlxEase.quadOut});
                new FlxTimer().start(1.03, function(tmr:FlxTimer)
                        {
                            FlxTween.tween(camGame, {zoom: 0.4}, 20.21);
                        });
            case 4:
                FlxTween.tween(whenyourered, {alpha: 0}, 2, {ease: FlxEase.quadInOut});
                FlxTween.tween(underdemFore1, {alpha: 1}, 2, {ease: FlxEase.quadOut});
                FlxTween.tween(underdemFore2, {alpha: 1}, 2, {ease: FlxEase.quadOut});
                FlxTween.color(boyfriend, 	2, FlxColor.BLACK, FlxColor.WHITE, {ease: FlxEase.quadInOut});
                FlxTween.color(dad,		2, FlxColor.BLACK, FlxColor.WHITE, {ease: FlxEase.quadInOut});
            case 5:
                setVar('camMove', false);
                boyfriend.alpha = 0;
                dad.alpha = 0;

                demFore1.alpha = 0.001;
                demFore2.alpha = 0.001;
                demFore3.alpha = 0.001;
                demFore4.alpha = 0.001;

                demcut1.alpha = 1;
                demcut2.alpha = 1;
                demcut3.alpha = 1;
                demcut4.alpha = 1;

                demcut1.animation.play('idle', true);
                demcut2.animation.play('idle', true);
                demcut3.animation.play('idle', true);
                demcut4.animation.play('idle', true);

                FlxTween.tween(floordemise, {alpha: 0}, 0.5);
                FlxTween.tween(demGround, {alpha: 0}, 0.5);
                FlxTween.tween(camGame, {zoom: 1.2}, 0.5);
                FlxTween.tween(camHUD, {alpha: 0.1}, 0.5);
                FlxTween.tween(camFollow, {x: 200, y: 500}, 0.4, {ease:FlxEase.expoOut});

               new FlxTimer().start((1 / (Conductor.bpm / 60)), function(tmr:FlxTimer)
                    {
                        FlxTween.tween(camGame, {zoom: 0.8}, 5);
                        FlxTween.tween(camFollow, {x: 1200, y: -100}, 6, {ease:FlxEase.quadInOut});
                    });
            case 6:
                demFore1.alpha = 1;
                demFore2.alpha = 1;
                demFore3.alpha = 1;
                demFore4.alpha = 1;
                FlxTween.tween(floordemise, {alpha: 1},  1);
                FlxTween.tween(demGround, {alpha: 1}, 1);
            case 7:
                FlxTween.tween(gordobondiola, {x: 1000, y: -900}, 1.85, {ease: FlxEase.expoIn});

                FlxTween.color(demcut1,		0.4, FlxColor.WHITE, 0xFF5E5E5E);
                FlxTween.color(demcut2,		0.4, FlxColor.WHITE, 0xFF5E5E5E);
                FlxTween.color(demcut3,		0.4, FlxColor.WHITE, 0xFF5E5E5E);
                FlxTween.color(demcut4,		0.4, FlxColor.WHITE, 0xFF5E5E5E);
                FlxTween.tween(camHUD, {alpha: 1}, 0.5);
            case 8: 
                FlxTween.color(demcut1,		0.4, 0xFF5E5E5E, FlxColor.WHITE);
                FlxTween.color(demcut2,		0.4, 0xFF5E5E5E, FlxColor.WHITE);
                FlxTween.color(demcut3,		0.4, 0xFF5E5E5E, FlxColor.WHITE);
                FlxTween.color(demcut4,		0.4, 0xFF5E5E5E, FlxColor.WHITE);
    
            case 11:
                setVar('camMove', true);
                demFlash = !demFlash;
        }
    }
    return;
}
function onSongStart(){
    demcut1.alpha = 0.001;
    demcut2.alpha = 0.001;
    demcut3.alpha = 0.001;
    demcut4.alpha = 0.001;

    
    return;
}
var lol;
function onUpdate(el){
    lol += el;
    if (useShader) test3.setFloat('time', lol);

    demcut2.x = demcut1.x + 650;
    demcut3.x = demcut1.x + 1100;
    demcut4.x = demcut1.x + 270;

    demcut2.y = demcut1.y;
    demcut3.y = demcut1.y + 370;
    demcut4.y = demcut1.y + 30;

    if(demcut1.animation.frameIndex == 17 && demcut1.alpha == 1){
        FlxTween.tween(demcut1, {y: -600, x: -200}, 5, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween)
            {
                FlxTween.tween(demcut1, {x: -300}, 2.5, {ease: FlxEase.quadInOut, type: 4});
                FlxTween.tween(demcut1, {y: -500}, 4, {ease: FlxEase.quadInOut, type: 4});
            }});
    }

    if(demcut1.animation.frameIndex == 232 && demcut1.alpha == 1){
        demcut1.alpha = 0.001;
        demcut2.alpha = 0.001;
        demcut3.alpha = 0.001;
        demcut4.alpha = 0.001;
        gordobondiola.alpha = 0.001;

        boyfriend.alpha = 1;
        dad.alpha = 1;
    }
    return;
}

function onBeatHit(){
    if(demFlash){
        FlxTween.color(demColor, (1 / (Conductor.bpm / 60)), 0xFF4D0000, FlxColor.BLACK);
    }
    return;
}


function onPause(){
    for (t in eventTweens) t.active = false;
    return;
}

function onResume(){
    for (t in eventTweens) t.active = true;
    return;
}