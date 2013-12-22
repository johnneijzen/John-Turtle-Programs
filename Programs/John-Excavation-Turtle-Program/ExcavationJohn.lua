-- This Version
--  0.04
-- Changelogs
--  0.01 -- First Draft
--  0.04 -- Fixing Spacing my notepad++ is making lot error

-- Locals
local wide = 0
local WC = 0
local long = 0
local LC = 0
local high = 0
local HC = 0
local FuelCount = turtle.getItemCount(1)
local FuelCount1 = turtle.getItemCount(2)
local Chest = turtle.getItemCount(3)
local Totalblocks = wide x long x high
local LSorWS = 0
local Error = 0
local recheck = 0

-- Checking
function check()
  if Fuelcount == 0 then
    print("Turtle has no fuel")
    Error = 1
  end
  if Fuelcount1 == 0 then
    print("turtle has no extra fuel but if is short job it okey")
  end
  if Chest == 0 then
    print("please put chests in 3 slot")
    Error = 1
  end
  if Error = 1 then 
    print("Items are missing please try again")
    sleep(10)
    recheck()
  else 
    print("all items are there turtle will start")
    run()
  end	
end

-- Run Command
function run()
  turtle.digDown
  turtle.down
  turtle.digDown
  turtle.down
  turtle.digdown
  WC = 0 
  LC = 0
  HC = HC + 3
  if high == HC
  long()
end

-- Recheck  if user forget something turtle will check after 10 sec
function recheck()
  FuelCount = turtle.getItemCount(1)
  FuelCount1 = turtle.getItemCount(2)
  Chest = turtle.getItemCount(3)
  Error = 0
  check()
end 

-- Mining Long
function long()
  repeat
    turtle.dig
      if turtle.forward then
	LC = LC + 1
      end  
     turtle.digUp
     turtle.digDown
     if turtle.getItemCount(16)>0 then -- If slot 16 in turtle has item slot 5 to 16 will go to chest
       turtle.select(3)
       turtle.placeUp()
       Chest = Chest - 1
       for slot = 4, 16 do
         turtle.select(slot)
         turtle.dropUp()
	 sleep(1) -- Small fix for slow pc because i had people problem with this
       end
     turtle.select(4)
     end
    repeat -- Fuel
      if turtle.getFuelLevel() == "unlimited" then 
        print("NO NEED FOR FUEL")
        Needfuel = 0
      elseif turtle.getFuelLevel() < 300 then
        if FuelCount > 0 then
	  turtle.select(1)
          turtle.refuel(10)
          Needfuel = 1
          FuelCount = FuelCount - 10
	elseif FuelCount1 > 0 then
	  turtle.select(2)
          turtle.refuel(10)
          Needfuel = 1
          FuelCount1 = FuelCount1 - 10
	else
	  print("out of fuel")
	end
      elseif NeedFuel == 1 then
        Needfuel = 0
      end
    until NeedFuel == 0
  until long = LC
  if wide = WC then
    run()
  else 
    wide()
  end
end

-- Mining Wide
function wide()
  if LSorWS = 0 then
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
    turtle.turnRight()
    LSorWS = 0
  end
  LC = 0
  WC = WC + 1
  if Wide == WC then
    Run()
  else
    Long()
  end
end

-- Starting
print("Welcome To Excavation Turtle Program")
print("Note: This Program Stop Before Bedrock.")
print("How long you want")
input = io.read()
wide = tonumber(input)
print("How wide you want")
input2 = io.read()
long = tonumber(input2)
print("What is turtle high aka Y value")
input3 = io.read()
high = tonumber(input3)
high = high - 5
print("turtle now starting")
turtle.select(1)
turtle.refuel(4)
Check()
