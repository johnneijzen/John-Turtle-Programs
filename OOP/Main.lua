local selector = 0;
local userSelect = 0;
local key;

local function display()
	print("List Programs")
	if selector == 0 then
		print("--> Excavation Program")
	else
		print("    Excavation Program")
	end
	if selector == 1 then
		print("--> Builder Program")
	else
		print("    Builder Program")
	end
	if selector == 2 then
		print("--> Strip Mining Program")
	else
		print("    Strip Mining Program")
	end
end

local function selector()
	if(selector == 0) then
	-- Runs Excavation Program
	end
	if(selector == 1) then
	-- Runs Builder Program
	end
	if(selector == 2) then
	--Strip Mining Program
	end
end

local function main()
	print("Welcome John Turtle Programs Program")
	repeat -- Basically Menu Program
		display()
		key = os.pullEvent( "key" )
		if key == keys.up then
			if(selector < 2) then
				selector = selector + 1
			end
		elseif key == keys.down then
			if(selector > 0) then
				selector = selector - 1
			end
		elseif key == keys.enter then
			userSelect = 1
		end
	until userSelect == 1
	selector()
end

main()
