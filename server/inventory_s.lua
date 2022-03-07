function servertakePlayerItem(source, itemID, amount)
	if source and itemID and amount then
		triggerClientEvent("takePlayerItem", source, tonumber(itemID), tonumber(amount))
	else
		print("[GRP] Failed to call servertakePlayerItem.")
	end
end
addEvent("servertakePlayerItem", true)
addEventHandler("servertakePlayerItem", root, servertakePlayerItem)

function servergivePlayerItem(source, itemID, amount)
	if source and itemID and amount then
		triggerClientEvent("givePlayerItem", source, tonumber(itemID), tonumber(amount))
	else
		print("[GRP] Failed to call servergivePlayerItem.")
	end
end
addEvent("servergivePlayerItem", true)
addEventHandler("servergivePlayerItem", root, servergivePlayerItem)

function serversetTable(source, JSONTABLE)
	if source and JSONTABLE then
		triggerClientEvent("setTable", source, tostring(JSONTABLE))
	else
		print("[GRP] Failed to call serversetTable.")
	end
end
addEvent("serversetTable", true)
addEventHandler("serversetTable", root, serversetTable)
