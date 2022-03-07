local screenW, screenH = guiGetScreenSize()
local resW, resH = 1360,768
local x, y = (screenW/resW), (screenH/resH)
local font = dxCreateFont("ui/font.ttf", 13)

function imortal()
	if getElementData(localPlayer, "knockout") then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, imortal)

function renderBlur()
	if getElementData(localPlayer, "knockout") then
		if renderBlur == true then
			exports["Blur"]:dxDrawBluredRectangle(x*0, y*0, x*1366, y*768, tocolor(255, 255, 255, 255))
		end
		dxDrawText(language[lang].lifetime.."#FF0000"..getElementData(localPlayer, "knockout").."#FFFFFF "..language[lang].seconds, screenW * 0.3801, screenH * 0.9089, screenW * 0.7059, screenH * 1.0299, tocolor(255, 255, 255, 255), 1.00, font, "left", "top", false, false, false, true, false)
	end
end
addEventHandler("onClientRender", root, renderBlur)
