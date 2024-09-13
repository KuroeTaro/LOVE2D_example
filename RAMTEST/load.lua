function loadAssetFunction(threadAddress,loadFunction,OrderSize)
    if threadAddress ~= nil and loadFunction ~= nil and loadOnce == false then 
        -- run thread
        if threadOnce == false then 
            local thread = love.thread.newThread(threadAddress)
            thread:start()
            threadOnce = true
        end
        -- pop image data
        if assetData == nil then 
            assetData = love.thread.getChannel('image'):pop()
        end
        -- load asset data to variables
        if assetData ~= nil then
            loadFunction(loadOrder)
            loadOrder = loadOrder + 1
            if loadOrder > OrderSize then 
                loadOrder = 0
                loadOnce = true
            end
        end
    elseif threadAddress == nil and loadFunction ~= nil and loadOnce == false then 
        loadFunction()
        loadOrder = 0
        loadOnce = true
    end
end