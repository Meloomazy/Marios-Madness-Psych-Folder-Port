import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;
import psychlua.CustomSubstate;
import flixel.sound.FlxSound;
import tjson.TJSON;
import flixel.text.FlxText;
import backend.MusicBeatState;
import options.OptionsState;
import flixel.input.keyboard.FlxKey;
import Type;
import Map;
import backend.WeekData;
import backend.Highscore;
import backend.Song;
import states.LoadingState;

var minBackground:Int = 0;
var maxBackground:Int = 6;

var transitionSplit:Int = 7;
var transitionDuration:Float = 0.15;
var buttonOffset = [-90, 180];

var background;
var hudSprite:FlxSprite;
var overlay:FlxSprite;
var warnText;
var destyText;
var vignette;
var vignetteFP;
var maro;
var songText;
var selectSong;
var lArrow;
var rArrow;

var selectors = [];
var buttons = [];
var freeplayCate = [];
var stars = [];

var pauseMusic:FlxSound;

var ignoreZoomSprites= [];

var selectorSpacing:Float = 55;
var selectorAnim:Float = 0;
var selected:Int = -1;

var bloomShader = game.createRuntimeShader('bloom');
var ntscShader = game.createRuntimeShader('ntsc');

var updateCorner:Bool = true;
var canSelect:Bool = true;
var lerpZoom:Bool = true;
var allowFlash:Bool = false;
var elapsedTime:Float = 0;
var curState = 'mainmenu';

var buttonArray = ["MainGame", "WarpZone", "Freeplay", "Options", "Credits", "Patch"];
var freeplayBtnArray = ["Mainweek", "Island", "Woodland", "Cosmos", "Heights", "Classified", "Legacy", "Extra"];

// only the part that i port lmao
var heightsSongs = ['Golden Land', 'Paranoia', 'Overdue', 'Powerdown', 'Demise'];
var heightsIcon = ['Char28', 'Char41', 'Char35', 'Char27', 'Char23'];
var songIcons = [];

function createSongList() {
    for (i in 0...heightsIcon.length) {
        var sprite:FlxSprite = new FlxSprite().loadGraphic(Paths.image('freeplay/charicon/' + heightsIcon[i]));
        sprite.scale.set(1, 1);
        sprite.updateHitbox();
        sprite.screenCenter(0x11);
        sprite.color = FlxColor.RED;
        sprite.x += (550 * i);
        sprite.ID = i;
        CustomSubstate.instance.add(sprite);
        sprite.cameras = [game.camGame];
        songIcons.push(sprite);
    }
}

function onSongStart(){
    CustomSubstate.openCustomSubstate("MM-MainMenu", true);
    game.camHUD.visible = false;
    game.dadGroup.visible = game.gfGroup.visible = game.boyfriendGroup.visible = false;
}

var eventTimes:Array<Float> = [];
var eventTriggered:Array<Bool> = [];
function onCustomSubstateCreate(n) {
    if (n == "MM-MainMenu") {
        var path = Paths.getPath('data/main-menu/events.json', "TEXT", null, true);
        var eventData = TJSON.parse(File.getContent(path));

        for (event in eventData.song.events) {
            var time:Float = event[0];
            var roundedTime:Int = Math.floor(time);
            eventTimes.push(roundedTime);
        }
        for (eventTime in eventTimes) {
            eventTriggered.push(false);
        }

        background = new FlxBackdrop(0x01);
        background.color = FlxColor.RED;
        background.velocity.x = -40;
        background.scrollFactor.set();

        var backgroundImage:String = "bg" + FlxG.random.int(0, 6);
        if (FileSystem.exists(Paths.modsImages("mainmenu/bgs/" + backgroundImage)+ '.xml')) {
            background.frames = Paths.getSparrowAtlas("mainmenu/bgs/" + backgroundImage);
            background.animation.addByPrefix("bg", "bg", 5);
            background.animation.play("bg", true);
        }else background.loadGraphic(Paths.image("mainmenu/bgs/" + backgroundImage));

        background.scale.set(4, 4);
        background.updateHitbox();

        background.x = FlxG.random.float(0, background.width * 2);
        background.screenCenter(0x10);
        background.y -= 40;
        CustomSubstate.instance.add(background);
        background.cameras = [game.camGame];

        overlay = new FlxSprite();
        overlay.frames = Paths.getSparrowAtlas("modstuff/estatica_uwu");
        overlay.animation.addByPrefix("static", "Estatica papu", 15);
        overlay.animation.play("static");
        overlay.antialiasing = false;
        overlay.color = FlxColor.RED;
        overlay.alpha = 0.7;
        overlay.scrollFactor.set();
        overlay.updateHitbox();
        CustomSubstate.instance.add(overlay);
        overlay.cameras = [game.camGame];

        vignette = new FlxSprite(0, 0, Paths.image("modstuff/126"));
        vignette.scrollFactor.set();
        vignette.alpha = 0.9;
        vignette.updateHitbox();
        vignette.screenCenter();
        CustomSubstate.instance.add(vignette);
        vignette.cameras = [game.camGame];

        vignetteFP = new FlxSprite(0, 0, Paths.image("freeplay/HUD_Freeplay_2"));
        vignetteFP.scrollFactor.set();
        vignetteFP.alpha = 0;
        vignetteFP.updateHitbox();
        vignetteFP.screenCenter();
        CustomSubstate.instance.add(vignetteFP);
        vignetteFP.cameras = [game.camGame];

        ignoreZoomSprites = [overlay, vignette, vignetteFP];

        for (i in 0...buttonArray.length) {
            var button:FlxSprite = new FlxSprite();
            button.frames = Paths.getSparrowAtlas("mainmenu/MM_Menu_Assets");

            button.animation.addByPrefix("normal",   buttonArray[i] + "Normal",   24);
            button.animation.addByPrefix("selected", buttonArray[i] + "Selected", 24);
            button.animation.play("normal");
            button.updateHitbox();
            button.scrollFactor.set(FlxG.random.float(0.5,1.5),FlxG.random.float(0.5,1.5));

            button.screenCenter(0x11).y -= 10;
            button.x += (button.width + 10) * Math.floor((i % 3) - 1);
            button.y += buttonOffset[Math.floor(i / Math.round(buttonArray.length / 2))];

            // hardcoding yeah
            if (i > 2)
                button.x = ((FlxG.width - button.width) / 2) + ((button.width - 205) * ((i == 3) ? -1 : 1));
            if (i == 5){
                button.x -= 20;
                button.y -= 480;
            }
            button.ID = i;
            CustomSubstate.instance.add(button);
            buttons.push(button);
            button.cameras = [game.camGame];
        }

        for (i in 0...4) {
            var corner:FlxSprite = new FlxSprite(-100, -100);
            corner.frames = Paths.getSparrowAtlas("mainmenu/MM_Menu_Assets");
            corner.animation.addByPrefix("corner", "Corner" + (i + 1), 24);
            corner.animation.play("corner");
            corner.updateHitbox();
            corner.ID = i;
            CustomSubstate.instance.add(corner);
            selectors.push(corner);
            corner.cameras = [game.camGame];
        }

        for (i in 0...4){ // three stars
            var star:FlxSprite = new FlxSprite();
            star.frames = Paths.getSparrowAtlas("mainmenu/MM_Menu_Assets");
            star.animation.addByPrefix("normal", "Star",  24, true);    
            star.animation.play('normal');
            star.cameras = [game.camGame];    
            star.screenCenter(0x11).y -= 140;
            star.x -= 520;
            star.y += (75 * i);
            star.ID = i;
            star.alpha = 0;
            stars.push(star);
            CustomSubstate.instance.add(star);
        }

        maro = new FlxSprite();
        maro.frames = Paths.getSparrowAtlas("mainmenu/maro");
        maro.animation.addByPrefix("d", "maro", 20, true);
        maro.animation.play("d");
        maro.color = FlxColor.RED;
        maro.alpha = 1;
        maro.screenCenter(0x11).y -= 320;
        CustomSubstate.instance.add(maro);
        maro.cameras = [game.camGame];

        warnText = new FlxText(0, 0, 1280, "", 32);
		warnText.setFormat(Paths.font("mariones.ttf"), 32, FlxColor.RED, "center");
		warnText.scrollFactor.set();
        warnText.screenCenter(0x11).y += 300;
        CustomSubstate.instance.add(warnText);

        for (star in stars) {
            FlxTween.tween(star, {alpha: 1}, 0.3, {ease: FlxEase.circInOut, startDelay: 0.1 * star.ID, onComplete: ()-> {
                FlxTween.tween(star, {x: star.x - 80}, 0.4, {ease: FlxEase.circInOut, startDelay: 0.05 * star.ID});
            }});
        }

        destyText = new FlxSprite();
        destyText.frames = Paths.getSparrowAtlas("freeplay/Freeplay_Assets");
        destyText.animation.addByPrefix("m", "Title", 15, true);
        destyText.animation.play("m");
        destyText.color = FlxColor.RED;
        destyText.color = FlxColor.RED;
        destyText.scrollFactor.set(FlxG.random.float(0.5,1.5),FlxG.random.float(0.5,1.5));
        destyText.updateHitbox();
        destyText.screenCenter(0x11).y -= 260;
        destyText.scale.set(0,0);
        destyText.cameras = [game.camGame];
        CustomSubstate.instance.add(destyText);

        for (i in 0...freeplayBtnArray.length) {
            var button:FlxSprite = new FlxSprite();
            button.frames = Paths.getSparrowAtlas("freeplay/Freeplay_Assets");
            button.animation.addByPrefix("d",  freeplayBtnArray[i], 24, true);
            button.animation.play("d");
            button.screenCenter(0x11).y -= 80;
            button.ID = i;
            button.scale.set(0,0);
            freeplayCate.push(button);
            CustomSubstate.instance.add(button);
            button.cameras = [game.camGame];
            button.color = 0x423633;
            // cries
            switch(i){
                case 0:
                    button.x -= 450;
                case 1:
                    button.x -= 245;
                case 2:
                    button.x -= 60;
                case 3:
                    button.x += 135;
                case 4:
                    button.x += 330;
                case 5:
                    button.x += 525;
                case 6:
                    button.x -= 235;
                    button.y += 342;
                case 7:
                   button.x += 234;
                   button.y += 342;
            }
            button.x -= 80;
        }

        var selectorTween = null;
        selectorTween = FlxTween.num(0, 7.5, 1.5, {
            ease: FlxEase.circInOut,
            type: 4,
            onUpdate: (_) -> selectorAnim = selectorTween.value
        });
        
        bloomShader.setFloat("Directions", 16.0);
        bloomShader.setFloat("Quality", 8.0);
        bloomShader.setFloat("Size", 1.0);
        bloomShader.setFloat("dim", 2.0);

        ntscShader.setFloat("glitchAmount", 0.4);
        ntscShader.setFloatArray("resolution", [FlxG.width, FlxG.height]);

        FlxG.camera.setFilters([new ShaderFilter(bloomShader), new ShaderFilter(ntscShader)]);

        FlxG.camera.zoom += 0.3;
        FlxTween.tween(FlxG.camera, {zoom: 1}, 1.3, {ease: FlxEase.circInOut, onComplete: (_) -> lerpZoom = true});

        FlxG.mouse.useSystemCursor = true;
        FlxG.mouse.visible = true;
        allowFlash = true;

        pauseMusic = new FlxSound().loadEmbedded(Paths.music('freakyMenu'), true, true);
        pauseMusic.play(false, 28 * 1000);
        FlxG.sound.list.add(pauseMusic);

        createSongList();

        selectSong = new FlxSprite(0, 0, Paths.image("freeplay/HUD_Freeplay_1"));
        selectSong.color = FlxColor.RED;
        selectSong.scale.set(0.9,0.9);
        selectSong.updateHitbox();
        selectSong.screenCenter(0x11).y -= 260;
        selectSong.visible = false;
        CustomSubstate.instance.add(selectSong);
        selectSong.cameras = [game.camGame];
        FlxTween.tween(selectSong, {y: selectSong + 10}, 2.5, {ease: FlxEase.sineInOut, type: 4});

        lArrow = new FlxSprite(0, 0, Paths.image("freeplay/arrow"));
        lArrow.color = FlxColor.RED;
        lArrow.screenCenter(0x11).x -= 560;
        lArrow.scale.set(0.5, 0.5);
        lArrow.flipX = true;
        lArrow.visible = false;
        CustomSubstate.instance.add(lArrow);
        lArrow.cameras = [game.camGame];

        rArrow = new FlxSprite(0, 0, Paths.image("freeplay/arrow"));
        rArrow.color = FlxColor.RED;
        rArrow.screenCenter(0x11).x += 560;
        rArrow.scale.set(0.5, 0.5);
        rArrow.visible = false;
        CustomSubstate.instance.add(rArrow);
        rArrow.cameras = [game.camGame];

        songText = new FlxText(0, 0, 1280, "Golden Land");
		songText.setFormat(Paths.font("Mario64.ttf"), 30, FlxColor.RED, "center", Type.resolveEnum('flixel.text.FlxTextBorderStyle').OUTLINE, 0xFF000000);
        songText.borderSize = 3;
        songText.scrollFactor.set();
        songText.screenCenter(0x11).y += 280;
        songText.visible = false;
        CustomSubstate.instance.add(songText);
        
        for (image in songIcons) {
            image.visible = false;
        }
    }
}
var curPage = 0;
function changePage(change:Int = 0):Void {
    curPage = FlxMath.wrap(curPage + change, 0, songIcons.length - 1);
    songText.text = heightsSongs[curPage];
    for (item in songIcons){
        item.ID = songIcons.indexOf(item) - curPage;
    }
}

var curButton = null;
var zoomL = false;
var timeR;

var lDistance = 300;
var rDistance = 1000;
var arrowTween = null;
function onCustomSubstateUpdatePost(tag, elapsed) {
    if (FlxG.keys.justPressed.G){
        CustomSubstate.closeCustomSubstate();
        FlxG.mouse.visible = false;
        if (pauseMusic != null)
            pauseMusic.destroy();
    }
    if (tag == "MM-MainMenu") {
        elapsedTime += elapsed;
        var lerp:Float = Math.exp(-elapsed * 24);

        ntscShader.setFloat("time", elapsedTime);

        FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX - (FlxG.width / 2))      * 0.015, (1 / 30) * 240 * elapsed);
        FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY - 6 - (FlxG.height / 2)) * 0.015, (1 / 30) * 240 * elapsed);

        if (lerpZoom) {
            FlxG.camera.zoom = FlxMath.lerp(
                FlxG.camera.zoom,
                (.98 - (Math.abs(((FlxG.mouse.screenX*0.4) + (FlxMath.remapToRange(FlxG.mouse.screenY, 0, FlxG.height, 0, FlxG.width)*0.6)) -(FlxG.width/2)) * 0.00002)), 
                (1/30) * 240 * elapsed
            );
        }
        for (i in 0...eventTimes.length) {
            var eventTime:Float = eventTimes[i];
            if (!eventTriggered[i] && pauseMusic.time > eventTime) {
                if (lerpZoom) FlxG.camera.zoom += 0.015;
                eventTriggered[i] = true;
            }
        }
        var fakeZoom:Float = (1 / FlxG.camera.zoom);
        for (spr in ignoreZoomSprites)
            spr.scale.set(fakeZoom, fakeZoom);

        maro.alpha = buttons[0].alpha;

        if (curState == 'mainmenu'){
            for (button in buttons) {
                if (canSelect) {
                    var overlaps:Bool = FlxG.mouse.overlaps(button);
                    var notSelected:Bool = (button.ID != selected);
            
                    if (overlaps && notSelected) {
                        FlxG.sound.play(Paths.sound("scrollMenu"), 0.7);
                        button.animation.play("selected", true);
                        selected = button.ID;
                        curButton = button;
                    }
                    else if (!overlaps && notSelected && button.animation.name != "normal")
                        button.animation.play("normal", true);
        
                    if (overlaps && FlxG.mouse.justReleased)
                        accept();
                }
                var groupLevel:Int = 1;

                button.offset.y = 8 * (Math.floor(8 * FlxMath.fastSin((elapsedTime / 2) + ((.5 * button.ID) + (2 * groupLevel)))) / 8);
                button.offset.x = 4 * (Math.floor(8 * FlxMath.fastSin((elapsedTime / 8) + ((2 / 8) * groupLevel))) / 8);
            }

            var l = 0;
            for (star in stars){
                l += 1;
                star.offset.y = 5 * (Math.floor(8 * FlxMath.fastSin((elapsedTime / 2) + ((.5 * l) + (2 * 1)))) / 8);
            }

            if (updateCorner && selected > -1) {
                for (corner in selectors) {
                    var button = curButton;
                    switch (corner.ID) {
                        case 0:
                            corner.x = (button.x - button.offset.x) - corner.width + selectorSpacing - selectorAnim;
                            corner.y = (button.y - button.offset.y) - corner.height + selectorSpacing - selectorAnim;
                        case 1:
                            corner.x = (button.x - button.offset.x) + button.width - selectorSpacing + selectorAnim;
                            corner.y = (button.y - button.offset.y) - corner.height + selectorSpacing - selectorAnim;
                        case 2:
                            corner.x = (button.x - button.offset.x) - corner.width + selectorSpacing - selectorAnim;
                            corner.y = (button.y - button.offset.y) + button.height - selectorSpacing + selectorAnim;
                        case 3:
                            corner.x = (button.x - button.offset.x) + button.width - selectorSpacing + selectorAnim;
                            corner.y = (button.y - button.offset.y) + button.height - selectorSpacing + selectorAnim;
                    }
                }
            }
        }
        if (curState == 'freeplayCategory'){
            if (FlxG.keys.justPressed.ESCAPE){
                updateCorner = canSelect = true;
                FlxG.camera.zoom += 0.3;
                FlxG.sound.play(Paths.sound('cancelMenu'), 1);
                var i = 0;
                for (button in buttons){
                    button.screenCenter(0x11).y -= 10;
                    button.x += (button.width + 10) * Math.floor((i % 3) - 1);
                    button.y += buttonOffset[Math.floor(i / Math.round(buttonArray.length / 2))];
                    if (i > 2)
                        button.x = ((FlxG.width - button.width) / 2) + ((button.width - 205) * ((i == 3) ? -1 : 1));
                    if (i == 5){
                        button.x -= 20;
                        button.y -= 480;
                    }
                    i += 1;
                    button.visible = true;
                    FlxTween.tween(button, {alpha: 1}, 0.3, {ease: FlxEase.circInOut});
                }
                for (star in stars) {
                    FlxTween.tween(star, {alpha: 1}, 0.3, {ease: FlxEase.circInOut, startDelay: 0.1 * star.ID, onComplete: ()-> {
                        FlxTween.tween(star, {x: star.x - 80}, 0.4, {ease: FlxEase.circInOut, startDelay: 0.05 * star.ID});
                    }});
                }
                for (corner in selectors) {
                    FlxTween.tween(corner, {alpha: 1}, 0.6, {ease: FlxEase.circInOut, startDelay: 0.1 * corner.ID});
                }
                FlxTween.tween(background, {alpha: 1}, 0.2, {ease: FlxEase.cubeOut});
                FlxTween.tween(FlxG.camera, {zoom: 1}, 0.6, {ease: FlxEase.cubeOut, onComplete: (_) -> lerpZoom = true});
                for (cate in freeplayCate){
                    cate.scale.set(0,0);
                    cate.x -= 40;
                }
                destyText.scale.set(0,0);
                destyText.y += 40;
                curState = 'mainmenu';
            }
            if (canSelect) {
                for (categ in freeplayCate){
                    var overlaps:Bool = FlxG.mouse.overlaps(categ);
                    var notSelected:Bool = (categ.ID != selected);

                    categ.offset.x = FlxG.random.int(-1, 1);
                    categ.offset.y = FlxG.random.int(-1, 1);
    
                    if (overlaps && notSelected) {
                        selected = categ.ID;
                        categ.color = 0xFFFFFF;
                        //curButton = cate;
                    }
                    else if (!overlaps && notSelected){
                        categ.animation.play("normal", true);
                        categ.color = 0x423633;
                    }

                    if (overlaps && FlxG.mouse.justPressed){
                        switch (freeplayBtnArray[selected].toLowerCase()) {
                            case "heights":    
                                FlxG.sound.play(Paths.sound("scrollMenu"), 0.7);
                                for (cag in freeplayCate)
                                    cag.visible = false;
                                curState = 'freeplaySong';
                                songText.visible = true;
                                destyText.visible = false;
                                rArrow.visible = lArrow.visible = selectSong.visible = true;
                                for (image in songIcons) {
                                    image.visible = true;
                                    var lolT;
                                    lolT = FlxTween.num(-90, 0, .2, {
                                        ease: FlxEase.cubeOut,
                                        onUpdate: (_) -> {
                                            image.offset.y = lolT.value;
                                        }
                                    });
                                }
                            default:
                                warnText.text = 'no lmao';
                                warnText.alpha = 1;
                                if (timeR != null) timeR.cancel();
                                timeR = new FlxTimer().start(1.0, ()->{timeR = null; FlxTween.tween(warnText, {alpha: 0}, 0.5); });
                                FlxG.sound.play(Paths.sound('cancelMenu'), 1);                
                        }
                    }
                }
            }
        }
        
        if (curState == 'freeplaySong'){
            if (FlxG.keys.justPressed.ESCAPE){
                for (cate in freeplayCate){
                    cate.visible = true;
                }
                for (image in songIcons) image.visible = false;
                rArrow.visible = lArrow.visible = songText.visible = selectSong.visible = false;
                curState = 'freeplayCategory';
                destyText.visible = true;
            }
            for (image in songIcons) {
                if (FlxG.mouse.justPressed && image.ID == 0 && FlxG.mouse.overlaps(image)){
                    canSelect = false;
                    lerpZoom = false;
                    pauseMusic.destroy();
                    FlxG.sound.play(Paths.sound('FREEPLAY_START'), 1);
                    if (allowFlash) {
                        var twn1 = null;
                        var twn2 = null;
                
                        bloomShader.setFloat("Size", 45.0);
                        bloomShader.setFloat("dim", 0.3);
                    
                        twn1 = FlxTween.num(4.0, 0.0, .5, {
                            onUpdate: (_) -> {
                                bloomShader.setFloat("Size", twn1.value);
                            }
                        });
                    
                        twn2 = FlxTween.num(0.1, 2.0, .5, {
                            onUpdate: (_) -> {
                                bloomShader.setFloat("dim", twn2.value);
                            }
                        });
                    }
                    var trans;
                    FlxTween.tween(FlxG.camera, {zoom: 1.2}, 4, {ease: FlxEase.sineInOut});
                    trans = FlxTween.num(1, 0, 1.5, {
                        startDelay: 1,
                        ease: FlxEase.cubeOut,
                        onUpdate: (_) -> {
                            for (icon in songIcons) if (icon.ID != 0) icon.alpha = trans.value;
                            songText.alpha = selectSong.alpha = rArrow.alpha = lArrow.alpha = trans.value;
                        },
                        onComplete: () ->{
                            FlxTween.tween(FlxG.camera, {alpha: 0}, 1, {ease: FlxEase.cubeOut, onComplete: () ->{                    
                                loadSong(heightsSongs[curPage].toLowerCase(), '');
                            }});
                        }
                    });
                    
                }
                if (lerpZoom){
                    image.x = FlxMath.lerp(((FlxG.width - image.width) * 0.5) + (450 * image.ID), image.x, lerp);
                    image.y = FlxMath.lerp(((FlxG.height - image.height) / 2) + (image.ID == 0 ? 0 : 70), image.y, lerp);
                    image.alpha = FlxMath.lerp((image.ID == 0) ? 1 : 0.4, image.alpha, lerp);
                }
            }
            
            lArrow.offset.x = FlxMath.lerp((FlxG.mouse.screenX < lDistance ? -40 : 0), lArrow.offset.x, Math.exp(-elapsed * 17));
            rArrow.offset.x = FlxMath.lerp((FlxG.mouse.screenX > rDistance ? 40 : 0), rArrow.offset.x, Math.exp(-elapsed * 17));
        
            if (FlxG.mouse.screenX < lDistance){
                if (FlxG.mouse.justPressed){
                    changePage(-1);
                    arrowTween = FlxTween.num(0.7, 0.5, 0.3, {
                        ease: FlxEase.cubeOut,
                        onUpdate: (_) -> lArrow.scale.x = lArrow.scale.y = arrowTween.value
                    });
                }
            }

            if (FlxG.mouse.screenX > rDistance){
                if (FlxG.mouse.justPressed){
                    changePage(1);
                    arrowTween = FlxTween.num(0.7, 0.5, 0.3, {
                        ease: FlxEase.circOut,
                        onUpdate: (_) -> rArrow.scale.x = rArrow.scale.y = arrowTween.value
                    });
                }
            }
        }
    }
}
function accept(){
    switch (buttonArray[selected].toLowerCase()) {
        case "maingame":
            warnText.text = 'not here, go play the mod.';
            warnText.alpha = 1;
            if (timeR != null) timeR.cancel();
            timeR = new FlxTimer().start(1.0, ()->{timeR = null; FlxTween.tween(warnText, {alpha: 0}, 0.5); });
            FlxG.sound.play(Paths.sound('cancelMenu'), 1);
        case "warpzone":
            warnText.text = 'not here, go play the mod.';
            warnText.alpha = 1;
            if (timeR != null) timeR.cancel();
            timeR = new FlxTimer().start(1.0, ()->{timeR = null; FlxTween.tween(warnText, {alpha: 0}, 0.5); });
            FlxG.sound.play(Paths.sound('cancelMenu'), 1);
        case "credits":
            warnText.text = "i can't :c_:";
            warnText.alpha = 1;
            if (timeR != null) timeR.cancel();
            timeR = new FlxTimer().start(1.0, ()->{timeR = null; FlxTween.tween(warnText, {alpha: 0}, 0.5); });
            FlxG.sound.play(Paths.sound('cancelMenu'), 1);
        case "patch":
            warnText.text = "mario";
            warnText.alpha = 1;
            if (timeR != null) timeR.cancel();
            timeR = new FlxTimer().start(1.0, ()->{timeR = null; FlxTween.tween(warnText, {alpha: 0}, 0.5); });
            FlxG.sound.play(Paths.sound('cancelMenu'), 1);
        default:
            FlxG.sound.play(Paths.sound('confirmMenu'), 1);
            updateCorner = canSelect = false;
            if (allowFlash) {
                var twn1 = null;
                var twn2 = null;
        
                bloomShader.setFloat("Size", 45.0);
                bloomShader.setFloat("dim", 0.3);
            
                twn1 = FlxTween.num(4.0, 0.0, .5, {
                    onUpdate: (_) -> {
                        bloomShader.setFloat("Size", twn1.value);
                    }
                });
            
                twn2 = FlxTween.num(0.1, 2.0, .5, {
                    onUpdate: (_) -> {
                        bloomShader.setFloat("dim", twn2.value);
                    }
                });
            }

            for (corner in selectors) {
                FlxTween.tween(corner, {alpha: 0}, 0.6, {ease: FlxEase.circInOut, startDelay: 0.1 * corner.ID});
            }
            for (star in stars) {
                FlxTween.tween(star, {x: star.x + 80}, 0.4, {ease: FlxEase.circInOut, startDelay: 0.1 * star.ID, onComplete: ()-> {
                    FlxTween.tween(star, {alpha: 0}, 0.4, {ease: FlxEase.circInOut, startDelay: 0.05 * star.ID});
                }});
            }

            lerpZoom = false;
            FlxTween.tween(FlxG.camera, {zoom: 1.25}, 1.3, {ease: FlxEase.cubeOut});
            FlxTween.tween(background, {alpha: 0}, 0.2, {ease: FlxEase.cubeOut});
            for (button in buttons){
                var centerX:Float = (FlxG.width - button.width) * 0.5;
                var centerY:Float = (FlxG.height - button.height) * 0.5;
                if (allowFlash) {
                    FlxFlicker.flicker(button, 1, 0.06, false, false, (_) -> {
                        new FlxTimer().start(.2, (_) -> {
                            switch (buttonArray[selected].toLowerCase()) {
                                case "freeplay":
                                    FlxTween.tween(FlxG.camera, {zoom: 1}, 1.3, {ease: FlxEase.cubeOut, onComplete: (_) -> lerpZoom = true});
                                    canSelect = true;
                                    curState = 'freeplayCategory';
                                    warnText.text = "";
                                    FlxTween.tween(destyText.scale, {x: 1, y: 1}, 0.4, {ease: FlxEase.cubeOut});
                                    FlxTween.tween(destyText, {y: destyText.y - 40}, 0.4, {ease: FlxEase.cubeOut});
                                    for (cate in freeplayCate){
                                        FlxTween.tween(cate, {x: cate.x + 40}, 0.2, {ease: FlxEase.cubeOut, startDelay: 0.05 * cate.ID});
                                        FlxTween.tween(cate.scale, {x: 1, y: 1}, 0.2, {ease: FlxEase.cubeOut, startDelay: 0.05 * cate.ID, onComplete: ()-> cate.updateHitbox() });
                                    }
                                case "options":
                                    MusicBeatState.switchState(new OptionsState());
                                    OptionsState.onPlayState = true;            
                                    warnText.text = "";
                                    FlxG.mouse.visible = false;
                                default:
                                    debugPrint('f');
                            }
                        });
                    });
                }
                else
                    FlxTween.tween(button, {alpha: 0}, .4);

                if (button.ID != selected)
                    FlxTween.tween(button, {alpha: 0}, 0.3, {ease: FlxEase.circInOut});
                else
                    FlxTween.tween(button, {x: centerX, y: centerY}, 0.6, {ease: FlxEase.circOut});
            }
    }
}

function loadSong(?name:String = null, ?difficulty:String = 'hard'){
    if(name == null || name.length < 1)
        name = PlayState.SONG.song;
    game.persistentUpdate = false;
    PlayState.SONG = Song.loadFromJson(Paths.formatToSongPath(name + difficulty), name);
    LoadingState.loadAndSwitchState(new PlayState());
}