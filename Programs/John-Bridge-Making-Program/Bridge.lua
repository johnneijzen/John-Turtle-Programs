-- Version
--  0.01
-- Changelog
--  0.01 - First Draft
-- TODO
-- Work on brige place Code

-- Locals Variables
local noFuelNeeded = 0 -- Check if turtle is using no fuel config
local itemFuel = turtle.getItemCount(1) -- Fuel Slot 1
local itemFuel1 = turtle.getItemCount(2) -- Fuel Slot 2
local distance = 0 -- Distance will dig
local distanceCount = 0 -- Count the distance
local missingFuel = 0 -- If there is missing fuel this will be 1

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

local function blockPlace() -- TODO
    turtle.forward()
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
    turtle.turnleft()
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
    turtle.turnleft()
    turtle.turnleft()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.turnRight()
end

function main()
    repeat
        reFuel()
        blockPlace()
        back()
        distance = distance + 1
    until distance == distanceCount
end

function start()
    print("Welcome To John Bridge Program")
    print("This Program Will Make 5 Wide Brige With Side Walls")
    print("Please Input Your Fuel In Slot 1 and Slot 2(Optional)")
    print("Please Input How Far Brige Will Be")
    input = io.read()
    distance = tonumber(input)
    print("Turtle Will Make " + Distance + " Long Brige")
    if turtle.getFuelLevel() == "unlimited" then -- just check if config of fuel is to unlimited
        noFuelNeeded = 1
    end
    checking()
    if missingFuel == 1
        repeat
            print("Please Put In Items That Are Missing")
            sleep(10)
            recheck()
            checking()
        until missingFuel == 0
    end
    main()
end

Start()