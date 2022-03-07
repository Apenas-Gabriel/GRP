function needs()
	player = source
	setTimer(function()
        if getElementData(player, "GRP:Hunger") then 
            if getElementData(player, "GRP:Hunger") <= 100 then
                setElementData(player, "GRP:Hunger", getElementData(player, "GRP:Hunger") - 1)
            end
            if getElementData(player, "GRP:Hunger") <= 20 then
               outputChatBox(language[lang].hunger, player, 255, 0, 0)
            end
            if getElementData(player, "GRP:Hunger") == 0 then
            	setElementData(player, "knockout", knockoutTime)
            	setElementData(player, "GRP:Hunger", 5)
            	setElementHealth(player, 10)
            end
        end
		if getElementData(player, "GRP:Thirst") then 
            if getElementData(player, "GRP:Thirst") <= 100 then
                setElementData(player, "GRP:Thirst", getElementData(player, "GRP:Thirst") - 1)
            end
            if getElementData(player, "GRP:Thirst") <= 20 then
               outputChatBox(language[lang].thirst, player, 255, 0, 0)
            end
            if getElementData(player, "GRP:Thirst") == 0 then
            	setElementData(player, "knockout", knockoutTime)
            	setElementData(player, "GRP:Thirst", 5)
            	setElementHealth(player, 10)
            end
        end
    end, 60000, 0)
end
addEventHandler("onPlayerLogin", root, needs)

local knockout = {}

function knockoutPlayer()
	player = source
	if getElementData(player, "knockout") then
		knockout[player] = true
	end
	if getElementHealth(player) <= 10 and getElementData(player, "knockout") == false then
		setElementData(player, "knockout", knockoutTime)
		knockout[player] = true
	end
	if not knockout[player] then
		timer = setTimer(function()
			if getElementData(player, "knockout") then
				if getElementData(player, "knockout") <= 0 then
					killPed(player)
					setElementFrozen(player, false)
					setElementData(player, "knockout", false)
					knockout[player] = false
					showChat(player, true)
				else
					setElementData(player, "knockout", getElementData(player, "knockout") - 1)
				end
			end
		end, 1000, knockoutTime+1)
		knockout[player] = true
		setElementFrozen(player, true)
		showChat(player, false)
		setPedAnimation(player, "CRACK", "crckidle2", -1, false, false, false, true)
	end
end
addEvent("forcedKnockout", true)
addEventHandler("forcedKnockout", root, knockoutPlayer)
addEventHandler("onPlayerDamage", root, knockoutPlayer)
