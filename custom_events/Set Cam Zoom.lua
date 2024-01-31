function onEvent(n,v1,v2)
    if n == 'Set Cam Zoom' then
        setProperty('defaultCamZoom', tonumber(v1))
    end
end