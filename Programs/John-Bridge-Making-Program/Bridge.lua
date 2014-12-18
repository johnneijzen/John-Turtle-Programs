-- Version
--  0.04 Dev 12/18/2014
-- Changelog
--  0.01 - First Draft
--  0.02 - Added 4 wide version
--  0.03 - small bug fixing and testing
--  0.04 dev - Testing And tweaking and add bleeding stuff
-- TODO 
-- Speed Up Building Code -- coming soon 0.04

-- Locals Variables
local noFuelNeeded = 0 -- Check if turtle is using no fuel config
local itemFuel = turtle.getItemCount(1) -- Fuel Slot 1
local itemFuel1 = turtle.getItemCount(2) -- Fuel Slot 2
local distance = 0 -- Distance will dig
local distanceCount = 0 -- Count the distance
local missingFuel = 0 -- If there is missing fuel this will be 1
local bridgeType = 0 -- If it is 0 then 5 wide if is 1 then 4 wide
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

local function blockPlace()
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
    turtle.forward()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
end

local function blockPlace1()
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
    turtle.forward()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
end

local function blockPlace2()
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
    turtle.forward()
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
end

local function back()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.turnRight()
    turtle.forward()
    turtle.down()
end

local function back1()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.turnRight()
    turtle.forward()
    turtle.down()
end

local function back2()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.turnRight()
    turtle.forward()
    turtle.down()
end

function main()
    reFuel()
    turtle.select(3) -- this be cobble slot select
    turtle.forward()
    repeat
        reFuel()
        if turtle.getItemCount(currentSlot) <= 8 then -- this code will switch turtle slot when cobble is less than 7
        currentSlot = currentSlot + 1
        turtle.select(currentSlot)
        else
            turtle.select(currentSlot)
        end
        if bridgeType == 0 then
            blockPlace()
            back()
        elseif bridgeType == 1 then
            blockPlace1()
            back1()
        elseif bridgeType == 2 then
            blockPlace2()
            back2()
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