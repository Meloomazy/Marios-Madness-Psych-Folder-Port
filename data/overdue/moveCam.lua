--Script by Teniente Mantequilla#0139--

--change this ones--
local camMovement = 20
local velocity = 1

--leave this ones alone--
local campointx = getProperty('gf.x')
local campointy = getProperty('gf.y')
local camlockx = campointx
local camlocky = campointy
local camlock = true
local bfturn = false
local camon = true

local posValDad = {getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]'), getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]')}
local posValBF = {getMidpointX('boyfriend') - 100 - getProperty('boyfriend.cameraPosition[0]'), getMidpointY('boyfriend') - 100 + getProperty('boyfriend.cameraPosition[1]')}

local dadZoom = getProperty('defaultCamZoom')
local bfZoom = getProperty('defaultCamZoom')

function onSectionHit(focus)
	if not mustHitSection then
		campointx = posValDad[1]
		campointy = posValDad[2]
		bfturn = false
		camlock = false
		setProperty('cameraSpeed', 1)
		setProperty('defaultCamZoom', dadZoom)	
	else
		campointx = posValBF[1]
		campointy = posValBF[2]
		bfturn = true
		camlock = false
		setProperty('cameraSpeed', 1)
		setProperty('defaultCamZoom', bfZoom)
	end
	camlockx = campointx
	camlocky = campointy
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if camon == true then
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

function onTimerCompleted(tag, loops, loopsLeft)
	if camon == true then
	if tag == 'camreset' then
	camlock = false
	setProperty('cameraSpeed', 1)
	setProperty('camFollow.x', campointx)
	setProperty('camFollow.y', campointy)
	end
end
end

function onUpdate()
	setProperty('camFollow.x', camlockx)
	setProperty('camFollow.y', camlocky)
end

function onEvent(n,v1,v2)
	if n == 'Set Cam Pos' then
		if v2 == 'bf' then
			local pos = stringSplit(v1, ", ")
			posValBF = {pos[1], pos[2]}
		end
		if v2 == 'dad' then
			local pos = stringSplit(v1, ", ")
			posValDad = {pos[1], pos[2]}
		end
	end
	if n == 'Set Cam Zoom' then
		if v2 == '' then
			dadZoom = tonumber(v1)
			bfZoom = tonumber(v1)
		end
		if v2 == 'dad' then
			dadZoom = tonumber(v1)
		end
		if v2 == 'bf' then
			bfZoom = tonumber(v1)
		end
	end
end