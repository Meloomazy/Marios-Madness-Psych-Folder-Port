--Script by Teniente Mantequilla#0139--

--change this ones--
local camMovement = 15
local velocity = 1.5

--leave this ones alone--
local campointx = 670
local campointy = 460
local camlockx = 0
local camlocky = 0
local camlock = false
local bfturn = false
local camon = true

local ogSpeed = 1
function onSongStart()
	ogSpeed = getProperty('cameraSpeed')
end
	
function onSectionHit()
	if camon then
		if mustHitSection then
			bfturn = true
			camlock = false
			setProperty('cameraSpeed', ogSpeed)	
		else
			bfturn = false
			camlock = false
			setProperty('cameraSpeed', ogSpeed)	
		end
	end
end


function goodNoteHit(id, direction, noteType, isSustainNote)
	if camon then
	if bfturn then
		if direction == 0 then
			camlockx = campointx - camMovement
			camlocky = campointy
		elseif direction == 1 then
			camlocky = campointy + camMovement
			camlockx = campointx
		elseif direction == 2 then
			camlocky = campointy - camMovement
			camlockx = campointx
		elseif direction == 3 then
			camlockx = campointx + camMovement
			camlocky = campointy
		end
	runTimer('camreset', 1)
	setProperty('cameraSpeed', velocity)
	camlock = true
	end	
end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if camon then
	if not bfturn then
		if direction == 0 then
			camlockx = campointx - camMovement
			camlocky = campointy
		elseif direction == 1 then
			camlocky = campointy + camMovement
			camlockx = campointx
		elseif direction == 2 then
			camlocky = campointy - camMovement
			camlockx = campointx
		elseif direction == 3 then
			camlockx = campointx + camMovement
			camlocky = campointy
		end
	runTimer('camreset', 1)
	setProperty('cameraSpeed', velocity)
	camlock = true
	end	
end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if camon then
	if tag == 'camreset' then
	camlock = false
	setProperty('cameraSpeed', 1)
	setProperty('camFollow.x', campointx)
	setProperty('camFollow.y', campointy)
	end
end
end

function onUpdate()
	if camlock and camon then
		setProperty('camFollow.x', camlockx)
		setProperty('camFollow.y', camlocky)
	end
end

function onBeatHit()
	if songName == 'Boulevard' then
		if curBeat == 303 then
			camon = false
		end
	end
end