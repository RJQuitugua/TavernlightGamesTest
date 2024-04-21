--Question 1
--Fix or improve the implementation of the below methods

 

--[[local function releaseStorage(player)

player:setStorageValue(1000, -1)

end

function onLogout(player)

if player:getStorageValue(1000) == 1 then
addEvent(releaseStorage, 1000, player)

end

return true

end--]]

--This code seems to handle a delayed logout when a player hits the logout button. Probably for within PVE areas so players can't log scum. Probably resets on an event such as taking damage.
--I generally avoid hardcoding numbers and instead like to use variables that I can easily change

local storageValue = 1000
local storageValueReset = -1
local storageValueActive = 1
local logOutDelay = 1000

local function playerLogOut(player)
	player:setValue( storageValue, storageValueReset, storageValueActive ) --Resets player state on logout
end
function playerLogoutLoop(player)
	if player:setValue (storageValue) == storageValueActive then --Checks if the player is active
		addEvent(playerLogOut, logOutDelay, player)
	end
	return true --Will process logout
end

