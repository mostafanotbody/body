local function TLG(msg, matches)

if matches[1]:lower() == 'lock auto' or matches[1] == 'تفعيل صامت تلقائي' and is_mod(msg) then
redis:setex("atolc"..msg.chat_id_..msg.sender_user_id_,45,true)
if redis:get("atolct1"..msg.chat_id_) and redis:get("atolct2"..msg.chat_id_) then
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'رجاءا ارسل الوقت الذي تريد ضبط الصامت التلقائي فيه \n مثلا 10:15', 1, 'md')
redis:del("atolct1"..msg.chat_id_)
redis:del("atolct2"..msg.chat_id_)
redis:del("lc_ato:"..msg.chat_id_)
else
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'رجاءا ارسل الوقت الذي تريد ضبط الصامت التلقائي فيه \n مثلا 10:15', 1, 'md')
end


elseif matches[1]:lower() == 'unlock auto' or matches[1] == 'فتح صامت تلقائي' and is_mod(msg) then
if redis:get("atolct1"..msg.chat_id_) and redis:get("atolct2"..msg.chat_id_) then
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'تم الغاء الصامت التلقائي.', 1, 'md')
redis:del("atolct1"..msg.chat_id_)
redis:del("atolct2"..msg.chat_id_)
redis:del("lc_ato:"..msg.chat_id_)
else
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'تم الغاء الصامت التلقائي 🚫🔕', 'md')
end

elseif matches[1]:lower() == 'lockauto stats' or matches[1] == 'صامت تلقائي احصائية' and is_mod(msg) then
local t1 = redis:get("atolct1"..msg.chat_id_)
local t2 = redis:get("atolct2"..msg.chat_id_)
if t1 and t2 then
local lc = redis:get("lc_ato:"..msg.chat_id_)

if lc then
stats = "الصامت التلقائي مفعل 🚫✅"
else
stats = "الصامت التلقائي غير مفعل 🚫❎"
end

tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '`سيتم قفل المجموعة ساعة `*'..t1..'*`الى ساعة` *'..t2..'* `وقت فتح المجموعة`\n\n _حالة المجموعة حاليا :_ '..stats, 1, 'md')
else
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'لم يتم تسجيل أي وقت لإغلاق المجموعة ‼️', 1, 'md')
end

elseif (matches[1] == "00" or matches[1] == "01" or matches[1] == "02" or matches[1] == "03" or matches[1] == "04" or matches[1] == "05" or matches[1] == "06" or matches[1] == "07" or matches[1] == "08" or matches[1] == "09" or matches[1] == "10" or matches[1] == "11" or matches[1] == "12" or matches[1] == "13" or matches[1] == "14" or matches[1] == "15" or matches[1] == "16" or matches[1] == "17" or matches[1] == "18" or matches[1] == "19" or matches[1] == "20" or matches[1] == "21" or matches[1] == "22" or matches[1] == "23") and (matches[2] == "00" or matches[2] == "01" or matches[2] == "02" or matches[2] == "03" or matches[2] == "04" or matches[2] == "05" or matches[2] == "06" or matches[2] == "07" or matches[2] == "08" or matches[2] == "09" or matches[2] == "10" or matches[2] == "11" or matches[2] == "12" or matches[2] == "13" or matches[2] == "14" or matches[2] == "15" or matches[2] == "16" or matches[2] == "17" or matches[2] == "18" or matches[2] == "19" or matches[2] == "20" or matches[2] == "21" or matches[2] == "22" or matches[2] == "23" or matches[2] == "24" or matches[2] == "25" or matches[2] == "26" or matches[2] == "27" or matches[2] == "28" or matches[2] == "29" or matches[2] == "30" or matches[2] == "31" or matches[2] == "32" or matches[2] == "33" or matches[2] == "34" or matches[2] == "35" or matches[2] == "36" or matches[2] == "37" or matches[2] == "38" or matches[2] == "39" or matches[2] == "40" or matches[2] == "41" or matches[2] == "42" or matches[2] == "43" or matches[2] == "44" or matches[2] == "45" or matches[2] == "46" or matches[2] == "47" or matches[2] == "48" or matches[2] == "49" or matches[2] == "50" or matches[2] == "51" or matches[2] == "52" or matches[2] == "53" or matches[2] == "54" or matches[2] == "55" or matches[2] == "56" or matches[2] == "57" or matches[2] == "58" or matches[2] == "59") and redis:get("atolc"..msg.chat_id_..msg.sender_user_id_) and is_mod(msg) then

tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'رجاءا ارسل الوقت الذي تريد للفتح المجموعة تلقائيا\n\nمثلا 11:13', 'md')
redis:del("atolc"..msg.chat_id_..msg.sender_user_id_)
redis:setex("atolct1"..msg.chat_id_,45,matches[1]..':'..matches[2])
redis:setex("atolc2"..msg.chat_id_..msg.sender_user_id_,45,true)


elseif (matches[1] == "00" or matches[1] == "01" or matches[1] == "02" or matches[1] == "03" or matches[1] == "04" or matches[1] == "05" or matches[1] == "06" or matches[1] == "07" or matches[1] == "08" or matches[1] == "09" or matches[1] == "10" or matches[1] == "11" or matches[1] == "12" or matches[1] == "13" or matches[1] == "14" or matches[1] == "15" or matches[1] == "16" or matches[1] == "17" or matches[1] == "18" or matches[1] == "19" or matches[1] == "20" or matches[1] == "21" or matches[1] == "22" or matches[1] == "23") and (matches[2] == "00" or matches[2] == "01" or matches[2] == "02" or matches[2] == "03" or matches[2] == "04" or matches[2] == "05" or matches[2] == "06" or matches[2] == "07" or matches[2] == "08" or matches[2] == "09" or matches[2] == "10" or matches[2] == "11" or matches[2] == "12" or matches[2] == "13" or matches[2] == "14" or matches[2] == "15" or matches[2] == "16" or matches[2] == "17" or matches[2] == "18" or matches[2] == "19" or matches[2] == "20" or matches[2] == "21" or matches[2] == "22" or matches[2] == "23" or matches[2] == "24" or matches[2] == "25" or matches[2] == "26" or matches[2] == "27" or matches[2] == "28" or matches[2] == "29" or matches[2] == "30" or matches[2] == "31" or matches[2] == "32" or matches[2] == "33" or matches[2] == "34" or matches[2] == "35" or matches[2] == "36" or matches[2] == "37" or matches[2] == "38" or matches[2] == "39" or matches[2] == "40" or matches[2] == "41" or matches[2] == "42" or matches[2] == "43" or matches[2] == "44" or matches[2] == "45" or matches[2] == "46" or matches[2] == "47" or matches[2] == "48" or matches[2] == "49" or matches[2] == "50" or matches[2] == "51" or matches[2] == "52" or matches[2] == "53" or matches[2] == "54" or matches[2] == "55" or matches[2] == "56" or matches[2] == "57" or matches[2] == "58" or matches[2] == "59") and redis:get("atolc2"..msg.chat_id_..msg.sender_user_id_) and is_mod(msg) then

local time_1 = redis:get("atolct1"..msg.chat_id_)

if time_1 == matches[1]..':'..matches[2] then
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'خطا.', 1, 'md')
else
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '_تم تفعيل الصامت تلقائي 🚫✅_ \n\nسيتم قفل المجموعة على ساعة *'..time_1..'* الی *'..matches[1]..':'..matches[2]..'* وقت الغاء قفل المجموعة 🚫❎ ', 1, 'md')
redis:set("atolct1"..msg.chat_id_,redis:get("atolct1"..msg.chat_id_))
redis:set("atolct2"..msg.chat_id_,matches[1]..':'..matches[2])
redis:del("atolc2"..msg.chat_id_..msg.sender_user_id_)
end


elseif matches[1]:lower() == 'settime riyath' or matches[1]:lower() == 'تعيين وقت رياض' and is_sudo(msg) then
io.popen("cp /usr/share/zoneinfo/Asia/Riyath /etc/localtime")
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'تم ضبط الوقت على رياض', 1, 'md')


elseif matches[1]:lower() == 'server time' or matches[1]== 'توقيت السيرفر' and is_sudo(msg) then
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, 'وقت السيرفر هو ['..os.date("%H:%M:%S")..'] ', 1, 'md')
end
end


local function pre_process(msg)
if redis:get("atolct2"..msg.chat_id_) or redis:get("atolct2"..msg.chat_id_) then

local time = os.date("%H%M")
local time2 = redis:get("atolct1"..msg.chat_id_)
time2 = time2.gsub(time2,":","")
local time3 = redis:get("atolct2"..msg.chat_id_)
time3 = time3.gsub(time3,":","")
if tonumber(time3) < tonumber(time2) then
if tonumber(time) <= 2359 and tonumber(time) >= tonumber(time2) then
if not redis:get("lc_ato:"..msg.chat_id_) then
redis:set("lc_ato:"..msg.chat_id_,true)
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '_المجموعة مغلقة حاليا 🚫❎\n\nمرجو عدم ارسال اي شيء 🔐\nحتى الساعة_ *'..redis:get("atolct2"..msg.chat_id_)..'* _ستفتح تلقائيا ✅_', 'md')
end
elseif tonumber(time) >= 0000 and tonumber(time) < tonumber(time3) then
if not redis:get("lc_ato:"..msg.chat_id_) then
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '_المجموعة مغلقة حاليا 🚫❎\n\nمرجو عدم ارسال اي شيء 🔐\nحتى الساعة_ *'..redis:get("atolct2"..msg.chat_id_)..'* _ستفتح تلقائيا ✅_', 'md')
redis:set("lc_ato:"..msg.chat_id_,true)
end
else
if redis:get("lc_ato:"..msg.chat_id_) then
redis:del("lc_ato:"..msg.chat_id_, true)
end
end
elseif tonumber(time3) > tonumber(time2) then
if tonumber(time) >= tonumber(time2) and tonumber(time) < tonumber(time3) then
if not redis:get("lc_ato:"..msg.chat_id_) then
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '_المجموعة مغلقة حاليا 🚫❎\n\nمرجو عدم ارسال اي شيء 🔐\nحتى الساعة_ *'..redis:get("atolct2"..msg.chat_id_)..'* _ستفتح تلقائيا ✅_', 'md')
redis:set("lc_ato:"..msg.chat_id_,true)
end
else
if redis:get("lc_ato:"..msg.chat_id_) then
redis:del("lc_ato:"..msg.chat_id_, true)
end
end
end
end

-- Message Check.

local is_channel = msg.to.type == "channel"
local is_chat = msg.to.type == "chat"
if redis:get("lc_ato:"..msg.chat_id_) then
if not is_mod(msg) then
if is_channel then
del_msg(msg.chat_id_, tonumber(msg.id))
elseif is_chat then
kick_user(msg.sender_user_id_, msg.chat_id_)
end
end
end


end
return { 
patterns = {
"^[/!#]([sS][eE][rR][vV][eE][rR] [tT][iI][mM][eE])$",
"^[/!#]([sS][eE][tT][tT][iI][mM][eE] [tT][eE][hH][rR][aA][nN])$",
"^[/!#]([lL][oO][cC][kK] [aA][uU][tT][oO])$",
"^[/!#]([uU][nN][lL][oO][cC][kK] [aA][uU][tT][oO])$",
"^[/!#]([lL][oO][cC][kK][aA][uU][tT][oO] [sS][tT][aA][tT][sS])$",
"^(تفعيل صامت تلقائي)$",
"^(تعطيل صامت تلقائي)$",
"^(صامت تلقائي احصائية)$",
"^(توقيت السيرفر)$",
"^(باز کردن خودکار)$",
"^(تعيين وقت رياض)$",
"^(%d+):(%d+)$"
}, 
run=TLG,
pre_process=pre_process
}
-- End By @omidhttp
-- Our Channel @TeleGold_Team