os.unloadAPI("buttons")
os.loadAPI("buttons")

local running = true
local allButtons = {}

monitor = peripheral.wrap("right")

exit = function()
	running = false
end

allButtons.exit = buttons.register(10, 10, 10, 3, colors.white, colors.gray, "exit", exit)


buttons.draw()
while running do 
	local eventArray = {os.pullEvent()}
	buttons.event(eventArray)
	buttons.draw()
end

monitor.clear()

os.unloadAPI("buttons")
