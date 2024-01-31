local dumbshit = {205, 213, 221, 229, 237, 245, 253}
local useAltInst
function onCreate()
	useAltInst = getRandomBool(50)
	-- Primer fondo
	makeLuaSprite('street1', 'stages/TooLateBG/street/BackTrees', -1400, -550)
	setScrollFactor('street1', 0.95, 0.95)
	addLuaSprite('street1')

	makeLuaSprite('street2', 'vTooLateBG/street/Front Trees', -1400, -550)
	setScrollFactor('street2', 1.05, 1.05)
	addLuaSprite('street2')

	makeLuaSprite('street3', 'stages/TooLateBG/street/Road', -1400, -550)
	setScrollFactor('street3', 1, 1)
	addLuaSprite('street3')

	makeLuaSprite('street4', 'stages/TooLateBG/street/Foreground Trees', -1400, -550)
	setScrollFactor('street4', 1, 1)
	addLuaSprite('street4', true)

	makeLuaSprite('street5', 'stages/TooLateBG/street/car', -1400, -550)
	setScrollFactor('street5', 1, 1)
	addLuaSprite('street5')

    
    makeLuaSprite('vig', '126', 0, 0)
    setObjectCamera('vig', 'camHUD')
    addLuaSprite('vig')
end
function onCreatePost()
	for i = 1,5 do
		setProperty('street' .. i .. '.alpha', 1)
	end

end

function onSongStart()
	if useAltInst then playMusic('overdue/altInst',1) end
end

function goodNoteHit(id, dir, type, sus)
	if type == 'Bullet' then
		setProperty('dad.alpha', 0)
		doTweenAlpha('dumbass', 'dad', 1, 0.5)
		playSound('overdue/gunshot', 1) -- the original file are a WHOLE blank music with the gun shot sound at certain moment....
	end
end

function onEvent(n,v1,v2)
	if n == 'Triggers Universal' then
		if v1 == '7' then
			triggerEvent('Change Character', 'bf', 'pico_run')
			triggerEvent('fuckoff', '', '')
		end
	end
end