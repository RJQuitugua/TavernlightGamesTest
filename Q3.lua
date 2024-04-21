--Question 3
--Fix or improve the implementation of the below methods

--[[
function do_sth_with_PlayerParty(playerId, membername)

player = Player(playerId)

local party = player:getParty()

for k,v in pairs(party:getMembers()) do --This loops for the party members returns a list of the members

    if v == Player(membername) then --This removes players defined in membername

        party:removeMember(Player(membername)) --Removes players found in the loop
    end
end
end
]]--

--Immediately noticed single character variable names, I'm going to do my best to be descriptive with variables

function do_sth_with_PlayerParty(playerId, membername)
    local player = Player(playerId)
    local party = player:getParty()
    if party then
		print("Enter the name of the member to remove:") --Added an interactive method for a potential player to remove a player. It was likely implied to have been done for testing purposes, but just in case
        local membername = io.read()
        local memberToRemove = Player(membername)
        for _, member in pairs(party:getMembers()) do
            if member == memberToRemove then
                party:removeMember(memberToRemove)
                break -- Break the loop once the member is found 
            end
        end
    end
end
