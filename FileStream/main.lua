function love.load()
    local chunk = love.filesystem.load( 'Save.lua' ) -- load the chunk
    local result = chunk() -- execute the chunk
    print('result: ' .. tostring(result)) -- prints 'result: 2'
    i = 30
    chunk = 
    [[ com = ]]..i..
    [[ com1 = "this is"]]
    love.filesystem.write('Save.lua',chunk)
    chunk = love.filesystem.load( 'Save.lua' ) -- load the chunk
    chunk() -- execute the chunk
    print('result: ' .. tostring(com))
    print(com1)
end