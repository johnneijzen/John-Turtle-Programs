-- Current Version
--  0.05
-- ChangeLogs
--  0.01 - First Draft
--  0.02 - Rewritting
--  0.03 - Making Turtle go back to start
--  0.04 - Updating Lot stuff
--  0.05 - Tabs Version

--Locals
local tree = turtle.getItemCount(3)
local tree1 = turtle.getItemCount(4)
local compareblock = turtle.getItemCount(5)
local ItemFuel = turtle.getItemCount(1)
local ItemFuel1 = turtle.getItemCount(2)
local WC = 0
local TD = 0
local UC = 0
local TT = 0
local wide = 0
local long = 0
local lc = 0
local x = 0
local SideC = 0
local auto = 0

--Main Program
function start()
  turtle.forward()
  turtle.select(5)
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

--Tree Cutter
function TreeCutter()
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

--Tree Planter
function TreePlant()
  turtle.dig()
  turtle.forward()
  turtle.forward()
  turtle.turnLeft()
  turtle.turnLeft()
  if tree > 0 then
    turtle.select(3)
    turtle.place()
    tree = tree - 1
  elseif tree1 > 0 then
    turtle.select(4)
    turtle.place()
    tree1 = tree1 - 1
  end
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
  turtle.forward()
  turtle.turnRight()
  turtle.forward()
  turtle.forward()
  turtle.turnRight()
  SideC = SideC + 2
  start()
end

--Back To Home Program
function home()
  if Long == 1 then
    turtle.forward()
    turtle.turnRight()
    for Back = 1 , SideC do
      turtle.forward()
    end
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    turtle.turnLeft()
  end
  if auto == 0 then
    print("Program is done")
  else
    turtle.turnRight()
    for slot = 6, 16 do
      turtle.select(slot)
      turtle.drop()
      sleep(1)
    end
    turtle.turnLeft()
    turtle.turnLeft()
    for slot = 1, 2 do
      turtle.select(slot) 
      turtle.drop()
      sleep(1)
    end
  end 
  -- Still have work Here add code to get items from chest and maybe furnace code.
end

-- Starting
print("Welecome to Turtle Tree Logger Program")
print("How wide for Saplings")
input = io.read()
wide = tonumber(input)
print("How long for saplings")
input2 = io.read()
long = tonumber(input2)
print("you want automatic. 1 = yes 0 = no")
input3 = io.read()
auto = input3
print("Turtle go to work")
turtle.forward()
start()
