local image
local imageData
local contour = {}
local simplifiedContour = {}

function love.load()
    image = love.graphics.newImage("0.png")
    imageData = love.image.newImageData("0.png")
    local w, h = imageData:getDimensions()

    -- 阈值法提取二值图
    local alphaMask = {}
    for y = 1, h do
        alphaMask[y] = {}
        for x = 1, w do
            local _, _, _, a = imageData:getPixel(x - 1, y - 1)
            alphaMask[y][x] = (a > 0.1) and 1 or 0
        end
    end

    -- 执行 marching squares 轮廓提取
    contour = marchingSquares(alphaMask, w, h)

    -- 简化多边形轮廓（可选）
    simplifiedContour = simplifyPolygon(contour, 2)
end

function love.draw()
    love.graphics.clear(1, 1, 1)
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(image, 100, 100)

    -- 绘制阴影（偏移 + 半透明）
    drawShadow(simplifiedContour, 100, 100, 20, 20)

    -- 轮廓线可视化（调试用）
    love.graphics.setColor(1, 0, 0)
    for _, p in ipairs(simplifiedContour) do
        love.graphics.circle("fill", 100 + p[1], 100 + p[2], 2)
    end
end

function drawShadow(points, ox, oy, dx, dy)
    if #points < 3 then return end

    local vertices = {}
    for _, p in ipairs(points) do
        table.insert(vertices, ox + p[1] + dx)
        table.insert(vertices, oy + p[2] + dy)
    end

    love.graphics.setColor(0, 0, 0, 0.3)
    love.graphics.polygon("fill", vertices)
end

-- 简化轮廓点（去除距离太近的点）
function simplifyPolygon(points, tolerance)
    local result = {}
    local last = nil
    for _, p in ipairs(points) do
        if not last or distance(p, last) > tolerance then
            table.insert(result, p)
            last = p
        end
    end
    return result
end

function distance(a, b)
    local dx = a[1] - b[1]
    local dy = a[2] - b[2]
    return math.sqrt(dx * dx + dy * dy)
end

-- Marching Squares 实现
function marchingSquares(grid, w, h)
    local result = {}
    for y = 1, h - 1 do
        for x = 1, w - 1 do
            local tl = grid[y][x]
            local tr = grid[y][x + 1]
            local br = grid[y + 1][x + 1]
            local bl = grid[y + 1][x]

            local state = tl * 8 + tr * 4 + br * 2 + bl * 1

            -- 每种 case 添加线段中点（我们简单中点连接）
            local cx, cy = x - 0.5, y - 0.5
            local unit = 1

            if state == 1 or state == 14 then
                table.insert(result, {cx, cy + unit})
            elseif state == 2 or state == 13 then
                table.insert(result, {cx + unit, cy + unit})
            elseif state == 4 or state == 11 then
                table.insert(result, {cx + unit, cy})
            elseif state == 8 or state == 7 then
                table.insert(result, {cx, cy})
            elseif state == 3 or state == 12 then
                table.insert(result, {cx + 0.5 * unit, cy + unit})
            elseif state == 6 or state == 9 then
                table.insert(result, {cx + unit, cy + 0.5 * unit})
            elseif state == 5 or state == 10 then
                table.insert(result, {cx + 0.5 * unit, cy})
                table.insert(result, {cx + 0.5 * unit, cy + unit})
            end
        end
    end
    return result
end
