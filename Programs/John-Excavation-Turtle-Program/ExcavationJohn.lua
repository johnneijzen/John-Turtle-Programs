-- This Version
--  0.38 4/10/2014 2:00 AM
-- Changelogs
--  0.30 Rewrite of Everything
--  0.31 Extreme Bugs Fixing
--  0.32 Change Speed of Wide so wont look like program stop but if gravel in way it still works and change speed of Chest Code
--  0.33 Weird Chest Bug With Gravel Fix. So i change speed of chest to 1 sec i hope that fix it.
--  0.34 I think i found out want was making items on ground when turtle go back it cant bump it item so it on floor i now fix it.
--  0.35 Opps Fuel Code was worng
--  0.36 Fully Fixed Bug Where Items fall on ground it was Length Code
--  0.37 Change: Until High == Hc To Until High <= Hc so if number is not divible by 3 will stop when it past high limit
--  0.38 Change: Remove -5 on high so you can have you own hight

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
local function Length1() -- Length Mine
	if turtle.detect() then
		turtle.dig()
	end
	if turtle.forward() then
		Lc = Lc + 1
		TotalBlockDone = TotalBlockDone + 3
		print(TotalBlocks - TotalBlockDone)
	else
		repeat
			turtle.dig()
			sleep(0.6)
			if turtle.forward() then
				BlockUp = 0
			else
				BlockUp = 1
			end
		until BlockUp == 0
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

local function Wide1() -- Wide Around Right
	turtle.turnRight()
	if turtle.detect() then
		turtle.dig()
		sleep(0.6) -- Minor bug fix if there is gravel
	end
	if turtle.forward() then
	else
		repeat
			turtle.dig()
			sleep(0.6)
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
	if turtle.detectDown() then
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
		sleep(0.6) -- Minor bug fix if there is gravel
	end
	if turtle.forward() then
	else
		repeat
			turtle.dig()
			sleep(0.6)
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
	if turtle.detectDown() then
		turtle.digDown()
	end
	turtle.turnLeft()
	LSorWS = 0
	Lc = 0
	Wc = Wc + 1
end

-- High Code
local function High1()
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
		print("turtle will recheck in 10 sec")
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
				turtle.refuel(10)
				FuelCount = FuelCount - 10
			elseif FuelCount1 > 10 then
				turtle.select(2)
				turtle.refuel(10)
				FuelCount1 = FuelCount1 - 10
			else
				print("out of fuel")
				os.shutdown()
			end
		end
	end
end

local function Chest1()
	if turtle.getItemCount(16)> 0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
		repeat -- The Fix to Gravel Chest Bug. It check if gravel above then it dig three times
			turtle.digUp()
			sleep(1)
			if turtle.detectUp() then
				turtle.digUp()
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
			sleep(1.45) -- Small fix for slow pc because i had people problem with this
			turtle.dropUp()
		end
		turtle.select(4)
		if Chest == 0 then
			print("Out Of Chest")
			os.shutdown()
		end
	end
end

local function Start()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	Wc = 0
	Lc = 0
	Hc = Hc + 3
end

function MainPart()
	repeat
		repeat
			Length1()
			Refuel()
			Chest1()
			if Long == Lc then
				if LSorWS == 0 then
					Wide1()
				else
					Wide2()
				end
			end
		until Wide == Wc
		repeat
			Length1()
			Refuel()
			Chest1()
		until Long == Lc
		turtle.turnRight()
		LSorWS = 0
		High1()
	until High <= Hc
	print("Turtle Is Done")
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
print("How Deep You Want")
input3 = io.read()
High = tonumber(input3)
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
if Error == 1 then
	repeat
		sleep(10)
		Recheck()
		Check()
	until Error == 0
end
Start()
MainPart()
