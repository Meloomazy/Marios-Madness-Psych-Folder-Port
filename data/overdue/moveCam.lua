--[[
	Base Script by Teniente Mantequilla#0139
	Modified by Meloomazy for MMv2 Port :scream:
]]--

setProperty('isCameraOnForcedPos', true)

local posValDad = {-80, 450}
local posValBF = {900, 550}
local posValGF = {550, 250}
local dadMove = 30
local bfMove = 30
local dadZoom = 0.5
local bfZoom = 0.6

local campointx = posValDad[1]
local campointy = posValDad[2]
local camlockx = campointx
local camlocky = campointy
local camlock = true
local bfturn = false
local camon = true

setVar('posValDad', posValDad)
setVar('posValBF', posValBF)
setVar('posValGF', posValGF)

setVar('dadMove', dadMove)
setVar('bfMove', bfMove)
setVar('dadZoom', dadZoom)
setVar('bfZoom', bfZoom)

setVar('camMove', true)
setVar('camMoveZoom', true)

local isGF = false
function onSectionHit()
	if getVar('camMove') then
		if not mustHitSection then
			bfturn = false
			if isGF then 
				campointx = getVar('posValGF')[1]
				campointy = getVar('posValGF')[2]    
			else
				campointx = getVar('posValDad')[1]
				campointy = getVar('posValDad')[2]
			end	
            if getVar('camMoveZoom') then setProperty('defaultCamZoom', getVar('dadZoom')) end
		else
			if isGF then 
				campointx = getVar('posValGF')[1]
				campointy = getVar('posValGF')[2]    
			else
				campointx = getVar('posValBF')[1]
				campointy = getVar('posValBF')[2]
			end	
			bfturn = true
			if getVar('camMoveZoom') then setProperty('defaultCamZoom', getVar('bfZoom')) end
		end
		camlockx = campointx
		camlocky = campointy
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if bfturn then
		isGF = (noteType == 'GF Sing')
		if direction == 0 then
			camlockx = campointx - getVar('bfMove')
			camlocky = campointy
		elseif direction == 1 then
			camlocky = campointy + getVar('bfMove')
			camlockx = campointx
		elseif direction == 2 then
			camlocky = campointy - getVar('bfMove')
			camlockx = campointx
		elseif direction == 3 then
			camlockx = campointx + getVar('bfMove')
			camlocky = campointy
		end
        runTimer('camreset', 1)
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if not bfturn then
		isGF = (noteType == 'GF Sing')
		if direction == 0 then
			camlockx = campointx - getVar('dadMove')
			camlocky = campointy
		elseif direction == 1 then
			camlocky = campointy + getVar('dadMove')
			camlockx = campointx
		elseif direction == 2 then
			camlocky = campointy - getVar('dadMove')
			camlockx = campointx
		elseif direction == 3 then
			camlockx = campointx + getVar('dadMove')
			camlocky = campointy
		end
        runTimer('camreset', 1)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if getVar('camMove') then
		if tag == 'camreset' then
		setProperty('camFollow.x', campointx)
		setProperty('camFollow.y', campointy)
		end
	end
end

function onUpdate()
	if getVar('camMove') then
		setProperty('camFollow.x', camlockx)
		setProperty('camFollow.y', camlocky)
	end
end

function onEvent(n,v1,v2)
	if n == 'Set Cam Pos' then
		if v2 == 'bf' then
			local pos = stringSplit(v1, ", ")
            setVar('posValBF', {pos[1], pos[2]})
		end
		if v2 == 'dad' then
			local pos = stringSplit(v1, ", ")
			setVar('posValDad', {pos[1], pos[2]})
		end
	end
	if n == 'Set Cam Zoom' then
        if v2 == '' then
            setVar('dadZoom', tonumber(v1))
            setVar('bfZoom', tonumber(v1))
        end
		if v2 == 'dad' then
            setVar('dadZoom', tonumber(v1))
		end
		if v2 == 'bf' then
            setVar('bfZoom', tonumber(v1))
		end
	end
end