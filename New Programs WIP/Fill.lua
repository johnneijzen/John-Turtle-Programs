--[[
Version
        0.02 31/12/2015
Changelog
        0.01 - First Draft
		0.02 - Updates
]]
 
-- Local Variables in My New Program style it now a-z not random
-- Area
local long = 0
local longCount = 0
local wide = 0
local wideCount = 0
local high = 0
local highCount = 0
--Misc
local buildSlot = 3
local donePlacing = 0
local fuelItem = 0
local fuelItem1 = 0
local noFuelNeed = 0
local LorR = 0
local selectType = 0

 
local function refuel()
	if noFuelNeed == 0 then
		repeat
			if turtle.getFuelLevel() < 100 then
				if fuelItem > 0 then
					turtle.select(1)
					turtle.refuel(1)
					fuelItem = fuelItem - 1
				elseif fuelCount1 > 0 then
					turtle.select(2)
					turtle.refuel(1)
					fuelCount1 = fuelCount1 - 1
				else
					print("out of fuel")
					os.shutdown()
				end
			end
		until turtle.getFuelLevel() >= 100
	end
end
 
local function placeLong()
	if turtle.getItemCount(buildSlot) == 0 then
		repeat
			buildSlot = buildSlot + 1
			if buildSlot > 16 then
				print("Out of Build Materials")
				os.shutdown()
			end
		until turtle.getItemCount(buildSlot) > 0
	end
	turtle.select(buildSlot)
	turtle.placeDown()
	if turtle.forward() then
		longCount = longCount + 1
	else
		turtle.dig()
		longCount = longCount + 1
	end
end
 
local function placeWide()
	if LorR == 0 then
		turtle.turnRight()
	else
		turtle.turnLeft()
	end
	turtle.placeDown()
	turtle.forward()
	if turtle.getItemCount(buildSlot) == 0 then
		repeat
			buildSlot = buildSlot + 1
			if buildSlot > 16 then
				print("Out of Build Materials")
				os.shutdown()
			end
		until turtle.getItemCount(buildSlot) > 0
	end
	turtle.select(buildSlot)
	turtle.placeDown()
	if LorR == 0 then
		turtle.turnRight()
		LorR = 1
	else
		turtle.turnLeft()
		LorR = 0
	end
	longCount = 0
	wideCount = wideCount + 1
end
 
local function fill()
	repeat
		refuel()
		placeLong()
		if longCount == long then
			if wideCount == wide then
				-- Notting
			else
				placeWide()
			end
		end
		if longCount == long and wideCount == wide then
			donePlacing = 1
		end
	until donePlacing == 1
	print("turtle is Done")
end

local function placeWallLong()
	longCount = 0
	repeat
		if turtle.getItemCount(buildSlot) == 0 then
			repeat
				buildSlot = buildSlot + 1
				if buildSlot > 16 then
					print("Out of Build Materials")
					os.shutdown()
				end
			until turtle.getItemCount(buildSlot) > 0
		end
		turtle.placeDown()
		turtle.placeUp()
		if turtle.back() then
			turtle.place()
			longCount = longCount + 1
		else
			turtle.turnRight()
			turtle.turnRight()
			turtle.dig()
			turtle.turnRight()
			turtle.turnRight()
			turtle.back()
			turtle.place()
			longCount = longCount + 1
		end
	until longCount == long
end

local function placeWallWide()
	wideCount = 0
	repeat
		if turtle.getItemCount(buildSlot) == 0 then
			repeat
				buildSlot = buildSlot + 1
				if buildSlot > 16 then
					print("Out of Build Materials")
					os.shutdown()
				end
			until turtle.getItemCount(buildSlot) > 0
		end
		turtle.placeDown()
		turtle.placeUp()
		if turtle.back() then
			turtle.place()
			wideCount = wideCount + 1
		else
			turtle.turnRight()
			turtle.turnRight()
			turtle.dig()
			turtle.turnRight()
			turtle.turnRight()
			turtle.back()
			turtle.place()
			wideCount = wideCount + 1
		end
	until wideCount == wide
end

local function placeWallEnd()
	wideCount = 0
	repeat
		if turtle.getItemCount(buildSlot) == 0 then
			repeat
				buildSlot = buildSlot + 1
				if buildSlot > 16 then
					print("Out of Build Materials")
					os.shutdown()
				end
			until turtle.getItemCount(buildSlot) > 0
		end
		turtle.placeDown()
		turtle.placeUp()
		if turtle.back() then
			turtle.place()
			wideCount = wideCount + 1
		else
			turtle.turnRight()
			turtle.turnRight()
			turtle.dig()
			turtle.turnRight()
			turtle.turnRight()
			turtle.back()
			turtle.place()
			wideCount = wideCount + 1
		end
	until wideCount == wide - 1
	turtle.up()
	turtle.placeDown()
	turtle.up()
	turtle.placeDown()
	turtle.forward()
	turtle.turnRight()
end

local function wall()
	repeat
		turtle.up()
		turtle.turnRight()
		turtle.turnRight()
		placeWallLong()
		turtle.turnRight()
		placeWallWide()
		turtle.turnRight()
		placeWallLong()
		turtle.turnRight()
		placeWallEnd()
		print("turtle is Done")
		highCount = highCount + 3
	until high == highCount 
end
 
 -- Checking
local function check()
	if noFuelNeed == 0 then
		if fuelCount == 0 then
			print("Turtle has no fuel")
			print("Put fuel in First and Second slot")
			missingItems = 1
		else
			print("Turtle has Fuel")
		end
		if fuelCount1 == 0 then
			print("Turtle has no extra fuel but if is short job it okey")
		end
	end
	if missingItems == 1 then
		print("Items are missing please try again")
		print("Turtle will recheck in 5 sec")
	end 
end

local function itemCheck()
	chest = turtle.getItemCount(3)
	fuelCount = turtle.getItemCount(1)
	fuelCount1 = turtle.getItemCount(2)
	missingItems = 0
end
 
--starting
local function starting()
	print("welcome to John Fill Program")
	print("Fuel Slot 1 and Slot 2")
	print("Build Materials: Slot 3 to 16")
	print("Please enter lenght you want to fill")
	long = tonumber(read())
	long = long - 1
	print("Please enter wide you want to fill")
	wide = tonumber(read())
	wide = wide - 1
	print("Please enter what type fill you want")
	print("1 = Fill, 2 = Walls(WIP), 3 = Cube(WIP)")
	selectType = tonumber(read())
	if turtle.getFuelLevel() == "unlimited" then
		print("Your turtle config does need fuel")
		noFuelNeed = 1
	end
	repeat
		itemCheck()
		check()
		sleep(5)
	until missingItems == 0
	if selectType == 1 then
		fill()
	elseif selectType == 2 then
		print("Please Enter Hight you want")
		high = tonumber(read())
		wall()
	elseif selectType == 3 then
		-- cube()
	end
end
 
starting()
