function love.load()
    a = 0
    b = 1
    c = 2
end

function love.update(dt)
    a,b,c = test(a,b,c)
end

function love.draw()
    love.graphics.print(tostring(a),0,0)
    love.graphics.print(tostring(b),0,10)
    love.graphics.print(tostring(c),0,20)
end

function test(a,b,c)
    a = 1
    b = 2
    c = 3
    return a,b,c
end