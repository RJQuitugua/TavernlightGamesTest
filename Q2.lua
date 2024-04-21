--Question 2
--Fix or improve the implementation of the below methods


--[[
function printSmallGuildNames(memberCount)

-- this method is supposed to print names of all guilds that have less than memberCount max members

local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"

local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))

local guildName = result.getString("name") *This retrieves one result because it's not inside a loop

print(guildName) ** Just prints the unlooped result

end
]]--

--This seems to be code that prints the name of all the guilds that have less than the memberCount max using SQL quesries, but it looks like it will only print out one guild name which I indicated with aterisks in the snippet above

function printSmallGuildNames(memberCount)
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    if resultId then --This creates a loop
        repeat
            local guildName = db.getResultData(resultId, "name")
            print(guildName)
        until not db.nextResult(resultId) -- This will close the loop when it finally returns nothing or null
        db.freeResult(resultId) --Essentially a cache clear
    else
        print("Query failed or no results found.")
    end
end
