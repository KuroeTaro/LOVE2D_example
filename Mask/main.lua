
-- a black/white mask image: black pixels will mask, white pixels will pass.
local fg = love.graphics.newImage("ANRI.png")
local mask = love.graphics.newImage("LeftCover.png")

-- In the Circle.png image, the circle is at 570, 370 with a size of 460x460.
function love.update(dt)

end

function love.draw()

  local res = love.graphics.newCanvas(1650, 455)

  love.graphics.setCanvas(res)
  love.graphics.draw(fg)
  love.graphics.setBlendMode('multiply', 'premultiplied')
  love.graphics.draw(mask,-100)
  love.graphics.setBlendMode('alpha', 'alphamultiply')
  love.graphics.setCanvas()

  love.graphics.draw(res,0,0,0,0.5,0.5)
end

function love.keypressed(k)
  return k == "escape" and love.event.quit()
end
