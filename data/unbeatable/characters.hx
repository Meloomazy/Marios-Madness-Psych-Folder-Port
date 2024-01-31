import objects.HealthIcon;

var ycbu_bowser;
var ycbu_hunter;
function onCreate(){
    
    ycbu_bowser = new Character(game.dad.x, game.dad.y + 700, 'koopa');
    setVar('ycbu_bowser',ycbu_bowser);
    ycbu_bowser.alpha = 1;
    addBehindDad(ycbu_bowser);

    ycbu_hunter = new Character(game.dad.x, game.dad.y + 800, 'hunter');
    setVar('ycbu_hunter',ycbu_hunter);
    ycbu_hunter.alpha = 1;
    addBehindDad(ycbu_hunter);

    return;
}

var iconP2Alt;
var iconP3;
var iconP4;
function onCreatePost(){
    game.iconP2.visible = false;
    iconP2Alt = new HealthIcon('sys', false);
	iconP2Alt.y = healthBar.y - 75;
	iconP2Alt.alpha = 1;
	game.uiGroup.add(iconP2Alt);

    iconP3 = new HealthIcon('bowser', false);
	iconP3.y = healthBar.y - 75;
	iconP3.alpha = 0.0001;
	game.uiGroup.add(iconP3);

    iconP4 = new HealthIcon('hunt', false);
	iconP4.y = healthBar.y - 75;
	iconP4.alpha = 0.0001;
	game.uiGroup.add(iconP4);

    return;
}

var iconOffsX = [0, -100, -100];
var iconOffsY = [0, -50, 50];
function iconChange(who:String){
    var colH = FlxColor.fromRGB(ycbu_hunter.healthColorArray[0], ycbu_hunter.healthColorArray[1], ycbu_hunter.healthColorArray[2]);
    var colB = FlxColor.fromRGB(ycbu_bowser.healthColorArray[0], ycbu_bowser.healthColorArray[1], ycbu_bowser.healthColorArray[2]);
    var colS = FlxColor.fromRGB(game.dad.healthColorArray[0], game.dad.healthColorArray[1], game.dad.healthColorArray[2]);

    switch(who){
        case 'bowser':
            iconP3.alpha = 1;
            FlxTween.color(game.healthBar.leftBar, 0.3, game.healthBar.leftBar.color, colB, {ease: FlxEase.cubeOut});
            FlxTween.num(iconOffsX[0], -100, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsX[0] = val; });
            FlxTween.num(iconOffsX[1], 0, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsX[1] = val; });
            FlxTween.num(iconOffsX[2], -100, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsX[2] = val; });
            FlxTween.num(iconOffsY[0], 50, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsY[0] = val; });
            FlxTween.num(iconOffsY[1], 0, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsY[1] = val; });
            FlxTween.num(iconOffsY[2], -50, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsY[2] = val; });
        case 'hunter':
            iconP4.alpha = 1;
            FlxTween.color(game.healthBar.leftBar, 0.3, game.healthBar.leftBar.color, colH, {ease: FlxEase.cubeOut});
            FlxTween.num(iconOffsX[1], -100, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsX[1] = val; });
            FlxTween.num(iconOffsX[0], -100, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsX[0] = val; });
            FlxTween.num(iconOffsX[2], 0, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsX[2] = val; });
            FlxTween.num(iconOffsY[0], -50, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsY[0] = val; });
            FlxTween.num(iconOffsY[1], 50, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsY[1] = val; });
            FlxTween.num(iconOffsY[2], 0, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsY[2] = val; });
        case 'sys':
            iconP2Alt.alpha = 1;
            FlxTween.color(game.healthBar.leftBar, 0.3, game.healthBar.leftBar.color, colS, {ease: FlxEase.cubeOut});
            FlxTween.num(iconOffsX[0], 0, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsX[0] = val; });
            FlxTween.num(iconOffsX[1], -100, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsX[1] = val; });
            FlxTween.num(iconOffsX[2], -100, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsX[2] = val; });
            FlxTween.num(iconOffsY[0], 0, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsY[0] = val; });
            FlxTween.num(iconOffsY[1], -50, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsY[1] = val; });
            FlxTween.num(iconOffsY[2], 50, 0.3, {ease: FlxEase.cubeOut}, function(val) { iconOffsY[2] = val; });
    }
}
function onUpdate(elapsed){
    iconP2Alt.x = game.iconP2.x + iconOffsX[0];
    iconP3.x = game.iconP2.x + iconOffsX[1];
    iconP4.x = game.iconP2.x + iconOffsX[2];
    iconP2Alt.y = game.iconP2.y + iconOffsY[0];
    iconP3.y = game.iconP2.y + iconOffsY[1];
    iconP4.y = game.iconP2.y + iconOffsY[2];


    iconP2Alt.origin.x = iconP3.origin.x = iconP4.origin.x = 200;
    iconP2Alt.scale.x = iconP3.scale.x = iconP4.scale.x = game.iconP2.scale.x;
    iconP2Alt.scale.y = iconP3.scale.y = iconP4.scale.y = game.iconP2.scale.y;
    iconP2Alt.animation.curAnim.curFrame = iconP3.animation.curAnim.curFrame = iconP4.animation.curAnim.curFrame = game.iconP2.animation.curAnim.curFrame;
    
    iconP2Alt.updateHitbox();
    iconP3.updateHitbox();
    iconP4.updateHitbox();

    ycbu_hunter.visible = ycbu_bowser.visible = game.dadGroup.visible;
    if (!ycbu_bowser.stunned && ycbu_bowser.holdTimer > Conductor.stepCrochet * 0.0011 * ycbu_bowser.singDuration && StringTools.startsWith(ycbu_bowser.animation.curAnim.name, 'sing'))
    {
        ycbu_bowser.dance();
    }
    if (!ycbu_hunter.stunned && ycbu_hunter.holdTimer > Conductor.stepCrochet * 0.0011 * ycbu_hunter.singDuration && StringTools.startsWith(ycbu_hunter.animation.curAnim.name, 'sing'))
    {
        ycbu_hunter.dance();
    }

    if (FlxG.keys.justPressed.ONE) iconChange('sys');
    if (FlxG.keys.justPressed.TWO) iconChange('hunter');
    if (FlxG.keys.justPressed.THREE) iconChange('bowser');

    return;
}
function onBeatHit(){
	if (curBeat % ycbu_bowser.danceEveryNumBeats == 0 && ycbu_bowser.animation.curAnim != null && !StringTools.startsWith(ycbu_bowser.animation.curAnim.name, 'sing') && !ycbu_bowser.stunned)
	{
		ycbu_bowser.dance();
	}
    if (curBeat % ycbu_hunter.danceEveryNumBeats == 0 && ycbu_hunter.animation.curAnim != null && !StringTools.startsWith(ycbu_hunter.animation.curAnim.name, 'sing') && !ycbu_hunter.stunned)
    {
        ycbu_hunter.dance();
    }

    return;
}
createGlobalCallback('iconTurn', function(who:String){
    iconChange(who);
});

function onEvent(n,v1,v2){
    if (n == 'ui thing'){
        if (v1 == 'ui'){
            if (v2 == 'normal'){
                iconP2Alt.alpha = 1;
                iconP3.alpha = 0;
                iconP4.alpha = 0;
            }
        }
    }
    if (n == 'random bs'){
        if (v1 == 'bowserClownCar'){
            iconChange('sys');
            iconP2Alt.alpha = 1;
            iconP3.alpha = 0;
            iconP4.alpha = 0;
        }
    }
    if (n == 'level'){
        if (v1 == '2'){
            FlxTween.tween(game.dadGroup, {alpha: 0}, 1, {ease: FlxEase.linear});
            FlxTween.tween(iconP2Alt, {alpha: 0}, 1, {ease: FlxEase.linear, onComplete: function(){
                iconChange('hunter');
                iconP4.alpha = 0;
                new FlxTimer().start(1, function(tmr:FlxTimer) {
                    FlxTween.tween(game, {health: 1}, 1.2, {ease: FlxEase.quadOut});
                    FlxTween.tween(ycbu_hunter, {y: game.dad.y + 120}, 1.2, {ease: FlxEase.quadOut});
                    FlxTween.tween(iconP4, {alpha: 1}, 1.4, {ease: FlxEase.linear});            
                });
            }});
        }
        if (v1 == '3'){
            FlxTween.tween(ycbu_hunter, {alpha: 0}, 1.5, {ease: FlxEase.linear});
            FlxTween.tween(iconP4, {alpha: 0}, 1, {ease: FlxEase.linear, onComplete: function(){
                iconChange('bowser');
                iconP3.alpha = 0;
                new FlxTimer().start(2, function(tmr:FlxTimer) {
                    FlxTween.tween(game, {health: 1}, 1.2, {ease: FlxEase.quadOut});
                    FlxTween.tween(ycbu_bowser, {y: game.dad.y}, 1.2, {ease: FlxEase.quadOut});
                    FlxTween.tween(iconP3, {alpha: 1}, 1.4, {ease: FlxEase.linear});            
                });
            }});
        }
    }
    if (n == 'Play Animation'){
        ycbu_hunter.playAnim('singUP', true);
        ycbu_hunter.holdTimer = 0;
    }
    return;
}

function opponentNoteHit(note){
    if (note.noteType == '' || note.noteType == 'Yoshi Note'){
        ycbu_bowser.playAnim(game.singAnimations[note.noteData], true);
        ycbu_bowser.holdTimer = 0;
    }

    if (note.noteType == '' || note.noteType == 'GF Sing' || note.noteType == 'GF Duet'){
        ycbu_hunter.playAnim(game.singAnimations[note.noteData], true);
        ycbu_hunter.holdTimer = 0;
    }

    return;
}

function goodNoteHit(note){
    if (note.noteType == 'Hey!'){
        game.gf.playAnim('hey', true);
        game.gf.holdTimer = 0;
        game.gf.specialAnim = true;
    }

    return;
}
