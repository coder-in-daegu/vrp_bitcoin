local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_bitcoin")

RegisterServerEvent('btc:buybtc')
AddEventHandler('btc:buybtc',function()
    local player = source
    local user_id = vRP.getUserId({player})
    local notice = vRP.getUserSource({user_id})	
    local wm = vRP.getMoney({user_id})
    local bm = vRP.getBankMoney({user_id})
    local allmoney = wm + bm

    vRP.prompt({source,"매수할 비트코인의 수량을 정해주세요!","",function(player, amount)       
        PerformHttpRequest("http://127.0.0.1:5000/btc", function(code, body, headers)
            local data = json.decode(body)
            price = data['price']
            amount2 = price*amount
            local name = GetPlayerName(notice)
            if tonumber(amount) > 0 and vRP.tryFullPayment({user_id, amount2}) then
TriggerClientEvent(
		"pNotify:SendNotification",
		notice,
		{
			text = "비트코인을 ".. amount .." 개를 성공적으로 매수하였습니다. <br>(현재시세 : ".. price .."원)",
			type = "success",
			timeout = 3000,
			layout = "centerleft",
			queue = "global"
		}
	)			
            sendtodiscord_mesu("비트코인 매수로그","현재 시세 ".. price .."원에 ".. amount .."개를 매수 했습니다.\n지불금액  : ".. amount2 .."", "유저정보 : "..  name .." | ".. user_id .."", 65280)      
            vRP.giveInventoryItem({user_id, "btc", tonumber(amount), true})   
			else
			TriggerClientEvent("pNotify:SendNotification",notice,{text = "비트코인을 매수할 수 있는 돈이 부족합니다.",type = "error",timeout = 3000,layout = "centerleft",queue = "global"})	
            end          
        end)
    end})
end)

RegisterServerEvent('btc:sell')
AddEventHandler('btc:sell',function()
    local player = source
    local user_id = vRP.getUserId({player})
    local wm = vRP.getMoney({user_id})
    local bm = vRP.getBankMoney({user_id})
    local notice = vRP.getUserSource({user_id})	
    local allmoney = wm + bm
    local name = GetPlayerName(notice)
    local max = vRP.getInventoryItemAmount({user_id,"btc"})
    vRP.prompt({source,"매도할 비트코인의 수량을 정해주세요. 최대(".. max .."코인)","",function(player, amount)       
        PerformHttpRequest("http://127.0.0.1:5000/btc", function(code, body, headers)
            local data = json.decode(body)
            price = data['price']
            amount2 = price*amount
            print(round(amount2))
            if vRP.tryGetInventoryItem({user_id,"btc",tonumber(amount)}) then
            sendtodiscord_medo("비트코인 매도로그","현재 시세 ".. price .."원에 ".. amount .."개를 매도 했습니다.\n지급한 금액  : ".. amount2 .."", "유저 정보 : ".. name .." | ".. user_id .."", 16744576)      
                TriggerClientEvent(
		"pNotify:SendNotification",
		notice,
		{
			text = "비트코인을 ".. amount .." 개를 성공적으로 매도하였습니다. <br>(현재시세 : ".. price .."원)",
			type = "error",
			timeout = 3000,
			layout = "centerleft",
			queue = "global"
		}
	)
               vRP.giveBankMoney({user_id,round(amount2)})              
			   else
                TriggerClientEvent("pNotify:SendNotification",notice,{text = "".. amount .."개의 코인을 매도할수있는 비트코인이 부족합니다.<br>(현재 ".. max .."코인)",type = "error",timeout = 3000,layout = "centerleft",queue = "global"})	               
            end          
        end)
    end})
end)

function sendtodiscord_medo(title, message, footer, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = title,
              ["description"] = message,
              ["footer"] = {
              ["text"] = footer,
              },
          }
      }
    PerformHttpRequest("메도로그", function(err, text, headers) end, 'POST', json.encode({username = "테스트", embeds = connect}), { ['Content-Type'] = 'application/json' })
  end
  
  function sendtodiscord_mesu(title, message, footer, color)
    local connect = {
          {
              ["color"] = color,
              ["title"] = title,
              ["description"] = message,
              ["footer"] = {
              ["text"] = footer,
              },
          }
      }
    PerformHttpRequest("메수로그", function(err, text, headers) end, 'POST', json.encode({username = "테스트", embeds = connect}), { ['Content-Type'] = 'application/json' })
  end
  