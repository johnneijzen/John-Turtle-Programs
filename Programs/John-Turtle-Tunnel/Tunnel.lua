-- This Version
-- 0.01
-- ChangeLogs
-- 0.01 - New Programed

-- Locals Variables
local itemFuel = turtle.getItemCount(1) -- Fuel Slot 1
local itemFuel1 = turtle.getItemCount(2) -- Fuel Slot 2
local chest = turtle.getItemCount(3) -- Chest Slot 3
local distance = 0 -- Distance will dig
local missingFuel = 0 -- If there is missing fuel this will be 1
local missingChest = 0 -- If there is missing chest this will be 1

-- Checking On Items
function checking()
	if itemFuel == 0 then
		missingFuel = 1
	else
		missingFuel = 0
	end
	if chest == 0 then
		missingChest = 1
	else
		missingChest = 0
	end
	if missingFuel == 1 then
		print("Missing Fuel in Slot 1")
	end
	if missingChest == 1 then
		print("Missing Chest in Slot 3")
	end
end

function recheck()
	itemFuel = turtle.getItemCount(1)
	itemFuel1 = turtle.getItemCount(2)
	chest = turtle.getItemCount(3)
end
function reFuel()

end

function dig()

end

function main()

end

function start()
	print("Welcome To John Tunnel Program")
	print("Please Input Your Fuel In Slot 1 and Slot 2(Optional) and Chest in Slot 3")
	print("Please Input Your Distance You Want Turtle To Dig")
	input = io.read()
	distance = input
	print("Turtle Will Dig " + Distance + " Long")
	check()
	if missingFuel == 0 or missingChest == 0 then
		repeat
			print("Please Put In Items That Are Missing")
			sleep(10)
			recheck()
			check()
		until missingFuel == 0 and missingChest == 0
	end
	main()
end

Start()