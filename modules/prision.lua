local connect = dbConnect( "sqlite", "database/database.db" )

function setPrisoner(ID, time, officer, reason)
	if ID and time and officer and reason then
		dbExec(connect, "INSERT INTO GRP_Ficha(ID,Time,Reason,Officer) VALUES(?,?,?,?)", tonumber(ID), tonumber(time), tostring(reason), tostring(reason))
		setJail(tonumber(ID), tonumber(time))
	else
		print("[GRP] Failed to call setPrisoner.")
	end
end

function setJail(ID, time)
	if ID and time then
		local player = getPlayerID(tonumber(ID))
		setElementData(player, "GRP:Jail", tonumber(time))
		setElementPosition(player, px, py, pz)
	else
		print("[GRP] Failed to call setJail.")
	end
end

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
