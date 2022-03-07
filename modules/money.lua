function transferBankMoney(player, targetID, value)
	if targetID and value then
		local target = getPlayerID(tonumber(targetID))
		local value = tonumber(value)
		if getElementData(player, "GRP:BankMoney") - value >= 0 then
			setElementData(source, "GRP:BankMoney", getElementData(player, "GRP:BankMoney") - value)
			setElementData(target, "GRP:BankMoney", getElementData(target, "GRP:BankMoney") + value)
			return true
		else
			return false
		end
	end
end

function withdrawBankMoney(player, value)
	if value then
		local value = tonumber(value)
		if getElementData(player, "GRP:BankMoney") - value >= 0 then
			local money = getPlayerMoney(player)
			setElementData(player, "GRP:BankMoney", getElementData(player, "GRP:BankMoney") - value)
			setPlayerMoney(player, money + value)
			return true
		else
			return false
		end
	end
end

function depositBankMoney(player, value)
	if value then
		local value = tonumber(value)
		if getElementData(player, "GRP:BankMoney") + value >= 0 then
			local money = getPlayerMoney(player)
			setElementData(player, "GRP:BankMoney", getElementData(player, "GRP:BankMoney") + value)
			setPlayerMoney(player, money - value)
			return true
		else
			return false
		end
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
