import Type;
import flixel.text.FlxText;
import flixel.text.FlxTextFormat;
import tjson.TJSON;

var col = [];
var disabled = true; // Disabled because we use MM note skin instead :>
var sn = Paths.formatToSongPath(game.songName.toLowerCase());
var stG = PlayState.curStage;

var autor = 'i forgor';
var titleText;
var autorText;
var line2;
var line1;

var sgCol; 

var doIdleReturn = false;
switch(sn){
    case 'paranoia':
        PlayState.daPixelZoom = 3.5;
}
function onCreate(){
    sgCol = (sn == 'golden-land' ? 0xFFADADAD : 0xFFF42626);
    
    var ratingD = ['sick', 'good', 'bad', 'shit'];
    for (i in 0...4){
        ratingsData[i].image = 'rating/' + (sn == 'golden-land' ? 'gb' : '')  + ratingD[i];
    }
    switch(sn){
        case 'paranoia':
            col = [0xFFFF0000, 0xFFFFFFFF, 0xFF000000];
        case 'i-hate-you':
            col = [0xFF5AA400,0xFF005CBF, 0xFFFFFFFF];
        case 'overdue':
            col = [0xFF83a27d,0xFF151028, 0xFFafaf8c];
        case 'overdue-joke':
            col = [0xFF83a27d,0xFF151028, 0xFFafaf8c];
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
            autor = 'Sandi ft. iKenny';
        case 'overdue':
            autor = 'FriedFrick ft. Sandi';
    }

    titleText = new FlxText(400, 304.5, 0, PlayState.SONG.song, 42);
	titleText.setFormat(Paths.font("mariones.ttf"), 42, FlxColor.BLACK, 'center', Type.resolveEnum('flixel.text.FlxTextBorderStyle').OUTLINE, sgCol);
    titleText.camera = camHUD;
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
    autorText.camera = camHUD;
    autorText.alpha = 0;
    setVar('autorText', autorText);
    add(autorText);
    autorText.addFormat(format);


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
    comboGroup.x = gfGroup.x;
    comboGroup.y = gfGroup.y;

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
    if (doIdleReturn){
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
        case 'Change Character':
            switch(dad.curCharacter){
                case 'gbv2evil':
                    doIdleReturn = true;
            }
        case 'Ocultar HUD':
            var bruhHUD:Float = Std.parseFloat(v1);
            if (Math.isNaN(bruhHUD))
                bruhHUD = 0;
            switch (bruhHUD) {
                case 0:
                    FlxTween.tween(camHUD, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
                case 1:
                    FlxTween.tween(camHUD, {alpha: 1}, 0.001, {ease: FlxEase.quadInOut});
                case 2:
                    FlxTween.tween(camHUD, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
            }
    }
    if (n == 'Show Song'){
        switch(v1){
            case '' | '0':
                var checkwidth:Float = autorText.width;
                if (titleText.width >= autorText.width){
                    checkwidth = titleText.width;
                }
            
                line2 = new FlxSprite(566, titleText.y + 57).makeGraphic(Std.int(checkwidth), 5, FlxColor.BLACK);
                line2.cameras = [camHUD];
                line2.screenCenter(0x11);
                line2.alpha = 0;
            
                line1 = new FlxSprite(line2.x - 5, line2.y - 2).makeGraphic(Std.int(checkwidth + 10), 8, sgCol);
                line1.cameras = [camHUD];
                line1.screenCenter(0x11);
                line1.alpha = 0;
                add(line1);
                add(line2);

                titleText.visible = true;
                autorText.visible = true;
                line1.visible = true;
                line2.visible = true;
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
            case '1':
                FlxTween.tween(titleText, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
                FlxTween.tween(autorText, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
                FlxTween.tween(line1, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
                FlxTween.tween(line2, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});

                new FlxTimer().start(0.5, function(tmr:FlxTimer)
                    {
                        titleText.visible = false;
                        autorText.visible = false;
                        line1.visible = false;
                        line2.visible = false;
                        remove(line1);
                        remove(line2);
                    });
        }
    }

    return;
}
