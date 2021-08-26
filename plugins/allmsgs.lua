--Begin Stats.lua By Amir CerNer
local function cerner(msg, matches)
redis:incr("allmsg")
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match('-100(%d+)') then
if not redis:sismember("su",msg.chat_id_) then
redis:sadd("su",msg.chat_id_)
end
elseif id:match('-(%d+)') then
if not redis:sismember("gp",msg.chat_id_) then
redis:sadd("gp",msg.chat_id_)
end
elseif id:match('') then
if not redis:sismember("user",msg.chat_id_) then
redis:sadd("user",msg.chat_id_)
end
end
end
if matches[1] == 'stephbot' or matches[1] == 'احصائية البوت' and is_sudo(msg) then
--------------------------------------------------—
local allmsg = redis:get("allmsg")
-------------------------------------------------—
local gps = redis:scard("su")
-------------------------------------------------—
local gp = redis:scard("gp")
------------------------------------------------—
local user = redis:scard("user")
--------------------------------------------------—
       tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '`معلومات` *ѕтєρнвσт*\n\n_● عدد رسائل مجموعات:_ *'..allmsg..'*\n\n_● عدد مجموعات خارقة:_ *'..gps..'*\n\n_● عدد مجموعات عادية:_ *'..gp..'*\n\n_● عدد اعضاء خاص:_ *'..user..'*', 1, 'md')
end
if matches[1] == 'reset' or matches[1] == 'ریست' and is_sudo(msg) then
redis:del("allmsg")
redis:del("su")
redis:del("gp")
redis:del("user")
tdcli.sendMessage(msg.chat_id_, msg.id_,1,' Stats Has Been Reseted ',1,'md')
end
end
return {
patterns ={ 
"^[/](stephbot)$",
"^[/](reset)$",
"(.*)",
"^(احصائية البوت)$",
"^(ریست)$",
"(.*)",
},
  run = cerner
}
