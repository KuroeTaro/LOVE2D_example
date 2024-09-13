require "love.filesystem"
require "love.image"
local imageData = {}
imageData[1] = love.image.newImageData("asset/noiseTest.png")
imageData[2] = love.image.newImageData("asset/0.png")
love.thread.getChannel( 'image' ):push( imageData )