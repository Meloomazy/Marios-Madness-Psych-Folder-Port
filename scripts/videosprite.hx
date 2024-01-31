import psychlua.LuaUtils;
import hxcodec.flixel.FlxVideo;

var sn = Paths.formatToSongPath(game.songName.toLowerCase());
var globalData:Array<Array<Dynamic>> = [];

var cutsceneCam;
function onStartCountdown(){
	if (sn == 'powerdown' || sn == 'demise'){
		FlxG.cameras.remove(game.camHUD,false);
		FlxG.cameras.remove(game.camOther,false);
		cutsceneCam = new FlxCamera();
		cutsceneCam.bgColor = 0x00;
		setVar('cutsceneCam', cutsceneCam);
		FlxG.cameras.add(cutsceneCam,false);
		FlxG.cameras.add(game.camHUD,false);
		FlxG.cameras.add(game.camOther,false);
	}
	return;
}
function onCreatePost(){
	switch(sn){
		case 'powerdown':
			balls('yea', 'Powerdownscene');
			game.modchartSprites.get('yea_video').visible = false;
		case 'demise':
			balls('yea', 'demise_cutscene');
			game.modchartSprites.get('yea_video').visible = false;

	}
	return;
}
createGlobalCallback('objCutsceneCam', function(tag:String){
    game.getLuaObject(tag).camera = cutsceneCam;
});


function balls(tag:String, videoFile:String){
	var videoData:Array<Dynamic> = [];
	
	if (game.modchartSprites.exists(tag + '_video'))
	{
		debugPrint('makeVideoSprite: This tag is not available! Use a different tag.', FlxColor.RED);
		
		return;
	}
	
	if (!FileSystem.exists(Paths.video(videoFile)))
	{
		debugPrint('makeVideoSprite: The video file "' + videoFile + '" cannot be found!', FlxColor.RED);
		
		return;
	}
	
	var sprite:FlxSprite = new FlxSprite().makeGraphic(1, 1, FlxColor.TRANSPARENT);
	sprite.camera = cutsceneCam;
	game.modchartSprites.set(tag + '_video', sprite);
	add(sprite);
	
	var video:FlxVideo = new FlxVideo();
	
	video.alpha = 0;
	
	video.onTextureSetup.add(function()
	{
		sprite.loadGraphic(video.bitmapData);
	});
	
	video.play(Paths.video(videoFile), false);
	
	video.onEndReached.add(function()
	{
		video.dispose();
		
		if (FlxG.game.contains(video))
			FlxG.game.removeChild(video);
		
		if (globalData.indexOf(videoData) >= 0)
			globalData.remove(videoData);
		
		if (game.modchartSprites.exists(tag + '_video'))
		{
			game.modchartSprites.get(tag + '_video').destroy();
			game.modchartSprites.remove(tag + '_video');
		}
			
		game.callOnLuas('onVideoFinished', [tag]);
	});
	
	FlxG.game.addChild(video);
	videoData.push(video);
	videoData.push(sprite);
	globalData.push(videoData);
	return;
}
createGlobalCallback('startVideoSprite', function(tag:String, videoFile:String)
{
	balls(tag, videoFile);
	return;
});
function onPause()
{
	for (video in globalData)
	{
		if (video[0] != null)
		{
			video[0].pause();
			
			if (FlxG.autoPause)
			{
				if (FlxG.signals.focusGained.has(video[0].resume))
					FlxG.signals.focusGained.remove(video[0].resume);

				if (FlxG.signals.focusLost.has(video[0].pause))
					FlxG.signals.focusLost.remove(video[0].pause);
			}
		}
	}
	return;
}

function onResume()
{
	for (video in globalData)
	{
		if (video[0] != null){
			video[0].resume();
			if (FlxG.autoPause)
			{
				if (!FlxG.signals.focusGained.has(video[0].resume))
					FlxG.signals.focusGained.add(video[0].resume);

				if (!FlxG.signals.focusLost.has(video[0].pause))
					FlxG.signals.focusLost.add(video[0].pause);
			}
		}
	}
	return;
}

function onDestroy()
{
	for (video in globalData)
	{
		if (video[0] != null)
			video[0].stop();
	}
	return;
}
