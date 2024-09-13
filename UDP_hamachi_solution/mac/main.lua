local socket = require "socket"
local mac_ip = "25.0.170.53"
local pc_ip = "25.51.137.112"
mac_udp = socket.udp()
pc_udp = socket.udp()
mac_udp:setsockname(mac_ip, 28960)
pc_udp:setpeername(pc_ip, 28961)
mac_udp:settimeout(0)
pc_udp:settimeout(0)

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
	pc_udp:send(tostring(redX)..'-'..tostring(redY))
	data = mac_udp:receive()
	while data ~= nil do
		last_data = data
		data = mac_udp:receive()
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
