local version = 0.01 -- WIP For Updater

--[[
	Version
		0.01 7/7/2016
	Changelog
		0.01 - Rewriting
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
local itemError = 0

-- Misc
local corrent
local coalNeeded = 0
local itemError = 0
local noFuelNeed = 0
local totalBlocks = 0
local amountofblockdone = 0

-- Location
local mPosDepth,msPosLenght,mPosWidth = 0,0,0 -- WIP i have plans to use this for moving item to surface without to place random chests

local function mine()

end

local function mineWidth()

end

local function mineLength()

end

-- ItemDump Note: this will be remove soon for new ItemDump Code that work bit like Excavate program build into turtles
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