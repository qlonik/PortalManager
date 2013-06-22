os.unloadAPI("buttons")
os.loadAPI("buttons")

local running = true
local heading = "Portals"
local allButtons = {}

local monitor = peripheral.wrap("right")
buttons.setDefaultOutput(monitor)
local monitorWidth, monitorHeight = monitor.getSize()

exit = function()
	running = false
end

allButtons.exit = buttons.register(10, 10, 10, 3, colors.white, colors.gray, "exit", exit)


buttons.draw()
while running do 
	local eventArray = {os.pullEvent()}
	buttons.event(eventArray)
	buttons.draw()
	monitor.setCursorPos(math.floor((monitorWidth - #heading) / 2), 1)
	monitor.write(heading)
end

monitor.clear()

os.unloadAPI("buttons")
