-- Version
--  0.02
-- Changelog
--  0.01 - First Draft
--  0.02 - Added 4 wide version
-- TODO
-- Work on brige place Code

-- Locals Variables
local noFuelNeeded = 0 -- Check if turtle is using no fuel config
local itemFuel = turtle.getItemCount(1) -- Fuel Slot 1
local itemFuel1 = turtle.getItemCount(2) -- Fuel Slot 2
local distance = 0 -- Distance will dig
local distanceCount = 0 -- Count the distance
local missingFuel = 0 -- If there is missing fuel this will be 1
local bridgeType = 0 -- If it is 0 then 5 wide if is 1 then 4 wide

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

local function blockPlace1() -- TODO
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
        if bridgeType == 0 then
            blockPlace()
        elseif bridgeType == 1 then
            blockPlace1()
        end
        back()
        distance = distance + 1
    until distance == distanceCount
end

function start()
    print("Welcome To John Bridge Program")
    print("This Program Will Make 5 Wide Brige With Side Walls or 4 Wide")
    print("If You want 5 wide then 0 if you want 4 wide then 1")
    input = io.read()
    bridgeType = tonumber(input)
    print("Please Input Your Fuel In Slot 1 and Slot 2(Optional)")
    print("Please Input How Far Brige Will Be")
    input1 = io.read()
    distance = tonumber(input1)
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