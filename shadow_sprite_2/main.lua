local image
local shadowCanvas, blurCanvas
local blurShaderH, blurShaderV

function love.load()
    image = love.graphics.newImage("0.png")
    local w, h = image:getWidth(), image:getHeight()

    shadowCanvas = love.graphics.newCanvas(w, h)
    blurCanvas   = love.graphics.newCanvas(w, h)

    -- 加载 shader
    blurShaderH = love.graphics.newShader("blurh.glsl")
    blurShaderV = love.graphics.newShader("blurv.glsl")

    blurShaderH:send("radius", 10)
    blurShaderV:send("radius", 10)
end

function drawShadowToCanvas()
    love.graphics.setCanvas(shadowCanvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.draw(image, 10, 10) -- 阴影偏移
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas()
end

function applyBlur()
    -- 横向模糊
    love.graphics.setCanvas(blurCanvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setShader(blurShaderH)
    love.graphics.draw(shadowCanvas)
    love.graphics.setShader()
    love.graphics.setCanvas()

    -- 纵向模糊
    love.graphics.setCanvas(shadowCanvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setShader(blurShaderV)
    love.graphics.draw(blurCanvas)
    love.graphics.setShader()
    love.graphics.setCanvas()
end

function love.draw()
    love.graphics.clear(1,1,1,1)
    drawShadowToCanvas()
    applyBlur()

    -- 绘制阴影
    love.graphics.draw(shadowCanvas, 100, 100)

    -- 绘制原始图像
    love.graphics.draw(image, 100, 100)
end
