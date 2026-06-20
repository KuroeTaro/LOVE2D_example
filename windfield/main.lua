local wf = require("libs/windfield")

objects = {}

function love.load()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.15)

    -- 创建物理世界
    world = wf.newWorld(0, 0, true)  -- 重力向下

    -- 增加碰撞类别
    world:addCollisionClass('Ground')
    world:addCollisionClass('Player')

    -- 创建地面
    objects.ground = world:newRectangleCollider(0, 365.47, 800, 10)
    objects.ground:setType('static')
    objects.ground:setCollisionClass('Ground')
    objects.ground:setRestitution(0)

    objects.s = world:newRectangleCollider(100, 200, 20, 150)
    objects.s:setType('static')
    objects.s:setCollisionClass('Ground')
    objects.s:setRestitution(0)

    -- 创建玩家（一个动态矩形）
    local collider = nil
    collider = world:newRectangleCollider(400, 300, 40, 30)
    collider:setCollisionClass('Player')
    collider:setRestitution(0)
    collider:setFixedRotation(true)
    collider:setFriction(0)
    collider:setBullet(true)
    collider:setMass(5.0)
    objects.player = collider

    -- 创建一个圆形刚体
    local collider = nil
    collider = world:newCircleCollider(200, 0, 20)
    collider:setRestitution(0)
    collider:setFixedRotation(true)
    collider:setFriction(0)
    collider:setBullet(true) 
    collider:setMass(5.0)
    objects.ball = collider
end

function love.update(dt)
    require("lovebird").update()
    world:update(1)
    world:update(1)
    world:update(1)
    world:update(1)
    world:update(1)
    world:update(1)
    world:update(1)
    world:update(1)
    world:update(1)
    world:update(1)
    local px, py = objects.player:getLinearVelocity()
    objects.player:setLinearVelocity(px, 0)
    if objects.player:enter("Ground") or objects.player:stay("Ground") then
        objects.player:setPosition(420, 355)
    end
    print(objects.player:getPosition())

    local px, py = objects.player:getLinearVelocity()
    local speed = 1

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        objects.player:setLinearVelocity(-speed, py)
    elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        objects.player:setLinearVelocity(speed, py)
    end

    local px, py = objects.player:getLinearVelocity()
    -- 跳跃
    if love.keyboard.isDown("space") then
        objects.player:setLinearVelocity(px, 10)
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    world:draw() -- Windfield 内置调试渲染器
end
