import objects.BGSprite;

var explosionBOM;
var secretWarning;
var frontTrees;
var blackBarThingie;

var eventTweens = [];
var extraTween = [];
var eventTimers = [];
function onCreate(){
    game.skipCountdown = true;

    var floorField:BGSprite = new BGSprite('stages/secret/WallAndFloor', -1300, -600, 1, 1);
    floorField.setGraphicSize(Std.int(floorField.width * 0.85));

    var backTrees:BGSprite = new BGSprite('stages/secret/BackTrees', -1300, -600, 0.8, 0.8);
    backTrees.setGraphicSize(Std.int(backTrees.width * 0.85));

    var skyBox:BGSprite = new BGSprite('stages/secret/SkyBox', -1300, -600, 0.4, 0.4);
    skyBox.setGraphicSize(Std.int(skyBox.width * 0.85));

    addBehindGF(skyBox);
    addBehindGF(backTrees);
    addBehindGF(floorField);

    game.addCharacterToList('secretstages', 1);

    explosionBOM = new BGSprite('stages/secret/SECRETEXPLOSION', 250, -290, 1, 1, ['1'], false);
    explosionBOM.animation.addByPrefix('BOOM', '1', 35, false);
    explosionBOM.alpha = 0;
    explosionBOM.setGraphicSize(Std.int(explosionBOM.width * 1.5));
    explosionBOM.updateHitbox();
    add(explosionBOM);

    secretWarning = new BGSprite('stages/secret/BulletBill_Warning', 0, 0, 1, 1, ['warning'], true);
    secretWarning.animation.addByPrefix('loop', 'warning', 24, true);
    secretWarning.animation.addByPrefix('bye', 'blow away', 24, false);
    secretWarning.animation.play('loop');
    secretWarning.cameras = [camHUD];
    secretWarning.screenCenter();
    secretWarning.x += 200;
    secretWarning.visible = false;
    add(secretWarning);

    frontTrees = new BGSprite('stages/secret/BushesForeground', -1300, -700, 1.4, 1.4);
    add(frontTrees);

    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.alpha = 1;
    blackBarThingie.cameras = [getVar('camEst')];
    add(blackBarThingie);

    camHUD.alpha = 0;
    return;
}

function onCreatePost(){
    for (note in game.unspawnNotes){
        if (note.noteType == 'Bullet Bill'){
            note.texture = 'stages/secret/BulletBillMario_NOTE_assets';
            note.noAnimation = true;
            note.offsetX -= 50;
            if (ClientPrefs.data.downScroll){
                note.flipY = true;
                note.offsetY -= 550;
            }
        }
        if (note.noteType == 'Bullet2'){
            note.visible = false;
            note.noAnimation = true;
        }
    }
    return;
}

var bulletCounter = 0;
var bulletTimer = 0;

function goodNoteHit(note){
    if (note.noteType == 'Bullet Bill' || note.noteType == 'Bullet2'){
        bulletCounter += 1;
        if(bulletCounter >= 2){
            bulletCounter = 0;
            bulletBillSplash(note.noteData);
            FlxG.sound.play(Paths.sound('SHbullethit'), 0.6);
        }
    }
    return;
}

function noteMiss(note){
    if (note.noteType == 'Bullet Bill'){
        bulletTimer = 1;
    }
    return;
}

function bulletBillSplash(id){
    var x = game.playerStrums.members[id].x;
    var y = game.playerStrums.members[id].y;
    var spl = new FlxSprite(x,y);
    spl.frames = Paths.getSparrowAtlas('stages/secret/BulletBillMario_NOTE_assets');
    spl.animation.addByPrefix('boom', 'notesplash', 24, false);
    spl.antialiasing = ClientPrefs.data.antialiasing;
    spl.offset.x += 460;
    spl.offset.y += 350;
    spl.camera = camHUD;
    if (ClientPrefs.data.downScroll){
        spl.flipY = true;
       spl.offset.y += 350;
    }
    spl.animation.play('boom', true);
    spl.animation.finishCallback = (_) -> {
        remove(spl);
    }
    add(spl);
}

function onSongStart(){
    eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: 0}, 0.5, {startDelay: 1, ease: FlxEase.quadInOut}));
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Triggers Universal' || n == 'Triggers Dictator'){
        var trigger:Float = Std.parseFloat(v1);
        var trigger2:Float = Std.parseFloat(v2);
        if (Math.isNaN(trigger))
            trigger = 0;
        if (Math.isNaN(trigger2))
            trigger2 = 0;
        
        switch (trigger)
        {
            case 0:
                setVar('camMove', false);
                game.camFollow.x = 220;
                game.camFollow.y = -390;
                FlxG.camera.snapToTarget();
            case 1:
                setVar('posValDad', [220, 430]);
                eventTweens.push(FlxTween.tween(camFollow, {y: 380}, 4, {ease: FlxEase.quadInOut}));
                eventTweens.push(FlxTween.tween(camGame, {zoom: 1.2}, (22.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadInOut}));
            case 2:
                eventTweens.push(FlxTween.tween(camGame, {zoom: 1.3}, 1, {startDelay: (0.5 * (1 / (Conductor.bpm / 60))), ease: FlxEase.backOut}));
            case 3:
                eventTweens.push(FlxTween.tween(camGame, {zoom: 0.8}, (2 * (1 / (Conductor.bpm / 60))), { ease: FlxEase.quadIn}));
            case 4:
                setVar('camMove', true);
            case 5:
                setVar('dadZoom', 0.7);
                setVar('bfZoom', 0.7);
                game.defaultCamZoom = 0.7;
            case 7:
                setVar('camMove', false);
                setVar('camMoveZoom', false);
                extraTween.push(FlxTween.tween(camFollow, {x: 1020, y: 550}, (2 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadIn}));
                eventTweens.push(FlxTween.tween(camGame, {zoom: 1}, 0.3, {ease: FlxEase.quadOut}));
                game.defaultCamZoom = 1;
            case 8:
                for (tween in extraTween)
                    {
                        tween.cancel();
                    }
                extraTween.push(FlxTween.tween(camFollow, {y: 50}, (1 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadOut}));
                setVar('camMove', false);
                explosionBOM.alpha = 1;
                explosionBOM.animation.play('BOOM');
            case 9:
                blackBarThingie.alpha = 1;
            case 11:
                secretWarning.animation.play('bye', true);
                secretWarning.x -= 470;
            case 12:
                secretWarning.visible = true;
                secretWarning.y -= 800;
                eventTweens.push(FlxTween.tween(secretWarning, {y: secretWarning.y + 800}, 1.5, {ease: FlxEase.quadOut}));
                add(secretWarning);
        }
    }
    return;
}

function onUpdate(elapsed){
    if (bulletTimer > 0){
        bulletTimer -= 1 * (60 / ClientPrefs.data.framerate);
        if (bulletTimer <= 0){
            bulletTimer = -1;
            eventTweens.push(FlxTween.tween(game, {health: health - 1}, 0.2, {ease: FlxEase.quadOut}));
            FlxG.sound.play(Paths.sound('SHbulletmiss'), 0.5);
            var whiteSquare:FlxSprite = new FlxSprite().makeGraphic(Std.int(iconP1.width / 2), Std.int(iconP1.height / 2), FlxColor.WHITE);
            whiteSquare.cameras = [camHUD];
            whiteSquare.setPosition(iconP1.x + 60, iconP1.y + 30);
            whiteSquare.visible = ClientPrefs.data.flashing;
            add(whiteSquare);

            eventTimers.push(new FlxTimer().start(0.05, function(tmr:FlxTimer)
                {
                    whiteSquare.destroy();
                    iconP1.color = 0x000000;
                    whiteSquare.visible = true;
                    eventTimers.push(new FlxTimer().start(0.05, function(tmr:FlxTimer)
                        {
                            iconP1.color = 0xFFFFFF;
                        }));
                }));
        }
    }
    return;
}