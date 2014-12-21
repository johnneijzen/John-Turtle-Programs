--[[
Version
  0.04 Dev 2 12/18/2014
Changelog
  0.01 - First Draft
  0.02 - Added 4 wide version
  0.03 - small bug fixing and testing
  0.04 dev - Testing And tweaking and add bleeding stuff
  0.04 dev 2 - add speed code by making building process 2 sided not 1 sided
To Do List
  Speed Up Building Code - Will be added in 0.04
  Add more fetures
--]]


-- Locals Variables
local noFuelNeeded = 0 -- Check if turtle is using no fuel config
local itemFuel = turtle.getItemCount(1) -- Fuel Slot 1
local itemFuel1 = turtle.getItemCount(2) -- Fuel Slot 2
local distance = 0 -- Distance will dig
local distanceCount = 0 -- Count the distance
local missingFuel = 0 -- If there is missing fuel this will be 1
local bridgeType = 0 --[[ If This is 0 then it 5 Wide
                          If This is 1 then it 4 Wide
                          if This is 2 then it 3 Wide--]]
local currentSlot = 3 -- For checking on cobble
local way = 0 -- Testing to Speed up the code

-- Checking On Items
local function checking()
    if noFuelNeeded == 0 then
        if itemFuel == 0 then
            missingFuel = 1
        else
            missingFuel = 0
        end
    end
    if missingFuel == 1 then
        print("Missing Fuel in Slot 1")
    end
end

local function recheck()
    itemFuel = turtle.getItemCount(1)
    itemFuel1 = turtle.getItemCount(2)
end

local function reFuel()
    if noFuelNeeded == 0 then
        repeat
            if turtle.getFuelLevel() < 120 then
                if itemFuel > 1 then
                    turtle.select(1)
                    turtle.refuel(1)
                    itemFuel = itemFuel - 1
                    turtle.select(3)
                elseif itemFuel1 > 1 then
                    turtle.select(2)
                    turtle.refuel(1)
                    itemFuel1 = itemFuel1 - 1
                    turtle.select(3)
                else
                    print("out of fuel")
                    os.shutdown()
                end
            end
        until turtle.getFuelLevel() >= 120
    end
end

local function blockPlaceRight()
    turtle.forward()
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
    turtle.turnRight()
    turtle.forward()
    turtle.down()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    if bridgeType == 0 then
      turtle.forward()
      turtle.placeDown()
    end
    if bridgeType == 0 or bridgeType == 1 then
      turtle.forward()
      turtle.placeDown()
    end
    turtle.up()
    turtle.placeDown()
end

local function blockPlaceLeft()
    turtle.forward()
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
    turtle.turnLeft()
    turtle.forward()
    turtle.down()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    if bridgeType == 0 then
        turtle.forward()
        turtle.placeDown()
    end
    if bridgeType == 0 or bridgeType == 1 then
        turtle.forward()
        turtle.placeDown()
    end
    turtle.up()
    turtle.placeDown()
end

function main()
    reFuel()
    turtle.select(3) -- this be cobble slot select
    turtle.forward()
    repeat
        reFuel()
        repeat
            if turtle.getItemCount(currentSlot) <= 8 then -- this code will switch turtle slot when cobble is less than 7
                currentSlot = currentSlot + 1
            elseif turtle.getItemCount(currentSlot) >= 8 then
                currentSlot = currentSlot
            else
                os.shutdown()
            end
        until turtle.getItemCount(currentSlot) >= 8
        turtle.select(currentSlot)
        if way == 0 then
            blockPlaceRight()
            way = 1
        else
            blockPlaceLeft()
            way = 0
        end
        distance = distance + 1
    until distance == distanceCount
end

function start()
    print("Welcome To John Bridge Program")
    print("This Program Will Make 5 Wide Brige With Side Walls or 4 Wide")
    print("If You want 5 wide then 0")
    print("If you want 4 wide then 1")
    print("If you want 3 wide then 2")
    input = io.read()
    bridgeType = tonumber(input)
    print("Please Input Your Fuel In Slot 1 and Slot 2(Optional)")
    print("Please Input How Far Brige Will Be")
    input1 = io.read()
    distance = tonumber(input1)
    print("Turtle Will Make " .. distance .. " Long Brige")
    if turtle.getFuelLevel() == "unlimited" then -- just check if config of fuel is to unlimited
    noFuelNeeded = 1
    end
    checking()
    if missingFuel == 1 then
        repeat
            print("Please Put In Items That Are Missing")
            sleep(10)
            recheck()
            checking()
        until missingFuel == 0
    end
    main()
end

start()