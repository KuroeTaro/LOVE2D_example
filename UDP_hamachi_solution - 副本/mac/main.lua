local socket = require "socket"
local local_ip = "25.0.170.53" -- halocalhi虚拟IP地址1
local remote_ip = "25.51.137.112" -- halocalhi虚拟IP地址2
local_udp = socket.udp()
remote_udp = socket.udp()
local_udp:setsockname(local_ip, 28960)
remote_udp:setpeername(remote_ip, 28961)
local_udp:settimeout(0)
remote_udp:settimeout(0)

time = 0

local greenX, greenY = '100', '100'
local redX, redY = '400', '100'

function love.draw()
	love.graphics.setColor(0, 1, 0)
	love.graphics.rectangle("fill", greenX, greenY, 50, 50)

	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle("fill", redX, redY, 50, 50)

end

function love.update(dt)
	redX, redY = love.mouse.getPosition()
	remote_udp:send(tostring(redX)..'-'..tostring(redY))
	data = local_udp:receive()
	while data ~= nil do
		last_data = data
		data = local_udp:receive()
	end
	if last_data then
		local p = split(last_data, '-')
		greenX, greenY = p[1], p[2]
		print(last_data)
	end
end

function split(s, delimiter)
	result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end
