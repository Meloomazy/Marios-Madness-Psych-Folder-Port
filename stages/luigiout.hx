import objects.BGSprite;
using StringTools;

var gflol;

var gfwalk;
var gfspeak;
var bfwalk;
var mrwalk;
var lgwalk;

var lightWall;

var blackBarThingie;

var eventTweens = [];

var switchedBar = false;
function onCreate(){
    var sky:BGSprite = new BGSprite('stages/cityout/skyL', -200, -1000, 0.7, 0.8);
    addBehindGF(sky);

    var citybg:BGSprite = new BGSprite('stages/cityout/buildings far', 400, -200, 0.7, 0.8);
    addBehindGF(citybg);

    var cityplus:BGSprite = new BGSprite('stages/cityout/road plus building', 600, 100, 0.8, 1);
    addBehindGF(cityplus);

    var lightsky:BGSprite = new BGSprite('stages/cityout/corner sky overlay', 800, -500, 0.8, 0.8);
    addBehindGF(lightsky);

    var wall:BGSprite = new BGSprite('stages/cityout/buildingSide', -950, -450, 1, 1);
    addBehindGF(wall);

    gflol = new BGSprite('stages/cityout/GF_LDO', -400, 300, 1, 1, ['ldo gf dance'], false);
    gflol.animation.addByIndices('danceleft', "ldo gf dance", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
    gflol.animation.addByIndices('danceright', "ldo gf dance", [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

    gflol.animation.addByIndices('danceLeft-alt', "ldo gf dance annoyed", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
    gflol.animation.addByIndices('danceRight-alt', "ldo gf dance annoyed", [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
    gflol.animation.addByPrefix('why', "ldo gf why", 24, false);
    gflol.antialiasing = ClientPrefs.data.antialiasing;
    gflol.alpha = 0.001;
    addBehindGF(gflol);

    gfwalk = new BGSprite('stages/cityout/they-walkin', -390, 280, 1, 1, ['ldo gf end dialogue'], false);
    gfwalk.animation.addByPrefix('why', "ldo gf end dialogue", 21, false);

    gfspeak = new BGSprite('stages/cityout/stereo_still_image', -390, 640);
    gfspeak.alpha = 0.000001;

    bfwalk = new BGSprite('stages/cityout/they-walkin', -13, 325, 1, 1, ['ldo bf end dialogue'], false);
    bfwalk.animation.addByPrefix('why', "ldo bf end dialogue", 21, false);
    bfwalk.scale.set(1.1, 1.1);

    mrwalk = new BGSprite('stages/cityout/they-walkin', 355, 248, 1, 1, ['ldo mario end dialogue'], false);
    mrwalk.animation.addByPrefix('g', "ldo mario end dialogue", 21, false);

    lgwalk = new BGSprite('stages/cityout/they-walkin', 796.5, 150, 1, 1, ['ldo luigi end dialogue'], false);
    lgwalk.animation.addByPrefix('why', "ldo luigi end dialogue", 21, false);

    gfwalk.alpha = 0.000001;
    bfwalk.alpha = 0.000001;
    mrwalk.alpha = 0.000001;
    lgwalk.alpha = 0.000001;
    addBehindGF(gfspeak);
    addBehindGF(lgwalk);
    addBehindGF(mrwalk);
    addBehindGF(bfwalk);
    addBehindGF(gfwalk);

    lightWall = new BGSprite('stages/cityout/Overlay All', -800, -550, 1.2, 1.2);
    add(lightWall);

    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.alpha = 1;
    blackBarThingie.cameras = [getVar('camEst')];
    add(blackBarThingie);

    camHUD.alpha = 0;

    game.skipCountdown = true;
    return;
}

function onSongStart(){
    switchBar();

    boyfriend.alpha = 0.001;
    eventTweens.push(FlxTween.tween(blackBarThingie, {alpha: 0}, 0.5, {startDelay: 1, ease: FlxEase.quadInOut}));
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Triggers Day Out' || n == 'Triggers Universal'){
        var trigger:Float = Std.parseFloat(v1);
        if (Math.isNaN(trigger))
            trigger = 0;
        var trigger2:Float = Std.parseFloat(v2);
        if (Math.isNaN(trigger2))
            trigger2 = 0;
        switch (trigger)
        {
            case 0:
                game.camZooming = false;
                setVar('camMove', false);
                eventTweens.push(FlxTween.tween(camFollow, {x: getVar('posValDad')[0], y: getVar('posValDad')[1]}, 1.5, {ease: FlxEase.quadOut}));
                mrwalk.alpha = 1;
                dad.visible = false;

                gfwalk.alpha = 1;
                gflol.visible = false;

                bfwalk.alpha = 1;
                boyfriend.visible = false;

                lgwalk.alpha = 1;
                gfGroup.visible = false;

                gfwalk.animation.play('why');
                bfwalk.animation.play('why');
                mrwalk.animation.play('g');
                lgwalk.animation.play('why');

                gfspeak.alpha = 1;

                eventTweens.push(FlxTween.tween(gfwalk, {y: gfwalk.y + 400, x: gfwalk.x + 2533}, 6, {startDelay: 7.71}));
                eventTweens.push(FlxTween.tween(bfwalk, {y: bfwalk.y + 400, x: bfwalk.x + 2533}, 6, {startDelay: 7.85}));
                eventTweens.push(FlxTween.tween(mrwalk, {y: mrwalk.y + 400, x: mrwalk.x + 2533}, 6, {startDelay: 6.19}));
                eventTweens.push(FlxTween.tween(lgwalk, {y: lgwalk.y + 400, x: lgwalk.x + 2533}, 6, {startDelay: 9.14}));
            case 1:
                //13
                setVar('camMove', false);
                eventTweens.push(FlxTween.tween(camFollow, {x: 1050, y: 450}, 2.5, {ease: FlxEase.cubeInOut}));
                eventTweens.push(FlxTween.tween(FlxG.camera, {zoom: 1}, 2.4, {ease: FlxEase.quadInOut}));
                setVar('bfZoom', 1);
                setVar('dadZoom', 1);
            case 2:
                //32
                setVar('camMove', true);
                setVar('bfZoom', 0.75);
                setVar('dadZoom', 0.75);
            case 3:
                //188
                gflol.animation.play('why');
                setVar('camMove', false);
                eventTweens.push(FlxTween.tween(camFollow, {x: 320, y: 450}, 1, {ease: FlxEase.quadOut}));
            case 4:
                //196
                setVar('camMove', true);
            case 5:
                // 329
                setVar('camMove', false);
                //game.triggerEvent('Camera Follow Pos','320','450');
            case 6:
                // 339
                setVar('camMove', false);
                eventTweens.push(FlxTween.tween(camFollow, {x: 920, y: 450}, 3, {ease: FlxEase.quadInOut}));
                //game.triggerEvent('Camera Follow Pos','','');
            case 7:
                eventTweens.push(FlxTween.tween(camFollow, {x: 320, y: 450}, 2.4, {ease: FlxEase.cubeInOut}));
                eventTweens.push(FlxTween.tween(FlxG.camera, {zoom: 0.7}, 2.4, {ease: FlxEase.cubeInOut}));
                boyfriend.alpha = 1;
                gflol.alpha = 1;
            case 8:
                eventTweens.push(FlxTween.tween(camFollow, {x: 720, y: 450}, 1.4, {ease: FlxEase.cubeOut}));
        }
    }
    return;
}

function onStepHit(){
    if (curStep % 2 == 0 && curStep % 4 != 0){
        if (boyfriend.animation.curAnim.name != null && !boyfriend.animation.curAnim.name.startsWith("sing")){
            boyfriend.dance();
        }
        if (dad.animation.curAnim.name != null && !dad.animation.curAnim.name.startsWith("sing") && !dad.stunned){
            dad.dance();
        }
        if (gflol.animation.curAnim.finished || gflol.animation.curAnim.name == 'danceleft' || gflol.animation.curAnim.name == 'danceright'){
            if (gflol.animation.curAnim.name == 'danceleft')
            {
                gflol.animation.play('danceright');
            }
            else
            {
                gflol.animation.play('danceleft');
            }
        }
    }
    return;
}

var isLuigi = false;
function goodNoteHit(note){
    if (note.noteType == 'GF Sing'){
        if (!isLuigi){
            switchBar();
            isLuigi = true;
        }
    }else{
        if (isLuigi){
            switchBar();
            isLuigi = false;
        }
    }
    return;
}

function switchBar(){
    switchedBar = !switchedBar;
    iconP1.flipX = healthBar.leftBar.flipX = healthBar.rightBar.flipX = iconP2.flipX = switchedBar;
    if (switchedBar){
        healthBar.rightBar.color = FlxColor.fromRGB(boyfriend.healthColorArray[0],boyfriend.healthColorArray[1],boyfriend.healthColorArray[2]);
        iconP1.changeIcon('bf-ldo');
        game.updateIconsPosition = function(){
            var barCenter = healthBar.leftBar.x + FlxMath.lerp(0, healthBar.barWidth, healthBar.percent / 100) + healthBar.barOffset.x;
            iconP1.x = barCenter - (150 * iconP1.scale.x) / 2 - 46;
            iconP2.x = barCenter + (150 * iconP2.scale.x) / 2 - 116;
        }
    }else{
        healthBar.rightBar.color = FlxColor.fromRGB(105,187,104);
        iconP1.changeIcon('luigi-ldo');
        game.updateIconsPosition = function(){
            var iconOffset = 26;
            iconP1.x = healthBar.barCenter + (150 * iconP1.scale.x - 150) / 2 - iconOffset;
            iconP2.x = healthBar.barCenter - (150 * iconP2.scale.x) / 2 - iconOffset * 2;
        }
    }
}