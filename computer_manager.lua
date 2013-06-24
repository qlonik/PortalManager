-- Requirements for this project:
-- 	Advanced computer
-- 	Advanced monitors with size 8 blocks horizontal and 4 vertical

os.unloadAPI("buttons")
os.loadAPI("buttons")

local monitor = peripheral.wrap("right")
buttons.setDefaultOutput(monitor)
local monitorWidth, monitorHeight = monitor.getSize()

local modemSide = "top"
local bookManager
local books = {
	["nether"] = 1,
	["theEnd"] = 2,
	["mining"] = 3
}

local running = true
local heading = "Portals"
local allButtons = {}

local defaultTextColor = colors.white
local defaultBgColor = colors.red
local defaultBgPressedColor = colors.lime

findBookManager = function()
	rednet.broadcast("portal_screen_manager")

	local senderID, message, distance
	while message ~= "portal_book_manager" do
		senderID, message, distance = rednet.receive()
		bookManager = senderID
	end
end

draw = function()
	buttons.draw()
	monitor.setCursorPos(math.floor((monitorWidth - #heading) / 2), 1)
	monitor.write(heading)
end

openPortal = function(world)
	message = textutils.serialize({["command"] = "open", ["slot"] = books[world] - 1})
	rednet.send(bookManager, message)
	sleep(0.1)
end

closePortal = function(world)
	message = textutils.serialize({["command"] = "close", ["slot"] = books[world] - 1})
	rednet.send(bookManager, message)
	sleep(0.1)
end

exit = function()
	running = false
end

netherBtn = function()
	openPortal("nether")
	buttons.setColor(allButtons.nether, defaultTextColor, defaultBgPressedColor)
	draw()

	sleep(7)

	closePortal("nether")
	buttons.setColor(allButtons.nether, defaultTextColor, defaultBgColor)
	draw()
end

endBtn = function()
	openPortal("theEnd")
	buttons.setColor(allButtons.theEnd, defaultTextColor, defaultBgPressedColor)
	draw()

	sleep(7)

	closePortal("theEnd")
	buttons.setColor(allButtons.theEnd, defaultTextColor, defaultBgColor)
	draw()
end

miningBtn = function()
	openPortal("mining")
	buttons.setColor(allButtons.mining, defaultTextColor, defaultBgPressedColor)
	draw()

	sleep(7)

	closePortal("mining")
	buttons.setColor(allButtons.mining, defaultTextColor, defaultBgColor)
	draw()
end

--allButtons.exit = buttons.register(74, 23, 8, 3, defaultTextColor, colors.gray, "exit", exit)

allButtons.nether = buttons.register(3, 3, 10, 5, defaultTextColor, defaultBgColor, "Nether", netherBtn)
allButtons.theEnd = buttons.register(3, 9, 10, 5, defaultTextColor, defaultBgColor, "End", endBtn)
allButtons.mining = buttons.register(3, 15, 10, 5, defaultTextColor, defaultBgColor, "Mining", miningBtn) 
--allButtons.btn1 = buttons.register(3, 21, 10, 5, defaultTextColor, defaultBgColor, "Btn1", exit) 

--allButtons.btn2 = buttons.register(16, 3, 10, 5, defaultTextColor, defaultBgColor, "Btn2", exit)

rednet.open(modemSide)
findBookManager()
draw()
while running do 
	local eventArray = {os.pullEvent()}
	buttons.event(eventArray)
	draw()
end

rednet.close(modemSide)
monitor.clear()
os.unloadAPI("buttons")
