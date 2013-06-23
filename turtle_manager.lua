--	Requirements for this project:
--		Wireless inventory turtle

local modemSide = "right"
local inv = peripheral.wrap("left")

local screenManager

local running = true

findScreenManager = function()
	local senderID, message, distance
	while message ~= "portal_screen_manager" do
		senderID, message, distance = rednet.receive()
		screenManager = senderID
	end

	rednet.send(screenManager, "portal_book_manager")
end

openPortal = function(slot)
	turtle.select(1)
	inv.suck(slot, 1)
	turtle.dropUp()
end

closePortal = function(slot)
	turtle.select(1)
	turtle.suckUp()
	inv.drop(slot, 1)
end

rednet.open(modemSide)
findScreenManager()

while running do
	local senderID, message, distance = rednet.receive()
	command = textutils.unserialize(message)

	if command["command"] == "open" then
		openPortal(command["slot"])
	elseif command["command"] == "close" then
		closePortal(command["slot"])
	end
end

rednet.close(modemSide)
