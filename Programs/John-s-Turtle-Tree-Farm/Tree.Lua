-- Current Version
--  0.03
-- ChangeLogs
--  0.01 - First Draft
--  0.02 - Rewritting
--  0.03 - Making Turtle go back to start

-- Locals
local sappishing = turtle.getItemCount(1)
local ItemFuel = turtle.getItemCount(2)
local WC = 0
local TD = 0
local UC = 0
local TT = 0
local wide = 0
local long = 0
local lc = 0
local x = 0
local SideC = 0

-- Main Program
function start()
  turtle.forward()
  if turtle.compare() then
    turtle.dig()
    turtle.forward()
    WC = WC + 1
    TD = 1
  else
    WC = WC + 1
    TD = 0
  end
  if TD == 1 then
    TreeCutter()
  else
    TreePlant()
  end
end

-- Tree Cutter
function TreeCutter()
  turtle.select(2)
  repeat
  if turtle.compareUp() then
    turtle.digUp()
    TT = 0
    UC = UC + 1
  else
    TT = 1
  end
  turtle.up()
  until TT == 1
  turtle.forward()
  down()
end 

-- Tree Planter
function TreePlant()
  turtle.dig()
  turtle.forward()
  turtle.forward()
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.select(1)
  turtle.place()
  turtle.turnLeft()
  turtle.turnLeft()
  run()
end

-- Run aka Check
function run()
  if WC == Wide then
    Clong()
  else
    start()
  end
end

-- Bring Turtle Down Program
function down()
  do x = 1, UC
    turtle.down
  end
  run()
end

-- Check Long If it can
function Clong()
  if long == LC then
    Back()
  else
    long()
  end
end

-- Long Program
function long()
  WC = 0
  LC = LC + 1
  turtle.forward
  turtle.turnRight
  turtle.forward
  turtle.forward
  turtle.turnRight
  SideC = SideC + 2
  start()
end


-- Back To Home Program -- Still need to do this.
function home()
  if Long == 1 then
    print("Program Half Way Done")
  end
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
turtle.forward()
start()
