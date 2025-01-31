require "love.filesystem"
require "love.image"
local imageData = {}
local input = love.thread.getChannel("input"):pop()
imageData[1] = love.image.newImageData("asset/noiseTest.png")
imageData[2] = love.image.newImageData("asset/".. input ..".png")
love.thread.getChannel( 'image' ):push( imageData )