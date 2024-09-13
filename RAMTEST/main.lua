require("load")
qoi = require("qoi")

function love.load()
    threadOnce = false
    loadOnce = false
    loadOrder = 0

    love.graphics.setDefaultFilter('linear','nearest')
    
    local startTime = love.timer.getTime()
    playerImage = love.graphics.newImage("0.png")
    -- playerImage = qoi.load("artih-qahj6.qoi")
    local endTime = love.timer.getTime()
    local loadTime = endTime - startTime
    print("Image Load Time: " .. loadTime .. " seconds")

    eptFunction = function()
    
    end
end

-- function love.load()
--     love.graphics.setDefaultFilter('linear','nearest')

--     imageData = love.image.newImageData("0.png")
--     -- Encode the image data as PNG (you can also use "jpg" for JPEG format)
--     encodedData = imageData:encode("png")
--     imageData = nil
--     local startTime = love.timer.getTime()
--     image1 = love.graphics.newImage(encodedData)
--     -- playerImage = qoi.load("artih-qahj6.qoi")
--     local endTime = love.timer.getTime()
--     local loadTime = endTime - startTime
--     print("Compressed Image Load Time: " .. loadTime .. " seconds")

--     local startTime = love.timer.getTime()
--     image2 = love.graphics.newImage("0.dds")
--     -- playerImage = qoi.load("artih-qahj6.qoi")
--     local endTime = love.timer.getTime()
--     local loadTime = endTime - startTime
--     print("Image Load Time: " .. loadTime .. " seconds")

--     compressedDataString = encodedData:getString()
--     local compressedDataSize = #compressedDataString
--     print(string.format("Compressed image data size: %d bytes", compressedDataSize))
-- end


function love.update()
    if loadOnce == false then
        loadAssetFunction("thread.lua",eptFunction,1350)
    else
        print("Done")
    end
end

function love.draw()
    love.graphics.clear(0.2,0.2,0.2,1)
    love.graphics.draw(playerImage,0,0,0,2,2)
end