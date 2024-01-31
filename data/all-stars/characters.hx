// Basically handle all character stuff - [Tatoraa]
import objects.BGSprite;
import objects.HealthIcon;

var iconA4;
var iconA42;

var extraTween = [];
var eventTweens = [];

var iconLG;
var iconW4;
var iconY0;
var iconGF;
function onCreate(){
    iconA4 = new BGSprite('stages/allfinal/act4/iconAct4', 0, 0, 1, 1, ['BEEGY0SH']);
    iconA4.animation.addByPrefix('beta2', 'beta2', 1, false);
    iconA4.animation.addByPrefix('costume', 'costume', 1, false);
    iconA4.animation.addByPrefix('devil', 'devil', 1, false);
    iconA4.animation.addByPrefix('gb', 'gb', 1, false);
    iconA4.animation.addByPrefix('hally', 'hally', 1, false);
    iconA4.animation.addByPrefix('luigiH2', 'luigiH2', 1, false);
    iconA4.animation.addByPrefix('mrl', 'mrl', 1, false);
    iconA4.animation.addByPrefix('2MX', '2MX', 1, false);
    iconA4.animation.addByPrefix('omega', 'omega', 1, false);
    iconA4.animation.addByPrefix('cdpeach', 'cdpeach', 1, false);
    iconA4.animation.addByPrefix('peachex', 'peachex', 1, false);
    iconA4.animation.addByPrefix('secret', 'secret', 1, false);
    iconA4.animation.addByPrefix('stanley', 'stanley', 1, false);
    iconA4.animation.addByPrefix('sys', 'sys', 1, false);
    iconA4.animation.addByPrefix('turmoil', 'turmoil', 1, false);
    iconA4.animation.addByPrefix('v', 'v', 1, false);
    iconA4.animation.addByPrefix('wario', 'wario', 1, false);
    iconA4.animation.addByPrefix('wdwluigi', 'wdwluigi', 1, false);
    iconA4.animation.addByPrefix('BEEGY0SH', 'BEEGY0SH', 1, false);
    iconA4.cameras = [camHUD];
    iconA4.antialiasing = ClientPrefs.data.antialiasing;
    add(iconA4);

    iconA42 = new BGSprite('stages/allfinal/act4/iconAct4', 0, 0, 1, 1, ['yoshiex']);
    iconA42.cameras = [camHUD];
    iconA42.antialiasing = ClientPrefs.data.antialiasing;
    add(iconA42);

    iconA4.visible = false;
    iconA42.visible = false;

    return;
}
var hasDownScroll = ClientPrefs.data.downScroll;
function onCreatePost(){
    iconGF = new HealthIcon('gf', true);
	iconGF.y = healthBar.y - 75;
	game.uiGroup.add(iconGF);

    iconLG = new HealthIcon('LG', false);
	iconLG.y = healthBar.y - 75;
	iconLG.visible = false;
	game.uiGroup.add(iconLG);

    iconW4 = new HealthIcon('W4R', false);
	iconW4.y = healthBar.y - 75;
	iconW4.visible = false;
	game.uiGroup.add(iconW4);

    iconY0 = new HealthIcon('Y0SH', false);
	iconY0.y = healthBar.y - 75;
	iconY0.visible = false;
	game.uiGroup.add(iconY0);


    if (hasDownScroll){
        iconA4.y = iconP2.y + 50;
        iconA42.y = iconA4.y - 90;
    }
    else{
        iconA4.y = iconP2.y - 50;
        iconA42.y = iconA4.y + 70;
    }
    iconGF.y = iconA42.y + 15;
    return;
}

function onEvent(n,v1,v2){
    if (n == 'Triggers Universal'){
        if (v1 == '0' && v2 == '0') iconGF.visible = false;
        if (v1 == '2'){
            if (v2 == '1'){
                iconP2.visible = false;
                iconLG.visible = true;
                if (hasDownScroll){
                    iconW4.y = iconP2.y + 75 - 250;
                    iconY0.y = iconP2.y - 75 - 250;
                }
                else{
                    iconW4.y = iconP2.y + 75 + 250;
                    iconY0.y = iconP2.y - 75 + 250;
                }
            }
            if (v2 == '2'){
                iconW4.visible = true;
                if (hasDownScroll)
                    eventTweens.push(FlxTween.tween(iconW4, {y: iconW4.y + 230}, 2, {ease: FlxEase.circOut}));
                else
                    eventTweens.push(FlxTween.tween(iconW4, {y: iconW4.y - 280}, 2, {ease: FlxEase.circOut}));

            }
            if (v2 == '3'){
                iconY0.visible = true;
                if (hasDownScroll)
                    eventTweens.push(FlxTween.tween(iconY0, {y: iconY0.y + 280}, 2, {ease: FlxEase.circOut}));
                else
                    eventTweens.push(FlxTween.tween(iconY0, {y: iconY0.y - 230}, 2, {ease: FlxEase.circOut}));
            }
        }
        if (v1 == '3'){
            if (v2 == '0'){
                iconP2.visible = true;
                iconLG.visible = false;
                iconW4.visible = false;
                iconY0.visible = false;
            }
        }
        if (v1 == '5'){
            iconA4.visible = true;

            var a4Icon:String = v2;
            iconA4.visible = true;
            iconA4.animation.play(a4Icon, true);
            iconA42.angle = iconA4.angle = 0;
            extraTween.push(FlxTween.tween(iconA4, {angle: iconA4.angle + 360}, 0.25, {ease: FlxEase.backOut}));
            extraTween.push(FlxTween.tween(iconA42, {angle: iconA42.angle + 360}, 0.25, {ease: FlxEase.backOut}));

            if (a4Icon == 'peachex')
                iconA42.visible = true;
            else
                iconA42.visible = false;
        }
    }

    return;
}
function onUpdate(elapsed){
    iconLG.x = iconP2.x;
    iconGF.x = iconP1.x + 75;

    iconW4.x = iconY0.x = iconP2.x - 75;
    iconLG.scale.set(iconP2.scale.x, iconP2.scale.y);
    iconW4.scale.set(iconP2.scale.x, iconP2.scale.y);
    iconY0.scale.set(iconP2.scale.x, iconP2.scale.y);

	iconA42.x = iconA4.x = iconP2.x - 50;
    iconA4.scale.set(iconP2.scale.x - 0.2, iconP2.scale.y - 0.2);
    iconA42.scale.set(iconP2.scale.x - 0.2, iconP2.scale.y - 0.2);
    iconGF.scale.set(iconP1.scale.x - 0.15, iconP1.scale.y - 0.15);

    if(iconA4.alpha > 0.1){
        iconA42.alpha = iconA4.alpha -= elapsed;
    }
    iconA42.alpha = iconA4.alpha = iconP2.alpha * 0.7;


    if (!getVar('LG').stunned && getVar('LG').holdTimer > Conductor.stepCrochet * 0.0011 * getVar('LG').singDuration && StringTools.startsWith(getVar('LG').animation.curAnim.name, 'sing')){
        getVar('LG').dance();
    }
    if (!getVar('w4r').stunned && getVar('w4r').holdTimer > Conductor.stepCrochet * 0.0011 * getVar('w4r').singDuration && StringTools.startsWith(getVar('w4r').animation.curAnim.name, 'sing'))
    {
        getVar('w4r').dance();
    }
    if (!getVar('y0sh').stunned && getVar('y0sh').holdTimer > Conductor.stepCrochet * 0.0011 * getVar('y0sh').singDuration && StringTools.startsWith(getVar('y0sh').animation.curAnim.name, 'sing'))
    {
        getVar('y0sh').dance();
    }
    return;
}

function onBeatHit(){
	if (curBeat % getVar('LG').danceEveryNumBeats == 0 && getVar('LG').animation.curAnim != null && !StringTools.startsWith(getVar('LG').animation.curAnim.name, 'sing') && !getVar('LG').stunned)
		getVar('LG').dance();
    if (curBeat % getVar('w4r').danceEveryNumBeats == 0 && getVar('w4r').animation.curAnim != null && !StringTools.startsWith(getVar('w4r').animation.curAnim.name, 'sing') && !getVar('w4r').stunned)
        getVar('w4r').dance();
    if (curBeat % getVar('y0sh').danceEveryNumBeats == 0 && getVar('y0sh').animation.curAnim != null && !StringTools.startsWith(getVar('y0sh').animation.curAnim.name, 'sing') && !getVar('y0sh').stunned)
        getVar('y0sh').dance();

    return;
}
function opponentNoteHit(note){
    if (note.noteType == 'GF Sing' || note.noteType == 'AS Bud Note'){
        getVar('LG').playAnim(game.singAnimations[note.noteData], true);
        getVar('LG').holdTimer = 0;
    }
    if (note.noteType == '' || note.noteType == 'AS Bud Note'){
        getVar('w4r').playAnim(game.singAnimations[note.noteData], true);
        getVar('w4r').holdTimer = 0;
    }
    if (note.noteType == 'Yoshi Note' || note.noteType == 'AS Bud Note'){
        getVar('y0sh').playAnim(game.singAnimations[note.noteData], true);
        getVar('y0sh').holdTimer = 0;
    }
    return;
}

function goodNoteHit(note){
    if (note.noteType == 'GF Duet'){
        game.gf.playAnim(game.singAnimations[note.noteData], true);
        game.gf.holdTimer = 0;
    }
    return;
}