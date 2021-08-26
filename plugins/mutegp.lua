do
local function pre_process(msg)
 local hash = 'muteall:'..msg.to.id
  if redis:get(hash) and msg.to.type == 'channel' and not is_mod(msg)  then
    tdcli.deleteMessages(msg.chat_id_, {[0] = msg.id_})
       end
    return msg
 end
 
local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if matches[1] == 'قفل المجموعة' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
             local text = 'تم تفعيل الصامت في المجموعة '..msg.to.title..' 🔕\n'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=28, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
 else
local hour = string.gsub(matches[3], 'h', '')
local num1 = tonumber(hour) * 3600
local minutes = string.gsub(matches[4], 'm', '')
local num2 = tonumber(minutes) * 60
local second = string.gsub(matches[5], 's', '')
local num3 = tonumber(second) 
local num4 = tonumber(num1 + num2 + num3)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ hours : "..matches[3].."\n⏺ minutes : "..matches[4].."\n⏺ seconds : "..matches[5].."\n"
 elseif lang then
 return "بی صدا کردن فعال شد در \n⏺ ساعت : "..matches[3].."\n⏺ دقیقه : "..matches[4].."\n⏺ ثانیه : "..matches[5].."\n"
 end
 end
 end
 if matches[1] == 'silent' and matches[2] == 'h' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
             return "تم تفعيل الصامت في المجموعة"
 else
local hour = string.gsub(matches[3], 'h', '')
local num1 = tonumber(hour) * 3600
local num4 = tonumber(num1)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ hours : "..matches[3].."\n"
 elseif lang then
 return "تم تفعيل الصامت لمدة\n⏺ ساعات : "..matches[3].."\n"
 end
 end
 end
  if matches[1] == 'silent' and matches[2] == 'm' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
             return "تم تفعيل الصامت في المجموعة"
 else
local minutes = string.gsub(matches[3], 'm', '')
local num2 = tonumber(minutes) * 60
local num4 = tonumber(num2)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ minutes : "..matches[3].."\n"
 elseif lang then
 return "تم تفعيل الصامت لمدة\n⏺ دقيقة : "..matches[3].."\n"
 end
 end
 end
  if matches[1] == 'silent' and matches[2] == 's' and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
       if not matches[3] then
              redis:set(hash, true)
             return "تم تفعيل الصامت في المجموعة"
 else
local second = string.gsub(matches[3], 's', '')
local num3 = tonumber(second) 
local num4 = tonumber(num3)
redis:setex(hash, num3, true)
if not lang then
 return "Mute all has been enabled for \n⏺ seconds : "..matches[3].."\n"
 elseif lang then
 return "تم تفعيل الصامت لمدة\n⏺ ثانية : "..matches[3].."\n"
 end
 end
 end
if matches[1] == 'helpsilent' then
if not lang then
text = [[
*اوامر الصامت و صامت المؤقت:*
*/silent* 
_وضع الصامت للمجموعة_
*/nsilent*
_فتتح الصامت للمجموعة_ 
*/silent*  `h 1`
_وضع الصامت بالساعات_ 
*/silent* `m 60`
_وضع الصامت بدقائق_ 
*/silent* `s 120`
_وضع الصامت بثواني_ 
*Dev* @StePh
]]
elseif lang then
text = [[
*اوامر الصامت و صامت المؤقت:*
*/silent* 
_وضع الصامت للمجموعة_
*/nsilent*
_فتتح الصامت للمجموعة_ 
*/silent*  `h 1`
_وضع الصامت بالساعات_ 
*/silent* `m 60`
_وضع الصامت بدقائق_ 
*/silent* `s 120`
_وضع الصامت بثواني_ 
*Dev* @StePh
]]
end
return text
end
if matches[1] == 'فتح المجموعة' and is_mod(msg) then
               local hash = 'muteall:'..msg.to.id
        redis:del(hash)
		if not lang then
          return "mute all has been disabled"
		  elseif lang then
		  local text = 'تم الغاء تفعيل الصامت في المجموعة '..msg.to.title..' 🔔\n'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=34, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
  end
end
end
return {
   patterns = {
'^([Ss]ilent)$',
'^([Nn]silent)$',
 "^(قفل المجموعة)$",
 "^(فتح المجموعة)$",

 },
run = run,
pre_process = pre_process
}
end
--by @BeyondTeam
