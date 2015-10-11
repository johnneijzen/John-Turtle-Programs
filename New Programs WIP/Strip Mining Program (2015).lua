--[[
Version
  0.01 10/11/2015
Changelog
  0.01 - Rewriting.
]]

-- Local Variables in My New Program style it now a-z not random
-- Area
local distance = 0
local forwardsCount = 0
local backwardsCount = 0
local placeTorch = 0
-- Misc
local noFuelNeed = 0
local LorR = 0 -- if 0 then left if 1 then right
local howManyTimes = 0
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
        if fuelCount == 0 then
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
	if torchs == 0 then
		print("No torchs in Turle")
		missingItems = 1
	else
		print("Turtle has torchs")
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
                if fuelCount > 0 then
                    turtle.select(1)
                    turtle.refuel(1)
                    fuelCount = fuelCount - 1
                elseif fuelCount1 > 0 then
                    turtle.select(2)
                    turtle.refuel(1)
                    fuelCount1 = fuelCount1 - 1
                else
                    print("out of fuel")
                    os.shutdown()
                end
            end
        until turtle.getFuelLevel() >= 100
    end
end

local function main()



end

-- Starting 
local function start()
	print("Welcome to Mining Turtle Program")
	print("How Far Will Turtle Go")
	distance = tonumber(read())
	print("Left or Right")
	print("0 = Left and 1 = Right")
	LorR = tonumber(read())
	print("How Many Times")
	howManyTimes = tonumber(read())
	itemCheck()
	check()
	if missingItems = 1 then
		itemCheck()
		check()
	end
	main()
end

start()