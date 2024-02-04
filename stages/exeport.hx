
var test3;
var test5;
var lol;
var useShader = !getModSetting('noShaders');
function onCreatePost(){
    if (useShader){
        game.initLuaShader('test3');
        game.initLuaShader('test5');
        test3 = game.createRuntimeShader('test3');
        test5 = game.createRuntimeShader('test5');

        game.camGame.filters = [new ShaderFilter(test3), new ShaderFilter(test5)];
        game.camHUD.filters = [new ShaderFilter(test3), new ShaderFilter(test5)];
        getVar('camEst').filters = game.camHUD.filters;
    }
    return;
}

function onUpdate(el){
    lol += el;
    if (useShader) test3.setFloat('time', lol);
    return;
}