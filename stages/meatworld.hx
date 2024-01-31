import objects.HealthIcon;
var iconP3;

function onCreatePost(){
    iconP3 = new HealthIcon('latemario', true);
	iconP3.y = healthBar.y - 125;
	iconP3.alpha = 0.3;
	game.uiGroup.add(iconP3);

    for (n in game.unspawnNotes){
        if (n.noteType == 'Bullet') n.noAnimation = true;
    }

    return;
}
function onUpdate(elapsed){
    iconP3.x = game.iconP1.x + 100;
    iconP3.scale.x = iconP1.scale.x;
    iconP3.scale.y = iconP1.scale.y;
    iconP3.updateHitbox();

    return;
}
function goodNoteHit(note){
    if (note.noteType == 'GF Duet'){
        game.gf.playAnim(game.singAnimations[note.noteData], true);
        game.gf.holdTimer = 0;
    }
    if (note.noteType == 'Bullet'){
        game.boyfriend.playAnim('singUP-alt', true);
        game.boyfriend.holdTimer = 0;
    }

    return;
}