-- This Version
--  0.14
-- Changelogs
--  0.14 Add Counter to mining block

-- local
local Wide = 0
local Wc = 0
local Long = 0
local Lc = 0
local High = 0
local Hc = 0
local FuelCount = turtle.getItemCount(1)
local FuelCount1 = turtle.getItemCount(2)
local Chest = turtle.getItemCount(3)
local TotalBlocks = 0
local LSorWS = 0
local Error = 0
local Recheck = 0
local NoFuelNeed = 0
local TotalBlockDone = 0

-- Checking
function check()
  if FuelCount == 0 then
    print("Turtle has no fuel")
    print("put fuel in 1 first and second slot")
    Error = 1
  else
    print("turtle has Fuel")
  end
  if FuelCount1 == 0 then
    print("turtle has no extra fuel but if is short job it okey")
  end
  if Chest == 0 then
    print("No chest in Turtle")
    print("Put chest in 3 slot")
    Error = 1
  else
    print("turtle has chest")
  end
  if Error == 1 then 
    print("Items are missing please try again")
    print("turtle will recheck in 15 sec")
    sleep(15)
    recheck()
  else 
    print("all items are there turtle will start")
    run()
  end 
end

-- Recheck  if user forget something turtle will check after 15 sec
function recheck()
  FuelCount = turtle.getItemCount(1)
  FuelCount1 = turtle.getItemCount(2)
  Chest = turtle.getItemCount(3)
  Error = 0
  check()
end 

-- Run Command
function run()
  turtle.digDown()
  turtle.down()
  turtle.digDown()
  turtle.down()
  turtle.digDown()
  Wc = 0 
  Lc = 0
  Hc = Hc + 3
  if High == Hc then
    print("done")
  else
    Lenght()
  end
end

-- Mining for length
function Lenght()
  repeat
    turtle.dig()
    if turtle.forward() then
      Lc = Lc + 1
      TotalBlockDone = TotalBlockDone + 3
      print(TotalBlock - TotalBlockDone)
    end  
    turtle.digUp()
    turtle.digDown()
    if turtle.getItemCount(16)>0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
      turtle.select(3)
      turtle.placeUp()
      Chest = Chest - 1
      for slot = 4, 16 do
        turtle.select(slot)
        turtle.dropUp()
        sleep(1.5) -- Small fix for slow pc because i had people problem with this
      end
    turtle.select(4)
    end
    if NoFuelNeed == 0 then
      if turtle.getFuelLevel() < 300 then
        if FuelCount > 10 then
          turtle.select(1)
          turtle.refuel(12)
          FuelCount = FuelCount - 10
        elseif FuelCount1 > 10 then
          turtle.select(2)
          turtle.refuel(12)
          FuelCount1 = FuelCount1 - 10
        else
          print("out of fuel")
        end
      end
    end
  until Long == Lc
  if Wide == Wc then
    turtle.turnRight()
    run()
  else 
    wide()
  end
end

-- Mining Wide
function wide()
  if LSorWS == 0 then
    turtle.turnRight()
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    turtle.digDown()
    turtle.turnRight()
    LSorWS = 1
  else 
    turtle.turnLeft()
    turtle.dig()
    turtle.forward()
    turtle.digUp()
    turtle.digDown()
    turtle.turnLeft()
    LSorWS = 0
  end
  Lc = 0
  Wc = Wc + 1
  if Wide == WC then
    run()
  else
    Lenght()
  end
end

-- Starting
print("Welcome To Excavation Turtle Program")
print("Note: This Program Stop Before Bedrock.")
print("How long you want")
input = io.read()
Wide = tonumber(input)
Wide = Wide - 1
print("How wide you want")
input2 = io.read()
Long = tonumber(input2)
Long = Long - 1
print("What is turtle high aka Y value")
input3 = io.read()
High = tonumber(input3)
High = High - 5
print("caluclating")
Totalblocks = Wide * Long * High
print("Total amount for block to mine is")
print(Totalblocks)
print("turtle now starting")
if turtle.getFuelLevel() == "unlimited" then 
  print("your turtle config does need fuel")
  NoFuelNeed = 1
elseif turtle.getFuelLevel() < 200 then
  turtle.select(1)
  turtle.refuel(2)
end
check()
