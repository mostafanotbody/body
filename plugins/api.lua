local function CerNer(msg, matches) 
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
if matches[1] == 'stats' and is_sudo(msg) then
--------------------------------------------------—
local allmsg = redis:get("allmsg")
-------------------------------------------------—
local gps = redis:scard("su")
-------------------------------------------------—
local gp = redis:scard("gp")
------------------------------------------------—
local user = redis:scard("user")
--------------------------------------------------—
local bot = redis:scard("bot")
---------------------------------------------------
       tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '> Stats  Bot : \n\n> All Msg : '..allmsg..'\n\n> SuperGroup  : '..gps..'\n\n> Group  : '..gp..'\n\n> Users : '..user..'\n\n Bot Msg : '..bot..'', 1, 'md')
end
if text == 'reset' and is_sudo(msg) then
redis:del("allmsg")
redis:del("sgps")
redis:del("gp")
redis:del("user")
redis:del("bot")
tdcli.sendMessage(msg.chat_id_, msg.id_,1,' Stats Has Been Reseted ',1,'md')
end
 if matches[1] == "رابط" and is_mod(msg) then
 local data = load_data(_config.moderation.data)
      local link = data[tostring(msg.chat_id_)]['settings']['linkgp']
local text = '📎 رابط المجموعة\n\n['..msg.to.title..' ]('..link..')'
function viabold(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 1,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
            end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 107705060,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = text,
      offset_ = 0
    }, viabold, nil)
       end
       if matches[1] == "صوت" then
          local user = matches[2]
          function Txt2SpeechBot(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
            end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 182509766,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = user,
      offset_ = 0
    }, Txt2SpeechBot, nil)
       end
       if matches[1] == "ارسال ملصق" then
          local user = matches[2]
          function sticker(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
            end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 209859129,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = user,
      offset_ = 3
    }, sticker, nil)
       end
  if matches[1] == "صورة متحركة" then
          local user = matches[2]
          function guggybot(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
            end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 214603202,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = user,
      offset_ = 0
    }, guggybot, nil)
       end
       if matches[1] == "شكل مزخرف" then
          local user = matches[2]
          function textojibot(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
            end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 214546622,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = user,
      offset_ = 0
    }, textojibot, nil)
       end
if matches[1] == 'العب' then
          function ManagerTGBot(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
           end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 166035794,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = user,
      offset_ = 3
    }, ManagerTGBot, nil)
       end
       if matches[1] == 'يوتيوب' then
          local user = matches[2]
          function y(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
           end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 144862938,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = user,
      offset_ = 0
    }, ManagerTGBot, nil)
       end
if matches[1] == 'qrcode'  then
          local user = matches[2]
local text = 'qr '..user..''
          function qr(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
           end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 229533808,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = text,
      offset_ = 0
    }, qr, nil)
       end
if matches[1] == 'fuck' then
  local text = matches[2]
          function fuck(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
           end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 341641510,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = text,
      offset_ = 0
    }, fuck, nil)
       end
if matches[1] == 'تصويت' then
  local text = matches[2]
          function like(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
           end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 190601014,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = text,
      offset_ = 0
    }, like, nil)
       end
if matches[1] == 'اخفاء' then
  local text = matches[2]
          function HT4BOT(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
           end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 243684939,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = text,
      offset_ = 0
    }, HT4BOT, nil)
       end
 if matches[1] == 'بحث صورة' then
          local user = matches[2]
          function getph(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
            end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 109158646,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = user,
      offset_ = 0
    }, getph, nil)
       end
	     if matches[1] == "hide" and is_mod(msg) then
	   local text = matches[2]
          function hidetext(arg,data)
          tdcli_function({
        ID = "SendInlineQueryResultMessage",
        chat_id_ = msg.chat_id_,
        reply_to_message_id_ = msg.id_,
        disable_notification_ = 0,
        from_background_ = 0,
        query_id_ = data.inline_query_id_,
        result_id_ = data.results_[0].id_
      }, dl_cb, nil)
           end
          tdcli_function({
      ID = "GetInlineQueryResults",
      bot_user_id_ = 211684723,
      chat_id_ = msg.chat_id_,
      user_location_ = {
        ID = "Location",
        latitude_ = 0,
        longitude_ = 0
      },
      query_ = text,
      offset_ = 0
    }, hidetext, nil)
       end
if matches[1] == 'رقم رسالة' then
---------------------------------
 function msgid(extra, result, success)
 tdcli.sendMessage(msg.chat_id_, msg.id_, 1,"`رقم رسالة في سيرفر تيليجرام هو :`\n\n*"..result.id_.."*", 1, 'md')
end
 if tonumber(msg.reply_to_message_id_) == 0 then
 else
 tdcli.getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),msgid)
end
end
if matches[1] == "mention" then
local text = 'Click Here To See The User...'
local id = matches[2]
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=29, user_id_=id}}}}, dl_cb, nil)
end
if matches[1] == "get" then
 local function getpro(arg,data)
local id = matches[2]
if data.photos_[0] then
 tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'> Supergroup ID: '..msg.chat_id_..'\n> /profile2_'..id..'\n> /profile3_'..id..'\n> /profile4_'..id..'\n> /profile5_'..id..'\n> See User /mention_'..id..'')
   else
  return tdcli.sendMessage(msg.to.id,  msg.id,1, 'کاربر '..id..' هیچ عکس پروفایلی ندارد \n\n برای مشاهده کاربر دستور زیر را وارد کنید \n\n /mention_'..id..'  ',1,'html')
  end
  end
  tdcli_function ({ID ="GetUserProfilePhotos", user_id_ = matches[2], offset_ = 0, limit_ = 1 }, getpro, nil)   
   end
         if matches[1] == "profile" then  
  if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 5 then
return "*Wrong Number,Range Is* [1-5]"
end  
local function getpro(arg,data)
local x = matches[2]
if data.photos_[0] then
                  tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_)
else
    tdcli.sendMessage(msg.chat_id_, 0, 1,  'کاربر عکس پروفایل '..x..' ندارد', 1, 'md')

  end
  end
   tdcli_function ({ID ="GetUserProfilePhotos", user_id_ = matches[3], offset_ = matches[2]-1, limit_ = 5 }, getpro, nil)
   end
if matches[1] == "mention_" then
            local text = 'Click Here To See The User...'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=29, user_id_=matches[2]}}}}, dl_cb, nil)
end
if matches[1] == 'edit' and msg.reply_to_message_id_ ~= 0 and is_sudo(msg) then
local text = matches[2]
tdcli.editMessageText(msg.to.id, msg.reply_to_message_id_, nil, text, 1, 'md')
end
---//////-//Edit Cap-----//+++++
if matches[1] == 'edit' and msg.reply_to_message_id_ ~= 0 and is_sudo(msg) then
local tExt = matches[2]
tdcli.editMessageCaption(msg.to.id, msg.reply_to_message_id_, nil, tExt)
end
if matches[1] == 'share' and is_sudo(msg) then
  local function c(a,b,c) 
  tdcli.sendContact(msg.chat_id_, "", 0, 1, nil, b.phone_number_, b.first_name_, (b.last_name_ or ''), 0)
 end
tdcli.getMe(c)
end
end
return { 
patterns ={  
"^(رابط)$", 
"^(music) (.*)$",
"^(hide) (.*)$",
"^(share)$",
--"^(edit) (.*)$",
--"^(edit) (.*)$",
--"^(get) (.*)$",
--"^(profile)(.*)_(.*)$",
--"^(mention_)(.*)$",
--"^(mention) (.*)$",
"^(رقم رسالة)$",
--"^(stats)$",
--"^(reset)$",
"^(تصويت) (.*)$",
"^(بحث صورة) (.*)$",
"^(صورة متحركة) (.*)$",
"^(qrcode (.*)$",
"^(fuck) (.*)$",
"^(العب)$",
"^(ارسال ملصق) (.*)$",
"^(اخفاء) (.*)$",
"^(يوتيوب) (.*)$",
"^(رابط)$", 
"^(music) (.*)$",
"^(hide) (.*)$",
"^(share)$",
--"^(edit) (.*)$",
--"^(edit) (.*)$",
--"^(get) (.*)$",
--"^(profile)(.*)_(.*)$",
--"^(mention_)(.*)$",
--"^(mention) (.*)$",
"^(رقم رسالة)$",
"^(stats)$",
--"^(reset)$",
"^(تصويت) (.*)$",
"^(بحث صورة) (.*)$",
"^(صورة متحركة) (.*)$",
"^(qrcode (.*)$",
"^(fuck) (.*)$",
"^(تجروبة)$",
"^(ارسال ملصق) (.*)$",
"^(العب)$",
"^(اخفاء) (.*)$",
"^(صوت) (.*)$",
"^(يوتيوب) (.*)$",
"^(شكل مزخرف) (.*)$",
},  
  run = CerNer
}
          