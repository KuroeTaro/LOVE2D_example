require "love.filesystem"
require "love.image"
local imageData = {}
for i = 0,1319 do
    imageData[i] = love.image.newCompressedData("izyIdle_2BC7/"..i..".dds")
end
love.thread.getChannel( 'image' ):push( imageData )