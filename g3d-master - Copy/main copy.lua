-- written by groverbuger for g3d
-- september 2021
-- MIT license

local g3d = require "g3d"
local earth = g3d.newModel("assets/sphere.obj", "assets/earth.png", {4,0,0})
local moon = g3d.newModel("assets/sphere.obj", "assets/moon.png", {4,5,0}, nil, 0.5)
local background = g3d.newModel("assets/sphere.obj", "assets/starfield.png", nil, nil, 500)
local timer = 0

function love.update(dt)
    require("lovebird").update()
    timer = timer + dt
    moon:setTranslation(math.cos(timer)*5 + 4, math.sin(timer)*5, 0)
    moon:setRotation(0, 0, timer - math.pi/2)
    g3d.camera.firstPersonMovement(dt)
    if love.keyboard.isDown "escape" then
        love.event.push "quit"
    end
end

function love.draw()
    earth:draw()
    moon:draw()
    background:draw()
    	-- 获取统计信息
	local stats = love.graphics.getStats()
	-- 显示统计信息
	love.graphics.print("Draw Calls: " .. stats.drawcalls, 250, 150)
	love.graphics.print("Canvas Switches: " .. stats.canvasswitches, 250, 30)
	love.graphics.print("Texture Memory: " .. stats.texturememory / 1024 / 1024 .. " MB", 250, 50)
	love.graphics.print("Images Loaded: " .. stats.images, 250, 70)
end

function love.mousemoved(x,y, dx,dy)
    g3d.camera.firstPersonLook(dx,dy)
end
