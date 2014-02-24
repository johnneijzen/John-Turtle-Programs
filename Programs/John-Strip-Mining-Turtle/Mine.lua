-- This Version
-- 2.02
-- ChangeLogs
-- 2.00 - Now on Github
-- 2.02 - Space to Tab (Lot Clear to See) 4.279 kb to 4.042 kb

--Local
local Mines = 0 -- Multi Mines Yes Or No 1 = yes and 0 = no
local distance = 0 -- How Far Did User Pick
local onlight = 0 -- When to Place Torch
local torch = turtle.getItemCount(1) -- How many items are in slot 1 (torch)
local chest = turtle.getItemCount(2) -- How many items are in slot 2 (chest)
local ItemFuel = turtle.getItemCount(3) -- How many items are in slot 3 (Fuel)
local MD = 3 -- How Many Blocks Apart From Each Mine
local MineTimes = 0 -- If Multi Mines Are ON then This will keep Count
local Fuel = 0 -- if 2 then it is unlimited no fuel needed
local NeedFuel = 0 -- If Fuel Need Then 1 if not Then 0
local Error = 0 -- 1 = Error 0 = No Error

--Checking
function check()
	if torch == 0 then
		print("There are no torch's in Turtle")
		Error = 1
	else
		print("There are torch's in turtle")
	end
	if chest == 0 then
		print("there are no chests")
		Error = 1
	else
		print("There are chest in turtle")
	end
	repeat
		if turtle.getFuelLevel() == "unlimited" then 
			print("NO NEED FOR FUEL")
			Needfuel = 0
		elseif turtle.getFuelLevel() < 100 then
			turtle.select(3)
			turtle.refuel(1)
			Needfuel = 1
			ItemFuel = ItemFuel - 1
		elseif NeedFuel == 1 then
			Needfuel = 0
		end
	until NeedFuel == 0
	if Error == 1 then
		Test()
	else
		forwardM()
	end
end


--Mining
function forwardM()
	repeat
		if turtle.detect() then
			turtle.dig()
		end
		if turtle.forward() then -- sometimes sand and gravel and block and mix-up distance
			TF = TF - 1
			onlight = onlight + 1
		end
		if turtle.detectUp() then
			turtle.digUp()
		end
		turtle.select(4)
		turtle.placeDown()
		if onlight == 10 then -- Every 10 Block turtle place torch
			turtle.turnLeft()
			turtle.turnLeft()
			turtle.select(1)
			turtle.place()
			turtle.turnLeft()
			turtle.turnLeft()
			torch = torch - 1
			onlight = onlight - 10
		end
		if turtle.getItemCount(16)>0 then -- If slot 16 in turtle has item slot 5 to 16 will go to chest
			turtle.select(2)
			turtle.digDown()
			turtle.placeDown()
			chest = chest - 1
			for slot = 5, 16 do
				turtle.select(slot)
				turtle.dropDown()
				sleep(0.5) -- Small fix for slow pc
			end
			turtle.select(5) -- temp fix still checking
		end
		repeat
			if turtle.getFuelLevel() == "unlimited" then 
				print("NO NEED FOR FUEL")
				Needfuel = 0
			elseif turtle.getFuelLevel() < 100 then
				turtle.select(3)
				turtle.refuel(1)
				Needfuel = 1
				ItemFuel = ItemFuel - 1
			elseif NeedFuel == 1 then
				Needfuel = 0
			end
		until NeedFuel == 0
	until TF == 0
	if TF == 0 then
		backA()
	end
end

--Warm Up For Back Program
function backA() -- To make turn around so it can go back
	turtle.turnLeft()
	turtle.turnLeft()
	turtle.up()
	back()
end

--Back Program
function back()
	repeat
		if turtle.forward() then -- sometimes sand and gravel and block and mix-up distance
			TB = TB - 1
		end
		if turtle.detect() then -- Sometimes sand and gravel can happen and this will fix it
			turtle.dig()
		end
	until TB == 0
	if Mines == 1 then
		MultiMines()
	else
		print("Turtle done")
	end
end

-- Multimines Program
function MultiMines()
	turtle.turnRight()
	turtle.down()
	repeat
		if turtle.detect() then
			turtle.dig()
		end
		if turtle.forward() then
			MD = MD - 1
		end
		if turtle.detectUp() then
			turtle.digUp()
		end
	until MD == 0
	turtle.turnRight()
	if MineTimes == 0 then
		print("Turtle is done")
	else
		MineTimes = MineTimes - 1
		Restart()
	end
end

-- Restart 
function Restart()
	TF = distance
	TB = distance
	MD = 3
	onlight = 0
	forwardM()
end

-- Error
function Test()
	print("Pls Recheck And try aging")
end

-- Start
print("Hi There Welcome to Mining Turtle Program")
print("How Far Will Turtle Go")
input = io.read()
distance = tonumber(input)
TF = distance
TB = distance
print("To Want Multiple Strip Mines No = 0, Yes = 1")
input2 = io.read()
Mines = tonumber(input2)
if Mines == 1 then
	print("How Many Times")
	input3 = io.read()
	MineTimes = tonumber(input3)
	check()
else
	check()
end
