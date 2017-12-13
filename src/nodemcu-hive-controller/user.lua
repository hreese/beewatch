-- clean state for wifi
wifi.sta.disconnect()

-- read credentials
dofile("credentials.lua")
print("Connecting to access point "..station_cfg.ssid)

-- connect to AP
wifi.sta.config(station_cfg)
wifi.sta.connect()

tmr.alarm(1, 1000, 1, function() 
    if wifi.sta.getip()== nil then 
        print("IP unavaiable, Waiting...") 
    else 
        tmr.stop(1)
        print("Config done, IP is "..wifi.sta.getip())
    end 
end)