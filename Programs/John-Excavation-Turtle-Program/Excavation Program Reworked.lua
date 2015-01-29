--[[
Version
  0.01 29/1/2015
Changelog
  0.01 - Starting Of Rewriting
To Do List
  Fixing Bugs
--]]

-- Local Variables
-- Starting
local wide = 0
local wideCount = 0
local long = 0
local longCount = 0
local deep = 0
local deepCount = 0
local totalBlocks = 0
local coalNeeded = 0
local corrent = n
-- Inventory This Will Check At Start Code
local chest = 0
local fuelCount = 0
local fuelCount1 = 0
local noFuelNeed = 0 -- if Config has fuel no need on
local error = 0 -- Error Code
local reCheck = 0 -- Recheck Code
-- Others
local totalBlockDone = 0 -- How many Block Mined
local LSorWS = 0 -- Go Left or Go Right This is for Wide Code
local processRaw = 0
local process = 0
local enderChest = 0 -- TODO
local blockUp = 0 -- Fixing to Chest Probleem and moving probleem

-- Checking
local function Check()
    if noFuelNeed == 0 then
        if fuelCount == 0 then
            print("Turtle has no fuel")
            print("Put fuel in Second and Thrid slot")
            error = 1
        else
            print("Turtle has Fuel")
        end
        if fuelCount1 == 0 then
            print("Turtle has no extra fuel but if is short job it okey")
        end
    end
    if chest == 0 then
        print("No chest in Turtle")
        print("Put chest in 1 slot")
        error = 1
    else
        print("Turtle has chest")
    end
    if error == 1 then
        print("Items are missing please try again")
        print("Turtle will recheck in 10 sec")
    end
end

-- Recheck if user forget something turtle will check after 6 sec
local function Recheck()
    chest = turtle.getItemCount(1)
    fuelCount = turtle.getItemCount(2)
    fuelCount1 = turtle.getItemCount(3)
    error = 0
end

local function start()
    print("Welcome To Excavation Turtle Program")
    print("Slot 1: Chest, Slot 2: Fuel, Slot 3: Fuel")
    print("Note: If now put item in then it say error just wait it fix it self")
    print("How long(Lenght) you want")
    input = io.read()
    long = tonumber(input)
    long = long - 1
    print("How wide(Width) you want")
    input2 = io.read()
    wide = tonumber(input2)
    wide = wide - 1
    print("How Deep(Depth) You Want")
    input3 = io.read()
    deep = tonumber(input3)
    print("Is This Corrent Lenght " .. "Lenght = " .. (long + 1) .. " Width = " .. (wide + 1) .. " Depth = " .. (deep))
    print("Type y Or Y  if it is corrent and if not then n or N")
    input4 = io.read()
    corrent = input4
    if corrent == n or N then
        os.reboot()
    elseif corrent == y or Y then
        print("Okey Program Will Do Calculations")
    end
    totalBlocks = (wide + 1) * (long + 1) * deep -- 1 is add because above it removed for wide and long code
    print("Total amount for block to mine is " .. totalBlocks)
    coalNeeded = totalBlocks / 3 / 80
    print("Total amount for Coal needed is " .. math.floor(coalNeeded+0.5))
    if turtle.getFuelLevel() == "unlimited" then
        print("Your turtle config does need fuel")
        noFuelNeed = 1
    elseif turtle.getFuelLevel() < 160 then
        turtle.select(2)
        turtle.refuel(2)
    end
    chest = turtle.getItemCount(1)
    fuelCount = turtle.getItemCount(2)
    fuelCount1 = turtle.getItemCount(3)
    check()
    if error == 1 then
        repeat
            sleep(6)
            recheck()
            check()
        until error == 0
    end
    print("Turtle will now start!")
    MainPart()
end

Start()