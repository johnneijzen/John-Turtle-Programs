-- This version
-- 0.01
-- Changelogs
-- 0.01 First Coding

-- Local
local Distance = 0 -- How Far
local DistanceCounter = 0
local BDistance = 0 -- Back Distance
local Chest = turtle.getItemCount(1)
local Fuel = turtle.getItemCount(2)
local NoNeedFuel = 0
local Error = 0

-- Starting Part
function Check()
	if Chest == 0 then
		print("No chest in Turtle")
		print("Put chest in slot 1")
		Error = 1
	else
		print("turtle has chest")
	end
	if Fuel == 0 then
		print("No Chest in Turtle")
		print("Put Fuel in Slot 2")
		Error = 1
	else
		print("Turtle Has Fuel")
	end
	if Error == 1 then
		print("Items are missing please try again")
		print("turtle will recheck in 15 sec")
		sleep(15)
		recheck()
	else
		Mine()
	end
end

-- Recheck Code
function recheck()
	Chest = turtle.getItemCount(1)
	Fuel = turtle.getItemCount(2)
	Error = 0
	Check()
end

-- Mine Part
function Mine()
	repeat
		if turtle.detect() then
			turtle.dig()
		end
		if turtle.forward then -- if gravel block it Distance wont mixup
			BDistance = BDistance + 1
			DistanceCounter = DistanceCounter + 1
		end
		if turtle.detectUp() then
			turtle.digUp()
		end
		turtle.turnLeft()
		if turtle.detect() then
		  turtle.dig()
		end
		turtle.up()
		if turtle.detect() then
			turtle.dig()
		end
		if turtle.detectUp() then
		  turtle.digUp()
		end
		turtle.up()
		if turtle.detect() then
      turtle.dig()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    if turtle.detect() then
		  turtle.dig()
		end
		turtle.down()
		if turtle.detect() then
		  turtle.dig()
		end
		turtle.down()
		if turtle.detect() then
		  turtle.dig()
		end
		turtle.turnLeft()
		if turtle.getItemCount(16)>0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
		  turtle.digDown()
			turtle.select(1)
			turtle.placeDown()
			Chest = Chest - 1
		  for slot = 3, 16 do
        turtle.select(slot)
        turtle.dropDown()
        sleep(1.5) -- Small fix for slow pc because i had people problem with this  
	    end
	  end
	  if NoFuelNeed == 0 then
      if turtle.getFuelLevel() < 200 then
        if Fuel > 10 then
          turtle.select(1)
          turtle.refuel(10)
          Fuel = Fuel - 10
        else
          print("out of fuel")
					sleep(300000)
        end
      end
		end
	until DistanceCounter == Distance
end

-- Gui Part
print("Hi Welcome To Tunnel Program By John")
print("This Program 3x3 Tunnel")
print("Pls Put Chest in Slot 1")
print("Pls Put Fuel in Slot 2")
print("How long do you want tunnel")
input = io.read()
Distance = tonumber(input)
if turtle.getFuelLevel() == "unlimited" then 
  print("your turtle config does need fuel")
  NoFuelNeed = 1
elseif turtle.getFuelLevel() < 100 then
  turtle.select(1)
  turtle.refuel(2)
end
Check()
