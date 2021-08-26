--ping.lua
local function run(msg, matches)
if matches[1] == 'ping' or 'بوت' and is_mod(msg) then
   tdcli.sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './securebot/ping.gif', 'انا شغال لا تهتم 👌😉', dl_cb, nil)
end
    end

return {
  patterns = {
 "^(ping)$",
   "^(بوت)$"
},
  run = run
}

--end by @secure_dev
--our channel @secure_channel 