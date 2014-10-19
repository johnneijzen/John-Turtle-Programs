-- Current Version
--  0.14
-- ChangeLogs
--  0.01 - First Draft
--  0.02 - Added Fuel Code
--  0.03 - Testing and Debugging and fixing values
--  0.04 - Adding Plant code on Cutter Program
--  0.05 - More Spacing Cleaning and Small Debugs
--  0.06 - Starting Working on Back And Wide Programs 6/9/2014
--  0.07 - More Bug Fixing. Note: Still need lot of stuff
--  0.08 - Trying Fixing back code and add left stuff on side program 
--  0.09 - Done Fixing Back Code now working on chest and bit more tweaking on back code
--  0.10 - Adding Chest Code and Enderchest Not Tested i will soon.
--  0.11 - Add waiting code for items and compress some code
--  0.12 - Change: sapling1 > 0 to sapling1 > 1 and sapling2 > 0 to sapling2 > 1 and will accept sapling that was cut
--  0.13 - Remove: enderchest i will add back when i have time and fix spacing but still have no idea
-- 				   what is making program crash
--  0.14 - add repeating options
-- 
-- TODO
--  Other Stuff Named TODO This After Done others
--  And Testing after done with back and fuel programs
--  Fixing Spacing I think i will use tabs for this version 0.11 or 0.12

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
local otherSideMoveCount = 0 -- TODO or not needed later
local upCount = 0
local turtleReachTop = 0
local treeDetect = 0
local facing = 0 -- If turtle is forward then it is 0 if is going back then is 1
local furnace = 0 -- Feature-request TODO
local enderChestOn = 0 -- Feature-request TODO
local x = 0 -- I don't use this only for loop it may be remove later on.
local turtleType = 0
local turtleTimes = 0
local turtleTimesDone = 0

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
		print("turtle will recheck in 5 sec")
		sleep(5)
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
	if sapling1 > 1 then
		turtle.select(3)
		turtle.place()
		sapling1 = turtle.getItemCount(3)
	elseif sapling2 > 1 then
		turtle.select(4)
		turtle.place()
		sapling2 = turtle.getItemCount(4)
	else
		print("out of saplings")
		os.shutdown()
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
	if sapling1 > 1 then
		turtle.select(3)
		turtle.place()
		sapling1 = turtle.getItemCount(3)
	elseif sapling2 > 1 then
		turtle.select(4)
		turtle.place()
		sapling2 = turtle.getItemCount(4)
	else
		print("out of saplings")
		os.shutdown()
	end
	turtle.turnLeft()
	turtle.turnLeft()
end

local function reFuel()
	if noFuelNeeded == 0 then
		repeat
			if turtle.getFuelLevel() < 100 then
				if fuel > 1 then
					turtle.select(1)
					turtle.refuel(1)
					turtle.select(5)
					if turtle.compareTo(1) then
						if turtle.getItemCount > 32 then
							turtle.transferTo(1, 31)
						end
					end
					fuel = turtle.getItemCount(1)
				elseif fuel1 > 1 then
					turtle.select(2)
					turtle.refuel(1)
					turtle.select(5)
					if turtle.compareTo(2) then
						if turtle.getItemCount > 32 then
							turtle.transferTo(2, 31)
						end
					end	
					fuel1 = turtle.getItemCount(2)
				else
					print("out of fuel")
					os.shutdown()
				end
			end
		until turtle.getFuelLevel() >= 100
	end
end

local function side() 
	turtle.forward()
	longCount = 0
	sideMoveCount = sideMoveCount + 3 
	if facing == 0 then
		turtle.turnRight()
		turtle.forward()
		turtle.forward()
		turtle.forward()
		turtle.turnRight()
		facing = 1
	else --TODO
		facing = 0
		turtle.turnLeft()
		turtle.forward()
		turtle.forward()
		turtle.forward()
		turtle.turnLeft()
	end
end

local function back() --TODO
	if facing == 1 then
		turtle.forward()
		turtle.turnRight()
		repeat
			turtle.forward()
			sideMoveCount = sideMoveCount - 1
		until sideMoveCount == 0 
		turtle.turnRight()
		turtle.back()
	else
		turtle.forward()
		turtle.turnLeft()
		repeat
			turtle.forward()
			sideMoveCount = sideMoveCount - 1
		until sideMoveCount == 0 
		turtle.turnLeft()
		turtle.back()  
	end
end

local function chest()
	turtle.turnLeft()
	turtle.turnLeft()
	for slot = 6, 16 do
		turtle.select(slot)
		sleep(1.0)
		turtle.drop()
	end
end

local function restart()
	if turtleType == 0 then
		longCount = 0
		wideCount = 0
	elseif turtleType == 1 then
		sleep(180)
		longCount = 0
		wideCount = 0
	elseif turtleType == 2 then
		if turtleTimesDone ~= turtleTimes then
			turtleTimes = turtleTime + 1
		else
			print("turtle is Done")
			os.shutdown()
		end
	end
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
		wideCount = wideCount + 1
		if wide ~= wideCount then 
			side()
		end
	until wide == wideCount
	back()
	chest()
	restart()
	start()
end

-- Starting
print("Welecome to Turtle Tree Logger Program")
print("Fuel in slot 1 & 2, and Sapling in slot 3 & 4, and one piece of wood that you are farming in slot 5")
print("turtle is sleep 10 sec to wait for items")
sleep(10)
fuel = turtle.getItemCount(1)
fuel1 = turtle.getItemCount(2)
sapling1 = turtle.getItemCount(3)
sapling2 = turtle.getItemCount(4)
treeBlock = turtle.getItemCount(5)
print("How long for saplings")
input1 = io.read()
long = tonumber(input1)
print("How wide for Saplings")
input2 = io.read()
wide = tonumber(input2)
print("what type of repeater want to use")
print("0 = is forever but it done wait for 180 sec it useful small tree farms")
print("1 = is forever when it reach end so soon turtle put it item he will start aging")
print("2 = user will choose how many time")
input3 = io.read()
turtleType = tonumber(input3)
if turtleType == 2 then
	print("how many times")
	input4 = io.read()
	turtleTimes = tonumber(input4)
end
print("Turtle go to work")
if turtle.getFuelLevel() == "unlimited" then 
	print("your turtle configure does not need fuel")
	noFuelNeeded = 1
elseif turtle.getFuelLevel() < 100 then
	reFuel()
end
check()
if itemError == 1 then
	repeat
		reCheck()
		check()
	until itemError == 0
end
start()
