require("input")
require("assetload")

local tick = require 'tick'

function love.load()
	inputLoad()
	assetLoad()
	gft = 0
	tick.framerate = 60
	a1 = love.graphics.newImage("0.png")
	a2 = love.graphics.newImage("1.png")
	a3 = love.graphics.newImage("2.png")
end

function love.update(dt)
	inputUpdate(dt)
	gft = gft + 1
	fps = love.timer.getFPS( )
end

function love.draw()
	love.graphics.print(tostring(x),0,40)
	love.graphics.draw(a1)
	love.graphics.draw(a2)
	love.graphics.draw(a3)
	love.graphics.draw(a3)
	love.graphics.draw(a3)
	love.graphics.print( gft, 1550, 0)
    love.graphics.print( fps, 1550, 20)
	for i = 1,14 do
		love.graphics.print(tostring(currentCommand1P[commandList[i]]),70*i-70,0)
		love.graphics.print(tostring(commandState1P[commandList[i]]),70*i-70,10)
    end
	for i = 1,14 do
		love.graphics.print(tostring(currentCommand2P[commandList[i]]),70*i-70,20)
		love.graphics.print(tostring(commandState2P[commandList[i]]),70*i-70,30)
    end
end