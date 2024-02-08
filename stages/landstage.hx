import objects.BGSprite;


var brickslandEXE;
var bricksland;
var estaland;

var landbg = [];
var eventTweens = [];

var useShader = !getModSetting('noShaders');

var test5;
var tvstatic;

function onCreate(){
    //game.skipCountdown = true;

    var bglandEXE:BGSprite = new BGSprite('stages/EXE2/bad/4', -500, -200, 0.3, 0.3); // nubes
    bglandEXE.setGraphicSize(Std.int(bglandEXE.width * 6));
    bglandEXE.updateHitbox();
    bglandEXE.antialiasing = false;
    addBehindGF(bglandEXE);

    var bgwaterEXE:BGSprite = new BGSprite('stages/EXE2/bad/3', -500, -200, 0.4, 0.4); // agua
    bgwaterEXE.setGraphicSize(Std.int(bgwaterEXE.width * 6));
    bgwaterEXE.updateHitbox();
    bgwaterEXE.antialiasing = false;
    addBehindGF(bgwaterEXE);

    var floorEXE:BGSprite = new BGSprite('stages/EXE2/bad/2', -500, -200, 1, 1); // suelo
    floorEXE.setGraphicSize(Std.int(floorEXE.width * 6));
    floorEXE.updateHitbox();
    floorEXE.antialiasing = false;
    addBehindDad(floorEXE);

    brickslandEXE = new BGSprite('stages/EXE2/bad/1', -500, -400, 1.2, 1.2); // bloques
    brickslandEXE.setGraphicSize(Std.int(brickslandEXE.width * 6));
    brickslandEXE.updateHitbox();
    brickslandEXE.visible = false;
    brickslandEXE.antialiasing = false;
    add(brickslandEXE);

    var bgland:BGSprite = new BGSprite('stages/EXE2/normal/4', -500, -200, 0.3, 0.3); // nubes
    bgland.setGraphicSize(Std.int(bgland.width * 6));
    bgland.updateHitbox();
    bgland.antialiasing = false;
    landbg.push(bgland);
    addBehindDad(bgland);

    var bgwater:BGSprite = new BGSprite('stages/EXE2/normal/3', -500, -200, 0.4, 0.4); // agua
    bgwater.setGraphicSize(Std.int(bgwater.width * 6));
    bgwater.updateHitbox();
    bgwater.antialiasing = false;
    landbg.push(bgwater);
    addBehindDad(bgwater);

    var floor:BGSprite = new BGSprite('stages/EXE2/normal/2', -500, -200, 1, 1); // suelo
    floor.setGraphicSize(Std.int(floor.width * 6));
    floor.updateHitbox();
    floor.antialiasing = false;
    landbg.push(floor);
    addBehindDad(floor);

    bricksland = new BGSprite('stages/EXE2/normal/1', -500, -400, 1.2, 1.2); // bloques
    bricksland.setGraphicSize(Std.int(bricksland.width * 6));
    bricksland.updateHitbox();
    bricksland.antialiasing = false;
    add(bricksland);

    estaland = new FlxSprite();
    estaland.frames = Paths.getSparrowAtlas('modstuff/Mario_Phase2_Background_Assets_Overlay');
    estaland.animation.addByPrefix('idle', "aeiuo instancia 1", 12);
    estaland.animation.play('idle');
    estaland.antialiasing = false;
    estaland.setGraphicSize(Std.int(estaland.width * 2));
    estaland.alpha = 0.2;
    estaland.visible = false;
    estaland.cameras = [getVar('camEst')];
    estaland.updateHitbox();
    estaland.screenCenter(0x11);
    add(estaland);
    
    game.defaultCamZoom = 0.8;
    return;
}
function onCreatePost(){
    if (useShader){
        game.initLuaShader('TVStatic');
        game.initLuaShader('test5');
        tvstatic = game.createRuntimeShader('TVStatic');
        test5 = game.createRuntimeShader('test5');
        tvstatic.setFloat('strengthMulti', 0.5);
        tvstatic.setFloat('imtoolazytonamethis', 0.3);

        var sh = [new ShaderFilter(test5), new ShaderFilter(tvstatic)];
        game.camGame.filters = sh;
    }
    return;
}

var g = 0;
function onUpdate(e){
    g += e;
    tvstatic.setFloat('iTime', g);
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Triggers Universal' || n == 'Triggers Golden Land'){
        var tiempoN:Float = 0.001;
        var triggerGL:Float = Std.parseFloat(v1);
        var blackcoso:Float = Std.parseFloat(v2);
        if (Math.isNaN(triggerGL))
            triggerGL = 0;
        if (Math.isNaN(blackcoso))
            blackcoso = 1;

        switch (triggerGL)
        {
            case 0:
                for (land in landbg) land.visible = false;
                estaland.visible = true;
                bricksland.visible = false;
                brickslandEXE.visible = true;
                game.triggerEvent('Play Animation', 'idle', 'gf');
                gfGroup.y += 450;
            case 1:
                game.triggerEvent('Screen Shake', '0.15, 0.05', '');
                eventTweens.push(FlxTween.tween(gfGroup, {y: gfGroup.y - 450}, 1, {ease: FlxEase.quadOut}));
            case 2:
                eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: blackcoso}, 0.5, {ease: FlxEase.quadInOut}));
            case 3:
                //quitarvida = true;
            case 4:
                //quitarvida = false;
            case 5:
                eventTweens.push(FlxTween.tween(camHUD, {alpha: 0.1}, 0.5));
            case 6:
                eventTweens.push(FlxTween.tween(camGame, {zoom: 1.3}, 1.34, {ease: FlxEase.expoIn}));
            case 7:
                setVar('dadZoom', 0.9);
                game.triggerEvent('Screen Shake', '0.4, 0.008', '');
                game.triggerEvent('Play Animation', 'laugh', 'dad');
                eventTweens.push(FlxTween.tween(camFollow, {x: 380, y: 350}, 1.34, {ease: FlxEase.cubeOut}));
                eventTweens.push(FlxTween.tween(camHUD, {alpha: 0.4}, 0.2));
                eventTweens.push(FlxTween.tween(camGame, {zoom: 0.9}, 0.2, {ease: FlxEase.cubeOut}));
            case 8:
                setVar('dadZoom', 0.8);
                eventTweens.push(FlxTween.tween(camHUD, {alpha: 1}, 0.2));
        }
    }
    return;
}
var lol = false;
var startedCountdown = false;
function onStartCountdown(){
    startedCountdown = false;
    if (!lol){
        lol = true;
        startedCountdown = true;
        game.startCountdown();
        var blackthing = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        blackthing.setGraphicSize(Std.int(blackthing.width * 10));
        blackthing.alpha = 1;
        blackthing.cameras = [camOther];
        add(blackthing);

        FlxTween.tween(blackthing, {alpha: 0}, 1, {ease: FlxEase.quadInOut});
    }
}
