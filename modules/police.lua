local calls = {}

function callPolice(x, y, z, reason)
	if x and y and z and reason then
		for theKey,thePlayer in ipairs(getElementsByType("player")) do
			local accName = getAccountName(getPlayerAccount(thePlayer))
			if isObjectInACLGroup ("user."..accName, aclGetGroup(policeACL)) then
				if calls[thePlayer] == nil then
					local myBlip = createBlip(x, y, z, callBlip, 0, 0, 0, 255, thePlayer)
					calls[thePlayer] = myBlip
					outputChatBox(language[lang].police.." "..tostring(reason), thePlayer, 255, 255, 255)
				else
					destroyElement(calls[thePlayer])
					calls[thePlayer] = nil
					local myBlip = createBlip(x, y, z, callBlip, 0, 0, 0, 255, thePlayer)
					calls[thePlayer] = myBlip
					outputChatBox(language[lang].police.." "..tostring(reason), thePlayer, 255, 255, 255)
				end
			end
		end
	else
		print("[GRP] Failed to call callPolice.")
	end
end

function callRescue(x, y, z, reason)
	if x and y and z and reason then
		for theKey,thePlayer in ipairs(getElementsByType("player")) do
			local accName = getAccountName(getPlayerAccount(thePlayer))
			if isObjectInACLGroup ("user."..accName, aclGetGroup(rescueACL)) then
				if calls[thePlayer] == nil then
					local myBlip = createBlip(x, y, z, rescuecallBlip, 0, 0, 0, 255, thePlayer)
					calls[thePlayer] = myBlip
					outputChatBox(language[lang].rescue.." "..tostring(reason), thePlayer, 255, 255, 255)
				else
					destroyElement(calls[thePlayer])
					calls[thePlayer] = nil
					local myBlip = createBlip(x, y, z, rescuecallBlip, 0, 0, 0, 255, thePlayer)
					calls[thePlayer] = myBlip
					outputChatBox(language[lang].rescue.." "..tostring(reason), thePlayer, 255, 255, 255)
				end
			end
		end
	else
		print("[GRP] Failed to call callRescue.")
	end
end
