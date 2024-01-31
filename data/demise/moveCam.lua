--[[
	Base Script by Teniente Mantequilla#0139
	Modified by Meloomazy for MMv2 Port :scream:
]]--

setProperty('isCameraOnForcedPos', true)

local campointx = getProperty('gf.x')
local campointy = getProperty('gf.y')
local camlockx = campointx
local camlocky = campointy
local camlock = true
local bfturn = false
local camon = true

local posValDad = {1220, 0}
local posValBF = {380, 350}
local posValGF = {380, 350}
local dadMove = 60
local bfMove = 60
local dadZoom = 0.4
local bfZoom = 0.6

setVar('posValDad', posValDad)
setVar('posValBF', posValBF)
setVar('posValGF', posValGF)

setVar('dadMove', dadMove)
setVar('bfMove', bfMove)
setVar('dadZoom', dadZoom)
setVar('bfZoom', bfZoom)

setVar('camMove', true)

function onMoveCameraa()
    if getVar('camMove') then
		if not mustHitSection then
            campointx = getVar('posValDad')[1]
			campointy = getVar('posValDad')[2]
		end
	end
end
function onSectionHit()
	if getVar('camMove') then
		if not mustHitSection then
			bfturn = false
			setProperty('defaultCamZoom', getVar('dadZoom'))
		else
			bfturn = true
			setProperty('defaultCamZoom', getVar('bfZoom'))
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if bfturn then
        if noteType == 'GF Sing' then
            campointx = getVar('posValGF')[1]
            campointy = getVar('posValGF')[2]    
        else
            campointx = getVar('posValBF')[1]
            campointy = getVar('posValBF')[2]
        end
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
        if noteType == 'GF Sing' then
            campointx = getVar('posValGF')[1]
            campointy = getVar('posValGF')[2]    
        else
            campointx = getVar('posValDad')[1]
            campointy = getVar('posValDad')[2]
        end
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