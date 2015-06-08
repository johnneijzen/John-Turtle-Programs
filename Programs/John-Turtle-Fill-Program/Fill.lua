-- ChangeLog 

-- local Variables
local wide = 0
local wideCount = 0
local long = 0
local longCount = 0
local selectType = 1
local fuelItem = turtle.getItemCount(1)
local buildSlot = 3

local function refuel()
  repeat
    if turtle.getFuelLevel() < 100 then
      if fuelItem > 0 then
        turtle.select(1)
        turtle.refuel(1)
      else
        os.shutdown()
      end
    end
  until turtle.getFuelLevel () > 100 then
end

local function fill()
repeat
  repeat
    refuel()
    if turtle.getItemCount(buildSlot) > 0 then
      turtle.select(buildSlot)
      turtle.placeDown()
      turtle.forward()
    else
      buildSlot = buildSlot + 1
      turtle.select(buildSlot)
      turtle.placeDown()
      turtle.forward()
    end
    longCount = longCount + 1
  until long = longCount
  turtle.turnRight()
  turtle.forward()
  turtle.turnRight()
  wideCount = wideCount + 1
until wide == wideCount

--starting
print("welcome to Fill Program")
print("Please enter lenght you want to fill")
input1 = io.read()
long = tonumber(input1)
print("Please Enter wide you want to fill")
input2 = io.read()
wide = tonumber(input2)
print("Please enter what type fill you want")
print("1 = Fill, 2 = Walls, 3 = Cube")
input3 = io.read()
selectType = tonumber(input3)
fill()

