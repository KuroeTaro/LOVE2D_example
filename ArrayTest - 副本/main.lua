function love.load()
    frameTimer = 0
    a = 0
    collectgarbage("stop")
end
function love.update(dt)
  a = a + 1
  a = a*a
end
function love.draw()

end
