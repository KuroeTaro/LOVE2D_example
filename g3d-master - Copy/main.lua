-- written by groverbuger for g3d
-- september 2021
-- MIT license

local g3d = require "g3d"
local stair = g3d.newModel("assets/stair.obj", "assets/1.png", {0,0,0})
local ground = g3d.newModel("assets/ground.obj", "assets/1.png", {0,0,0})
local wall = g3d.newModel("assets/wall.obj", "assets/2.png", {0,0,0})

function love.update(dt)
    require("lovebird").update()
    g3d.camera.position = {0,0,-800}
    -- g3d.camera.firstPersonMovement(dt)
    if love.keyboard.isDown "escape" then
        love.event.push "quit"
    end
end

function love.draw()
    stair:draw()
    ground:draw()
    wall:draw()
	local stats = love.graphics.getStats()
	-- 显示统计信息
	love.graphics.print("Draw Calls: " .. stats.drawcalls, 250, 150)
	love.graphics.print("Canvas Switches: " .. stats.canvasswitches, 250, 30)
	love.graphics.print("Texture Memory: " .. stats.texturememory / 1024 / 1024 .. " MB", 250, 50)
	love.graphics.print("Images Loaded: " .. stats.images, 250, 70)
end