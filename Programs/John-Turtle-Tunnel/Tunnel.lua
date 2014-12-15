-- This Version
-- 0.02
-- ChangeLogs
-- 0.01 - New Programed
-- 0.02 - Allmost Done Not Yet Tested but it should work of looks

-- Locals Variables
local noFuelNeeded = 0 -- Check if turtle is using no fuel config
local itemFuel = turtle.getItemCount(1) -- Fuel Slot 1
local itemFuel1 = turtle.getItemCount(2) -- Fuel Slot 2
local chest = turtle.getItemCount(3) -- Chest Slot 3
local distance = 0 -- Distance will dig
local distanceCount = 0 -- Count the distance
local missingFuel = 0 -- If there is missing fuel this will be 1
local missingChest = 0 -- If there is missing chest this will be 1

-- Checking On Items
local function checking()
	if noFuelNeeded == 0 then
		if itemFuel == 0 then
			missingFuel = 1
		else
			missingFuel = 0
		end
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

local function recheck()
	itemFuel = turtle.getItemCount(1)
	itemFuel1 = turtle.getItemCount(2)
	chest = turtle.getItemCount(3)
end

local function reFuel()
	if noFuelNeeded == 0 then
		repeat
			if turtle.getFuelLevel() < 120 then
				if itemFuel > 1 then
					turtle.select(1)
					turtle.refuel(1)
					itemFuel = itemFuel - 1
					turtle.select(4)
				elseif itemFuel1 > 1 then
					turtle.select(2)
					turtle.refuel(1)
					itemFuel1 = itemFuel1 - 1
					turtle.select(4)
				else
					print("out of fuel")
					os.shutdown()
				end
			end
		until turtle.getFuelLevel() >= 120
	end
end

local function dig()
	turtle.dig()
	turtle.forward()
	turtle.turnLeft()
	turtle.dig()
	turtle.turnRight()
	turtle.turnRight()
	turtle.dig()
	turtle.digUp()
	turtle.up()
	turtle.dig()
	turtle.turnRight()
	turtle.turnRight()
	turtle.dig()
	turtle.digUp()
	turtle.up()
	turtle.dig()
	turtle.turnRight()
	turtle.turnRight()
	turtle.dig()
	turtle.down()
	turtle.down()
	turtle.turnLeft()
end

function main()
	repeat
		reFuel()
		dig()
		distance = distance + 1
	until distance == distanceCount
end

function start()
	print("Welcome To John Tunnel Program")
	print("This 3x3 Tunnel Program 4x4 is coming soon after this one is done")
	print("Please Input Your Fuel In Slot 1 and Slot 2(Optional) and Chest in Slot 3")
	print("Please Input Your Distance You Want Turtle To Dig")
	input = io.read()
	distance = tonumber(input)
	print("Turtle Will Dig " + Distance + " Long")
	if turtle.getFuelLevel() == "unlimited" then -- just check if config of fuel is to unlimited
		noFuelNeeded = 1
	end
	checking()
	if missingFuel == 1 or missingChest == 1 then
		repeat
			print("Please Put In Items That Are Missing")
			sleep(10)
			recheck()
			checking()
		until missingFuel == 0 and missingChest == 0
	end
	main()
end

Start()