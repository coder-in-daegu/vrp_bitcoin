incircle = false 

function DrawTxt(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.7*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function DrawTxt2(x, y, z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

  local scale = (1/dist)*2
  local fov = (1/GetGameplayCamFov())*100
  local scale = scale*fov

  if onScreen then
      SetTextScale(0.0*scale, 0.4*scale)
      SetTextFont(0)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 255)
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
  end
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
		local px,py,pz = playerPos.x, playerPos.y, playerPos.z

		if GetDistanceBetweenCoords(250.12553405762,-767.65936279297,30.408727645874,px,py,pz,true) <= 20 then
      DrawTxt(250.12553405762,-767.65936279297,30.408727645874 +0.40, tostring("~g~[ 비트코인 매수 ]"))
      DrawMarker(1,250.12553405762,-767.65936279297,30.408727645874-1.5,0, 0, 0, 0, 0, 0, 2.0,2.0,1.0,0,128,0,255,0,0,0,true)
		end
    if(Vdist(250.12553405762,-767.65936279297,30.408727645874,px,py,pz) < 1)then
      DrawTxt2(px,py,pz+1.0, tostring("~g~[E] ~w~키를 눌러 비트코인을 매수합니다."))
			if (incircle == false) then
			end
			incircle = true

      if(IsControlJustReleased(1, 38))then
              TriggerServerEvent('btc:buybtc')
			end
		elseif(Vdist(250.12553405762,-767.65936279297,30.408727645874,px,py,pz) > 1)then
			incircle = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
		local px,py,pz = playerPos.x, playerPos.y, playerPos.z

		if GetDistanceBetweenCoords(257.5964050293,-770.45281982422,30.272430419922,px,py,pz,true) <= 20 then
      DrawTxt(257.5964050293,-770.45281982422,30.272430419922+0.40, tostring("~r~[ 비트코인 매도 ]"))
      DrawMarker(1,257.5964050293,-770.45281982422,30.272430419922-1.5,0, 0, 0, 0, 0, 0, 2.0,2.0,1.0,255,0,0,255,0,0,0,true)
		end
    if(Vdist(257.5964050293,-770.45281982422,30.272430419922,px,py,pz) < 1)then
      DrawTxt2(px,py,pz+1.0, tostring("~r~[E] ~w~키를 눌러 비트코인을 매도합니다."))
			if (incircle == false) then
			end
			incircle = true

            if(IsControlJustReleased(1, 38))then
          
              TriggerServerEvent('btc:sell')
			end
		elseif(Vdist(257.5964050293,-770.45281982422,30.272430419922,px,py,pz) > 1)then
			incircle = false
		end
	end
end)