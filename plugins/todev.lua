--Begin sos.lua By Amir CerNee
local function amir(msg, matches) 
if matches [1] == 'todev' or 'رسالة للمطور' then 
local text = matches[2]
local gp = -1001058782829   --ایدی ساپورتتون ---یا اگ ندارین ایدی خودتون--
function cb(arg, data)
    if data.username_ then
     u = "@"..check_markdown(data.username_)
else
u = '_لا يوجد_'
   end
if data.first_name_ then
     f = check_markdown(data.first_name_)
else
f = '_لا يوجد_'
    end
if data.last_name_ then
l = check_markdown(data.last_name_)
else
l = '_لا يوجد_'
end
 tdcli.sendMessage(msg.chat_id_, msg.id_, 1,  '`تم ارسال الرسالة للمطور بنجاح ✅`', 1, 'md')   
 tdcli.sendMessage(gp, 0, 1, '`✉️ رسالة جديدة`\n\n_ايدي مجموعة_ : '..msg.chat_id_..'\n\n_ايدي العضو_ : '..msg.sender_user_id_..'\n\n_معرفه_ : '..u..'\n\n_اسم اول_ : '..f..'\n\n_اسم الثاني_ : '..l..'\n\n_الرسالة_ : '..text..'', 1, 'md')
end
tdcli_function ({ ID = "GetUser", user_id_ = msg.sender_user_id_ }, cb, {chat_id=msg.chat_id_,user_id=msg.sender_user_id_})
    end
end
return { 
patterns ={ 
"^(todev) (.*)$",
"^(رسالة للمطور) (.*)$", 
}, 
run = amir
}
--End

--@CerNer_Tm