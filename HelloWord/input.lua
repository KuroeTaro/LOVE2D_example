function inputLoad()
    currentCommand1P = {}
    commandState1P = {}
    joystick1 = nil
    device1P = "keyboard"
    currentCommand2P = {}
    commandState2P = {}
    joystick2 = nil
    device2P = "nil"

    --加载手柄按键 键盘按键 手柄z轴 对于指令的表
    commandList = {"Up","Down","Left","Right","A","B","C","D","Csystem","Step","back","start",
    "Throw","OverDrive"}
    buttomList = {"dpup","dpdown","dpleft","dpright","x","y","b","a","leftshoulder","rightshoulder",
    "back","start"}
    axisList = {"triggerleft","triggerright"}
    keyList = {"w","s","a","d","j","i","l","k","lshift","space","u","o","escape","escape"}
    
    for i=1,14 do
        commandState1P[commandList[i]] = "Released"
        commandState2P[commandList[i]] = "Released"
    end

    --初始化现指令数组
    for i = 1,14 do
        currentCommand1P[commandList[i]] = 0
        currentCommand2P[commandList[i]] = 0
    end

end

function inputUpdate(dt)

    --加载手柄
    updateController()

    --获得所有指令的现在布尔值和上一帧布尔值
    --并且赋值到currentCommand和perCommand
    getCurrentCommand(device1P,currentCommand1P,joystick1)
    getCurrentCommand(device2P,currentCommand2P,joystick2)

    --输入状态机
    inputStateMachine(commandState1P,currentCommand1P)
    inputStateMachine(commandState2P,currentCommand2P)
    
end

--将手柄按键的值转化为指令表内的数值
function joystickButtomCommand(js,ButtomName)
    if js ~= nil then
        result = js:isGamepadDown(ButtomName)
    else result = false end 
    return result 
end 

--将手柄扳机的值转化为指令表内的数值
function joystickAxisCommand(js,AxisName)
    if js ~= nil then 
        result = js:getGamepadAxis(AxisName)
    else result = 0.0 end
    return result
end 

--加载手柄
function updateController()
    local joysitcks = love.joystick.getJoysticks()
    if joysticks == nil then
        device1P = "keyboard"
        device2P = "nil"
    end
    if joysitcks[1] ~= nil then
        joystick1 = joysitcks[1]
        device1P = "controller"
        device2P = "keyboard"
    end
    if joysitcks[2] ~= nil then
        joystick2 = joysitcks[2]
        device1P = "controller"
        device2P = "controller"
    end
end

--获得所有指令的现在布尔值和上一帧布尔值（键盘）
function getCurrentCommand(device,currentCommand,joystick)
    --(键盘)
    if device == "keyboard" then
        for i = 1,14 do
            if love.keyboard.isDown(keyList[i]) then
                currentCommand[commandList[i]] = 1
            else currentCommand[commandList[i]] = 0
            end
        end
    end
    
    --(手柄)
    if device == "controller" then
        for i = 1,12 do
            if joystickButtomCommand(joystick,buttomList[i]) then
                currentCommand[commandList[i]] = 1
            else currentCommand[commandList[i]] = 0
            end
        end

        for i = 1,2 do
            if joystickAxisCommand(joystick,axisList[i]) > 0.2 then
                currentCommand[commandList[i+12]] = 1
            else currentCommand[commandList[i+12]] = 0
            end
        end
    end
end

--输入状态机
function inputStateMachine(commandState,currentCommand)

    for i=1,14 do
        local isUpdated = false
        if commandState[commandList[i]] == "Released"  and isUpdated == false then 
            if currentCommand[commandList[i]] == 1 then 
                commandState[commandList[i]] = "Pressing"
                isUpdated = true
            end
        end 

        if commandState[commandList[i]] == "Releasing"  and isUpdated == false then 
            if currentCommand[commandList[i]] == 1 then 
                commandState[commandList[i]] = "Pressing"
                isUpdated = true
            end
            if currentCommand[commandList[i]] == 0 then 
                commandState[commandList[i]] = "Released"
                isUpdated = true
            end
        end 

        if commandState[commandList[i]] == "Pressing"  and isUpdated == false then 
            if currentCommand[commandList[i]] == 1 then 
                commandState[commandList[i]] = "Holding"
                isUpdated = true
            end
            if currentCommand[commandList[i]] == 0 then 
                commandState[commandList[i]] = "Releasing"
                isUpdated = true
            end
        end 

        if commandState[commandList[i]] == "Holding"  and isUpdated == false then 
            if currentCommand[commandList[i]] == 0 then 
                commandState[commandList[i]] = "Releasing"
                isUpdated = true
            end
        end 
    end
end