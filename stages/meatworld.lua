addCharacterToList('pico_run', 0)
precacheMusic('overdue/altInst')

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