local version = 0.02 -- WIP For Updater

--[[
	Version
		0.02 7/8/2016
	Changelog
		0.01 - Rewriting 7/7/2016
		0.02 - Adding MORE FETURES 7/8/2016 
]]--

-- Global Variables 

-- Area
local deep = 0
local deepCount = 0
local long = 0
local longCount = 0
local wide = 0
local wideCount = 0

-- Inventory
local chest = 0
local fuelCount = 0
local fuelCount1 = 0
local itemError = 0

-- Misc
local blocked = 0
local corrent = 'N'
local coalNeeded = 0
local doneDig = 0
local itemError = 0
local noFuelNeed = 0
local totalBlocks = 0
local totalBlocksDone = 0
local LorR = 0

-- Location
local mineLenghtPoint, mineWidthPoint, mineDepthPoint = 0,0,0
local currentLenghtPoint, currentWidthPoint, currentDepthPoint = 0,0,0

local function goToStartPoint() -- WIP TODO
	mineLenghtPoint = longCount
	mineWidthPoint = wideCount
	mineDepthPoint = deepCount
	currentLenghtPoint = longCount
	currentWidthPoint - wideCount
	currentDepthPoint = deepCount
end

local function goToMinePoint() -- WIP TODO

end

local function newItemDump() -- WIP TODO
	goToStartPoint()
	for slot = 4, 16 do
		turtle.select(slot)
		turtle.dropUp()
		sleep(0.5)
	end
	goToMinePoint()
end

-- ItemDump Note: this will be remove soon for new ItemDump Code that work bit like Excavate program build into turtles
local function chestDump()
	if turtle.getItemCount(16)> 0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
		repeat
			sleep(0.6)
			if turtle.detectUp() then
				turtle.digUp()
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
			turtle.dropUp()
			sleep(0.5)
		end
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

local function itemCheck()
	repeat
		fuelCount = turtle.getItemCount(1)
		fuelCount1 = turtle.getItemCount(2)
		chest = turtle.getItemCount(3)
		itemError = 0
		if noFuelNeed == 0 then
			if fuelCount == 0 then
				print("Turtle has no fuel")
				print("Put fuel in First and Second slot")
				itemError = 1
			end
			if fuelCount1 == 0 then
				print("Turtle has no extra fuel but if is short job it okey")
			end
		end
		turtle.select(1)
		if not turtle.compareTo(2) then
			print("Move Chest To Thrid Slot")
			print("Otherwise it use chest as fuel")
			itemError= 1
		end
		if chest == 0 then
			print("No chest in Turtle")
			print("Put chest in Thrid slot")
			itemError = 1
		end
		if itemError == 1 then
			print("Items are missing please try again")
			print("Turtle will recheck in 5 sec")
		end
	until itemError == 0
end

local function mineLength()
	if turtle.detect() then
		turtle.dig()
	end
	if not turtle.forward() then
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

local function mineWidth()
	if LorR == 0 then
		turtle.turnRight()
	else
		turtle.turnLeft()
	end
	if turtle.detect() then
		turtle.dig()
	end
	if not turtle.forward() then
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

local function mineDepth()
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

local function digFirstPart()
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

local function mine()
	digFirstPart()
	repeat
		mineLength()
		refuel()
		chestDump()
		if longCount == long then
			print("How Much Is Done: " .. math.floor((totalBlocksDone / totalBlocks * 100) + 0.5) .. "%")
			print("TotalBlocks Still Need To Dig Is: " .. totalBlocks/totalBlocksDone)
			if wideCount == wide then
				if deepCount < deep then
					mineDepth()
				end
			else
				mineWidth()
			end
		end
		if longCount == long and wideCount == wide and deepCount >= deep then
			doneDig = 1
		end
	until doneDig == 1
end

local function main()
	print("Welcome To Excavation Turtle Program")
	print("Slot 1: Fuel, Slot 2: Fuel, Slot 3: Chest")
	print("Note: If now put item in then it say Error just wait it fix it self")
	repeat
		print("Whats is Lenght you want")
		long = tonumber(read() - 1)
		print("Whats is Width you want")
		wide = tonumber(read() - 1)
		print("Whats is Depth You Want")
		deep = tonumber(read() - 1)
		print("Is This Corrent Lenght " .. "Lenght = " .. (long + 1) .. " Width = " .. (wide + 1) .. " Depth = " .. (deep))
		print("it is correct: ")
		corrent = read()
	until corrent == y or Y
	print("Okey Program Will Do Calculations")
	totalBlocks = (wide + 1) * (long + 1) * deep
	print("Total amount for block to mine is " .. totalBlocks)
	coalNeeded = totalBlocks / 3 / 80
	print("Total amount for Coal needed is " .. math.floor(coalNeeded+0.5))
	if turtle.getFuelLevel() == "unlimited" then
		print("Your turtle config does need fuel")
		noFuelNeed = 1
	end
	itemCheck()
	refuel()
	mine()
end

main()