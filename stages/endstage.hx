var useShader = !getModSetting('noShaders');

var test3;
var test5;
var oldTv;
var bright;
function onCreatePost(){
    if (useShader){
        game.initLuaShader('test3');
        game.initLuaShader('test5');
        game.initLuaShader('oldTvEffect');
        game.initLuaShader('brightness');

        test3 = game.createRuntimeShader('test3');
        test5 = game.createRuntimeShader('test5');
        oldTv = game.createRuntimeShader('oldTvEffect');
        bright = game.createRuntimeShader('brightness');
        bright.setFloat('brightness', 1);
        bright.setFloat('contrast', 1);

        var sh = [new ShaderFilter(bright),new ShaderFilter(test3),new ShaderFilter(oldTv), new ShaderFilter(test5)];
        game.camGame.filters = sh;
        game.camHUD.filters = sh;
        getVar('camEst').filters = sh;
    }
    return;
}

var g = 0;
function onUpdate(e){
    g += e;
    if (useShader){
    test3.setFloat('time', g);
    oldTv.setFloat('iTime', g);
    }
    return;
}