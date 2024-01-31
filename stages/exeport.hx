game.initLuaShader('test3');
game.initLuaShader('test5');
var test3;
var test5;
var lol;
function onCreatePost(){ 
    test3 = game.createRuntimeShader('test3');
    test5 = game.createRuntimeShader('test5');

    game.camGame.filters = [new ShaderFilter(test3), new ShaderFilter(test5)];
    game.camHUD.filters = [new ShaderFilter(test3), new ShaderFilter(test5)];
    getVar('cutsceneCam').filters = game.camHUD.filters;
    return;
}

function onUpdate(el){
    lol += el;
    test3.setFloat('time', lol);
    return;
}