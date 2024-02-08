import Type;
import flixel.text.FlxText;
import flixel.text.FlxTextFormat;
import tjson.TJSON;
import objects.BGSprite;

var col = [];
var disabled = true; // Disabled because we use MM note skin instead :>
var sn = Paths.formatToSongPath(game.songName.toLowerCase());

var camEst;
//mainly for strums modchart
var camStrum1;
var camStrum2;

var autor = '---';
var titleText;
var autorText;
var line2;
var line1;
var sgCol; 

var titleNES;
var linefount;
var djStart;

var animReturnDad = false;

var eventTweens = [];
function onCreate(){
    switch(sn){
        case 'paranoia':
            col = [0xFFFF0000, 0xFFFFFFFF, 0xFF000000];
        case 'i-hate-you':
            col = [0xFF5AA400,0xFF005CBF, 0xFFFFFFFF];
        case 'overdue':
            col = [0xFF83a27d,0xFF151028, 0xFFafaf8c];
        case 'overdue-joke':
            col = [0xFF83a27d,0xFF151028, 0xFFafaf8c];
        case 'the-end':
            col = [0xff422929,0xFFFFFFFF, 0xFFafaf8c];
            col = [0xff000000,0xFFFFFFFF, 0xFFafaf8c];
            disabled = false;
        default: disabled = true;
    }
    switch (sn){
        case 'starman-slaughter':
            autor = 'Sandi ft. RedTV53\n FriedFrick and theWAHbox';
        case 'golden-land':
            autor = 'FriedFrick';
        case 'all-stars':
            autor = 'iKenny';
        case 'i-hate-you':
            autor = 'iKenny';
        case 'powerdown':
            autor = 'iKenny ft. TaeSkull';
        case 'alone':
            autor = 'RedTV53';
        case 'demise':
            autor = 'iKenny';
        case 'unbeatable':
            autor = 'RedTV53 ft. Ironik';
        case 'paranoia':
            PlayState.daPixelZoom = 3.5;
            autor = 'Sandi ft. iKenny';
        case 'overdue':
            autor = 'FriedFrick ft. Sandi';
        case 'nourishing-blood':
            autor = 'Kenny L';
        case 'day-out':
            autor = 'TheWAHBox';
        case 'promotion':
            autor = 'Sandi';
        case 'dictator':
            autor = 'Kenny L';
        case 'last-course':
            autor = 'FriedFrick ft. Sandi';
        case 'the-end':
            autor = 'Kenny L';
        case 'mario-sing-and-game-rythm-9':
            autor = 'TaeSkull';
        case 'no-party':
            PlayState.daPixelZoom = 1.85;
            autor = 'Kenny L';
        default:
            PlayState.daPixelZoom = 6;
    }

    FlxG.cameras.remove(game.camHUD,false);
    FlxG.cameras.remove(game.camOther,false);
    
    camEst = new FlxCamera();
    camEst.bgColor = 0x00;
    setVar('camEst', camEst);

    camStrum1 = new FlxCamera();
    camStrum1.bgColor = 0x00;
    setVar('camStrum1', camStrum1);
    camStrum2 = new FlxCamera();
    camStrum2.bgColor = 0x00;
    setVar('camStrum2', camStrum2);

    FlxG.cameras.add(camEst,false);
    FlxG.cameras.add(camStrum1,false);
    FlxG.cameras.add(camStrum2,false);
    FlxG.cameras.add(game.camHUD,false);
    FlxG.cameras.add(game.camOther,false);

    createGlobalCallback('setObjCamEst', function(tag:String){
        game.getLuaObject(tag).camera = camEst;
    });
    createGlobalCallback('camStrumShake', function(int:Float, dur:Float){
        camStrum1.shake(int, dur);
        camStrum2.shake(int, dur);
    });

    sgCol = (sn == 'golden-land' ? 0xFFADADAD : 0xFFF42626);
    
    var ratingD = ['sick', 'good', 'bad', 'shit'];
    for (i in 0...4){
        ratingsData[i].image = 'rating/' + (sn == 'golden-land' ? 'gb' : '')  + ratingD[i];
    }

    titleText = new FlxText(400, 304.5, 0, PlayState.SONG.song, 42);
	titleText.setFormat(Paths.font("mariones.ttf"), 42, FlxColor.BLACK, 'center', Type.resolveEnum('flixel.text.FlxTextBorderStyle').OUTLINE, sgCol);
    titleText.camera = camEst;
    titleText.borderSize = 3;
	titleText.screenCenter(0x01);
	titleText.alpha = 0;
    setVar('titleText', titleText);
	add(titleText);

    var format = new FlxTextFormat(0x000000, false, false, sgCol);
    format.leading = -5;
    autorText = new FlxText(400, titleText.y + 70, 0, autor, 35);
    autorText.setFormat(Paths.font("mariones.ttf"), 35, FlxColor.BLACK, 'center', Type.resolveEnum('flixel.text.FlxTextBorderStyle').OUTLINE, sgCol);
    autorText.borderSize += 2;
    autorText.screenCenter(0x01);
    autorText.camera = camEst;
    autorText.alpha = 0;
    setVar('autorText', autorText);
    add(autorText);
    autorText.addFormat(format);

    setVar('titText', titleText.text);
    setVar('autText', autorText.text);

    if (sn == 'mario-sing-and-game-rythm-9'){
        titleNES = new FlxSprite();
        titleNES.loadGraphic(Paths.image('pixelUI/title'));
        titleNES.width = titleNES.width / 4;
        titleNES.loadGraphic(Paths.image('pixelUI/title'), true, Math.floor(titleNES.width), Math.floor(titleNES.height));
        titleNES.scale.set(2, 2);
        titleNES.antialiasing = false;
        titleNES.visible = false;
        titleNES.cameras = [camHUD];
        titleNES.updateHitbox();
        titleNES.screenCenter();
        titleNES.y += 25;

        titleNES.animation.add("show", [3, 2, 1, 0], 12, false);
        titleNES.animation.add("hide", [0, 1, 2, 3], 12, false);
        add(titleNES);
    }else if (sn == 'the-end'){
        linefount = new BGSprite('stages/costume/endtext', 0, 0, 1, 1);
        linefount.screenCenter();
        linefount.antialiasing = ClientPrefs.data.globalAntialiasing;
        linefount.camera = camEst;
        linefount.visible = false;
        add(linefount);
    }else if (sn == 'no-party'){
        djStart = new BGSprite('stages/piracy/start', 1280, ClientPrefs.data.downScroll? 150 : 510, 0, 0);
        djStart.setGraphicSize(Std.int(djStart.width * 2));
        djStart.updateHitbox();
        djStart.antialiasing = false;
        djStart.camera = camEst;
        djStart.visible = false;
        add(djStart);
    }


    return;
}

function onCreatePost(){
    switch(sn){
        case 'paranoia':
            for (note in game.unspawnNotes){
                if (note.isSustainNote){
                    note.offsetX += 66;
                    note.scale.y *= 1.72;
				    note.updateHitbox();
                }
            }
            uiGroup.color = 0xff0000;
            sgCol = 0xff0000;
        case 'no-party':
            for (note in game.unspawnNotes){
                if (note.isSustainNote){
                    note.offsetX += 40;
                    note.scale.y *= 3.31;
                    note.updateHitbox();
                }
            }
    }
    game.timeTxt.color = (sn == 'i-hate-you' ? 0xFFF4DA8F : sgCol);
    game.scoreTxt.color = sgCol;
    game.timeBar.leftBar.color = sgCol;

    if (!disabled){
        for (note in game.unspawnNotes) {
            note.rgbShader.r = col[0];
            note.rgbShader.b = col[1];
            note.rgbShader.g = col[2];
        }
    }else{
        for (note in game.unspawnNotes) {
            note.rgbShader.enabled = false;
        }
        for (strums in game.strumLineNotes) {
            strums.rgbShader.enabled = false;
            strums.useRGBShader = false;
        }
    }
    
    comboGroup.camera = camGame;
    comboGroup.x = gf.x;
    comboGroup.y = gf.y;


    for (strum in game.playerStrums)
        strum.camera = camStrum2;
    for (strum in game.opponentStrums)
        strum.camera = camStrum1;
    for (note in game.unspawnNotes){
        if (note.mustPress) note.camera = camStrum2;
        else note.camera = camStrum1;
    }

    return;
}

function opponentNoteHit(i){
    if (!disabled){
        game.opponentStrums.members[i.noteData].rgbShader.r = col[0];
        game.opponentStrums.members[i.noteData].rgbShader.g = col[1];
        game.opponentStrums.members[i.noteData].rgbShader.b = col[2];
    }
    return;
}


function goodNoteHit(i){
    if (!disabled){
        game.playerStrums.members[i.noteData].rgbShader.r = col[0];
        game.playerStrums.members[i.noteData].rgbShader.g = col[1];
        game.playerStrums.members[i.noteData].rgbShader.b = col[2];
    }
    return;
}
function onUpdatePost(){
    for (splash in game.grpNoteSplashes)
        splash.camera = camStrum2;

    for (su in [camStrum1, camStrum2]){
        su.alpha = camHUD.alpha;
        su.angle = camHUD.angle;
        su.zoom = camHUD.zoom;
        su.filters = camHUD.filters;
    }

    if (animReturnDad){
        var currentAnim = dad.animation.curAnim;
        if (!currentAnim.finished) dad.holdTimer = 0;
    
        if (currentAnim.finished) {
            dad.dance();
        }
    }

    return;
}

function onEvent(n,v1,v2){
    switch(n){
        case 'Triggers Unbeatable' | 'Triggers Universal':
            if (sn == 'unbeatable'){
                if (v1 == '2'){
                    titleText.text = 'Unbeatable(Level 2)';
                    autorText.text = 'scrumbo_';
                }
                if (v1 == '11'){
                    titleText.text = 'Unbeatable(Level 3)';
                    autorText.text = 'theWAHbox ft. RedTV53';             
                }
                if (v1 == '17'){
                    titleText.text = 'Unbeatable(Level 4)';
                    autorText.text = 'RedTV53 ft. FriedFrick';           
                }
            }
        case 'Change Character':
            switch(dad.curCharacter){
                case 'gbv2evil':
                    animReturnDad = true;
                default:
                    animReturnDad = false;
            }
        case 'Ocultar HUD':
            var bruhHUD:Float = Std.parseFloat(v1);
            if (Math.isNaN(bruhHUD))
                bruhHUD = 0;
            switch (bruhHUD) {
                case 0:
                    FlxTween.tween(camHUD, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
                case 1:
                    FlxTween.tween(camHUD, {alpha: 1}, 0.001);
                case 2:
                    FlxTween.tween(camHUD, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
            }
        case 'Show Song':
            switch(v1){
                case '' | '0':
                    if (sn == 'mario-sing-and-game-rythm-9'){
                        titleNES.visible = true;
                        titleNES.animation.play("show");
                    }else if (sn == 'the-end'){
                        linefount.visible = true;
                    }else if (sn == 'no-party'){
                        djStart.visible = true;
                        eventTweens.push(FlxTween.tween(djStart, {x: 510}, 1, {ease: FlxEase.backOut, onComplete: function(twn:FlxTween)
                            {
                                eventTweens.push(FlxTween.tween(djStart, {x: -300}, 1, {startDelay: 1.5, ease: FlxEase.backIn}));
                            }}));
                    }else{
                        var checkwidth:Float = autorText.width;
                        if (titleText.width >= autorText.width){
                            checkwidth = titleText.width;
                        }

                        line2 = new FlxSprite(566, titleText.y + 57).makeGraphic(Std.int(checkwidth), 5, FlxColor.BLACK);
                        line2.camera = camEst;
                        line2.screenCenter(0x11);
                        line2.alpha = 0;
                    
                        line1 = new FlxSprite(line2.x - 5, line2.y - 2).makeGraphic(Std.int(checkwidth + 10), 8, sgCol);
                        line1.camera = camEst;
                        line1.screenCenter(0x11);
                        line1.alpha = 0;
                        add(line1);
                        add(line2);

                        titleText.y = 304.5;
                        autorText.y = titleText.y + 70;
                        line2.y 	= titleText.y + 57;
                        line1.y 	= line2.y - 2;
                        autorText.screenCenter(0x01);
                        titleText.screenCenter(0x01);
                        FlxTween.tween(titleText, {alpha: 1, y: titleText.y + 30}, 0.5, {ease: FlxEase.cubeOut});
                        FlxTween.tween(autorText, {alpha: 1, y: autorText.y + 30}, 0.5, {ease: FlxEase.cubeOut});
                        FlxTween.tween(line1, {alpha: 1, y: 	 line1.y 	 + 30}, 0.5, {ease: FlxEase.cubeOut});
                        FlxTween.tween(line2, {alpha: 1, y: 	 line2.y 	 + 30}, 0.5, {ease: FlxEase.cubeOut});
                    }
                case '1':
                    if (sn == 'mario-sing-and-game-rythm-9'){
                        titleNES.animation.play("hide");
                    }else if (sn == 'the-end'){
                        linefount.visible = false;
                    }else if (sn == 'no-party'){
                    }else{
                        FlxTween.tween(titleText, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
                        FlxTween.tween(autorText, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
                        FlxTween.tween(line1, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
                        FlxTween.tween(line2, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
        
                        new FlxTimer().start(0.5, function(tmr:FlxTimer){
                                titleText.alpha = 0;
                                autorText.alpha = 0;
                                remove(line1);
                                remove(line2);
                        });
                    }
            }
    }
    return;
}
