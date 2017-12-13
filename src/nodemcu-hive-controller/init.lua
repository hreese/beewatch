-- based on blog post in
-- https://bigdanzblog.wordpress.com/2015/04/24/esp8266-nodemcu-interrupting-init-lua-during-boot/
local FileToExecute = "user.lua"
local BootTimeout = 200
local AbortTimeout = 3000

-- initialize abort boolean flag
local abortFlag = false

function firmwareInfo()
  if (1/3) > 0 then
    print('FLOAT firmware version')
  else
    print('INTEGER firmware version')
  end
end

function init()
  print('Press ENTER to abort startup')

  -- if <CR> is pressed, call abort
  uart.on('data', '\r', abort, 0)

  -- start timer to execute startup function in 3 seconds
  tmr.alarm(0, AbortTimeout, 0, startup)
end

function abort()
  -- user requested abort
  abortFlag = true
end

function fileExists(name)
  local l = file.list();
  for k,v in pairs(l) do
    if k == name then
      return true
    end
  end
  return false
end

function startup()
  -- turns off uart scanning
  uart.on('data')

  if abortFlag == true then
    print('#### startup aborted ####')
    return
  end

  -- otherwise, start up
  if fileExists(FileToExecute) then
    print('Run startup script ...')
    dofile(FileToExecute)
  else
    print('Start script '..FileToExecute..' not found.')
  end
end

firmwareInfo()
tmr.alarm(0, BootTimeout, 0, init)

