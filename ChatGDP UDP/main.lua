-- main.lua
local socket = require("socket")
local udp

function love.load()
    -- Initialize UDP socket
    udp = socket.udp()
    udp:settimeout(0)
    udp:setpeername("76.180.69.89", 12345) -- Replace with the destination computer's IP address and port

    -- Start sending a message
    udp:send("Hello from source_computer!")
end

function love.update(dt)
    -- Receive messages
    repeat
        local data, msg = udp:receive()
        if data then
            print("Received: " .. data)
        elseif msg ~= "timeout" then
            print("Error: " .. msg)
        end
    until not data
end
