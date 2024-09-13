function love.conf(t)
    local res = love.filesystem.read( 'configSave.lua',8 )
    if res then 
        local width = tonumber(string.sub(res, 1, 4))
        local height = tonumber(string.sub(res, 5, 8))
        t.window.width = width
        t.window.height = height
    else
        t.window.width = 1600
        t.window.height = 900
        love.filesystem.write('configSave.lua','16000900')
    end

    -- t.window.width = 1600
    -- t.window.height = 900
    t.window.vsync = 1
    t.modules.physics = false 
    t.modules.touch = false 
    t.modules.video = false
    t.modules.math = false
    t.modules.mouse = false
end