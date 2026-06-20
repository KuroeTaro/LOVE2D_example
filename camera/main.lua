function draw(camera,object,Image)
    local scale = 1
    local coodRes = {0,0}
    scale = 800/(object[3]-camera[3])
    if object[6] == -1 then
        coodRes = {
            scale*(object[1]-camera[1])+800, 
            scale*(object[2]-camera[2])+450
        }
        love.graphics.draw(Image,coodRes[1],coodRes[2],0,-scale,scale)
    else
        coodRes = {
            scale*(object[1]-camera[1])+800, 
            scale*(object[2]-camera[2])+450
        }
        love.graphics.draw(Image,coodRes[1],coodRes[2],0,scale,scale)
    end
end
function love.load()
    alpha = love.graphics.newImage("LoadingText.png")
    -- x y z
    camera = {900,275,-500}
    -- x y z 图片宽度和高度
    local sx = 1
    af0 = {800,450,1000,97,18,sx}
    af1 = {800,50,20,97,18,sx}
    af2 = {1100,50,0,97,18,sx}
    af3 = {1500,700,550,97,18,sx}
    af4 = {1700,50,620,97,18,sx}
    af5 = {800,50,100,97,18,sx}
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