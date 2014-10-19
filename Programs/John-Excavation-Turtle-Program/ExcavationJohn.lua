-- This Version
--  0.45 10/19/2014
-- Changelogs
--  0.37 Change: Until High == Hc To Until High <= Hc so if number is not divisible by 3 will stop when it past high limit
--  0.38 Change: Remove -5 on high so you can have you own hight
--  0.39 Change: TotalBlock calculating has change to after is done doing length so it wont spam and percentage so it is to read
--               And Add Feature CoalNeeded This Not 100% or not at all but i will find better way.
--  0.40 Lot Change in CoalNeeded and it now print Corrent Block to need to dig
--  0.41 Trying to High problem and TotalBlocks Problems
--  0.42 Fully Fix and compressing code to make it easier and Fully Working TotalBlock Counter So i hope that charcoal system 
--       Code as normal and 100% corrent Amount but i`m not sure yet 
--  0.43 i`m Lowering Fuel Limits so can this use turtle when you only need 3 coal for ex. and it uses less fuel now
--       Limit is now 160 from 200 and refuel is now 1 from 10 so i will use one coal still it reach 160 it this makes
--	 more fuel friendly and change check of item from instant to 15 sec so you have time to think
--  0.44 Fix String Error
--  0.45 Made mistake i made wide to lenght and lenght to wide
-- TODO
-- Enderchest Support

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
local ProcessRaw = 0
local Process = 0
local CoalNeeded = 0
local EnderChest = 0
local BlockUp = 0 -- Fixing to Chest Probleem and moving probleem

-- Local Functions
local function Length1() -- Length Mine
	if turtle.detect() then
		turtle.dig()
	end
	if turtle.forward() then
		Lc = Lc + 1
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
		print(TotalBlocks - TotalBlockDone)
	end
	if turtle.detectUp() then
		turtle.digUp()
	end
	if turtle.detectDown() then
		turtle.digDown()
	end
	TotalBlockDone = TotalBlockDone + 3
end

local function Wide1() -- Wide Around Right
	turtle.turnRight()
	if turtle.detect() then
		turtle.dig()
		sleep(0.6)
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
	TotalBlockDone = TotalBlockDone + 3
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
	TotalBlockDone = TotalBlockDone + 3
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
	TotalBlockDone = TotalBlockDone + 3
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
		repeat
			if turtle.getFuelLevel() < 160 then
				if FuelCount > 0 then
					turtle.select(1)
					turtle.refuel(1)
					FuelCount = FuelCount - 1
				elseif FuelCount1 > 0 then
					turtle.select(2)
					turtle.refuel(1)
					FuelCount1 = FuelCount1 - 1
				else
					print("out of fuel")
					os.shutdown()
				end
			end
		until turtle.getFuelLevel() >= 160
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
	TotalBlockDone = TotalBlockDone + 3
end

function MainPart()
	repeat
		repeat
			Length1()
			Refuel()
			Chest1()
			if Long == Lc then
				Process = TotalBlockDone / TotalBlocks * 100
				ProcessRaw = TotalBlocks - TotalBlockDone
				print("How Much Is Done: " .. math.floor(Process+0.5) .. "%")
				print("TotalBlocks Still Need To Dig Is " .. ProcessRaw)
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
		Hc = Hc + 3
		if High > Hc then
			High1()
		end
	until High <= Hc
	Process = TotalBlockDone / TotalBlocks * 100
	ProcessRaw = TotalBlocks - TotalBlockDone
	print("How Much Is Done: " .. math.floor(Process+0.5) .. "%")
	print("TotalBlocks Still Need To Dig Is " .. ProcessRaw)
	print("Turtle Is Done")
end

-- Starting
print("Welcome To Excavation Turtle Program")
print("Note: This Program Stop Before Bedrock.")
print("Slot 1: Fuel, Slot 2:Fuel, Slot 3:Chest")
print("Note: if now put item in then it say error just wait for recheck")
print("How long you want")
input2 = io.read()
Long = tonumber(input2)
Long = Long - 1
print("How wide you want")
input = io.read()
Wide = tonumber(input)
Wide = Wide - 1
print("How Deep You Want")
input3 = io.read()
High = tonumber(input3)
print("calculating")
TotalBlocks = (Wide + 1) * (Long + 1) * High -- 1 is add because above it removed for wide and long code
print("Total amount for block to mine is " .. TotalBlocks)
CoalNeeded = TotalBlocks / 3 / 80
print("Total amount for Coal needed is " .. math.floor(CoalNeeded+0.5))
print("Sleep for 15 sec before starting. So can read what is above")
sleep(15)
print("turtle now starting")
if turtle.getFuelLevel() == "unlimited" then 
	print("your turtle config does need fuel")
	NoFuelNeed = 1
elseif turtle.getFuelLevel() < 160 then
	turtle.select(1)
	turtle.refuel(2)
end
FuelCount = turtle.getItemCount(1)
FuelCount1 = turtle.getItemCount(2)
Chest = turtle.getItemCount(3)
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
