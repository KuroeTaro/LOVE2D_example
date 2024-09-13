function draw(camera,object,Image)
    local scale = 1
    local coodRes = {0,0}
    scale = 800/(object[3]-camera[3])
    coodRes = {scale*(object[1]-camera[1])+800-scale/2*(object[4]),scale*(object[2]-camera[2])+450-scale/2*(object[5])}
    print(coodRes[1],coodRes[2])
    love.graphics.draw(Image,coodRes[1],coodRes[2],0,scale,scale)
end
function love.load()
    alpha = love.graphics.newImage("LoadingText.png")
    -- x y z
    camera = {900,275,-500}
    -- x y z 图片宽度和高度
    af0 = {800,450,1000,97,18}
    af1 = {800,50,20,97,18}
    af2 = {1100,50,0,97,18}
    af3 = {1500,700,550,97,18}
    af4 = {1700,50,620,97,18}
    af5 = {800,50,100,97,18}
end
function love.update()
    require("lovebird").update()
end
function love.draw()
    draw(camera,af0,alpha)
    draw(camera,af2,alpha)
    draw(camera,af3,alpha)
    draw(camera,af4,alpha)
    draw(camera,af5,alpha)
    draw(camera,af1,alpha)
end