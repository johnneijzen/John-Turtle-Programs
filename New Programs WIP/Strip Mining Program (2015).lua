--[[
Version
  0.03 10/13/2015
Changelog
  0.01 - Rewriting.
  0.02 - More Rewritting.....
  0.03 - Testing Phase
]]

-- Local Variables in My New Program style it now a-z not random
-- Area
local distance = 0
local distanceApart = 0
local distanceApartCount = 0
local backwardsCount = 0
local forwardsCount = 0
-- Misc
local noFuelNeed = 0 
local LorR = 0 -- if 0 then left if 1 then right
local howManyTimes = 0
local onlight = 0
-- Inventory
local chests = 0
local itemFuel = 0
local torch = 0

-- ItemCheck
local function itemCheck()
	chests = turtle.getItemCount(2)
	itemFuel = turtle.getItemCount(1)
	torch = turtle.getItemCount(3)
    missingItems = 0
end

-- Checking
local function check()
    if noFuelNeed == 0 then
        if itemFuel == 0 then
            print("Turtle has no fuel")
            print("Put fuel in second and thrid slot")
            missingItems = 1
        else
            print("Turtle has Fuel")
		end
    end
    if chests == 0 then
        print("No chests in turtle")
        print("Put chests in 1 slot")
        missingItems = 1
    else
        print("Turtle has chest")
    end
    if missingItems == 1 then
        print("Items are missing please try again")
        print("Turtle will recheck in 5 sec")
    end 
end

-- Refuel
local function refuel()
    if noFuelNeed == 0 then
        repeat
            if turtle.getFuelLevel() < 100 then
                if itemFuel > 0 then
                    turtle.select(1)
                    turtle.refuel(1)
                    itemFuel = itemFuel - 1
                else
                    print("out of fuel")
                    os.shutdown()
                end
            end
        until turtle.getFuelLevel() >= 100
    end
end

-- ItemDump
local function chestDump()
	if turtle.getItemCount(16)> 0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
		turtle.digDown()
		turtle.select(2)
		turtle.placedDown()
		chest = chest - 1
		for slot = 5, 16 do
			turtle.select(slot)
			sleep(0.6) -- Small fix for slow pc because i had people problem with this
			turtle.dropDown()
		end
		turtle.select(4)
		if chest == 0 then
			print("Out Of Chest")
			os.shutdown()
		end
	end
end

local function turnAround()
	turtle.turnLeft()
	turtle.turnLeft()
end

local function placeTorch()
	if torch > 0 then
		turnAround()
		turtle.select(3)
		turtle.place()
		turnAround()
		torch = torch - 1
		onlight = 0
	end
end

local function dig()
	repeat
		refuel()
		chestDump()
		if turtle.detect() then
			turtle.dig()
		end
		if turtle.forward() then -- sometimes sand and gravel and block and mix-up distance
			forwardsCount = forwardsCount + 1
			onlight = onlight + 1
		end
		if turtle.detectUp() then
			turtle.digUp()
		end
		if onlight == 8 then
			placeTorch()
		end
	until forwardsCount == distance
end

--Back Program
local function back()
	turtle.up()
	turnAround()
	repeat
		if turtle.forward() then -- sometimes sand and gravel and block and mix-up distance
			backwardsCount = backwardsCount + 1
		end
		if turtle.detect() then -- Sometimes sand and gravel can happen and this will fix it
			if backwardsCount ~= distance then
				turtle.dig()
			end
		end
	until backwardsCount == distance
end

-- Multimines Program
local function nextMine()
	if LorR == 1 then
		turtle.turnLeft()
		turtle.down()
	else
		turtle.turnRight()
		turtle.down()
	end
	repeat
		if turtle.detect() then
			turtle.dig()
		end
		if turtle.forward() then
			distanceApartCount = distanceApartCount + 1
		end
		if turtle.detectUp() then
			turtle.digUp()
		end
	until distanceApartCount == distanceApart
	if LorR == 1 then
		turtle.turnLeft()
	else
		turtle.turnRight()
	end
end

-- Reset 
local function reset()
	backwardsCount = 0
	forwardsCount = 0
	distanceApartCount = 0
	onlight = 0
end

local function main()
	repeat
		dig()
		back()
		nextMine()
		reset()
		howManyTimes = howManyTimes - 1
	until howManyTimes == 0
	print("Turtle is done")
end

-- Starting 
local function start()
	print("Welcome to Mining Turtle Program")
	print("Slot 1: Fuel, Slot 2: Chests, Optional Slot 3: Torchs")
	print("Note: turtle will still work then there is no more torchs")
	print("How Far Will Turtle Go")
	distance = tonumber(read())
	print("Left or Right")
	print("0 = Left and 1 = Right")
	LorR = tonumber(read())
	print("How Many Times")
	howManyTimes = tonumber(read())
	print("Distance Apart from each Mine")
	distanceApart = tonumber(read())
	distanceApart = distanceApart + 1
	if turtle.getFuelLevel() == "unlimited" then
		print("Your turtle config does need fuel")
		noFuelNeed = 1
	end
	itemCheck()
	check()
	if missingItems == 1 then
		itemCheck()
		check()
	end
	main()
end

start()