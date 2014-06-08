-- Current Version
--  0.02
-- ChangeLogs
--  0.01 - First Draft
--  0.02 - Added Fuel Code
-- TODO
--  Back Program and Side Program P.s I`m do this Fast As Possible
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
local sideCount = 0
local upCount = 0
local turtleReachTop = 0
local treeDetect = 0
local furnace = 0 -- Feature-request TODO
local x = 0 -- I dont use this only for loop

-- Local Programs
local function check
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
  if itemError == 1 then
    print("Items are missing please try again")
    print("turtle will recheck in 10 sec")
	sleep(10)
  end
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
	  turtleReachTop = 0
	  upCount = 0
	else
	  turtleReachTop = 1
	end
  until turtleReachTop = 1
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
      if fuel1 > 10 then
        turtle.select(1)
        turtle.refuel(10)
        FuelCount = FuelCount - 10
      elseif fuel2 > 10 then
        turtle.select(2)
        turtle.refuel(10)
        FuelCount1 = FuelCount1 - 10
      else
        print("out of fuel")
        os.shutdown()
      end
    end
  end
end

local function back() --TODO

end

local function side() --TODO
end

function Start()
  repeat
    repeat
      turtle.forward()
	  reFuel()
      treeDetecter()
      if treeDetect = 1 then
        treeCutter()
      else
        treePlant()
      end
	until long == longcount
  until wide == wideCount
end

-- Starting
print("Welecome to Turtle Tree Logger Program")
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
    itemError == 0
	check()
  until itemError == 0
end
start()
