local Inventory = {
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0},
    {Name="", Amount=0, ID=0}
}

local weight = 0
local playerWeight = 6

function takePlayerItem(itemID, amount)
    if itemID and amount then
        for i=1, #Inventory do
            if Inventory[i].ID == itemID then
                if (Inventory[i].Amount - tonumber(amount)) <= 0 then
                    weight = weight - (itemList[Inventory[i].ID].Weight*tonumber(amount))
                    Inventory[i].Name = ""
                    Inventory[i].Amount = 0
                    Inventory[i].ID = 0
                elseif (Inventory[i].Amount - tonumber(amount)) > 0 then
                    weight = weight - (itemList[Inventory[i].ID].Weight*tonumber(amount))
                    Inventory[i].Amount = Inventory[i].Amount - amount
                end
            end
        end
    else
        print("[GRP] Failed to call takePlayerItem.")
    end
end
addEvent("takePlayerItem", true)
addEventHandler("takePlayerItem", root, takePlayerItem)

function givePlayerItem(itemID, amount)
    if itemID and amount then
        for i=1, #Inventory do
            if (weight + itemList[tonumber(itemID)].Weight*tonumber(amount)) <= playerWeight then
                if Inventory[i].ID == tonumber(itemID) then
                    Inventory[i].Amount = Inventory[i].Amount+tonumber(amount)
                    weight = weight + itemList[tonumber(itemID)].Weight*tonumber(amount)
                    break
                elseif Inventory[i].ID == 0 then
                    Inventory[i].ID = tonumber(itemID)
                    Inventory[i].Amount = tonumber(amount)
                    Inventory[i].Name = itemList[tonumber(itemID)].Name
                    weight = weight + itemList[tonumber(itemID)].Weight*tonumber(amount)
                    break
                end
            end
        end
    else
        print("[GRP] Failed to call givePlayerItem.")
    end
end
addEvent("givePlayerItem", true)
addEventHandler("givePlayerItem", root, givePlayerItem)

function getPlayerWeight() --Export only
    return weight
end
addEvent("getPlayerWeight", true)
addEventHandler("getPlayerWeight", root, getPlayerWeight)

function getPlayerMaxWeight() --Export only
    return playerWeight
end
addEvent("getPlayerMaxWeight", true)
addEventHandler("getPlayerMaxWeight", root, getPlayerMaxWeight)

function getInventoryItems() --Export only
    return toJSON(Inventory)
end
addEvent("getInventoryItems", true)
addEventHandler("getInventoryItems", root, getInventoryItems)

function setPlayerWeight(w)
    if w then
        weight = tonumber(w)
    else
        print("[GRP] Failed to call setPlayerWeight.")
    end
end
addEvent("setPlayerWeight", true)
addEventHandler("setPlayerWeight", root, setPlayerWeight)

function addPlayerMaxWeight(mw)
    if mw then
        if playerWeight + tonumber(mw) <= maxPlayerWeight then
            playerWeight = playerWeight + tonumber(mw)
        end
    else
        print("[GRP] Failed to call addPlayerMaxWeight.")
    end
end
addEvent("addPlayerMaxWeight", true)
addEventHandler("addPlayerMaxWeight", root, addPlayerMaxWeight)

function setPlayerMaxWeight(mw)
    playerWeight = tonumber(mw)
end
addEvent("setPlayerMaxWeight", true)
addEventHandler("setPlayerMaxWeight", root, setPlayerMaxWeight)

function getItemAmount(itemID)
    if itemID then
        for i=1, #Inventory do
            if Inventory[i].ID == tonumber(itemID) then
                return Inventory[i].Amount
            elseif i == #Inventory then
                return 0
            end
        end
    else
        print("[GRP] Failed to call getItemAmount.")
    end
end
addEvent("getItemAmount", true)
addEventHandler("getItemAmount", root, getItemAmount)

function setTable(JSONtable)
    if JSONtable then
        for i=1, #Inventory do
            if JSONtable ~= "" then
                local convertedTable = fromJSON(tostring(JSONtable))
                Inventory[i].ID = convertedTable[i].ID
                Inventory[i].Name = convertedTable[i].Name
                Inventory[i].Amount = convertedTable[i].Amount
            end
        end
    else
        print("[GRP] Failed to call setTable.")
    end
end
addEvent("setTable", true)
addEventHandler("setTable", root, setTable)

function sendInfosToBase()
    triggerServerEvent("saveInfos", localPlayer, toJSON(Inventory), playerWeight)
end
addEvent("sendInfosToBase", true)
addEventHandler("sendInfosToBase", root, sendInfosToBase)
