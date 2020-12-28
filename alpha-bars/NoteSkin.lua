local Nskin = {}

-- [1.] Button Redirects
-- Defining on which direction the other directions should be based on
-- This will let us use less files which is quite handy to keep the noteskin directory nice
-- Do remember this will Redirect all the files of that Direction to the Direction its pointed to

-- Here, we're only going to cover directions that'll fall back unto different files depending of the game/style
-- Alternative Notes will not be implemented yet in this release.

Nskin.ButtonRedir =

{
	-- ordinal directions

		UpLeft		= GAMESTATE:GetCurrentGame():GetName() == 'pump' and "Mini" or "Global",
		UpRight 	= GAMESTATE:GetCurrentGame():GetName() == 'pump' and "Mini" or "Global",
		DownLeft	= GAMESTATE:GetCurrentGame():GetName() == 'pump' and "Mini" or "Global",
		DownRight	= GAMESTATE:GetCurrentGame():GetName() == 'pump' and "Mini" or "Global",

	-- centre is center

		Center 		= GAMESTATE:GetCurrentGame():GetName() == 'pump' and "Mini" or "Global",

	-- if gamemode is beat, fallback on different elements, else global

		Key1 	= GAMESTATE:GetCurrentGame():GetName() == 'beat' and "White" or "Global",
		Key2 	= GAMESTATE:GetCurrentGame():GetName() == 'beat' and "Blue" or "Global",
		Key3 	= GAMESTATE:GetCurrentGame():GetName() == 'beat' and "White" or "Global",
		Key4 	= GAMESTATE:GetCurrentGame():GetName() == 'beat' and "Blue" or "Global",
		Key5 	= GAMESTATE:GetCurrentGame():GetName() == 'beat' and "White" or "Global",
		Key6 	= GAMESTATE:GetCurrentGame():GetName() == 'beat' and "Blue" or "Global",
		Key7 	= GAMESTATE:GetCurrentGame():GetName() == 'beat' and "White" or "Global",
	
		scratch = "Scratch",
}	

-- [2.] Element Redirects
-- Define elements that need to be redirected

Nskin.ElementRedir =

	{
		["Tap Fake"]				= "Tap Note",
		["Hold Explosion"]			= "Tap Explosion Dim",
		["Roll Explosion"]			= "Hold Explosion",
		["Hold Head Inactive"]		= "Hold Head Inactive",
		["Hold Head Active"] 		= "Hold Head Inactive",
		["Roll Head Active"]		= "Hold Head Inactive",
		["Roll Head Inactive"] 		= "Hold Head Inactive",
		["Roll Bottomcap Inactive"] = "Hold Bottomcap Inactive",
		["Roll Bottomcap Active"] 	= "Hold Bottomcap Active",
	}

-- [4.] Element Rotations
-- Parts of noteskins which we want to rotate
-- Tap Explosions are set to false as they'll be rotated in Fallback Explosion

Nskin.PartsToRotate =

	{
		["Receptor"]				= true,
		["Tap Explosion Bright"]	= true,
		["Tap Explosion Dim"]		= true,
		["Tap Note"]				= true,
		["Tap Fake"]				= true,
		["Tap Lift"]				= true,
		["Tap Addition"]			= true,
		["Hold Explosion"]			= true,
		["Hold Head Active"]		= true,
		["Hold Head Inactive"]		= true,
		["Roll Explosion"]			= true,
		["Roll Head Active"]		= true,
		["Roll Head Inactive"]		= true,
	}

-- [5.] Blank Redirects
-- Parts that should be Redirected to _Blank.png
-- you can add/remove stuff if you want

Nskin.Blank =

	{
		["Hold Topcap Active"] 			= true,
		["Hold Topcap Inactive"] 		= true,
		["Roll Topcap Active"] 			= true,
		["Roll Topcap Inactive"] 		= true,
		["Hold Tail Active"]			= true,
		["Hold Tail Inactive"]			= true,
		["Roll Tail Active"]			= true,
		["Roll Tail Inactive"]			= true,
		["Center Hold Topcap"]			= true,
	}
	
-- [6.] Buttons and Elements
-- Between here we usally put all the commands the noteskin.lua needs to do, some are extern in other files
-- If you need help with lua go to https://quietly-turning.github.io/Lua-For-SM5/Luadoc/Lua.xml there are a bunch of codes there
-- Also check out common it has a load of lua codes in files there
-- Just play a bit with lua its not that hard if you understand coding
-- But SM can be a bum in some cases, and some codes jut wont work if you dont have the noteskin on FallbackNoteSkin=common in the metric.ini 

function Nskin.Load()
	local sButton = Var "Button"
	local sElement = Var "Element"
	
	-- [6a.] Global Elements
	-- This is where arguments related to all gametypes are covered.

		-- Setting global button
		
		local Button = Nskin.ButtonRedir[sButton] or "Global"
	
		-- Setting global element
		
		local Element = Nskin.ElementRedir[sElement] or sElement
		
		-- Set Hold/Roll Heads to Tap Notes
		-- Making it so it only works on the beat game mode
		-- Otherwise, points to the element itself.
		
		if GAMESTATE:GetCurrentGame():GetName() == 'beat' and 
		   string.find(sElement, "Head") then
			
			Element = "Tap Note"
		
		else 
			
			Element = Nskin.ElementRedir[sElement] or sElement
		
		end
		

		-- Explosion is universal
		
 		if string.find(Element, "Explosion") then 
			Button = "Global"
		end

		-- Mines only stem from one direction.
		-- I swear if you start singing One Direction songs
		
		if string.find(Element, "Tap Mine") then
			Button = "Global"
		end
			
	-- [6b.] Others
	-- Returning first part of the code, The redirects, Second part is for commands
	
	local t = LoadActor(NOTESKIN:GetPath(Button,Element))
	
	-- Set blank redirects
	if Nskin.Blank[sElement] then
		t = Def.Actor {}
		-- Check if element is sprite only
		if Var "SpriteOnly" then
			t = LoadActor(NOTESKIN:GetPath("","_blank"))
		end
	end
	
	if Nskin.PartsToRotate[sElement] then
		t.BaseRotationZ = nil
	end
	
	return t
end
-- >

-- dont forget to return cuz else it wont work >
return Nskin