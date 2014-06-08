-- Current Version
--  0.06
-- ChangeLogs
--  0.01 - First Draft
--  0.02 - Added Fuel Code
--  0.03 - Testing and Debugging and fixing values
--  0.04 - Adding Plant code on Cutter Program
--  0.05 - More Spacing Cleaning and Small Debugs
--  0.06 - Starting Working on Back And Wide Programs 6/9/2014
-- TODO
--  Back Program  P.s I`m do this Fast As Possible somewhere between version 0.06 to 0.09
--  Wide Program Aka Side Program I`m do this Fast As Possible somewhere between version 0.06 to 0.09
--  Other Stuff Named TODO This After Done others
--  And Testing after done with back and fuel programs

-- Locals Variables
-- Inventory Locals 
local fuel = turtle.getItemCount(1)
local fuel1 = turtle.getItemCount(2)
local sapling1 = turtle.getItemCount(3)
local sapling2 = turtle.getItemCount(4)
local treeBlock = turtle.getItemCount(5)
local itemError = 0
local noFuelNeeded = 0
-- Programming Locals
local wide = 0
local long = 0
local wideCount = 0
local longCount = 0
local sideMoveCount = 0 
local otherSideMoveCount = 0 -- TODO or not need later
local upCount = 0
local turtleReachTop = 0
local treeDetect = 0
local facing = 0 -- If turtle is forward then it is 0 if is going back then is 1
local furnace = 0 -- Feature-request TODO
local x = 0 -- I don't use this only for loop it may be remove later on.

-- Local Programs
local function check()
  if noFuelNeeded == 0 then
    if fuel == 0 and fuel1 == 0 then
      print("turtle has no fuel")
      print("put fuel in 1st and 2nd slot")
      itemError = 1
    end
  end
  if Sapling1 == 0 and Sapling2 == 0 then
    print("turtle has no sapling")
    print("put Sapling in 3nd and 4nd slot")
    itemError = 1
  end
  if treeBlock == 0 then
    print("turtle has no tree block to compair with")
    print("Put tree block in slot 5")
    itemError = 1
  end
  if itemError == 1 then
    print("Items are missing please try again")
    print("turtle will recheck in 8 sec")
    sleep(8)
  end
end

local function reCheck()
  fuel = turtle.getItemCount(1)
  fuel1 = turtle.getItemCount(2)
  sapling1 = turtle.getItemCount(3)
  sapling2 = turtle.getItemCount(4)
  treeBlock = turtle.getItemCount(5)
  itemError = 0
end

local function treeDetecter()
  turtle.forward()
  turtle.select(5)
  if turtle.compare() then
    turtle.dig()
    turtle.forward()
    longCount = longCount + 1
    treeDetect = 1
  else
    longCount = longCount + 1
    treeDetect = 0
  end
end

local function treeCutter()
  repeat
    turtle.select(5)
    if turtle.compareUp() then
      turtle.digUp()
      turtle.up()
      turtleReachTop = 0
      upCount = upCount + 1
    else
      turtleReachTop = 1
    end
  until turtleReachTop == 1
  repeat
    turtle.down()
    upCount = upCount - 1
  until upCount == 0
  turtle.forward()
  turtle.turnLeft()
  turtle.turnLeft()
  if sapling1 > 0 then
    turtle.select(3)
    turtle.place()
    sapling1 = sapling1 - 1
  elseif sapling2 > 0 then
    turtle.select(4)
    turtle.place()
    sapling2 = sapling2 - 1
  end
  turtle.turnLeft()
  turtle.turnLeft()
end

local function treePlant()
  turtle.dig()
  turtle.forward()
  turtle.forward()
  turtle.turnLeft()
  turtle.turnLeft()
  if sapling1 > 0 then
    turtle.select(3)
    turtle.place()
    sapling1 = sapling1 - 1
  elseif sapling2 > 0 then
    turtle.select(4)
    turtle.place()
    sapling2 = sapling2 - 1
  end
  turtle.turnLeft()
  turtle.turnLeft()
end

local function reFuel()
  if noFuelNeeded == 0 then
    if turtle.getFuelLevel() < 100 then
      if fuel > 10 then
        turtle.select(1)
        turtle.refuel(10)
        fuel = fuel - 10
      elseif fuel1 > 10 then
        turtle.select(2)
        turtle.refuel(10)
        fuel1 = fuel1 - 10
      else
        print("out of fuel")
        os.shutdown()
      end
    end
  end
end

local function wide() --TODO
  turtle.forward() -- to make it simple for me
  turtle.turnRight()
  turtle.forward()
  turtle.forward()
  turtle.forward()
  turtle.turnRight()
  wideCount = wideCount + 1
  sideCount = sideCount + 3 
  if facing == 0 then
    facing = 1
  else 
    facing = 0
  end
end

local function back() --TODO
  if facing == 1 then
    turtle.forward()
	turtle.turnRight()
	repeat
	  turtle.forward()
	  sideCount = sideCount - 1
	until sideCount == 0 
	turtle.turnRight()
	turtle.back()
  end
end

local function chest() -- TODO 
end

function start()
  turtle.forward()
  repeat
    repeat
      treeDetect = 0
      reFuel()
      treeDetecter()
      if treeDetect == 1 then
        treeCutter()
      else
        treePlant()
      end
    until long == longCount
  until wide == wideCount
end

-- Starting
print("Welecome to Turtle Tree Logger Program")
print("Fuel in slot 1 & 2, and Sapling in slot 3 & 4, and one piece of wood that you are farming in slot 5")
print("Note: If it says that items are missing but they are there just wait for recheck program that happen every 10 sec")
print("How wide for Saplings")
input = io.read()
wide = tonumber(input)
print("How long for saplings")
input2 = io.read()
long = tonumber(input2)
print("Turtle go to work")
if turtle.getFuelLevel() == "unlimited" then 
  print("your turtle config does need fuel")
  noFuelNeeded = 1
elseif turtle.getFuelLevel() < 200 then
  turtle.select(1)
  turtle.refuel(1)
end
check()
if itemError == 1 then
  repeat
    reCheck()
    check()
  until itemError == 0
end
start()
