-- Define the shader code
-- bunny = love.graphics.newImage("el.jpg")
-- love.graphics.draw(bunny)
-- Define the shader code
local shaderCode = [[
    extern vec2 iMouse;

    const int nsamples = 10;

    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
    {
        vec2 a;
        a.x = 198;
        a.y = 147;
        vec2 center = iMouse.xy / a.xy;
        float blurStart = 1.0;
        float blurWidth = 0.1;

        vec2 uv = texture_coords.xy;
        uv -= center;
        float precompute = blurWidth * (1.0 / float(nsamples - 1));

        vec4 finalColor = vec4(0.0);
        for (int i = 0; i < nsamples; i++)
        {
            float scale = blurStart + (float(i) * precompute);
            finalColor += Texel(texture, uv * scale + center);
        }

        finalColor /= float(nsamples);

        return finalColor;
    }
]]

function love.load()
    -- Load an example texture (replace this with your own texture)
    texture = love.graphics.newImage("el.jpg")

    -- Create a canvas to apply the shader
    canvas = love.graphics.newCanvas()

    -- Load the shader
    shader = love.graphics.newShader(shaderCode)

    -- Set the canvas as the target for drawing
    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    love.graphics.setCanvas()
end

function love.draw()
    -- Apply the shader
    -- shader:send("iResolution", { love.graphics.getWidth(), love.graphics.getHeight() })
    shader:send("iMouse", { love.mouse.getX(), love.mouse.getY() })
    love.graphics.setShader(shader)

    -- Draw something on the canvas (replace this with your own drawing logic)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(texture, 0, 0)  -- Draw the texture, not a rectangle

    -- Reset shader and canvas
    love.graphics.setShader()
end
