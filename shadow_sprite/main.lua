function love.load()
    love.graphics.setDefaultFilter("linear", "linear")

    image = love.graphics.newImage("0.png")
    imageWidth = image:getWidth()
    imageHeight = image:getHeight()

    -- 用于绘制阴影的全屏 Canvas
    shadowCanvas = love.graphics.newCanvas(1600, 1600)
    alphaCanvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())

    shadowShader = love.graphics.newShader([[
        extern vec2 direction;
        extern number steps;
        extern number shadowAlpha;

        vec4 effect(vec4 color, Image texture, vec2 texCoord, vec2 screenCoord) {
            vec4 sum = vec4(0.0);
            for (int i = 1; i < int(steps); i++) {
                vec2 offset = direction * float(i) * 1;
                vec4 sample = Texel(texture, texCoord + offset);
                sum += vec4(0.0, 0.0, 0.0, sample.a * shadowAlpha * (1.0 - (float(i) / float(steps))));
            }
            return sum * color;
        }
    ]])

    shadowShader:send("steps", 100)
    shadowShader:send("shadowAlpha", 0.04)

    -- 图片位置
    imageX, imageY = 200, 150
end

function love.update(dt)
    -- 动态计算光照方向（由图片中心指向鼠标）
    local mx, my = love.mouse.getPosition()
    local cx = imageX + imageWidth / 2
    local cy = imageY + imageHeight / 2
    local dx, dy = mx - cx, my - cy
    local len = math.sqrt(dx * dx + dy * dy)
    if len > 0 then
        dx = dx / len
        dy = dy / len
    end
    shadowShader:send("direction", {dx * 0.002, dy * 0.002})
end

function love.draw()
    -- 用 canvas 绘制阴影（带白色背景）
    love.graphics.clear(1, 1, 1, 1) -- 白色背景

    love.graphics.setCanvas(alphaCanvas)
    love.graphics.clear(0, 0, 0, 0) -- 白色背景
    love.graphics.setCanvas()






    
    local mx, my = love.mouse.getPosition()
    local cx = imageX + imageWidth / 2
    local cy = imageY + imageHeight / 2
    local dx, dy = mx - cx, my - cy
    local len = math.sqrt(dx * dx + dy * dy)
    if len > 0 then
        dx = dx / len
        dy = dy / len
    end
    shadowShader:send("direction", {dx * 0.002, dy * 0.002})

    love.graphics.setCanvas(shadowCanvas)
    love.graphics.clear(0, 0, 0, 0) -- 白色背景
    love.graphics.draw(image, imageX, imageY)
    love.graphics.setCanvas()

    -- 绘制 shadow canvas 到屏幕
    love.graphics.setCanvas(alphaCanvas)
    love.graphics.setShader(shadowShader)
    love.graphics.draw(shadowCanvas, 0, 0)
    love.graphics.setShader()
    love.graphics.setCanvas()





    local mx, my = love.mouse.getPosition()
    local cx = (imageX+800) + imageWidth / 2
    local cy = imageY + imageHeight / 2
    local dx, dy = mx - cx, my - cy
    local len = math.sqrt(dx * dx + dy * dy)
    if len > 0 then
        dx = dx / len
        dy = dy / len
    end
    shadowShader:send("direction", {dx * 0.002, dy * 0.002})

    -- 绘制 shadow canvas 到屏幕
    love.graphics.setCanvas(shadowCanvas)
    love.graphics.clear(0, 0, 0, 0) -- 白色背景
    love.graphics.draw(image, imageX+800, imageY)
    love.graphics.setCanvas()

    -- 绘制 shadow canvas 到屏幕
    love.graphics.setCanvas(alphaCanvas)
    love.graphics.setShader(shadowShader)
    love.graphics.draw(shadowCanvas, 0, 0)
    love.graphics.setShader()
    love.graphics.setCanvas()








    love.graphics.setColor(1,1,1,0.75)
    love.graphics.draw(alphaCanvas)
    love.graphics.setColor(1,1,1,1)


    -- 最后绘制原图（盖在阴影之上）
    love.graphics.draw(image, imageX, imageY)

    -- 可视化鼠标方向线（调试用）
    love.graphics.setColor(0, 0, 0, 0.3)
    local cx = imageX + imageWidth / 2
    local cy = imageY + imageHeight / 2
    local mx, my = love.mouse.getPosition()
    love.graphics.line(cx, cy, mx, my)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setColor(0,0,0,1)
    love.graphics.print( "GRAPHICIAL_FPS", 0, 255)
    FPS = love.timer.getFPS()
    love.graphics.print( FPS, 110, 255)
    love.graphics.setColor(1,1,1,1)
end