function love.load()
    -- Load the shader from file
    local shaderCode = love.filesystem.read("shadow_shader.glsl")
    shader = love.graphics.newShader(shaderCode)

    -- Load the textures
    iChannel0 = love.graphics.newImage("texture0.png")
    iChannel1 = love.graphics.newImage("texture1.png")

    -- Set shader variables
    shader:send("iResolution", {love.graphics.getWidth(), love.graphics.getHeight()})
    shader:send("iChannel0", iChannel0)
    shader:send("iChannel1", iChannel1)
end

function love.update(dt)
    -- Update the shader time uniform (if needed)
end

function love.draw()
    love.graphics.setShader(shader)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setShader()
end
