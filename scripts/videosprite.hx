import psychlua.LuaUtils;
import hxcodec.flixel.FlxVideo;

var sn = Paths.formatToSongPath(game.songName.toLowerCase());
var globalData:Array<Array<Dynamic>> = [];
var build = getVar('curBuild');

// im too stupid - meloom
if (build == 'windows' && !getModSetting('noVideoSprite')){
	createGlobalCallback('startVideoSprite', function(tag:String, videoFile:String){
		balls(tag, videoFile);
		return;
	});

	function onCreatePost(){
		if (build == 'windows' && !getModSetting('noVideoSprite')){
			switch(sn){
				case 'powerdown':
					balls('yea', 'Powerdownscene');
					game.modchartSprites.get('yea_video').visible = false;
				case 'demise':
					balls('yea', 'demise_cutscene');
					game.modchartSprites.get('yea_video').visible = false;

			}
		}
		return;
	}

	function balls(tag:String, videoFile:String){
		var videoData:Array<Dynamic> = [];
		var sprite:FlxSprite = new FlxSprite().makeGraphic(1, 1, FlxColor.TRANSPARENT);
		sprite.camera = getVar('camEst');
		game.modchartSprites.set(tag + '_video', sprite);
		add(sprite);
		
		var video:FlxVideo = new FlxVideo();
		video.alpha = 0;
		video.onTextureSetup.add(function()
		{
			sprite.loadGraphic(video.bitmapData);
		});
		video.play(Paths.video(videoFile), false);
		video.onEndReached.add(function(){
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
}
