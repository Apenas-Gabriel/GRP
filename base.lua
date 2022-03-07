local connect = dbConnect( "sqlite", "database/database.db" )
local discord = "discord.gg/mta"
local startBankMoney = 5000
local startHandMoney = 2000

function setPlayerInfos( _, acc )
	setElementData(source, "ID", getAccountID(acc))
	local query = dbQuery(connect, "SELECT Inventory,MaxWeight FROM GRP_inventory_infos WHERE ID=?", getAccountID(acc))
    local result = dbPoll(query, -1)
    local result2 = dbPoll(dbQuery(connect, "SELECT Whitelisted,Banned FROM GRP_user_infos WHERE ID=?", getAccountID(getPlayerAccount(source))), -1)
    local result3 = dbPoll(dbQuery(connect, "SELECT (Money,BankMoney,Knockout,Thirst,Hunger) FROM RP_Player_Infos WHERE ID=?", getAccountID(getPlayerAccount(source))), -1)
    if #result2 == 0 then
    	dbExec(connect, "INSERT INTO GRP_user_infos(ID,Whitelisted,Banned) VALUES(?,?,?)", getAccountID(acc), 0, 0)
    end
    if #result2 > 0 then
	    if result2[1].Banned == 0 then
		    if result2[1].Whitelisted == 0 then
		    	kickPlayer(source, "Console", language[lang].wl.." "..discord)
		    end
		else
			kickPlayer(source, "Console", language[lang].banned)
		end
	end
    if #result > 0 and #result3 > 0 then
	    triggerClientEvent(source, "setTable", source, result[1].Inventory)
	    triggerClientEvent(source, "setPlayerMaxWeight", source, result[1].MaxWeight)
	    setPlayerMoney(source, result3[1].Money)
	    setElementData(source, "GRP:BankMoney", result3[1].BankMoney)
	    setElementData(source, "GRP:Thirst", result3[1].Thirst)
	    setElementData(source, "GRP:Hunger", result3[1].Hunger)
	    if result3[1].Knockout >= 0 then
	    	setElementData(source, "GRP:Knockout", result3[1].Knockout)
	    	triggerEvent("forcedKnockout", source)
	    end
	else
		setElementData(source, "GRP:Thirst", 100)
		setElementData(source, "GRP:Hunger", 100)
		setPlayerMoney(source, startHandMoney)
		setElementData(source, "GRP:BankMoney", startBankMoney)
		dbExec(connect, "INSERT INTO GRP_inventory_infos(ID,Inventory,MaxWeight) VALUES(?,?,?)", getAccountID(acc), "", 6)
		dbExec(connect, "INSERT INTO GRP_Player_Infos(ID,Money,BankMoney,Knockout,Thirst,Hunger)", getAccountID(getPlayerAccount(source)), startHandMoney, startBankMoney, false, 100, 100)
	end
end
addEventHandler("onPlayerLogin", root, setPlayerInfos)

local inventoryTable = {}
local playerWeight = {}

function infos(JSONstring, weight)
	if JSONstring and weight then
		inventoryTable[client] = tostring(JSONstring)
		playerWeight[client] = tonumber(weight)
	end
end
addEvent("saveInfos", true)
addEventHandler("saveInfos", root, infos)

function savePlayerInfos(quitType, reason)
	if quitType == "Banned" then
    	dbExec(connect, "UPDATE GRP_user_infos SET Banned=? WHERE ID=?", 1, getAccountID(getPlayerAccount(source)))
    else
    	triggerClientEvent(source, "sendInfosToBase", source)
    	setTimer(function()
    		dbExec(connect, "UPDATE GRP_Player_Infos SET Money=?,BankMoney=?,Knockout=?,Thirst=?,Hunger=? WHERE ID=?", getPlayerMoney(source), getElementData(source, "GRP:BankMoney"), getElementData(source, "knockout") or false, getElementData(source, "GRP:Thirst"), getElementData(source, "GRP:Hunger"), getAccountID(getPlayerAccount(source)))
    		dbExec(connect, "UPDATE GRP_inventory_infos SET Inventory=?,MaxWeight=? WHERE ID=?", inventoryTable[source], playerWeight[source], getAccountID(getPlayerAccount(source)))
    	end, 1000, 1)
    end
end
addEventHandler("onPlayerQuit", root, savePlayerInfos)

function getPlayerID(id)
	v = false
	for i, player in ipairs (getElementsByType("player")) do
		if getElementData(player, "ID") == id then
			v = player
			break
		end
	end
	return v
end
