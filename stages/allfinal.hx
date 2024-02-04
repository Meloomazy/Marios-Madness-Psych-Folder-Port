// most of the stuff from the source code, so massive prop for the mm team - Meloom
// day 86 in meloom's basement, help - Tatoraa
// i like shark - numChamo

import flixel.addons.display.FlxBackdrop;
import objects.BGSprite;

var act1Stage:Array<Dynamic> = [];
var act2Stage:Array<Dynamic> = [];
var act3Stage:Array<Dynamic> = [];
var act4Stage:Array<Dynamic> = [];
var act4Floaters:Array<Dynamic> = [];
var act4Stage2:Array<Dynamic> = [];
var eventTweens = [];
var eventTimers = [];
var extraTween = [];
var extraTimers = [];

// cache character - numChamo
game.addCharacterToList('omega', 1);
game.addCharacterToList('bf_behind', 0);
game.addCharacterToList('bfASsad', 0);
game.addCharacterToList('gx', 1);
game.addCharacterToList('bf_ultrafinale', 0);
game.addCharacterToList('bf_ultrafinale2', 0);
game.addCharacterToList('mario_ultra2', 1);
game.addCharacterToList('bf_ultrafinale3', 0);
game.addCharacterToList('mario_ultra3', 1);

var act1Stat:BGSprite;
var act1Sky:BGSprite;
var act1Skyline:BGSprite;
var act1Buildings:BGSprite;
var act1Floor:BGSprite;
var act1FG:BGSprite;
var act1Gradient:BGSprite;
var act1Fog:BGSprite;
var act1Intro:BGSprite;

var act2Stat:BGSprite;
var act2WhiteFlash:FlxSprite;
var act2Sky:FlxBackdrop;
var act2PipesFar:BGSprite;
var act2Gradient:BGSprite;
var act2PipesMiddle:BGSprite;
var act2PipesClose:BGSprite;
var act2LPipe:BGSprite;
var act2WPipe:BGSprite;
var act2YPipe:BGSprite;
var act2BFPipe:BGSprite;
var act2Fog:BGSprite;

var act2IntroGF:BGSprite;
var act2IntroEyes:BGSprite;

var act3Stat:BGSprite;
var act3Hills:BGSprite;
var act3UltraArm:BGSprite;
var act3UltraBody:BGSprite;
var act3UltraHead1:BGSprite;
var act3UltraHead2:BGSprite;
var act3UltraPupils:BGSprite;
var act3BFPipe:BGSprite;
var act3Spotlight:BGSprite;
var act3Fog:BGSprite;

var act4Stat:BGSprite;
var act4Ripple:BGSprite;

var act4SpawnNum:Int = 1;

var act4Pipe1:BGSprite;
var act4Pipe2:BGSprite;
var act4Memory1:BGSprite;
var act4Memory2:BGSprite;

var act4Spotlight:BGSprite;
var act4Lightning:BGSprite;
var act4DeadBF:BGSprite;
var act4GameOver:BGSprite;

var act4Intro:BGSprite;
var blackBarThingie:FlxSprite;

var LG;
var w4r;
var y0sh;
function onCreate(){

// uh camera i think - meloom
    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.scrollFactor.set(0, 0);
    blackBarThingie.alpha = 1;
    blackBarThingie.cameras = [getVar('camEst')];
    add(blackBarThingie);

    act1Intro = new BGSprite('stages/allfinal/act1/All_Stars_Intro', 0, 0, 0, 0, ['intro anim']);
    act1Intro.animation.addByPrefix('idle', 'intro anim', 24, false);
    act1Intro.cameras = [getVar('camEst')];
    act1Intro.alpha = 0;
    act1Intro.screenCenter(0x01);
    add(act1Intro);

// act 1 - come little rat
    act1Stat = new BGSprite('stages/allfinal/act1/act1_stat', -900, -860, 0.4, 0.4, ['act1_static']);
    act1Stat.animation.addByPrefix('idle', 'act1_static', 24, true);
    act1Stat.animation.play('idle');
    act1Stat.scale.set(4, 4);
    addBehindGF(act1Stat);
    act1Stage.push(act1Stat);

    act1Sky = new BGSprite('stages/allfinal/act1/act1_sky', -1850, -660, 0.6, 0.6);
    addBehindGF(act1Sky);
    act1Stage.push(act1Sky);

    act1Skyline = new BGSprite('stages/allfinal/act1/act1_skyline', -2100, -660, 0.8, 0.8);
    addBehindGF(act1Skyline);
    act1Stage.push(act1Skyline);

    act1Buildings = new BGSprite('stages/allfinal/act1/act1_bgbuildings', -2100, -660, 0.8, 0.8);
    addBehindGF(act1Buildings);
    act1Stage.push(act1Buildings);

    act1Floor = new BGSprite('stages/allfinal/act1/act1_floor', -2300, -660, 1, 1);
    addBehindGF(act1Floor);
    act1Stage.push(act1Floor);

    act1Fog = new BGSprite('stages/allfinal/act1/act1', 0, 0, 1, 1);
    act1Fog.cameras = [camOther];
    addBehindGF(act1Fog);

    act1FG = new BGSprite('stages/allfinal/act1/act1_fg', -2530, -850, 1.7, 1.7);
    add(act1FG);
    act1Stage.push(act1FG);

    act1Gradient = new BGSprite('stages/allfinal/act1/act1_gradient', -2300, -910, 1, 1);
    add(act1Gradient);
    act1Stage.push(act1Gradient);

// act 2 - does he know?
    act2Stat = new BGSprite('stages/allfinal/act2/act2_static', -70, -360, 0.2, 0.2, ['act2Stat']);
    act2Stat.animation.addByPrefix('idle', 'act2stat', 24, true);
    act2Stat.animation.play('idle');
    act2Stat.scale.set(1.75, 1.75);
    addBehindGF(act2Stat);
    act2Stage.push(act2Stat);

    act2WhiteFlash = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
    act2WhiteFlash.setGraphicSize(Std.int(act2Stat.width * 10));
    act2WhiteFlash.alpha = 0;
    addBehindGF(act2WhiteFlash);

    act2Sky = new FlxBackdrop(Paths.image('stages/allfinal/act2/act2_scroll1'), 0x01, 0, 0);
    act2Sky.scrollFactor.set(0.3, 0.3);
    act2Sky.velocity.set(100, 0);
    act2Sky.y = -300;
    act2Sky.x = -500;
    act2Sky.alpha = 0.001;
    addBehindGF(act2Sky);
    act2Stage.push(act2Sky);
    
    act2PipesFar = new BGSprite('stages/allfinal/act2/act2_pipes_far', -500, -270, 0.6, 0.6);
    addBehindGF(act2PipesFar);
    act2Stage.push(act2PipesFar);

    act2Gradient = new BGSprite('stages/allfinal/act2/act2_abyss_gradient', -500, -425, 0.6, 0.6);
    addBehindGF(act2Gradient);
    act2Stage.push(act2Gradient);

    act2PipesMiddle = new BGSprite('stages/allfinal/act2/act2_pipes_middle', -500, -300, 0.7, 0.7);
    addBehindGF(act2PipesMiddle);
    act2Stage.push(act2PipesMiddle);

    act2PipesClose = new BGSprite('stages/allfinal/act2/act2_pipes_close', -500, -320, 0.8, 0.8);
    addBehindGF(act2PipesClose);
    act2Stage.push(act2PipesClose);

    //LG Pipe
    act2LPipe = new BGSprite('stages/allfinal/act2/act2_pipes_lgbf', -600, -360 + 800, 0.9, 0.9);
    addBehindGF(act2LPipe);
    act2Stage.push(act2LPipe);

    LG = new Character(100, 740, 'lg2');
    setVar('LG', LG);
    LG.scrollFactor.set(0.9, 0.9);
    LG.alpha = 0.001;
    addBehindGF(LG);

    //w4r pipe
    act2WPipe = new BGSprite('stages/allfinal/act2/act2_pipes_waryosh', -740, -260 + 800, 0.95, 0.95);
    addBehindGF(act2WPipe);
    act2Stage.push(act2WPipe);

    w4r = new Character(-370, 910, 'w4r');
    setVar('w4r', w4r);
    w4r.scrollFactor.set(0.95, 0.95);
    w4r.alpha = 0.001;
    addBehindGF(w4r);

    //y0sh pipe
    act2YPipe = new BGSprite('stages/allfinal/act2/act2_pipes_waryosh', -460, -260 + 800, 0.95, 0.95);
    act2YPipe.flipX = true;
    addBehindGF(act2YPipe);
    act2Stage.push(act2YPipe);

    y0sh = new Character(850, 1000, 'y0shi');
    setVar('y0sh', y0sh);
    y0sh.scrollFactor.set(0.9, 0.9);
    y0sh.alpha = 0.001;
    addBehindGF(y0sh);

    act2BFPipe = new BGSprite('stages/allfinal/act2/act2_pipes_lgbf', -630, -80, 1, 1);
    act2BFPipe.scale.set(1.2, 1.2);
    addBehindGF(act2BFPipe);
    act2Stage.push(act2BFPipe);

    act2Fog = new BGSprite('stages/allfinal/act2/act2', 0, 0, 1, 1);
    act2Fog.cameras = [camOther];
    add(act2Fog);
    act2Stage.push(act2Fog);

    act2IntroGF = new BGSprite('stages/allfinal/act1/Act_2_Intro', 0, 330, 0.2, 0.2, ['act2Stat']);
    act2IntroGF.animation.addByPrefix('idle', 'Anim1', 24, true);
    act2IntroGF.cameras = [getVar('camEst')];
    act2IntroGF.scale.set(2, 2);
    act2IntroGF.screenCenter(0x01);
    act2IntroGF.x -= 40;
    act2IntroGF.alpha = 0.001;
    act2IntroGF.angle = -10;
    add(act2IntroGF);

    act2IntroEyes = new BGSprite('stages/allfinal/act1/Act_2_Intro', 0, 320, 0.2, 0.2, ['act2Stat']);
    act2IntroEyes.animation.addByPrefix('idle', 'EyesBG', 24, false);
    act2IntroEyes.cameras = [getVar('camEst')];
    act2IntroEyes.scale.set(0.8, 0.8);
    act2IntroEyes.screenCenter(0x01);
    act2IntroEyes.x -= 270;
    act2IntroEyes.alpha = 0.001;
    act2IntroEyes.origin.set(act2IntroEyes.width / 2, act2IntroEyes.height / 2);
    add(act2IntroEyes);

// act 3 - he doesn't know...
    act3Stat = new BGSprite('stages/allfinal/act3/Act3_Static', -730 - 275, -720 + 440, 0.2, 0.2, ['act3Stat']);
    act3Stat.animation.addByPrefix('idle', 'act3stat', 24, true);
    act3Stat.animation.play('idle');
    act3Stat.scale.set(1.3, 1.3);
    addBehindGF(act3Stat);
    act3Stage.push(act3Stat);

    act3Hills = new BGSprite('stages/allfinal/act3/Act3_Hills', -730 - 275 + 300, 450, 0.4, 0.4, ['hills']);
    act3Hills.animation.addByPrefix('idle', 'hills', 24, true);
    act3Hills.animation.play('idle');
    act3Hills.scale.set(1.3, 1.3);
    addBehindGF(act3Hills);
    act3Stage.push(act3Hills);

    act3UltraArm = new BGSprite('stages/allfinal/act3/Act3_Ultra_Arm', -900 - 275, -1215 + 440, 0.8, 0.8);
    act3UltraArm.origin.set(880, 1540);
    addBehindGF(act3UltraArm);
    act3Stage.push(act3UltraArm);

    act3UltraBody = new BGSprite('stages/allfinal/act3/Act3_Ultra_M', -1185, -650 + 600, 0.8, 0.8, ['torso idle 1']);
    act3UltraBody.animation.addByPrefix('idle', 'torso idle 1', 24, false);
    act3UltraBody.animation.addByPrefix('change', 'torso change pose', 24, false);
    act3UltraBody.animation.addByPrefix('idle-alt', 'torso idle 2', 24, false);
    act3UltraBody.scale.set(1.4, 1.4);
    addBehindGF(act3UltraBody);
    act3Stage.push(act3UltraBody);

    act3UltraHead1 = new BGSprite('stages/allfinal/act3/Act3_Ultra_M_Head', -200 - 275, -650 + 440, 0.8, 0.8, ['ultra m static head']);
    act3UltraHead1.animation.addByPrefix('idle', 'ultra m static head', 24, true);
    act3UltraHead1.animation.addByPrefix('sing', 'ultra m lyrics 1', 24, false);
    act3UltraHead1.animation.play('idle');
    act3UltraHead1.scale.set(1.1, 1.1);
    addBehindGF(act3UltraHead1);
    act3Stage.push(act3UltraHead1);

    act3UltraHead2 = new BGSprite('stages/allfinal/act3/Act3_Ultra_M_Head2', -200 - 300, -650 + 325, 0.8, 0.8, ['ultra m lyrics 1']);
    act3UltraHead2.animation.addByPrefix('sing', 'ultra m lyrics 2', 24, false);
    act3UltraHead2.animation.addByPrefix('laugh', 'ultra m head laugh', 24, false);
    addBehindGF(act3UltraHead2);
    act3Stage.push(act3UltraHead2);

    act3UltraPupils = new BGSprite('stages/allfinal/act3/Act3_Ultra_Pupils', -175, -300 + 405, 0.8, 0.8, ['ultra pupils']);
    act3UltraPupils.animation.addByPrefix('idle', 'ultra pupils', 24, true);
    act3UltraPupils.animation.play('idle');
    addBehindGF(act3UltraPupils);
    act3Stage.push(act3UltraPupils);

    act3BFPipe = new BGSprite('stages/allfinal/act3/Act3_bfpipe', 390 - 275, 165 + 440, 1, 1);
    addBehindGF(act3BFPipe);
    act3Stage.push(act3BFPipe);

    act3Spotlight = new BGSprite('stages/allfinal/act3/act3Spotlight', -1550, -300, 1, 1);
    act3Spotlight.scale.set(1.3, 1);
    add(act3Spotlight);
    act3Stage.push(act3Spotlight);

    act3Fog = new BGSprite('stages/allfinal/act3/act3', 0, 0, 1, 1);
    act3Fog.alpha = 0.7;
    act3Fog.cameras = [camOther];
    addBehindGF(act3Fog);
    act3Stage.push(act3Fog);

// act 4 - 1.end
    act4Stat = new BGSprite('stages/allfinal/act4/gray static', -75, -300, 0.3, 0.3, ['static']);
    act4Stat.animation.addByPrefix('idle', 'static', 24, true);
    act4Stat.animation.play('idle');
    addBehindGF(act4Stat);
    act4Stage.push(act4Stat);
    
    act4Ripple = new BGSprite('stages/allfinal/act4/bg ripple', -180, 25, 0.5, 0.5, ['bg ripple']);
    act4Ripple.animation.addByPrefix('idle', 'bg ripple', 24, true);
    act4Ripple.animation.play('idle');
    addBehindGF(act4Ripple);
    act4Stage.push(act4Ripple);

    act4Pipe1 = new BGSprite('stages/allfinal/act4/bf pipe final', 890, 620, 1, 1);
    addBehindBF(act4Pipe1);
    act4Stage.push(act4Pipe1);

    act4Pipe2 = new BGSprite('characters/Act_4_secondperspective', 685, 580, 1, 1, ['pipe']);
    act4Pipe2.animation.addByPrefix('idle', 'pipe', 24, true);
    act4Pipe2.animation.play('idle');
    addBehindBF(act4Pipe2);
    act4Stage2.push(act4Pipe2);

    act4Memory1 = new BGSprite('stages/allfinal/act4/memory', -70, 100 + 150, 1.1, 1.1);
    act4Memory1.animation.play('idle');
    act4Memory1.scale.set(1.2,1.2);
    act4Memory1.alpha = 0;
    addBehindGF(act4Memory1);
    act4Stage2.push(act4Memory1);

    act4Memory2 = new BGSprite('stages/allfinal/act4/she got infected with the exe', 1250, 100 - 150, 1.1, 1.1);
    act4Memory2.animation.play('idle');
    act4Memory2.scale.set(1.2,1.2);
    act4Memory2.alpha = 0;
    addBehindGF(act4Memory2);
    act4Stage2.push(act4Memory2);

    act4Lightning = new BGSprite('stages/allfinal/act4/Act_4_FINALE_Lightingmcqueen', 550, 40, 1, 1, ['line']);
    act4Lightning.animation.addByPrefix('idle', 'line', 24, true);
    act4Lightning.animation.play('idle');

    act4DeadBF = new BGSprite('stages/allfinal/act4/Act_4_FINALE_DEATH', 340, -85, 1, 1, ['Death']);
    act4DeadBF.animation.addByPrefix('die', 'Death', 24, false);
    act4DeadBF.alpha = 0.001;

    act4GameOver = new BGSprite('stages/allfinal/act4/Act_4_FINALE_Gameover', 0, 0, 1, 1);
    act4GameOver.cameras = [getVar('camEst')];
    act4GameOver.screenCenter();
    act4GameOver.alpha = 0.001;

    act4Spotlight = new BGSprite('stages/allfinal/act4/spotlight', 400, 30, 1, 1);
    act4Spotlight.scale.set(2, 2);
    act4Spotlight.alpha = 0.25;
    act4Stage2.push(act4Spotlight);

    act4Intro = new BGSprite('stages/allfinal/act4/Act_4_Voiceline', 0, 0, 1, 1, ['thingy']);
    act4Intro.animation.addByPrefix('anim', 'thingy', 24, false);
    act4Intro.cameras = [getVar('camEst')];
    act4Intro.alpha = 0.001;

    add(act4DeadBF);
    add(act4GameOver);


    for (o in act2Stage) o.alpha = 0.001;
    for (o in act3Stage) o.alpha = 0.001;
    for (o in act4Stage) o.alpha = 0.001;
    for (o in act4Stage2) o.alpha = 0.001;
    act1Fog.visible = false;
    camHUD.visible = false;
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Triggers Universal'){
        switch(Std.parseFloat(v1)){
        case 1:
            switch(Std.parseFloat(v2))
            {
                case 1:
                    camHUD.visible = false;
                    blackBarThingie.alpha = 1;
                    act1Intro.alpha = 1;
                    act1Intro.animation.play('idle');
                case 2:
                    if (ClientPrefs.flashing)
                        {
                            FlxG.camera.flash(FlxColor.RED, 0.8);
                        }
                        else
                        {
                            FlxG.camera.flash(FlxColor.BLACK, 0.8);
                        }
                    camHUD.visible = true;
                    blackBarThingie.alpha = 0;
                    act1Intro.alpha = 0;
                    act1Fog.visible = true;
            }        
        case 0:
            switch(Std.parseFloat(v2)) {
                case 0:
                    act1Fog.visible = false;
                    act2IntroGF.alpha = 1;
                    act2IntroGF.animation.play('idle');
                    FlxTween.tween(act2IntroGF, {alpha: 1}, 0.1, {});
                    FlxTween.tween(act2IntroGF.scale, {x: 0.01}, 3, {ease: FlxEase.expoOut});
                    FlxTween.tween(act2IntroGF.scale, {y: 0.01}, 3, {ease: FlxEase.expoOut});

                    FlxTween.tween(act2IntroGF, {y: act2IntroGF.y - 400}, 3, {ease: FlxEase.circOut});
                    FlxTween.tween(act2IntroGF, {angle: 5}, 3, {ease: FlxEase.expoOut});
                case 1:
                    FlxTween.tween(act2IntroGF, {alpha: 0}, 0.6, {});
                case 2:
                    act2IntroEyes.alpha = 1;
                    act2IntroEyes.animation.play('idle');
                    FlxTween.tween(act2IntroEyes.scale, {x: 1.8}, 0.8, {ease: FlxEase.expoIn});
                    FlxTween.tween(act2IntroEyes.scale, {y: 1.8}, 0.8, {ease: FlxEase.expoIn});
                    FlxTween.tween(act2IntroEyes, {x: act2IntroEyes.x - 185}, 0.8, {ease: FlxEase.expoIn});
                    FlxTween.tween(act2IntroEyes, {y: 120}, 0.8, {ease: FlxEase.circOut});
                case 3:
                    FlxTween.tween(blackBarThingie, {alpha: 0}, 0.7, {ease: FlxEase.expoOut});
                    FlxTween.tween(act2IntroEyes, {alpha: 0}, 0.2, {ease: FlxEase.expoOut});
                    FlxTween.tween(act2Fog, {alpha: 0.7}, 0.7, {ease: FlxEase.expoOut});
                    remove(act2IntroEyes, true);
                    remove(act2IntroGF, true);

                    camHUD.visible = true;
                    setVar('dadZoom', 0.6);
                    setVar('posValDad', [520, 350]);

                    //camOther.visible = true;
            }
        case 2:
            switch(Std.parseFloat(v2)){
                case 0:
                    //camOther.visible = false;
                    setVar('dadZoom', 2);
                    setVar('posValDad', [480, -220]);
                    setVar('bfZoom', 0.8);
                    setVar('posValBF', [520, 450]);

                    for (o in act1Stage) o.alpha = 0.001;

                    //part 1
                    getVar('titleText').text = 'All-Stars (Act 2)';
                    getVar('autorText').text = 'Sandi ft. iKenny';

                    blackBarThingie.alpha = 1;
                    camHUD.alpha = 0;

                    game.triggerEvent('Change Character', '1', 'omega');
                    game.triggerEvent('Change Character', '0', 'bf_behind');
                    dad.x = 320;
                    dad.y = -130;
                    dad.scrollFactor.set(0.5, 0.5);
                    gf.visible = false;

                    game.remove(dadGroup);
                    insert(members.indexOf(act2Sky) + 1, dadGroup);
                    
                    for (o in act1Stage) remove(o, true);
                    for (o in act2Stage) o.alpha = 1;
                    act2WhiteFlash.alpha = 0;

                case 1:
                    //luigi
                    LG.alpha = 1;
                    setVar('posValGF', [520, 350]);
                    eventTweens.push(FlxTween.tween(LG, {y: LG.y - 800}, 2, {ease: FlxEase.circOut}));
                    eventTweens.push(FlxTween.tween(act2LPipe, {y: act2LPipe.y - 800}, 2, {ease: FlxEase.circOut}));
                    eventTweens.push(FlxTween.tween(act2Sky.velocity, {x: 10}, 0.8, {ease: FlxEase.quadInOut}));
                case 2:
                    //wario
                    setVar('posValDad', [260, 450]);
                    setVar('dadZoom', 0.7);
                    w4r.alpha = 1;
                    eventTweens.push(FlxTween.tween(w4r, {y: w4r.y - 800}, 2, {ease: FlxEase.circOut}));
                    eventTweens.push(FlxTween.tween(act2WPipe, {y: act2WPipe.y - 800}, 2, {ease: FlxEase.circOut}));
                case 3:
                    //yoshi
                    y0sh.alpha = 1;
                    eventTweens.push(FlxTween.tween(act2Sky.velocity, {x: -700}, 1.6, {ease: FlxEase.cubeOut}));
                    eventTweens.push(FlxTween.tween(y0sh, {y: y0sh.y - 800}, 2, {ease: FlxEase.circOut}));
                    eventTweens.push(FlxTween.tween(act2YPipe, {y: act2YPipe.y - 800}, 2, {ease: FlxEase.circOut}));
                case 4:
                    //start act3 transition
                    extraTween.push(FlxTween.tween(blackBarThingie, {alpha: 1}, 0.8, {ease: FlxEase.quadInOut}));
                    extraTween.push(FlxTween.tween(act2Fog, {alpha: 0}, 0.8, {ease: FlxEase.quadInOut}));
                    extraTween.push(FlxTween.tween(camHUD, {alpha: 0}, 3.6, {ease: FlxEase.quadInOut}));
                    extraTween.push(FlxTween.tween(camHUD, {angle: 15}, 3.6, {ease: FlxEase.quadIn}));
                    extraTween.push(FlxTween.tween(camHUD, {y: 500}, 3.6, {ease: FlxEase.quadIn}));
                case 5:
                    //omega scream
                    game.triggerEvent('Play Animation', 'scream', 'dad');
                    setVar('camMove', false);
                    extraTimers.push(new FlxTimer().start(1.1, function(tmr:FlxTimer)
                        {
                            setVar('camMove', true);
                        }));
                    extraTimers.push(new FlxTimer().start(0.2, function(tmr:FlxTimer)
                        {
                            game.triggerEvent('Screen Shake', '0.8, 0.01', '');
                        }));
                    extraTween.push(FlxTween.tween(camFollow, {y: getVar('posValDad')[1] - 250}, 0.8, {startDelay: 0.2, ease: FlxEase.cubeOut}));
                    extraTween.push(FlxTween.tween(camGame, {zoom: getVar('dadZoom') + 0.5}, 1, {ease: FlxEase.quadInOut}));
                case 6:
                    //change camera for bow
                    setVar('camMove', false);
                    extraTween.push(FlxTween.tween(camFollow, {y: 130}, 0.6, {ease: FlxEase.quadOut, onComplete: (_) -> setVar('camMove', true) }));
                    extraTween.push(FlxTween.tween(camGame, {zoom: 0.9}, 0.6, {ease: FlxEase.quadOut}));
                case 7: 
                    //hide omega
                    dad.visible = false;
                case 8:
                    //white flash
                    extraTween.push(FlxTween.tween(act2Sky, {x: act2Sky.x - 75}, 0.35, {ease: FlxEase.quadOut}));
                    if (ClientPrefs.data.flashing){
                        act2WhiteFlash.alpha = 1;
                        extraTween.push(FlxTween.tween(act2WhiteFlash, {alpha: 0}, 0.35, {ease: FlxEase.quadInOut}));
                    }
                }
        case 3:
            switch(Std.parseFloat(v2))
            {
                case 0:
                    remove(dadGroup);
                    insert(members.indexOf(gfGroup) + 1, dadGroup);
                    //act 3
                    getVar('titleText').text = 'All-Stars (Act 3)';
                    getVar('autorText').text = 'Scrumbo_ ft. FriedFrick';

                    game.triggerEvent('Change Character', '0', 'bfASsad');
                    game.triggerEvent('Change Character', '1', 'gx');

                    setVar('posValDad', [-800, 400]);
                    setVar('dadZoom', 0.8);
                    setVar('dadMove', 20);
                    setVar('bfMove', 20);
                    setVar('dadZoom', 0.6);
                    setVar('posValBF', [350, 475]);

                    dad.visible = true;
                    dad.x = -1400;
                    dad.y = -1310;
                    dad.scrollFactor.set(1, 1);

                    for (o in act3Stage) o.alpha = 1;
                    for (o in act2Stage) remove(o, true);

                    act3Fog.alpha = 0;

                    act3UltraHead2.alpha = 0.001;

                    y0sh.visible = false;
                    LG.visible = false;
                    w4r.visible = false;
                    gf.visible = false;

                    game.triggerEvent('Play Animation', 'cut', 'bf');

                    act3Spotlight.alpha = 0.7;
                    extraTween.push(FlxTween.tween(act3Fog, {alpha: 0.7}, 1, {ease: FlxEase.quadIn}));
                    extraTween.push(FlxTween.tween(blackBarThingie, {alpha: 0}, 1, {ease: FlxEase.quadOut}));
                    extraTween.push(FlxTween.tween(camFollow, {x: getVar('posValDad')[0]}, 3.2, {startDelay: 1.6, ease: FlxEase.quadInOut}));
                    extraTween.push(FlxTween.tween(camFollow, {y: getVar('posValDad')[1]}, 3.2, {startDelay: 1.6, ease: FlxEase.quadInOut}));
                    extraTween.push(FlxTween.tween(camGame, {zoom: getVar('dadZoom')}, 3.2, {startDelay: 1.6, ease: FlxEase.quadOut}));
                case 1:
                    //lower gx
                    eventTweens.push(FlxTween.tween(dad, {y: dad.y + 900}, 1.6, {ease: FlxEase.quadInOut}));
                    extraTween.push(FlxTween.tween(act3Spotlight, {alpha: 0}, 3.2, {ease: FlxEase.quadInOut}));
                case 2:
                    //reset gx camera
                    setVar('posValDad', [-400, getVar('posValDad')[1]]);
                    setVar('dadZoom', 0.65);
                case 3:
                    //first lyrics
                    act3UltraHead1.animation.play('sing');
                case 4:
                    //second lyrics
                    act3UltraHead1.visible = false;
                    act3UltraHead2.alpha = 1;
                    act3UltraHead2.animation.play('sing');
                    act3UltraBody.animation.play('change', true);

                    setVar('posValDad', [-240, 400]);
                    setVar('posValBF', [-240, 400]);
                    setVar('dadMove', 30);
                    setVar('bfMove', 30);
                    setVar('camMoveZoom', false);

                    game.triggerEvent('Set Cam Zoom', '0.5', '');

                    extraTween.push(FlxTween.tween(camGame, {zoom: 0.5}, 0.8, {ease: FlxEase.cubeInOut}));
                    extraTween.push(FlxTween.tween(game, {defaultCamZoom: 0.5}, 0.8, {ease: FlxEase.cubeInOut}));
                case 5:
                    //reset hude cam
                    camHUD.angle = 0;
                    camHUD.y = 0;
                    extraTween.push(FlxTween.tween(camHUD, {alpha: 1}, 2.4, {ease: FlxEase.quadInOut}));
                case 6:
                    //hide pupils
                    act3UltraPupils.visible = false;
                case 7:
                    //start act 4 transition
                    setVar('camMove', false);
                    act3UltraHead2.animation.play('laugh', true);
                    extraTween.push(FlxTween.tween(camHUD, {alpha: 0}, 1, {ease: FlxEase.quadInOut}));
                    extraTween.push(FlxTween.tween(camFollow, {y: getVar('posValBF')[1] + 350}, 1.6, {ease: FlxEase.quadInOut}));
                    extraTween.push(FlxTween.tween(camGame, {zoom: 0.6}, 1.2, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween)
                        {
                            extraTween.push(FlxTween.tween(act3Fog, {alpha: 0}, 0.35, {ease: FlxEase.quadInOut}));
                            extraTween.push(FlxTween.tween(camGame, {zoom: 8}, 0.35, {ease: FlxEase.expoIn, onComplete: function(twn:FlxTween)
                                {
                                    blackBarThingie.alpha = 1;
                                }}));
                        }}));
                }
        case 4:
            switch(Std.parseFloat(v2))
            {
                case 0:
                    //act 4
                    getVar('titleText').text = 'All-Stars (Act 4)';
                    getVar('autorText').text = 'FriedFrick\n ft. theWAHbox and RedTV53';

                    setVar('camMove', true);
                    setVar('camMoveZoom', true);

                    setVar('posValDad', [190, 240]);
                    setVar('posValBF', [720, 480]);
                    setVar('dadMove', 40);
                    setVar('bfMove', 15);
                    setVar('dadZoom', 2.5);
                    setVar('bfZoom', 1.3);

                    game.triggerEvent('Change Character', '0', 'bf_ultrafinale');
                    game.triggerEvent('Change Character', '1', 'mario_ultra2');

                    dadGroup.x = 100;
                    dadGroup.y = 100;
                    boyfriendGroup.x = 810;
                    boyfriendGroup.y = -75;

                    extraTimers.push(new FlxTimer().start(1 / act4SpawnNum, function(tmr:FlxTimer){
                        for (i in 0... act4SpawnNum){
                            var objsize:Float = FlxG.random.int(60, 115) / 100;

                            var act4Obj:BGSprite = new BGSprite('stages/allfinal/act4/floating objects', 2200, 200 + FlxG.random.int(-250, 250), 0.5, 0.5, ['floating objects']);
                            act4Obj.animation.addByIndices('1', 'floating objects', [0], "", 24, true);
                            act4Obj.animation.addByIndices('2', 'floating objects', [1], "", 24, true);
                            act4Obj.animation.addByIndices('3', 'floating objects', [2], "", 24, true);
                            act4Obj.animation.addByIndices('4', 'floating objects', [3], "", 24, true);
                            act4Obj.animation.addByIndices('5', 'floating objects', [4], "", 24, true);
                            act4Obj.animation.addByIndices('6', 'floating objects', [5], "", 24, true);
                            act4Obj.animation.addByIndices('7', 'floating objects', [6], "", 24, true);
                            act4Obj.animation.addByIndices('8', 'floating objects', [7], "", 24, true);
                            act4Obj.animation.addByIndices('9', 'floating objects', [8], "", 24, true);
                            act4Obj.animation.addByIndices('10', 'floating objects', [9], "", 24, true);
                            act4Obj.animation.play(FlxG.random.int(1,10) + '', true);
                            act4Obj.angle = FlxG.random.int(0,360);
                            act4Obj.scrollFactor.set(0.65 + (objsize / 5), 0.65 + (objsize / 5));
                            act4Obj.scale.set(objsize, objsize);
                            addBehindGF(act4Obj);
                            act4Floaters.push(act4Obj);

                            if (boyfriend.curCharacter == 'bf_ultrafinale2') act4Obj.color = 0xff4e4e4e;

                            var tweenspeed:Float = FlxG.random.int(95, 220) / (7 + (act4SpawnNum * 3));

                            if (FlxG.random.bool(50))
                                extraTween.push(FlxTween.tween(act4Obj, {angle: act4Obj.angle + FlxG.random.int(90, 360)}, tweenspeed));
                            else
                                extraTween.push(FlxTween.tween(act4Obj, {angle: act4Obj.angle - FlxG.random.int(90, 360)}, tweenspeed));
                            
                            extraTween.push(FlxTween.tween(act4Obj, {x: -450}, tweenspeed, {onComplete: function(twn:FlxTween)
                                {
                                    act4Obj.destroy();
                                }}));
                        }
                    }, 0));

                    for (o in act3Stage) remove(o, true);
                    for (o in act4Stage) o.alpha = 1;

                    dad.visible = true;

                    insert(members.indexOf(blackBarThingie) + 1, act4Intro);
                case 1:
                    setVar('posValBF', [1000, 550]);
                    setVar('bfZoom', 1.5);
                    
                    extraTween.push(FlxTween.tween(uiGroup, {alpha: 0}, 1.6, {ease: FlxEase.quadInOut}));
                     extraTween.push(FlxTween.tween(blackBarThingie, {alpha: 1}, 1.6, {ease: FlxEase.quadInOut}));
                    extraTween.push(FlxTween.tween(camFollow, {x: getVar('posValBF')[0], y: getVar('posValBF')[1]}, 1.6, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween)
                    {
                        camFollow.x += 40;
                        camFollow.y -= 250;
                    }}));
                    extraTween.push(FlxTween.tween(camGame, {zoom: getVar('bfZoom')}, 1.6, {ease: FlxEase.quadInOut}));
                case 2:
                    for (o in act4Stage) o.alpha = 0.001;
                    for (o in act4Stage2) o.alpha = 1;
                    act4Memory1.alpha = 0;
                    act4Memory2.alpha = 0;
                    act4Spotlight.alpha = 0.25;
                    dad.visible = false;
                    act4SpawnNum = 1;

                    for (f in act4Floaters) f.color = 0xff4e4e4e;

                    game.triggerEvent('Change Character', '0', 'bf_ultrafinale2');
                    setVar('posValBF', [1000, 425]);
                    setVar('bfZoom', 0.7);

                    extraTween.push(FlxTween.tween(blackBarThingie, {alpha: 0}, 0.8, {ease: FlxEase.quadInOut}));
                    insert(members.indexOf(boyfriendGroup) + 1, act4Spotlight);
                case 3:
                    //gf memory
                    setVar('bfZoom', 0.6);

                    extraTween.push(FlxTween.tween(act4Spotlight, {alpha: 1}, 20, {ease: FlxEase.linear}));
                    extraTween.push(FlxTween.tween(act4Memory1, {y: act4Memory1.y - 300}, 9, {ease: FlxEase.linear}));
                    extraTween.push(FlxTween.tween(act4Memory1, {alpha: 0.4}, 4.5, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween)
                    {
                        extraTween.push(FlxTween.tween(act4Memory1, {alpha: 0}, 4.5, {ease: FlxEase.quadOut}));
                    }}));
                case 4:
                    //gx memory
                    extraTween.push(FlxTween.tween(act4Memory2, {y: act4Memory2.y + 300}, 9, {ease: FlxEase.linear}));
                    extraTween.push(FlxTween.tween(act4Memory2, {alpha: 0.4}, 4.5, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween)
                    {
                        extraTween.push(FlxTween.tween(act4Memory2, {alpha: 0}, 4.5, {ease: FlxEase.quadOut}));
                    }}));
                case 5:
                    //end perspective transition
                    setVar('camMoveZoom', false);
                    extraTween.push(FlxTween.tween(camGame, {zoom: 0.5}, 0.8, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween)
                        {
                            act4SpawnNum = 4;
                            extraTween.push(FlxTween.tween(camGame, {zoom: 1.2}, 0.8, {ease: FlxEase.cubeIn}));
                        }}));
                case 6:
                    extraTween.push(FlxTween.tween(uiGroup, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut}));
                    //finale perspective

                    for (f in act4Floaters) f.color = FlxColor.WHITE;

                    if (ClientPrefs.data.flashing)
                    {
                        FlxG.camera.flash(FlxColor.WHITE, 0.8);
                    }
                    else
                    {
                        FlxG.camera.flash(FlxColor.BLACK, 0.8);
                    }
                    
                    game.triggerEvent('Change Character', '0', 'bf_ultrafinale3');
                    game.triggerEvent('Change Character', '1', 'mario_ultra3');
                    game.defaultCamZoom = 1.05;
                    boyfriendGroup.x += 270;
                    boyfriendGroup.y += 225;
                    dadGroup.x += 250;

                    for (o in act4Stage) o.alpha = 1;
                    for (o in act4Stage2) o.alpha = 0;
                    act4Pipe1.visible = false;
                    act4Spotlight.visible = false;

                    act4Ripple.x += 300;
                    act4Ripple.y += 75;
                    act4Stat.x += 150;
                    act4Stat.y += 75;

                    setVar('posValDad', [getVar('posValBF')[0] - 50, getVar('posValBF')[1]]);
                    setVar('posValBF', [getVar('posValBF')[0] - 50, getVar('posValBF')[1]]);
                    setVar('dadMove', 20);
                    setVar('bfMove', 20);
                    extraTween.push(FlxTween.tween(camFollow, {x: getVar('posValDad')[0], y: getVar('posValDad')[1]}, 0.1));
                    insert(members.indexOf(boyfriendGroup) + 1, act4Lightning);
                case 7:
                    //S1E8 Boyfriend Dies and Doesn't Come Back
                    FlxG.camera.flash(FlxColor.RED, 1);
                    act2WhiteFlash.color = FlxColor.RED;
                    act2WhiteFlash.alpha = 1;

                    act4DeadBF.animation.play('die');
                    act4DeadBF.alpha = 1;
                    act4GameOver.alpha = 0;

                    camHUD.visible = false;

                    setVar('camMove', false);

                    dadGroup.visible = false;
                    boyfriendGroup.visible = false;
                    act3Fog.visible = false;
                    
                    act4Lightning.visible = false;

                    for (o in act3Stage) remove(o, true);
                    for (o in act4Stage) remove(o, true);
                    for (o in act4Stage2) remove(o, true);
                    for (f in act4Floaters) f.visible = false;
                    for (f in extraTimers) f.cancel();

                    setVar('camMoveZoom', false);
                    setVar('bfZoom', 0.3);
                    game.defaultCamZoom = 0.6;
                    camGame.zoom = 0.7;
                    new FlxTimer().start(1, (_) -> game.camZooming = false );
                case 8:
                    //bf dies part 3
                    extraTween.push(FlxTween.tween(camGame, {zoom: 0.25}, 7.2, {ease: FlxEase.quadIn}));
                    extraTween.push(FlxTween.tween(act4DeadBF, {alpha: 0}, 4.8, {ease: FlxEase.quadIn}));
                case 9:
                    //bf dies part 3
                    extraTween.push(FlxTween.tween(act4GameOver, {alpha: 1}, 4.8, {ease: FlxEase.quadInOut}));
                case 10:
                    //bf dies part 4
                    extraTween.push(FlxTween.tween(blackBarThingie, {alpha: 1}, 4.8, {ease: FlxEase.quadInOut}));
                case 11:
                    act4SpawnNum = 3;
                case 12:
                    act4SpawnNum = 2;
                case 13:
                    //bf die zoom in
                    extraTween.push(FlxTween.tween(camGame, {zoom: getVar('bfZoom') + 0.4}, 0.8, {ease: FlxEase.cubeIn}));
                    extraTween.push(FlxTween.tween(camFollow, {x: getVar('posValBF')[0] + 150, y: getVar('posValBF')[1] + 50}, 0.8, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween)
                        {	
                        camFollow.x = getVar('posValBF')[0];
                        camFollow.y = getVar('posValBF')[1];
                        }}));
                case 14:
                    //voiceline thing
                    act4Intro.scale.set(0.01, 0.01);
                    act4Intro.animation.play('anim', true);
                    extraTween.push(FlxTween.tween(act4Intro, {alpha: 1}, 0.5, {ease: FlxEase.sineOut}));
                    extraTween.push(FlxTween.tween(act4Intro.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.sineOut, onComplete: function(twn:FlxTween)
                        {	
                            extraTween.push(FlxTween.tween(act4Intro.scale, {x: 1.2, y: 1.2}, 10, {ease: FlxEase.quadInOut}));
                        }}));
                case 15:
                    //FIGHT
                    setVar('posValDad', [570, 440]);
                    setVar('dadZoom', 1);
                    camFollow.x = getVar('posValDad')[0];
                    camFollow.y = getVar('posValDad')[1];

                    game.defaultCamZoom = 1;

                    PlayState.instance.callOnLuas('onSectionHit', []);
                    PlayState.instance.callOnLuas('opponentNoteHit', [0, 0, '', false]);
                    extraTween.push(FlxTween.tween(blackBarThingie, {alpha: 0}, 0.7, {ease: FlxEase.quadOut}));
                    extraTween.push(FlxTween.tween(act3Fog, {alpha: 0.7}, 0.7, {ease: FlxEase.quadOut}));
                    extraTween.push(FlxTween.tween(act4Intro, {alpha: 0}, 0.7, {ease: FlxEase.quadOut}));
                    camHUD.alpha = 1;

            }
        }
    }

    return;
}

function onBeatHit(){

    var fuckyoupysch:Array<Int> = [57, 79, 97, 113, 185, 217, 241];
    for(i in 0... fuckyoupysch.length){
        if(curBeat == fuckyoupysch[i]){
            boyfriend.dance();
        }
    }

    if (curBeat % 4 == 0)
    {
        if (PlayState.SONG.notes[Math.floor(curStep / 16)].mustHitSection){
            eventTweens.push(FlxTween.tween(act3UltraPupils, {x: -175}, 1.5, {ease: FlxEase.quadInOut}));
        }
        else{
            eventTweens.push(FlxTween.tween(act3UltraPupils, {x: -220}, 1.5, {ease: FlxEase.quadInOut}));
        }
        eventTweens.push(FlxTween.tween(act3UltraHead1, {y: -210 + 30}, 0.1, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
            {
                eventTweens.push(FlxTween.tween(act3UltraHead1, {y: -210}, 0.4, {ease: FlxEase.quadInOut}));
            }}));
        eventTweens.push(FlxTween.tween(act3UltraHead2, {y: -300 + 30}, 0.1, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
            {
                eventTweens.push(FlxTween.tween(act3UltraHead2, {y: -300}, 0.4, {ease: FlxEase.quadInOut}));
            }}));
        eventTweens.push(FlxTween.tween(act3UltraPupils, {y: 105 + 30}, 0.1, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
            {
                eventTweens.push(FlxTween.tween(act3UltraPupils, {y: 105}, 0.4, {ease: FlxEase.quadInOut}));
            }}));
        if (curBeat <= 810){
            if (curBeat != 808)
                act3UltraBody.animation.play('idle', true);
        }
        else{
            if (curBeat <= 872)
                game.triggerEvent('Set Cam Zoom', camGame.zoom + 0.005 + '', '');
            act3UltraBody.animation.play('idle-alt', true);
        }
    }

    return;
}