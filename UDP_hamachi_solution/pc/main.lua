local socket = require "socket"
local remote_ip = "25.0.170.53"
local local_ip = "25.51.137.112"
remote_udp = socket.udp()
local_udp = socket.udp()
remote_udp:setpeername(remote_ip, 28960)
local_udp:setsockname(local_ip, 28961)
remote_udp:settimeout(0)
local_udp:settimeout(0)

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
	greenX, greenY = love.mouse.getPosition()
	remote_udp:send(tostring(greenX)..'-'..tostring(greenY))
	data = local_udp:receive()
	while data ~= nil do
		last_data = data
		data = local_udp:receive()
	end
	if last_data then
		local p = split(last_data, '-')
		redX, redY = p[1], p[2]
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
