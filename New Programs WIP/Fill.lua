--[[
Version
	0.01 10/15/2015
Changelog
	0.01 - First Draft
]]

-- Local Variables in My New Program style it now a-z not random
-- Area
local long = 0
local longCount = 0
local wide = 0
local wideCount = 0
--Misc
local buildSlot = 3
local fuelItem = 0
local selectType = 0
local donePlacing = 0
local LorR = 0

local function refuel()
	if noFuelNeed == 0 then
		repeat
			if turtle.getFuelLevel() < 100 then
				if fuelItem > 0 then
					turtle.select(1)
					turtle.refuel(1)
					fuelItem = fuelItem - 1
				else
					print("out of fuel")
					os.shutdown()
				end
			end
		until turtle.getFuelLevel() >= 120
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
	turtle.forward()
	longCount = longCount + 1
end

local function placeWide()
	if LorR == 0 then
		turtle.turnRight()
	else
		turtle.turnLeft()
	end
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
			placeWide()
		end
		if longCount == long and wideCount == wide then
			donePlacing = 1
		end
	until donePlacing == 1
	print("turtle is Done")
end

--starting
local function starting()
	print("welcome to John Fill Program")
	print("Please enter lenght you want to fill")
	long = tonumber(read())
	print("Please Enter wide you want to fill")
	wide = tonumber(read())
	print("Please enter what type fill you want")
	print("1 = Fill, 2 = Walls(WIP), 3 = Cube(WIP)")
	selectType = tonumber(read())
	if turtle.getFuelLevel() == "unlimited" then
		print("Your turtle config does need fuel")
		noFuelNeed = 1
	end
	if selectType == 1 then
		fill()
	elseif selectType == 2 then
		-- wall()
	elseif selectType == 3 then
		-- cube()
	end
end

starting()