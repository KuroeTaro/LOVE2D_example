function love.load()
    frameTimer = 0
    a = 0
    a1 = love.graphics.newImage("0.png")
end
function love.update(dt)
-- This is a different example code because touching the default love.run is not necessary (in the no vsync scenario), and mine is a bit more specifically tailored... so this is a bit more minimal.
local tickPeriod = 1/60-- seconds per tick
local accumulator = 0.0
function love.update(dt)
  accumulator = accumulator + dt
  if accumulator >= tickPeriod then
    -- Here be your fixed timestep.
    acumulator = accumulator - tickPeriod
  end
end
-- love.draw's case is more complex.
end
function love.draw()
    love.graphics.clear(7/255,19/255,31/255,1)
    love.graphics.print( a, 1550, 0)
    love.graphics.draw(a1)
    
end
