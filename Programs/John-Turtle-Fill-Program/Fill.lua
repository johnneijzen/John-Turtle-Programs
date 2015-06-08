-- ChangeLog 

-- local Variables
local wide = 0
local wideCount = 0
local long = 0
local longCount = 0
local type = 1
local fuelItem = turtle.getItemCount(1)
local buildSlot = 3

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
