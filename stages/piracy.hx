import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import objects.BGSprite;
import Type;
import flixel.util.FlxSpriteUtil;
import sys.thread.Thread;

using StringTools;

var scrollcoords;
var bgH0;
var djDone;
var bfspot;

var lifebar;
var lifebarLeft;
var lifebarRight;

var backing;
var thetext;
var thetextC;
var drawspot;
var canvas;
var writeText;

var blackBarThingie;
var bfspotblackLeft;
var bfspotblackRight;

var eventTweens = [];
var eventTimers = [];
var extraTween = [];

var dsTimer = 0;
var lastPosition = [9999, 9999];

var scoreDS;


var forceWindow = getModSetting('forceWindow');

function onCreate(){
    var scrollcoords:Float = 91;
    if(!ClientPrefs.data.downScroll){
        boyfriendGroup.y = 340;
        dadGroup.y = 315;
        scrollcoords = 452;
    }else{
        dadGroup.y -= 150;    
        boyfriendGroup.y += 70;    
    }
    boyfriendGroup.x += 650;
    dadGroup.x += 50;

    bgH0 = new FlxBackdrop(Paths.image('stages/piracy/HallyBG2'),0x01,-192);
    bgH0.setPosition(715, -2.5 + scrollcoords);
    bgH0.scale.set(1.3, 1.3);
    bgH0.scrollFactor.set(1, 1);
    bgH0.updateHitbox();
    bgH0.antialiasing = false;
    addBehindDad(bgH0);

    var bgH1 = new FlxBackdrop(Paths.image('stages/piracy/HallyBG4'), 0x10);
    bgH1.x = 955;
    bgH1.scale.set(1.3, 1.3);
    bgH1.updateHitbox();
    bgH1.scrollFactor.set(1, 1);
    bgH1.velocity.set(0, 40);
    bgH1.antialiasing = false;
    addBehindBF(bgH1);

    var bgH2 = new FlxBackdrop(Paths.image('stages/piracy/HallyBG4'), 0x10);
    bgH2.x = (bgH1.x + bgH1.width);
    bgH2.scale.set(1.3, 1.3);
    bgH2.updateHitbox();
    bgH2.scrollFactor.set(1, 1);
    bgH2.velocity.set(0, 40);
    bgH2.antialiasing = false;
    addBehindBF(bgH2);

    var bgH3:BGSprite = new BGSprite('stages/piracy/HallyBG3', 955, -2.5 + scrollcoords, 1, 1);
    bgH3.scale.set(2.2, 1.5);
    bgH3.updateHitbox();
    bgH3.antialiasing = false;
    bgH3.alpha = 0.8;
    addBehindBF(bgH3);

    var bgH4:BGSprite = new BGSprite('stages/piracy/HallyBG1', 715, -2.5 + scrollcoords, 1, 1);
    bgH4.scale.set(1.3, 1.3);
    bgH4.updateHitbox();
    bgH4.antialiasing = false;
    add(bgH4);

    var bgbottom:FlxBackdrop = new FlxBackdrop(Paths.image('stages/piracy/bgbottom'), 0x01);
    bgbottom.scrollFactor.set(1, 1);
    bgbottom.velocity.set(40, 0);
    bgbottom.setGraphicSize(Std.int(bgbottom.width * 2.5));
    bgbottom.updateHitbox();
    bgbottom.x = 600;
    bgbottom.y = ClientPrefs.data.downScroll ? 360 : -120;
    bgbottom.antialiasing = false;
    bgbottom.cameras = [getVar('camEst')];
    addBehindGF(bgbottom);

    backing = new BGSprite('stages/piracy/paper', 7, ClientPrefs.data.downScroll ? 1200 : -690, 1, 1);
    //backing = new FlxSprite(30, 400).makeGraphic(416, 250, 0xFFFFFFFF, true);
    backing.setGraphicSize(Std.int(backing.width * 1.9));
    backing.updateHitbox();
    backing.antialiasing = false;
    backing.cameras = [getVar('camEst')];
    addBehindGF(backing);

    thetext = new FlxText(backing.x + 30, backing.y + 69, 416, "sorry", 95);
    thetext.setFormat(Paths.font("arial-rounded-mt-bold.ttf"), 95, 0xBA888888, 'center');
    thetext.cameras = [getVar('camEst')];
    addBehindGF(thetext);
    thetext.y = backing.y + 125 - thetext.pixels.rect.height / 2;

    thetextC = new FlxText(backing.x + 30, backing.y + 69, 416, "criminal", 95);
    thetextC.setFormat(Paths.font("arial-rounded-mt-bold.ttf"), 95, 0xFFE58F8F, 'center');
    thetextC.visible = false;
    thetextC.cameras = [getVar('camEst')];
    addBehindGF(thetextC);

    canvas = new FlxSprite(backing.x, backing.y).makeGraphic(Std.int(backing.width), Std.int(backing.height), 0x00000000, true);
    canvas.cameras = [getVar('camEst')];
    canvas.updateHitbox();
    canvas.visible = false;
    addBehindGF(canvas);

    writeText = new FlxText(30, 500, 416, "00", 16);
    writeText.cameras = [getVar('camEst')];
    writeText.color = FlxColor.BLACK;
    writeText.setFormat(Paths.font("BIOSNormal.ttf"), 28, FlxColor.BLACK, 'center', Type.resolveEnum('flixel.text.FlxTextBorderStyle').OUTLINE);
    writeText.visible = false;
    writeText.y = backing.y - 680;
    addBehindGF(writeText);

    djDone = new BGSprite('stages/piracy/Finish', 160 + 400, ClientPrefs.data.downScroll? 150 : 510, 0, 0);
    djDone.setGraphicSize(Std.int(djDone.width * 2));
    djDone.updateHitbox();
    djDone.antialiasing = false;
    //djDone.alpha = 0;

    bfspot = new BGSprite('stages/piracy/bfspotlight', 715, -2.5 + scrollcoords, 1, 1);
    //bgspot.setGraphicSize(Std.int(bgspot.width * 2));
    bfspot.updateHitbox();
    bfspot.antialiasing = true;
    bfspot.alpha = 0;
    add(bfspot);

    bfspotblackLeft = new FlxSprite().makeGraphic(640, FlxG.height + 500, FlxColor.BLACK);
    bfspotblackLeft.alpha = 0;
    bfspotblackLeft.x = (bfspot.x - bfspot.width)-90;
    add(bfspotblackLeft);

    bfspotblackRight = new FlxSprite().makeGraphic(1540, FlxG.height + 500, FlxColor.BLACK);
    bfspotblackRight.alpha = 0;
    bfspotblackRight.x = (bfspot.x + bfspot.width);
    add(bfspotblackRight);

    drawspot = new BGSprite('stages/piracy/spotlight', 0, -100, 0, 0);
    //drawspot.setGraphicSize(Std.int(drawspot.width * 1.2));
    drawspot.screenCenter();
    drawspot.updateHitbox();
    drawspot.antialiasing = true;
    drawspot.cameras = [camOther];
    drawspot.alpha = 0;
    drawspot.x = (forceWindow ? -450 : -50);
    addBehindGF(drawspot);

    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.scrollFactor.set(1, 1);
    blackBarThingie.alpha = 0;
    add(blackBarThingie);

// ui

    lifebar = new BGSprite('stages/piracy/bar', 7, (ClientPrefs.data.downScroll ? 390 : 312), 0, 0);
    lifebar.setGraphicSize(Std.int(lifebar.width * 1.9));
    lifebar.updateHitbox();
    lifebar.antialiasing = false;
    lifebar.cameras = [camHUD];
    add(lifebar);

    lifebarRight = new BGSprite('modstuff/bar2', 7, (ClientPrefs.data.downScroll ? 390 : 312), 0, 0);
    lifebarRight.setGraphicSize(Std.int(lifebarRight.width * 1.9));
    lifebarRight.updateHitbox();
    lifebarRight.antialiasing = false;
    lifebarRight.cameras = [camHUD];
    add(lifebarRight);

    lifebarLeft = new BGSprite('modstuff/bar1', 7, (ClientPrefs.data.downScroll ? 390 : 312), 0, 0);
    lifebarLeft.setGraphicSize(Std.int(lifebarLeft.width * 1.9));
    lifebarLeft.updateHitbox();
    lifebarLeft.antialiasing = false;
    lifebarLeft.cameras = [camHUD];
    add(lifebarLeft);

    scoreDS = new FlxText(100, lifebar.y + (ClientPrefs.data.downScroll ? -25 : 25), FlxG.width, "", 20);
    scoreDS.setFormat(Paths.font("BIOSNormal.ttf"), 26, FlxColor.BLACK, 'center');
    scoreDS.scrollFactor.set();
    scoreDS.borderSize = 1.25;
    scoreDS.screenCenter(0x01);
    scoreDS.cameras = [camHUD];
    add(scoreDS);

    var lol = 400;
    writeText.x += lol;
    canvas.x += lol;
    thetextC.x += lol;
    thetext.x += lol;
    backing.x += lol;
    lifebar.x += lol;
    lifebarRight.x += lol;
    lifebarLeft.x += lol;

    return;
}
var ogScrollX;
var ogScrollY;

function onCreatePost(){
    FlxG.mouse.visible = true;

    FlxG.camera.target = null;
    game.camZoomingMult = 0;
    ogScrollX = game.camGame.scroll.x;
    ogScrollY = game.camGame.scroll.y;

    healthBar.visible = scoreTxt.visible = timeTxt.visible = timeBar.visible = iconP1.visible = iconP2.visible = false;
    for (strum in game.strumLineNotes) {
        strum.y = ClientPrefs.data.downScroll ? 768 - 355 : 190;
    }
    return;
}

function onUpdatePost(elapsed){
    scoreDS.text = scoreTxt.text;
    lifebarLeft._frame.frame.width = (1 - game.health / 2) * 246;    

    if(dsTimer <= 0){
        if(canvas.visible) writeGone();
    }else{
        writeText.text = '' + Math.round(dsTimer * 10) / 10;
        dsTimer -= elapsed;
    }

    if(canvas.visible == true){
		if (FlxG.mouse.pressed)
			{
				FlxSpriteUtil.drawCircle(canvas, FlxG.mouse.screenX - canvas.x, FlxG.mouse.screenY - canvas.y, 5, 0xFF0000FF);
				if (lastPosition.x != 9999 && lastPosition.y != 9999 && FlxG.mouse.justMoved)
				{
					var tanSlope:Float = (-(FlxG.mouse.screenY - lastPosition.y)) / (FlxG.mouse.screenX - lastPosition.x);
					var secSlope:Float = -(1 / tanSlope);
					var angle:Float = Math.atan(secSlope);
					var circlePos = [5 * Math.cos(angle), 5 * Math.sin(angle)];
					var vertices = new Array<FlxBasePoint>();
					vertices[0] = [FlxG.mouse.screenX - canvas.x + circlePos.x, FlxG.mouse.screenY - canvas.y - circlePos.y];
					vertices[1] = [lastPosition.x - canvas.x + circlePos.x, lastPosition.y - canvas.y - circlePos.y];
					vertices[2] = [lastPosition.x - canvas.x - circlePos.x, lastPosition.y - canvas.y + circlePos.y];
					vertices[3] = [FlxG.mouse.screenX - canvas.x - circlePos.x, FlxG.mouse.screenY - canvas.y + circlePos.y];
					if (!Math.isNaN(vertices[0].x)) {
						FlxSpriteUtil.drawPolygon(canvas, vertices, 0xFF0000FF);
					}
				}
				lastPosition = [FlxG.mouse.screenX, FlxG.mouse.screenY];
			}
			else if (FlxG.mouse.justReleased)
			{
				lastPosition = [9999, 9999];
			}
		}
    return;
}

function onDestroy(){
    FlxG.mouse.visible = false;
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Triggers Universal' || n == 'Triggers No Party'){
        var triggerP:Float = Std.parseFloat(v1);
        if (Math.isNaN(triggerP)) triggerP = 0;
        switch (triggerP)
        {
            case 0:
                eventTweens.push(FlxTween.tween(bfspot, {alpha: 1}, 6));
                eventTweens.push(FlxTween.tween(bfspotblackLeft, {alpha: 1}, 6));
                eventTweens.push(FlxTween.tween(bfspotblackRight, {alpha: 1}, 6));

                FlxTween.num(1, 1.2, 6, {ease: FlxEase.quadInOut}, (v) -> game.defaultCamZoom = camGame.zoom = v);
                FlxTween.num(ogScrollX, ogScrollX + 100, 6, {ease: FlxEase.quadInOut}, (v) -> game.camGame.scroll.x = v);
                if (!ClientPrefs.data.downScroll) FlxTween.num(ogScrollY, ogScrollY + 70, 6, {ease: FlxEase.quadInOut}, (v) -> game.camGame.scroll.y = v);
            case 1:
                eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: 1}, 1.5));
            case 2:
                camGame.flash(FlxColor.WHITE, 0.5);
                game.defaultCamZoom = camGame.zoom = 1;
                game.camGame.scroll.x = ogScrollX;
                game.camGame.scroll.y = ogScrollY;

                blackBarThingie.alpha = bfspot.alpha = bfspotblackLeft.alpha = bfspotblackRight.alpha = 0;
            case 3:
                FlxG.sound.play(Paths.sound('lightOn'));
                drawspot.flipY = !ClientPrefs.data.downScroll;
                drawspot.alpha = 1;
                drawspot.scale.set(1.3, 1.3);
                drawspot.y = ClientPrefs.data.downScroll ? -120 : -20;
                drawspot.angle = 2;

                var coords:Float = -30;
                if(!ClientPrefs.data.downScroll) coords = -100;
                
                eventTweens.push(FlxTween.tween(drawspot.scale, {x: 1, y: 1}, 1, {ease: FlxEase.expoOut}));
                eventTweens.push(FlxTween.tween(drawspot, {y: coords}, 2, {ease: FlxEase.expoOut}));
                extraTween.push(FlxTween.tween(drawspot, {angle: -2}, 2, {ease: FlxEase.quadInOut, type: 4}));
            case 4:
                for (tween in extraTween)
                    {
                        tween.cancel();
                    }

                var coords:Float = -100;
                if(!ClientPrefs.data.downScroll) coords = -20;
                eventTweens.push(FlxTween.tween(drawspot, {angle: 0}, 1, {ease: FlxEase.quadInOut}));
                eventTweens.push(FlxTween.tween(drawspot, {alpha: 0}, 1.5, {startDelay: 0.5}));
                eventTweens.push(FlxTween.tween(drawspot, {y: coords}, 2, {ease: FlxEase.backIn}));

            case 5:
                djDone.scale.x = 20;
                djDone.scale.y = 20;
                add(djDone);
                FlxG.sound.play(Paths.sound('finish'));
                extraTween.push(FlxTween.tween(djDone, {x: djDone.x + 3}, 0.04, {type: 4}));
                extraTween.push(FlxTween.tween(djDone, {y: djDone.y + 3}, 0.02, {type: 4}));
                eventTweens.push(FlxTween.tween(djDone.scale, {x: 2, y: 2}, 0.7, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween)
                    {
                        for (tween in extraTween)
                            {
                                tween.cancel();
                            }
                    }}));

                eventTweens.push(FlxTween.tween(djDone, {y: djDone.y - 200}, 0.8, {startDelay: 1.5, ease: FlxEase.backIn}));
            case 6:
                thetextC.visible = !thetextC.visible;
                thetext.visible = !thetextC.visible;
        }
    }
    if (n == 'Write DS'){
        var timer:Float = Std.parseFloat(v1);
        if (Math.isNaN(timer)) timer = 4; //NUMERO EN BEATS DE LA CANCION 
        if (v2 == '') v2 = 'sorry';
        var coords:Float = 535;
        if(!ClientPrefs.data.downScroll) coords = 10;
        eventTweens.push(FlxTween.tween(backing, {y: coords}, 4 * (1 / (Conductor.bpm / 60)), {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
            {
                thetext.text = v2;
                thetext.visible = true;
                canvas.visible = true;
                writeText.visible = true;
                writeText.y = backing.y + 11;
                thetext.y = backing.y + 85 - thetext.pixels.rect.height / 2;
                thetextC.y = backing.y + 85 - thetext.pixels.rect.height / 2;
                if(v2 == 'criminal'){
                    thetextC.visible = true;
                    thetext.visible = false;
                }
                canvas.y = backing.y;
                dsTimer = ((timer * 0.9) * (1 / (Conductor.bpm / 60)));

            }}));
    }
    return;
}

function writeGone(){
    thetext.visible = true;
    for (timer in eventTimers) timer.cancel();
    var acc = FlxG.random.float(0.4, 1.1) * 100;

    var check = 'What';
    if (acc < 60){
        check = 'Nice!';
    }else if (acc < 80){
        check = 'Good Job!';
    }else if (acc < 100){
        check = 'Sick!';
    }else if (acc > 100){
        check = 'Crime!';
    }
    writeText.text = check;
    thetext.visible = false;
    canvas.visible = false; //295
    thetextC.visible = false;
    eventTimers.push(new FlxTimer().start(3, function(tmr:FlxTimer)
        {
            writeText.visible = false;
        }));
    FlxSpriteUtil.fill(canvas,FlxColor.TRANSPARENT);
    var coords:Float = 1200;
    if(!ClientPrefs.data.downScroll) coords = -690;

    eventTweens.push(FlxTween.tween(backing, {y: coords}, 1.5, {ease: FlxEase.quadIn}));	
    if (!cpuControlled) {
        if (thetext.text == 'criminal') {
            //eventTweens.push(FlxTween.tween(game, {health: health - ((100 - check) / 20) }, 0.4, {ease: FlxEase.circOut}));
        } else {
            //eventTweens.push(FlxTween.tween(game, {health: health - ((100 - check) / 30) }, 0.4, {ease: FlxEase.circOut}));
        }
    }
}

// because for loop is laggy in hscript ill be doing a random text - meloom
// basically this is unused - meloom
function accuracy():Float{
    var whiteBad:Int = 0;
    var whiteTotal:Int = 0;
    var grayBad:Int = 0;
    var grayTotal:Int = 0;
    var bounds = thetext.pixels.rect;
    var bounds2 = canvas.pixels.rect;
    for (y in 0...Std.int(bounds2.bottom))
    {
        for (x in 0...Std.int(bounds2.right))
        {
            var blue:Bool = false;
            var shouldBe:Bool = false;
            var color = canvas.pixels.getPixel32(x, y);
            if (color == -16776961)
            {
                blue = true;
            }
            var convertedX = x - Std.int(thetext.x - canvas.x);
            var convertedY = y - Std.int(thetext.y - canvas.y);
            if (bounds.contains(convertedX, convertedY))
            {
                var color2 = thetext.pixels.getPixel32(convertedX, convertedY);
                if (color2 == -7829368)
                {
                    shouldBe = true;
                    grayTotal += 1;
                }
                else
                {
                    whiteTotal += 1;
                }
            }
            else
            {
                whiteTotal += 1;
            }
            if (blue && !shouldBe)
            {
                whiteBad += 1;
            }
            else if (!blue && shouldBe)
            {
                grayBad += 1;
            }
        }
    }
    var accuracy = 100 * (((Math.log(((grayTotal - grayBad) / grayTotal) * 4.84 + 1) / Math.log(2.2)) / 2.24) - (whiteBad / whiteTotal) * 3);
    accuracy *= 10;
    accuracy = Math.round(accuracy) / 10; //making the time 00.0
    if (accuracy < 0 || (whiteBad / whiteTotal) > 0.8)
    {
        return 0;
    }
    else
    {
        
        return accuracy;
    }
}