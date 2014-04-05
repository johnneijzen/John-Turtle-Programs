-- This Version
--  0.29
-- Changelogs
--  0.21 Fixing Gravel block chest bug
--  0.22 Improving Mining Speed by adding turtle.detect(), turtle.detectDown(), turtle.detectUp()
--  0.23 Adding More Comments so can keep Track and remove blank space and fixing two Bug.
--  0.24 Better Fix to UI and More Bug Fixing
--  0.25 Fixing My Programming error
--  0.26 Trying to fix Chest Bug
--  0.27 Fixed Chest Bug My Bad 
--  0.28 Improving Wide Code By adding turtle.detect() , turtle.detectUp() , turtle.detectDown() so it bit fast and stable
--  0.29 Rewrite of Everything

-- Local Variables
local Wide = 0  -- How Wide 
local Wc = 0 -- Wide Counter
local Long = 0 -- How Long
local Lc = 0 -- Long Counter
local High = 0 -- How High
local Hc = 0 -- Hign Counter
local FuelCount = turtle.getItemCount(1) -- Fuel Counter
local FuelCount1 = turtle.getItemCount(2) -- Fuel 2 Counter
local Chest = turtle.getItemCount(3) -- Chest Counter
local TotalBlocks = 0 -- TotalBlocks
local LSorWS = 0 -- Go Left or Go Right This is for Wide Code
local Error = 0 -- Error Code
local Recheck = 0 -- Recheck Code
local NoFuelNeed = 0 -- If computercraft Config Has Fuel Off then this is 1 but not then it is 0
local TotalBlockDone = 0 -- How many Block Mined
local BlockUp = 0 -- Fixing to Chest Probleem and moving probleem

-- Local Functions
local function Length() -- Length Mine
	if turtle.detect() then
		turtle.dig()
	end
	if turtle.forward() then
		Lc = Lc + 1
		TotalBlockDone = TotalBlockDone + 3
		print(TotalBlocks - TotalBlockDone)
	end
	if turtle.detectUp() then
		turtle.digUp()
	end
	if turtle.detectDown() then
		turtle.digDown()
	end
end

local function Wide() -- Wide Around Right
	turtle.turnRight()
	if turtle.detect() then
		turtle.dig()
		sleep(2) -- Minor bug fix if there is gravel
	end
	if turtle.forward() then
		turtle.digDown()
	else
		repeat
			turtle.dig()
			sleep(2)
			if turtle.forward() then
				BlockUp = 0
			else
				BlockUp = 1
			end
		until BlockUp == 0
	end
	if turtle.detectUp() then
		turtle.digUp()
	end
	if turtle.detechDown() then
		turtle.digDown()
	end
	turtle.turnRight()
	LSorWS = 1
	Lc = 0
	Wc = Wc + 1
end

local function Wide2() -- Wide Around Left
	turtle.turnLeft()
	if turtle.detect() then
		turtle.dig()
		sleep(2) -- Minor bug fix if there is gravel
	end
	if turtle.forward() then
		turtle.digDown()
	else
		repeat
			turtle.dig()
			sleep(2)
			if turtle.forward() then
				BlockUp = 0
			else
				BlockUp = 1
			end
		until BlockUp == 0
	end
	if turtle.detectUp() then
		turtle.digUp()
	end
	if turtle.detechDown() then
		turtle.digDown()
	end
	turtle.turnLeft()
	LSorWS = 0
	Lc = 0
	Wc = Wc + 1
end

-- High Code
local function High()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	Wc = 0
	Lc = 0
	Hc = Hc + 3
end

-- Checking
local function Check()
	if FuelCount == 0 then
		print("Turtle has no fuel")
		print("put fuel in 1 first and second slot")
		Error = 1
	else
		print("turtle has Fuel")
	end
	if FuelCount1 == 0 then
		print("turtle has no extra fuel but if is short job it okey")
	end
	if Chest == 0 then
		print("No chest in Turtle")
		print("Put chest in 3 slot")
		Error = 1
	else
		print("turtle has chest")
	end
	if Error == 1 then
		print("Items are missing please try again")
		print("turtle will recheck in 15 sec")
	end
end

-- Recheck if user forget something turtle will check after 15 sec
local function Recheck()
	FuelCount = turtle.getItemCount(1)
	FuelCount1 = turtle.getItemCount(2)
	Chest = turtle.getItemCount(3)
	Error = 0
end

-- Refuel
local function Refuel()
	if NoFuelNeed == 0 then
		if turtle.getFuelLevel() < 300 then
			if FuelCount > 10 then
				turtle.select(1)
				turtle.refuel(12)
				FuelCount = FuelCount - 10
			elseif FuelCount1 > 10 then
				turtle.select(2)
				turtle.refuel(12)
				FuelCount1 = FuelCount1 - 10
			else
				print("out of fuel")
				os.shutdown()
			end
		end
	end
end

local function Chest()
	if turtle.getItemCount(16)> 0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
		repeat -- The Fix to Gravel Chest Bug. It check if gravel above then it dig three times
			turtle.digUp()
			sleep(2)
			if turtle.detectUp() then
				BlockUp = 0
			else
				BlockUp = 1
			end
		until BlockUp == 1
		turtle.select(3)
		turtle.placeUp()
		Chest = Chest - 1
		for slot = 4, 16 do
			turtle.select(slot)
			turtle.dropUp()
			sleep(1.5) -- Small fix for slow pc because i had people problem with this
		end
		turtle.select(4)
		if Chest == 0 then
			print("Out Of Chest")
			os.shutdown()
		end
	end
end

function MainPart()
	repeat
		repeat
			Length()
			Refuel()
			Chest()
			if Long == Lc then
				if LSorWS == 0 then
					Wide()
				else
					Wide2()
				end
			end
		until Wide == Wc
		High()
	until High = Hc
end

-- Starting
print("Welcome To Excavation Turtle Program")
print("Note: This Program Stop Before Bedrock.")
print("Slot 1: Fuel, Slot 2:Fuel, Slot 3:Chest")
print("Note: if now put item in then it say error just wait for recheck")
print("How long you want")
input = io.read()
Wide = tonumber(input)
Wide = Wide - 1
print("How wide you want")
input2 = io.read()
Long = tonumber(input2)
Long = Long - 1
print("What is turtle high aka Y value")
input3 = io.read()
High = tonumber(input3)
High = High - 5
print("caluclating")
TotalBlocks = Wide * Long * High
print("Total amount for block to mine is")
print(TotalBlocks)
print("turtle now starting")
if turtle.getFuelLevel() == "unlimited" then 
	print("your turtle config does need fuel")
	NoFuelNeed = 1
elseif turtle.getFuelLevel() < 200 then
	turtle.select(1)
	turtle.refuel(2)
end
Check()
repeat Error == 1 then
	Recheck()
	Check()
until Error = 0
MainPart()
