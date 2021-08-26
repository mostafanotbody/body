local function run (msg , matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
if ((matches[1] == "helpall" and not Clang) or (matches[1] == "اوامر العامة" and Clang)) and is_mod(msg) then
if not lang then
text = [[
*📋 AdamBot cσммαиɒs :*

`● Orders to raise supervisors ● `
            
*👤 setmanager* `[username|id|reply]` 
_Add User To Group Admins_
*👤 Remmanager* `[username|id|reply]` 
 _Remove User From Owner List_
*👤 setowner* `[username|id|reply]` 
_Set Group Owner_
*👤 remowner* `[username|id|reply]` 
 _Remove User From Owner List_
*👤 promote* `[username|id|reply]` 
_Promote User To Group Admin_
*👤 demote* `[username|id|reply]` 
_Demote User From Group Admins List_

`● Expulsion and protection orders ● `
            
*⛔️ setflood* `[2-50]`
_Set Flooding Number_
*⛔️ stop* `[username|id|reply]` 
_Silent User From Group_
*⛔️ nstop* `[username|id|reply]` 
_Unsilent User From Group_
*⛔️ kick* `[username|id|reply]` 
_Kick User From Group_
*⛔️ ban* `[username|id|reply]` 
_Ban User From Group_
*⛔️ unban* `[username|id|reply]` 
_UnBan User From Group_

`● Information orders ● `
            
*ℹ️ res* `[username]`
_Show User ID_
*ℹ️ id* `[reply]`
_Show User ID_
*ℹ️ whois* `[id]`
_Show User's Username And Name_
*ℹ️ id*
_Show Your And Chat ID_
*ℹ️ gpinfo*
_Show Group Information_
            
`● Lock and unlock orders ● `

*🔐 k* `[link | join | tag | edit | arabic | webpage | bots | spam | flood | markdown | mention | pin | cmds | all | gif | photo | document | sticker | keyboard | video | text | forward | location | audio | voice | contact]`
            
_If This Actions (K 🔐), Bot Check Actions And Delete Them_
            
*🔓 n* `[link | join | tag | edit | arabic | webpage | bots | spam | flood | markdown | mention | pin | cmds | all | gif | photo | document | sticker | keyboard | video | text | forward | location | audio | voice | contact]`   
            
_If This Actions (N 🔓), Bot Not Delete Them_

`● Orders Silent ● `
            
*🔕 silent*
_close group_
*🔔 nsilent*
_open group_
*🔕 silent* `(hour) (minute) (seconds)`
_Mute group at this time_ 
*🔕 silenth* `(number)`
_Mute group at this time_ 
*🔕 silentm* `(number)`
_Mute group at this time_ 
*🔕 silents* `(number)`
_Mute group at this time_

`● Clean & Set Orders ● `
         
*📋 set*`[rules | name | link | about | welcome]`
            
_Bot Set Them_
            
*📋 clean* `[bans | mods | bots | rules | about | silentlist | 
filterlist | welcome]`   

_Bot Clean Them_

*📋 setwelcome [text]*
_set Welcome Message_
*📋 setrules [text]*
_set Rules Message_
*📋 setabout [text]*
_set About Message_

`● Other orders ● `

*📌 filter* `[word]`
_Word filter_
*📌 unfilter* `[word]`
_Word unfilter_
*📌 pin* `[reply]`
_Pin Your Message_
*📌 unpin* 
_Unpin Pinned Message_
*📌 welcome enable/disable*
_Enable Or Disable Group Welcome_
*📌 whitelist* `[+ | -]`	
_Add User To White List_
            
`● Lists Orders ● `
            
*🗒 mutelist*
_Show Mutes List_
*🗒 whitelist* `[+ | -]`	
_Add User To White List_
*🗒 silentlist*
_Show Silented Users List_
*🗒 filterlist*
_Show Filtered Words List_
*🗒 banlist*
_Show Banned Users List_
*🗒 ownerlist*
_Show Group Owners List_ 
*🗒 whitelist*
_Show Group whitelist List_
*🗒 modlist* 
_Show Group Moderators List_
            
`● Group Additions Orders ● `

*📍 rules*
_Show Group Rules_
*📍 about*
_Show Group Description_

`● Links Orders ● `
            
*🔗 newlink*
_Create A New Link_
*🔗 newlink pv*
_Create A New Link The Pv_
*🔗 link*
_Show Group Link_
*🔗 link pv*
_Send Group Link In Your Private Message_

`● General Orders ● `

*🔧 cmds* `[member | moderator | owner]`	
_set cmd_
*🔧 settings*
_Show Group Settings_
*🔧 setlang ar*
_Set Persian Language_
            
`● Helps Orders ● `
   
*🔹 helptools*
_Show Tools Help_
*🔹 helpfun*
_Show Fun Help_
*🔹 helpmute*
_Show mute Help_

_⚠️ You Can Use_ *[!/#]* _To Run The Commands ⚠️_
*Good luck ;)*
            ]]

elseif lang then

text = [[
`📋 اوامر AdamBot :`

`● اوامر الترقية ● `
            
`👤 رفع مدير`
_رفع مدير في المجموعة_
`👤 حذف مدير` 
_حذف مدير من المجموعة_
`👤 رفع ادمن` 
_رفع ادمن في المجموعة_
`👤 حذف ادمن`
_حذف ادمن من المجموعة_
            
_🚸 ملاحظة : جميع اوامر الترقية تعمل بالرد والمعرف والايدي 🚸_ 
            
`● اوامر الطرد والحماية ● `
            
`⛔️ تحديد التكرار [عدد]`
_تحديد التكرار هجوم بين 5 و 50_
`⛔️ تحديد وقت التكرار [عدد]`
_تحديد وقت بين رسائل تكرار_
`⛔️ الحد الاقصى للحروف [عدد]`
_تحديد عدد حروف رسائل_
`⛔️ تصميت`
_تفعيل وضع الصامت لعضو_
`⛔️ الغاء تصميت` 
_ازالة العضو من قائمة المصمتين_
`⛔️ طرد` 
_طرد عضو من المجموعة_
`⛔️ حظر` 
_حظر عضو من المجموعة_
`⛔️ الغاء الحظر` 
_ازالة حظر عن عضو_

_🚸 ملاحظة : جميع اوامر الطرد والحماية تعمل بالرد والمعرف والايدي 🚸_     
            
`● اوامر المعلومات ● `
            
*ℹ️ من هو* `[المعرف]`
_معرفة معلومات العضو بالمعرف_
*ℹ️ ايدي* `[reply]`
_معلومات العضو بالرد_
*ℹ️ العضو* `[الايدي]`
_معرف العضو بالايدي_
*ℹ️ معلومات المجموعة*
_عرض معلومات المجموعة_
*ℹ️ معلومات بالرد | المعرف*
_عرض معلوماتي او اعضاء_
*ℹ️ ايدي*
_عرض معلوماتي مرفقة بصورة_

`● صامت للمجموعة ● `
          
`🔕 قفل مجموعة`
_وضع صامت للمجموعة_ 
`🔔 فتح مجموعة`
_فتح صامت للمجموعة_ 

`🔕 اوامر الصامت`
_للعرض جميع اوامر الصامت_

`● اوامر التعيين والتنظيف ● `
         
`📋 تعيين [قوانين | اسم | رابط | وصف | ترحيب]`
            
_البوت سيقوم بتعيينهم_
            
`📋 تنظيف [المحظورين | الادمن | القوانين | الوصف | قائمة المصمتين | قائمة فلتر | الترحيب]  `

_البوت سيقوم بحذفهم_

`⛔️ طرد البوتات`
_طرد البوتات في المجموعة_

`🗑 تنظيف المطرودين`
_تنظيف قائمة المطرودين من مجموعة_

`🗑 تنظيف حسابات المحذوفة`
_مسح حسابات محذوفة من قروب_

`● اوامر اخرى ●`

 `📌 فلتر [كلمة]`
_حظر كلمة_
 `📌 حذف فلتر [كلمة]`
_ازالة الحظر عن كلمة_
`📌 تثبيت [بالرد]`
_تثبيت رسالة_
`📌 الغاء التثبيت` 
_ازالة تثبيت رسالة_
`📌 الترحيب فعال/تعطيل`
_تفعيل وتعطيل الترحيب_
`📌 القائمة البيضاء [+ | -]`	
_اضافة او ازالة مستخدم للقائمة البيضاء_

`● اوامر الترحيب ● `

`🎉️ الترحيب تفعيل | تعطيل`
_للتشغيل او تعطيل الترحيب_
`🎉️ تعيين ترحيب`
_تخصيص ترحيب للمجموعة_

`● اوامر القوائم ● `
            
`🗒 قائمة المصمتين`
_عرض قائمة الاعضاء المصمتين_
`🗒 قائمة فلتر`
_عرض قائمة الكلمات المحظورة_
`🗒 قائمة المحظورين`
_عرض قائمة المحظورين_
`🗒 قائمة المدراء`
_عرض قائمة المدراء_
`🗒 اعضتء القائمة البيضاء`
_عرض الاعضاء في القائمة البيضاء_
`🗒 قائمة الادمن` 
_عرض قائمة الادمن_
            
`● اوامر اضافية ● `

*📍 قوانين*
_عرض قوانين المجموعة_

`● اوامر الروابط ● `
            
`🔗 تعيين رابط`
_حفظ رابط جديد_
`🔗 الرابط`
_عرض رابط المجموعة_
`🔗 الرابط خاص`
_ارسال الرابط خاص_

`● اوامر عامة ● `

`🔧 الاوامر [المدراء | الاعضاء | المشرفين]`	
_تحديد من يستخدم الاوامر_
`🔧 الاعدادات`
_عرض اعدادات المجموعة_
`🔧 لغة [انجليزي | عربي]`
_تحويل اللغة للانجليزية لو العربية_
`🔧 اوامر انجليزي`
_تحويل اوامر للانجليزي_

`🚮 مسح` *1000*
_تنظيف رسائل المجموعة بالعدد_

`🚮 تنظيف المجموعة`
_تنظيف 5000 رسالة من المجموعة_

`🔰 تحقق`
_تحقق من ايام تفعيل_
`👤 بروفايل [ ايدي عضو ]`
_للعرض صور بروفايل العضو_
`🌀 منشن [ ايدي عضو ]`
_للعمل منشن للعضو و دخول له_
`✉️ رسالة للمطور [رسالة]`
_ارسال رسالة للمطور_

*Dev* : @alameen79
            ]]
end
return text
end
-----------------------------------------
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
if ((matches[1] == "helptools" and not Clang) or (matches[1] == "اوامر المطور" and Clang)) and is_sudo(msg) then
if not lang then
lock = [[

_Sudoer And Admins AdamBot Bot Help :_

*!visudo* `[username|id|reply]`
_Add Sudo_

*!desudo* `[username|id|reply]`
_Demote Sudo_

*!sudolist *
_Sudo(s) list_

*!adminprom* `[username|id|reply]`
_Add admin for bot_

*!admindem* `[username|id|reply]`
_Demote bot admin_

*!adminlist *
_Admin(s) list_

*!leave *
_Leave current group_

*!autoleave* `[disable/enable]`
_Automatically leaves group_

*!chats*
_List of added groups_

*!join* `[id]`
_Adds you to the group_

*!off* `[id]`
_Remove a group from Database_

*!import* `[link]`
_Bot joins via link_

*!setbotname* `[text]`
_Change bot's name_

*!setbotusername* `[text]`
_Change bot's username_

*!delbotusername *
_Delete bot's username_

*!markread* `[off/on]`
_Second mark_

*!broadcast* `[text]`
_Send message to all added groups_

*!bc* `[text] [gpid]`
_Send message to a specific group_

*!del* `[Reply]`
_Remove message Person you are_

*!clear cache*
_Clear All Cache Of .telegram-cli/data_

*!check*
_Stated Expiration Date_

*!check* `[GroupID]`
_Stated Expiration Date Of Specific Group_

*!charge* `[GroupID]` `[Number Of Days]`
_Set Expire Time For Specific Group_

*!charge* `[Number Of Days]`
_Set Expire Time For Group_

*!jointo* `[GroupID]`
_Invite You To Specific Group_

*!leave* `[GroupID]`
_Leave Bot From Specific Group_

_You can use_ *[!/#]* _at the beginning of commands._

*Dev* @alameen79

]]
           

elseif lang then

lock = [[

_اوامر المطورين_

`✅ تفعيل` 
_تفعيل البوت في المجموعة_

`❎ تعطيل`
_تعطيل البوت في مجموعة_

`💠 تعطيل [ايدي مجموعة]`
_تعطيل البوت في مجموعة_

`📄 قائمة المطورين`
_عرض المطورين_

`🆔 ايدي مجموعة`
_عرض ايدي المجموعة_

`⤵️ اضافتي الى [ايدي مجموعة]`
_اضافة المطور للمجموعات_

`✔️ رفع مطور`
_رفع مطور في البوت_

`✖️ حذف مطور`
_للحذف مطور من البوت_

`✅ رفع ادمن`
_للرفع ادمن في البوت_

`❎ حذف ادمن`
_للحذف ادمن من البوت_

`📛 حذف معرف بوت`
_حذف معرف البوت بامر_

`🗯 تغيير معرف بوت [معرف]`
_تغيير معرف البوت_

`♦️ تغيير اسم بوت [اسم]`
_تغيير اسم البوت_

`🔊 ارسال للمجموعات`
_ارسال رسالة للمجموعات_

`📈 قائمة المجموعات`
_عرض مجموعات البوت_

`❌ خروج البوت`
_اخراج البوت من المجموعة_

`🚫 طرد البوت [ايدي مجموعة]`
_طرد البوت عن بعد_

`📜 قائمة ادمن`
_قائمة الادمن للبوت_

`🔮 شحن [ايدي مجموعة] [عدد]`
_شحن ايام تفعيل عن بعد_

`⌛️ شحن [عدد ايام]`
_شحن ايام تفعيل في مجموعة_

`🔰 تحقق`
_تحقق من ايام تفعيل عن بعد_

`🆔 تحقق [ايدي مجموعة]`
_تحقق من ايام تفعيل عن بعد_

`📋 ارسال [النص] [ايدي مجموعة]`
_ارسال رسالة للمجموعة معينة_

`📌 اضافتي [ايدي مجموعة]`
_اضافة المطور للمجموعة_

`📎 اضافة البوت [الرابط]`
_اضافة البوت على الرابط_

*Dev* : @alameen79
            
            ]]
end
return lock
end
-----------------------------------------
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
if ((matches[1] == "helpfun" and not Clang) or (matches[1] == "اوامر اضافية" and Clang)) and is_mod(msg) then
if not lang then
Management = [[

_AdamBot Fun Help Commands:_

*!time*
_Get time in a sticker_

*!short* `[link]`
_Make short url_

*!voice* `[text]`
_Convert text to voice_

*!tr* `[lang] [word]`
_Translates FA to EN and EN to FA_
_Example:_
*!tr fa hi*

*!sticker* `[word]`
_Convert text to sticker_

*!photo* `[word]`
_Convert text to photo_

*!azan* `[city]`
_Get Azan time for your city_

*!calc* `[number]`
Calculator

*!praytime* `[city]`
_Get Patent (Pray Time)_

*!tosticker* `[reply]`
_Convert photo to sticker_

*!tophoto* `[reply]`
_Convert text to photo_

*!weather* `[city]`
_Get weather_

*Dev* @alameen79]]

elseif lang then

Management = [[
            

_قائمة اوامر AdamBot :_

*🎤 الصوت* `[نص]`
_تبديل نص لصوت_

*🔅 ترجمة* `اللغة-الكلمة`
_ترجمة النصوص_

*💕 قلب* `[كلمة اولى] [كلمة ثانية]`
_عمل صورة وسطها قلب_

*✍ زخرفة* `[نص انجليزي]`
_زخرفة انجليزي_

*🔰 الملصق* `[نص]`
_تبديل النص لملصق_

*🖼 الصورة* `[نص]`
_تحويل نص لصورة_

*💠 اذان* `[مدينة]`
_موعد الاذان في مدينة_

*🔢 حساب* `[عدد]`
_حساب الارقام_

*🎈 تحويل لملصق* `[بالرد]`
_تحويل صورة لملصق_

*تحويل لصورة* `[بالرد]`
🖼 _تحويل ملصق لصورة_

*🌞 الطقس* `[المدينة]`
_حالة الطقس في المدينة_

`📎 رابط`
_عرض الرابط بماركداون_

`🔎 بحث صورة [اسم]`
_للبحث عن الصور عبر بوت_

`📧 رقم رسالة [بالرد]`
_عرض رقم رسالة في سيرفر تلجرام_

`🌇 صورة متحركة [اسم بانجليزي]`
_بحث عن صور متحركة عبر بوت_

`📽 يوتيوب [نص]`
_بحث ف يوتيوب وتحميل عبر بوت_

`🗑 مسح رسائلي`
_مسج جميع رسائلك من المجموعة_

`📊 تصويت [النص]`
_للتصويت بشفاف في مجموعة_

`🛢 اخفاء [النص]`
_لاخفاء النص في الزر الشفاف_

`🕹 العب`
_للعب لعبة الحساب مع اصدقاء_

`📲 بحث برنامج`
_للبحث عن البرامج و تحمليها_

*Dev* : @alameen79
            
            ]]
end
return Management
end
-----------------------------------------
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
if ((matches[1] == "helpmute" and not Clang) or (matches[1] == "اوامر الصامت" and Clang)) and is_mod(msg) then
if not lang then
helpfun = [[

`● Orders Silent ● `
            
*🔕 silent*
_close group_
*🔔 nsilent*
_open group_
*🔕 silent* `(hour) (minute) (seconds)`
_Mute group at this time_ 
*🔕 silenth* `(number)`
_Mute group at this time_ 
*🔕 silentm* `(number)`
_Mute group at this time_ 
*🔕 silents* `(number)`
_Mute group at this time_
*🔕 silent status*
_show time silent_

_👤 المطور_ > @alameen79
            ]]
tdcli.sendMessage(msg.chat_id_, 0, 1, helpfun, 1, 'md')
else

helpfun = [[



`● اوامر الصامت AdamBot ● `
          
`🔕 قفل المجموعة`
_وضع صامت للمجموعة_ 
`🔔 فتح المجموعة`
_فتح صامت للمجموعة_ 
`🔕 الصامت`  (ساعات) (دقائق) (ثواني)
_قفل المجموعة بالساعات و الدقائق والثواني_ 
`🔕 الصامت ساعات (رقم)`
_قفل المجموعة بالساعات_ 
`🔕 الصامت دقائق (رقم)`
_قفل المجموعة بالدقائق_ 
`🔕 الصامت ثواني (رقم)`
_قفل المجموعة بالثواني_
`ℹ️ الصامت احصائية`
_للمعرفة كم متبقي في صامت المؤقت_

`● اوامر الصامت تلقائي ● `

`❎ تفعيل صامت تلقائي`
_للوضع صامت تلقائي للمجموعة_ 
`❎ تعطيل صامت تلقائي`
_لاغاء صامت تلقائي للمجموعة_
`📉 صامت تلقائي احصائية`
_للمعرفة وضع الصامت تلقائي_


*Dev* : @alameen79
            ]]
tdcli.sendMessage(msg.chat_id_, 0, 1, helpfun, 1, 'md')
end
end
-------------------------
-----------------------------------------
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
if ((matches[1] == "helplock" and not Clang) or (matches[1] == "اوامر بالتحذير" and Clang)) and is_mod(msg) then
if not lang then
text = [[


*Good luck ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
            
🔰 `اوامر` القفل بالتحذير *AdamBot*

ا➖➖➖➖➖➖➖➖➖➖➖

🔐 `قفل الروابط بالتحذير`
🔓 _قفل الروابط تعطيل_

🔐 `قفل المعرفات بالتحذير`
🔓 _قفل المعرفات تعطيل_

🔐 `قفل روابط المواقع بالتحذير`
🔓 _قفل روابط المواقع تعطيل_

🔐 `قفل السبام بالتحذير`
🔓 _قفل السبام تعطيل_

🔐 `قفل التكرار بالتحذير`
🔓 _قفل التكرار تعطيل_

🔐 `قفل الماركداون بالتحذير`
🔓 _قفل الماركداون تعطيل_

🔐 `قفل المنشن بالتحذير`
🔓 _قفل المنشن تعطيل_

🔐 `قفل العربية بالتحذير`
🔓 _قفل العربية تعطيل_

🔐 `قفل اعادة التوجيه بالتحذير`
🔓 _قفل اعادة التوجيه تعطيل_

🔐 `قفل توجيه القنوات بالتحذير`
🔓 _قفل توجيه القنوات تعطيل_

🔐 `قفل التسجيلات بالتحذير`
🔓 _قفل التسجيلات تعطيل_

🔐 `قفل صور المتحركة بالتحذير`
🔓 _قفل صور المتحركة تعطيل_

🔐 `قفل الصوتيات بالتحذير`
🔓 _قفل الصوتيات تعطيل_

🔐 `قفل الفيديو بالتحذير`
🔓 _قفل الفيديو تعطيل_

🔐 `قفل المجموعة بالتحذير`
🔓 _قفل المجموعة تعطيل_

🔐 `قفل الصور بالتحذير`
🔓 _قفل الصور تعطيل_

🔐 `قفل ازرار شفافة بالتحذير`
🔓 _قفل ازرار شفافة تعطيل_

🔐 `قفل كيبورد بالتحذير`
🔓 _قفل كيبورد تعطيل_

🔐 `قفل جهات اتصال بالتحذير`
🔓 _قفل جهات اتصال تعطيل_

🔐 `قفل الملفات بالتحذير`
🔓 _قفل الملفات تعطيل_

🔐 `قفل مشاركة الموقع بالتحذير`
🔓 _قفل مشاركة الموقع تعطيل_

🔐 `قفل النصوص بالتحذير`
🔓 _قفل النصوص تعطيل_

🔐 `قفل التعديل بالتحذير`
🔓 _قفل التعديل تعطيل_

🔐 `قفل الملصقات بالتحذير`
🔓 _قفل الملصقات تعطيل_

ℹ️ هذه اوامر لا تحتاج تحذير ⬇️

🔐 `قفل دخول البوتات`
🔓_ فتح دخول البوتات_
🔐 `قفل دخول الاعضاء`
🔓 _فتح دخول الاعضاء_
🔐 `قفل الاشعارات`
🔓 _فتح الاشعارات_
🔐 `قفل التثبيت`
🔓 _فتح التثبيت_
ا➖➖➖➖➖➖➖➖➖➖➖
*Dev* : @alameen79

]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
end
-------------------------
-----------------------------------------
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
if ((matches[1] == "helpwarn" and not Clang) or (matches[1] == "اوامر التحذير" and Clang)) and is_mod(msg) then
if not lang then
text = [[


*Good luck ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
            
🔰 `اوامر التحذيرات` *AdamBot*

ا➖➖➖➖➖➖➖➖➖➖➖

🔧 `تحديد حد تحذيرات (رقم)`
_للتحديد حد التحذيرات الاقصى_
🔴 `تحذير`
_تحذير العضو بالرد و المعرف و ايدي_
⚪️ `حذف تحذير`
_حذف تحذيرات عضو برد معرف وايدي_
📋 `قائمة تحذيرات`
_للعرض قائمة التحذيرات اعضاء_
🗑 `مسح تحذيرات`
_للمسح جميع تحذيرات الاعضاء_

ا➖➖➖➖➖➖➖➖➖➖➖
*Dev* : @alameen79

]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
end
-------------------------
-----------------------------------------
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
if ((matches[1] == "helpwarn" and not Clang) or (matches[1] == "اوامر بالحذف" and Clang)) and is_mod(msg) then
if not lang then
text = [[


*Good luck ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
            
🔰 `اوامر القفل بالحذف` *AdamBot*

ا➖➖➖➖➖➖➖➖➖➖➖

🔐 `قفل الروابط بالحذف`
🔓 _قفل الروابط تعطيل_

🔐 `قفل المعرفات بالحذف`
🔓 _قفل المعرفات تعطيل_

🔐 `قفل روابط المواقع بالحذف`
🔓 _قفل روابط المواقع تعطيل_

🔐 `قفل السبام بالحذف`
🔓 _قفل السبام تعطيل_

🔐 `قفل التكرار بالحذف`
🔓 _قفل التكرار تعطيل_

🔐 `قفل الماركداون بالحذف`
🔓 _قفل الماركداون تعطيل_

🔐 `قفل المنشن بالحذف`
🔓 _قفل المنشن تعطيل_

🔐 `قفل العربية بالحذف`
🔓 _قفل العربية تعطيل_

🔐 `قفل اعادة التوجيه بالحذف`
🔓 _قفل اعادة التوجيه تعطيل_

🔐 `قفل توجيه القنوات بالحذف`
🔓 _قفل توجيه القنوات تعطيل_

🔐 `قفل التسجيلات بالحذف`
🔓 _قفل التسجيلات تعطيل_

🔐 `قفل صور المتحركة بالحذف`
🔓 _قفل صور المتحركة تعطيل_

🔐 `قفل الصوتيات بالحذف`
🔓 _قفل الصوتيات تعطيل_

🔐 `قفل الفيديو بالحذف`
🔓 _قفل الفيديو تعطيل_

🔐 `قفل المجموعة بالحذف`
🔓 _قفل المجموعة تعطيل_

🔐 `قفل الصور بالحذف`
🔓 _قفل الصور تعطيل_

🔐 `قفل ازرار شفافة بالحذف`
🔓 _قفل ازرار شفافة تعطيل_

🔐 `قفل كيبورد بالحذف`
🔓 _قفل كيبورد تعطيل_

🔐 `قفل جهات اتصال بالحذف`
🔓 _قفل جهات اتصال تعطيل_

🔐 `قفل الملفات بالحذف`
🔓 _قفل الملفات تعطيل_

🔐 `قفل مشاركة الموقع بالحذف`
🔓 _قفل مشاركة الموقع تعطيل_

🔐 `قفل النصوص بالحذف`
🔓 _قفل النصوص تعطيل_

🔐 `قفل التعديل بالحذف`
🔓 _قفل التعديل تعطيل_

🔐 `قفل الملصقات بالحذف`
🔓 _قفل الملصقات تعطيل_

ℹ️ هذه اوامر لا تحتاج الحذف ⬇️

🔐 `قفل دخول البوتات`
🔓_ فتح دخول البوتات_
🔐 `قفل دخول الاعضاء`
🔓 _فتح دخول الاعضاء_
🔐 `قفل الاشعارات`
🔓 _فتح الاشعارات_
🔐 `قفل التثبيت`
🔓 _فتح التثبيت_

ا➖➖➖➖➖➖➖➖➖➖➖
*Dev* : @alameen79

]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
end
-------------------------
-----------------------------------------
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
if ((matches[1] == "helpwarn" and not Clang) or (matches[1] == "اوامر بالطرد" and Clang)) and is_mod(msg) then
if not lang then
text = [[


*Good luck ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
            
🔰 `اوامر القفل بالطرد` *AdamBot*

ا➖➖➖➖➖➖➖➖➖➖➖

🔐 `قفل الروابط بالطرد`
🔓 _قفل الروابط تعطيل_

🔐 `قفل المعرفات بالطرد`
🔓 _قفل المعرفات تعطيل_

🔐 `قفل روابط المواقع بالطرد`
🔓 _قفل روابط المواقع تعطيل_

🔐 `قفل السبام بالطرد`
🔓 _قفل السبام تعطيل_

🔐 `قفل التكرار بالطرد`
🔓 _قفل التكرار تعطيل_

🔐 `قفل الماركداون بالطرد`
🔓 _قفل الماركداون تعطيل_

🔐 `قفل المنشن بالطرد`
🔓 _قفل المنشن تعطيل_

🔐 `قفل العربية بالطرد`
🔓 _قفل العربية تعطيل_

🔐 `قفل اعادة التوجيه بالطرد`
🔓 _قفل اعادة التوجيه تعطيل_

🔐 `قفل توجيه القنوات بالطرد`
🔓 _قفل توجيه القنوات تعطيل_

🔐 `قفل التسجيلات بالطرد`
🔓 _قفل التسجيلات تعطيل_

🔐 `قفل صور المتحركة بالطرد`
🔓 _قفل صور المتحركة تعطيل_

🔐 `قفل الصوتيات بالطرد`
🔓 _قفل الصوتيات تعطيل_

🔐 `قفل الفيديو بالطرد`
🔓 _قفل الفيديو تعطيل_

🔐 `قفل المجموعة بالطرد`
🔓 _قفل المجموعة تعطيل_

🔐 `قفل الصور بالطرد`
🔓 _قفل الصور تعطيل_

🔐 `قفل ازرار شفافة بالطرد`
🔓 _قفل ازرار شفافة تعطيل_

🔐 `قفل كيبورد بالطرد`
🔓 _قفل كيبورد تعطيل_

🔐 `قفل جهات اتصال بالطرد`
🔓 _قفل جهات اتصال تعطيل_

🔐 `قفل الملفات بالطرد`
🔓 _قفل الملفات تعطيل_

🔐 `قفل مشاركة الموقع بالطرد`
🔓 _قفل مشاركة الموقع تعطيل_

🔐 `قفل النصوص بالطرد`
🔓 _قفل النصوص تعطيل_

🔐 `قفل التعديل بالطرد`
🔓 _قفل التعديل تعطيل_

🔐 `قفل الملصقات بالطرد`
🔓 _قفل الملصقات تعطيل_

ℹ️ هذه اوامر لا تحتاج الطرد ⬇️

🔐 `قفل دخول البوتات`
🔓_ فتح دخول البوتات_
🔐 `قفل دخول الاعضاء`
🔓 _فتح دخول الاعضاء_
🔐 `قفل الاشعارات`
🔓 _فتح الاشعارات_
🔐 `قفل التثبيت`
🔓 _فتح التثبيت_
ا➖➖➖➖➖➖➖➖➖➖➖
*Dev* : @alameen79

]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
end
-------------------------
-----------------------------------------
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
if ((matches[1] == "helpwarn" and not Clang) or (matches[1] == "اوامر بالتصميت" and Clang)) and is_mod(msg) then
if not lang then
text = [[


*Good luck ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
            
🔰 `اوامر القفل بالتصميت` *AdamBot*

ا➖➖➖➖➖➖➖➖➖➖➖

🔐 `قفل الروابط بالتصميت`
🔓 _قفل الروابط تعطيل_

🔐 `قفل المعرفات بالتصميت`
🔓 _قفل المعرفات تعطيل_

🔐 `قفل روابط المواقع بالتصميت`
🔓 _قفل روابط المواقع تعطيل_

🔐 `قفل السبام بالتصميت`
🔓 _قفل السبام تعطيل_

🔐 `قفل التكرار بالتصميت`
🔓 _قفل التكرار تعطيل_

🔐 `قفل الماركداون بالتصميت`
🔓 _قفل الماركداون تعطيل_

🔐 `قفل المنشن بالتصميت`
🔓 _قفل المنشن تعطيل_

🔐 `قفل العربية بالتصميت`
🔓 _قفل العربية تعطيل_

🔐 `قفل اعادة التوجيه بالتصميت`
🔓 _قفل اعادة التوجيه تعطيل_

🔐 `قفل توجيه القنوات بالتصميت`
🔓 _قفل توجيه القنوات تعطيل_

🔐 `قفل التسجيلات بالتصميت`
🔓 _قفل التسجيلات تعطيل_

🔐 `قفل صور المتحركة بالتصميت`
🔓 _قفل صور المتحركة تعطيل_

🔐 `قفل الصوتيات بالتصميت`
🔓 _قفل الصوتيات تعطيل_

🔐 `قفل الفيديو بالتصميت`
🔓 _قفل الفيديو تعطيل_

🔐 `قفل المجموعة بالتصميت`
🔓 _قفل المجموعة تعطيل_

🔐 `قفل الصور بالتصميت`
🔓 _قفل الصور تعطيل_

🔐 `قفل ازرار شفافة بالتصميت`
🔓 _قفل ازرار شفافة تعطيل_

🔐 `قفل كيبورد بالتصميت`
🔓 _قفل كيبورد تعطيل_

🔐 `قفل جهات اتصال بالتصميت`
🔓 _قفل جهات اتصال تعطيل_

🔐 `قفل الملفات بالتصميت`
🔓 _قفل الملفات تعطيل_

🔐 `قفل مشاركة الموقع بالتصميت`
🔓 _قفل مشاركة الموقع تعطيل_

🔐 `قفل النصوص بالتصميت`
🔓 _قفل النصوص تعطيل_

🔐 `قفل التعديل بالتصميت`
🔓 _قفل التعديل تعطيل_

🔐 `قفل الملصقات بالتصميت`
🔓 _قفل الملصقات تعطيل_

ℹ️ هذه اوامر لا تحتاج التصميت ⬇️

🔐 `قفل دخول البوتات`
🔓_ فتح دخول البوتات_
🔐 `قفل دخول الاعضاء`
🔓 _فتح دخول الاعضاء_
🔐 `قفل الاشعارات`
🔓 _فتح الاشعارات_
🔐 `قفل التثبيت`
🔓 _فتح التثبيت_
ا➖➖➖➖➖➖➖➖➖➖➖
*Dev* : @alameen79

]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
end
-----------------------------------------
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
if ((matches[1] == "helpreply" and not Clang) or (matches[1] == "اوامر الردود" and Clang)) and is_mod(msg) then
if not lang then
text = [[

]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
            
🔰 `قائمة الاوامر الردود` *AdamBot*

➕ `اضافة رد` *+* *(*`الكلمة او كم كلمة`*) /* `الرد`
_للاضافة الردود_

➖ `حذف الرد` *- (*`الكلمة`*)*
_لحذف الردود_


`مثال للاضافة الردود`
_اضافة رد_ *+* _ستيف بوت_ */* _بوت شغال 👍_

`مثال حذف الردود`
_حذف رد_ *-* _ستيف بوت_

ا➖➖➖➖➖➖➖➖➖➖➖
*Dev* : @alameen79

]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
end
-----------------------------------------
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
if ((matches[1] == "help" and not Clang) or (matches[1] == "الاوامر" and Clang)) and is_mod(msg) then
if not lang then
text = [[

]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
            
🔰 `قائمة الاوامر` *AdamBot*

`⚙ الضبط`
_للعرض اعدادات بازرار شفافة_
`🔇 اوامر بالتصميت`
_للعرض قائمة اوامر قفل بتصميت_
`⛔️ اوامر بالطرد`
_للعرض اوامر قفل بالطرد_
`🗑 اوامر بالحذف`
_للعرض اوامر قفل بالحذف_
`⚠️ اوامر بالتحذير`
_للعرض اوامر قفل بالتحذير_
`⚙ اوامر العامة`
_للعرض اوامر تحكم بالمجموعة_
`🔕 اوامر الصامت`
_للعرض اوامر الصامت للمجموعة_
`🎨 اوامر اضافية`
_للعرض اوامر الترفيه للجميع_
`♻️ اوامر الردود`
_عرض اوامر اضافة الردود_

ا➖➖➖➖➖➖➖➖➖➖➖
*Dev* : @alameen79

]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
end
end


return {
patterns ={
"^([Hh]elplock)$",
"^([Hh]elp)$",
"^([Hh]elpmute)$",
"^([Hh]elpfun)$",
"^([Hh]elptools)$",
"^(helpall)$",
"^(helpreply)$",
"^(اوامر التحذير)$",
"^(اوامر بالتصميت)$",
"^(اوامر بالطرد)$",
"^(اوامر بالتحذير)$",
"^(اوامر بالحذف)$",
"^(اوامر اضافية)$",
"^(اوامر الردود)$",
"^(اوامر المطور)$",
"^(اوامر الصامت)$",
"^(اوامر العامة)$",
"^(الاوامر)$"

}, 
run =run
}
