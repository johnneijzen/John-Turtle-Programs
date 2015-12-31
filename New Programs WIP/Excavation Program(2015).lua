--[[
Version
	0.07 31/12/2015
Changelog
	0.01 - Starting Of Rewriting 20/8/2015
	0.02 - More Rewriting...... 
	0.03 - Testing phase....... 10/12/2015 8:00 PM
	0.04 - Minor Enchaments and bug fixing 10/12/2015 10:00 PM
	0.05 - Fully Working it pass Testing Phase if there are bugs please report on github 10/12/2015 11:50 PM
	0.06 - Quick Auto reformater So make everything tap not space 10/13/2015
	0.07 - Minor Improvement in itemCheck that you didnt put chest in fuelslot.
]]

-- Local Variables in My New Program style it now a-z not random
-- Area
local deep = 0
local deepCount = 0
local long = 0
local longCount = 0
local wide = 0
local wideCount = 0
-- Misc
local corrent = n
local coalNeeded = 0
local progress = 0
local progressPercent = 0
local redstoneStart = 0 -- 0 is normal start and 1 is starting with redstone.
local redstoneOn = 0 -- 1 if redstone is detected and 0 if not
local totalBlocks = 0
local totalBlocksDone = 0
-- Inventory
local chest = 0
local enderChest = 0 -- TODO
local fuelCount = 0
local fuelCount1 = 0
local noFuelNeed = 0 -- This is 0 if fuel is needed and 1 is not needed
local missingItems = 0
-- Dig
local blocked = 0 -- Fixing to Chest Probleem and moving probleem
local LorR = 0 -- Left or Right This is for Wide Code
local doneDig = 0

-- Main Functions in order when is it used.

-- ItemCheck
local function itemCheck()
	chest = turtle.getItemCount(3)
	fuelCount = turtle.getItemCount(1)
	fuelCount1 = turtle.getItemCount(2)
	missingItems = 0
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
	turtle.select(1)
	if turtle.compareTo(2) then
		-- noting
	else
		print("Move Chest To Thrid Slot")
		print("Otherwise it use chest as fuel")
		missingItems = 1
	end
	if chest == 0 then
		print("No chest in Turtle")
		print("Put chest in Thrid slot")
		missingItems = 1
	else
		print("Turtle has chest")
	end
	if missingItems == 1 then
		print("Items are missing please try again")
		print("Turtle will recheck in 5 sec")
	end 
end

-- ItemDump
local function chestDump()
	if turtle.getItemCount(16)> 0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
		repeat -- Better Fix To Gravel Problem. Compacted and Faster and less like to break.
			sleep(0.6) -- I let turtle wait for 0.6 second for gravel to fall
			if turtle.detectUp() then -- if there is gravel remove it before placing chest
				turtle.digUp()
				sleep(0.6)
				blocked = 1
			else
				blocked = 0
			end
		until blocked == 0
		turtle.select(3)
		turtle.placeUp()
		chest = chest - 1
		for slot = 4, 16 do
			turtle.select(slot)
			sleep(0.6) -- Small fix for slow pc because i had people problem with this
			turtle.dropUp()
		end
		turtle.select(4)
		if chest == 0 then
			print("Out Of Chest")
			os.shutdown()
		end
	end
end

-- Refuel
local function refuel()
	if noFuelNeed == 0 then
		repeat
			if turtle.getFuelLevel() < 120 then
				if fuelCount > 0 then
					turtle.select(1)
					turtle.refuel(1)
					fuelCount = fuelCount - 1
				elseif fuelCount1 > 0 then
					turtle.select(2)
					turtle.refuel(1)
					fuelCount1 = fuelCount1 - 1
				else
					print("out of fuel")
					os.shutdown()
				end
			end
		until turtle.getFuelLevel() >= 120
	end
end

-- Mining Lenght
local function mineLong()
	if turtle.detect() then
		turtle.dig()
	end
	if turtle.forward() then
		-- Notting
	else
		repeat
			if turtle.detect() then -- First check if there is block front if there is dig if not next step.
				turtle.dig()
				sleep(0.6)
			end
			if turtle.forward() then -- try to move if turtle can move blocked == 0 if cant move then blocked 1
				blocked = 0
			else
				blocked = 1
			end
		until blocked == 0
	end
	if turtle.detectUp() then
		turtle.digUp()
	end
	if turtle.detectDown() then
		turtle.digDown()
	end
	longCount = longCount + 1
	totalBlocksDone = totalBlocksDone + 3
end

-- Mining Width
local function mineWide()
	if LorR == 0 then
		turtle.turnRight()
	else
		turtle.turnLeft()
	end
	if turtle.detect() then
		turtle.dig()
	end
	if turtle.forward() then
		--Notting
	else
		repeat
			if turtle.detect() then
				turtle.dig()
				sleep(0.6)
			end
			if turtle.forward() then
				blocked = 0
			else
				blocked = 1
			end
		until blocked == 0
	end
	if turtle.detectUp() then
		turtle.digUp()
	end
	if turtle.detectDown() then
		turtle.digDown()
	end
	if LorR == 0 then
		turtle.turnRight()
		LorR = 1
	else
		turtle.turnLeft()
		LorR = 0
	end
	longCount = 0
	wideCount = wideCount + 1
	totalBlocksDone = totalBlocksDone + 3
end

-- Mine Deep
local function mineDeep()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	turtle.turnRight()
	turtle.turnRight()
	wideCount = 0
	longCount = 0
	deepCount = deepCount + 3
	totalBlocksDone = totalBlocksDone + 3
end

local function firstDig()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	wideCount = 0
	longCount = 0
	deepCount = deepCount + 3
	totalBlocksDone = totalBlocksDone + 3
end

local function main()
	repeat
		mineLong()
		refuel()
		chestDump()
		if longCount == long then
			process = totalBlocksDone / totalBlocks * 100
			processRaw = totalBlocks - totalBlocksDone
			print("How Much Is Done: " .. math.floor(process+0.5) .. " %")
			print("TotalBlocks Still Need To Dig Is " .. processRaw)
			if wideCount == wide then
				if deepCount < deep then
					mineDeep()
				end
			else
				mineWide()
			end
		end
		if longCount == long and wideCount == wide and deepCount >= deep then
			doneDig = 1
		end
	until doneDig == 1
	print("turtle is Done")
end

local function start()
	print("Welcome To Excavation Turtle Program")
	print("Slot 1: Fuel, Slot 2: Fuel, Slot 3: Chest")
	print("Note: If now put item in then it say Error just wait it fix it self")
	print("Whats is Lenght you want")
	long = tonumber(read())
	long = long - 1
	print("Whats is Width you want")
	wide = tonumber(read())
	wide = wide - 1
	print("Whats is Depth You Want")
	deep = tonumber(read())
	print("Is This Corrent Lenght " .. "Lenght = " .. (long + 1) .. " Width = " .. (wide + 1) .. " Depth = " .. (deep))
	print("Type y Or Y if it is correct and if not then n or N")
	corrent = read()
	if corrent == n or N then
		os.reboot()
	end
	print("Okey Program Will Do Calculations")
	totalBlocks = (wide + 1) * (long + 1) * deep -- 1 is add because above it removed for wide and long code
	print("Total amount for block to mine is " .. totalBlocks)
	coalNeeded = totalBlocks / 3 / 80
	print("Total amount for Coal needed is " .. math.floor(coalNeeded+0.5))
	if turtle.getFuelLevel() == "unlimited" then
		print("Your turtle config does need fuel")
		noFuelNeed = 1
	end
	print("Do You Want Redstone as Starting Input")
	print("Note: It Only Detect Back of Turtle")
	print("if not then type 0 if yes then type 1")
	starting = tonumber(read())
	itemCheck()
	check()
	if missingItems == 1 then
		repeat
			sleep(5)
			itemCheck()
			check()
		until missingItems == 0
	end
	if noFuelNeed == 0 then
		if turtle.getFuelLevel() < 120 then
			turtle.select(1)
			turtle.refuel(2)
		end
	end
	if starting == 0 then
		print("Turtle will now start!")
		firstDig()
		main()
	elseif starting == 1 then
		repeat
			os.pullEvent("redstone") -- Wait For Redstone Input without it break with words Too long without yielding.
			if redstone.getInput("back") then
				On = 1
			end	
		until On == 1
		print("Turtle will now start!")
		firstDig()
		main()
	end	
end

start()
