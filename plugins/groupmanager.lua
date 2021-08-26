local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '_You are not bot admin_'
else
     return '`للمطورين فقط`'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '*Group is already added ❇️*'
else
return '_المجموعة مفعلة مسبقا ❇️_'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      whitelist ={},
      settings = {
          set_name = msg.to.title,
          link = 'بالحذف',
          tag = 'غير مفعل',
          spam = 'غير مفعل',
          webpage = 'غير مفعل',
          markdown = 'غير مفعل',
          flood = 'بالتصميت',
          lock_bots = 'yes',
          lock_pin = 'no',
          welcome = 'yes',
                  forward = 'غير مفعل',
                  view = 'غير مفعل',
                  audio = 'غير مفعل',
                  video = 'غير مفعل',
                  contact = 'غير مفعل',
                  text = 'غير مفعل',
                  photos = 'غير مفعل',
                  gif = 'غير مفعل',
                  location = 'غير مفعل',
                  document = 'غير مفعل',
                  sticker = 'غير مفعل',
                  voice = 'غير مفعل',
                   chat = 'غير مفعل',
				   keyboard = 'غير مفعل',
		  num_msg_max = '10',
		  set_char = '4000',
		  time_check = '2'
          }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '*Group has been added ✅*'
else
  local text = 'تم تفعيل البوت في المجموعة ✅'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=28, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '`للمطورين فقط`'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '*Group is not added ❎*'
else
    return '_المجموعة ليست مفعلة ❎_'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '*Group has been removed ❇️*'
 else
  local text = 'تم الغاء تفعيل البوت ❎'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=22, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "_Word_ *"..word.."* _is already filtered_"
            else
         return "_الكلمة_ *"..word.."* _تم حظرها مسبقا_"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "_Word_ *"..word.."* _added to filtered words list_"
            else
         return "_الكلمة_`( "..word.." )` _تم اضافتها الى قائمة الكلمات المحظورة_"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "_Word_ *"..word.."* _removed from filtered words list_"
       elseif lang then
         return "_الكلمة_`( "..word.." )` _تم ازالتها من من قائمة الكلمات المحظورة_"
     end
      else
       if not lang then
         return "_Word_ *"..word.."* _is not filtered_"
       elseif lang then
         return "_الكلمة_`( "..word.." )`  _ليست في قائمة الكلمات المحظورة_"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "*Group is not added ❎*"
 else
    return "_المجموعة ليست مفعلة ❎_"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "_No_ *moderator* _in this group_"
else
   return "_لا يوجد ادمن في المجموعة_"
  end
end
if not lang then
   message = '*List of moderators :*\n'
else
   message = '`قائمة الادمن :`\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "*Group is not added ❎*"
else
return "المجموعة ليست مفعلة"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "_No_ *owner* _in this group_"
else
    return "`لا يوجد مدراء`"
  end
end
if not lang then
   message = '*List of owners :*\n'
else
   message = '`قائمة المدراء :`\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "*Group is not added ❎*", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_المجموعة ليست مفعلة_", 0, "md")
     end
  end
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *موجود مسبقا في القائمة البيضاء*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم اضافته الى القائمة البيضاء*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, setwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *غير موجود في القائمة البيضاء*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم ازالته من القائمة البيضاء*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, remwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "👤_ User_ "..user_name.."\n🆔 ID *"..data.id_.."*\n✅ _is already a_ *SuperList*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_👤العضو_ "..user_name.." \n🆔ايدي*"..data.id_.."* \n`✅هو مدير مسبقا`", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, '🗣 *user* ['..user_name..'] \n🆔 *ID* *['..data.id_..']* \n✅ *Is add to* `SuperList`  ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '🗣 _العضو_ ['..user_name..']\n🆔 _ الايدي _*['..data.id_..']*\n✅` تم اضافته مدير`', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is Already a* `Adminlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`هو ادمن في المجموعة مسبقا`', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Add to* `Adminlist` ', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`تم اضافته ادمن في المجموعة`', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is not a* `Superlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`ليس مدير في المجموعة`', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is delete from* `Superlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`تم حذفه مدير`', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is not a* `Adminlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`هو ليس ادمن في مجموعة`', 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is delete from* `Adminlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`تم حذفه من الاشراف`', 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_المستخدم غير موجود_", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
      end
   end
end


local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "*Group is not added ❎*", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_المجموعة ليست مفعلة_", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *موجود مسبقا في القائمة البيضاء*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم اضافته الى القائمة البيضاء*", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *غير موجود في القائمة البيضاء*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم ازالته من القائمة البيضاء*", 0, "md")
   end
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "👤_ User_ "..user_name.."\n🆔 ID *"..data.id_.."*\n✅ _is already a_ *SuperList*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_👤العضو_ "..user_name.." \n🆔ايدي*"..data.id_.."* \n`✅هو مدير مسبقا`", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, '🗣 *user* ['..user_name..'] \n🆔 *ID* *['..data.id_..']* \n✅ *Is add to* `SuperList`  ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '🗣 _العضو_ ['..user_name..']\n🆔 _ الايدي _*['..data.id_..']*\n✅` تم اضافته مدير`', 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is Already a* `Adminlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`هو ادمن في المجموعة مسبقا`', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Add to* `Adminlist` ', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`تم اضافته ادمن في المجموعة`', 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is not a* `Superlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`ليس مدير في المجموعة`', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is delete from* `Superlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`تم حذفه مدير`', 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is not a* `Adminlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`هو ليس ادمن في مجموعة`', 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is delete from* `Adminlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`تم حذفه من الاشراف`', 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "Result for [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. ""..check_markdown(data.title_).."\n"
    .. " ["..data.id_.."]"
  else
     text = "معلومات عن [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         end
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم غير موجود_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "*Group is not added ❎*", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_المجموعة ليست مفعلة_", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *موجود مسبقا في القائمة البيضاء*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم اضافته الى القائمة البيضاء*", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *غير موجود في القائمة البيضاء*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *تم ازالته من القائمة البيضاء*", 0, "md")
   end
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "👤_ User_ "..user_name.."\n🆔 ID *"..data.id_.."*\n✅ _is already a_ *SuperList*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_👤العضو_ "..user_name.." \n🆔ايدي*"..data.id_.."* \n`✅هو مدير مسبقا`", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, '🗣 *user* ['..user_name..'] \n🆔 *ID* *['..data.id_..']* \n✅ *Is add to* `SuperList`  ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '🗣 _العضو_ ['..user_name..']\n🆔 _ الايدي _*['..data.id_..']*\n✅` تم اضافته مدير`', 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is Already a* `Adminlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`هو مشرف في المجموعة مسبقا`', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Add to* `Adminlist` ', 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`تم اضافته مشرف في المجموعة`', 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is not a* `Superlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`ليس مدير في المجموعة`', 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is delete from* `Superlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`تم حذفه مدير`', 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is not a* `Adminlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`هو ليس مشرف في مجموعة`', 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, '👤 *User* ['..user_name..'] \n🆔 *ID*  *['..data.id_..'] *\n✅ *Is delete from* `Adminlist` ', 0, "md")    else return tdcli.sendMessage(arg.chat_id, "", 0, '👤 _العضو_ ['..user_name..'] \n🆔_ الايدي _*['..data.id_..']*\n✅`تم حذفه من الاشراف`', 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = 'not found'
 else
username = 'لا يوجد'
  end
end
     if not lang then
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'Info for [ '..data.id_..' ] :\nUserName : '..username..'\nName : '..data.first_name_, 1)
   else
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'معلومات عن[ '..data.id_..' ] :\n المعرف : '..username..'\n الاسم : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User not founded_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم غير موجود_", 0, "md")
    end
  end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم غير موجود_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "للمشرفين فقط"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
 return "*Bots* _Protection Is Already Enabled_"
elseif lang then
 return "_قفل دخول البوتات مفعل من قبل 🔐_"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Bots* _Protection Has Been Enabled_"
else
 return "تم تفعيل قفل دخول البوتات 🔐_"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "للمشرفين فقط"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
return "*Bots* _Protection Is Not Enabled_" 
elseif lang then
return "_قفل دخول البوتات غير مفعل 🔓_"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*Bots* _Protection Has Been Disabled_" 
else
return "_تم الغاء قفل دخول البوتات 🔓_"
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "للمشرفين فقط"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "yes" then
if not lang then
 return "*Pinned Message* _Is Already Locked_"
elseif lang then
 return "_قفل التثبيت مفعل من قبل 🔐_"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Pinned Message* _Has Been Locked_"
else
 return "_تم تفعيل قفل التثبيت 🔐_"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "للمشرفين فقط"
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "no" then
if not lang then
return "*Pinned Message* _Is Not Locked_" 
elseif lang then
return "_قفل التثبيت غير مفعل 🔓_"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "*Pinned Message* _Has Been Unlocked_" 
else
return "_تم الغاء قفل التثبيت 🔓_"
end
end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "للمشرفين فقط"
end
end

local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "yes" then
if not lang then
 return "*Join* _Is Already Locked_"
elseif lang then
 return "_قفل دخول الاعضاء مفعل من قبل 🔐_"
end
else
 data[tostring(target)]["settings"]["lock_join"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*Join* _Has Been Locked_"
else
 return "_تم قفل دخول الاعضاء 🔐_"
end
end
end

local function unlock_join(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "للمشرفين فقط"
end 
end

local lock_join = data[tostring(target)]["settings"]["lock_join"]
 if lock_join == "no" then
if not lang then
return "*Join* _Is Not Locked_" 
elseif lang then
return "_قفل دخول الاعضاء غير مفعل 🔓_"
end
else 
data[tostring(target)]["settings"]["lock_join"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "*Join* _Has Been Unlocked_" 
else
return "_تم الغاء قفل دخول الاعضاء 🔓_"
end
end
end

function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "_You're Not_ *Moderator*"
else
  return "للمشرفين فقط"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
	print('custom'..SETCHAR) 	
else 	
SETCHAR = 4000
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
	print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["link"] then			
data[tostring(target)]["settings"]["link"] = "غير مفعل"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["tag"] then			
data[tostring(target)]["settings"]["tag"] = "غير مفعل"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mention"] then			
data[tostring(target)]["settings"]["mention"] = "غير مفعل"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["arabic"] then			
data[tostring(target)]["settings"]["arabic"] = "غير مفعل"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["edit"] then			
data[tostring(target)]["settings"]["edit"] = "غير مفعل"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["spam"] then			
data[tostring(target)]["settings"]["spam"] = "disable"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["flood"] then			
data[tostring(target)]["settings"]["flood"] = "disable"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["markdown"] then			
data[tostring(target)]["settings"]["markdown"] = "غير مفعل"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["webpage"] then			
data[tostring(target)]["settings"]["webpage"] = "غير مفعل"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "no"		
 end
 end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["chat"] then			
data[tostring(target)]["settings"]["chat"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["gif"] then			
data[tostring(target)]["settings"]["gif"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["text"] then			
data[tostring(target)]["settings"]["text"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["photo"] then			
data[tostring(target)]["settings"]["photo"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["video"] then			
data[tostring(target)]["settings"]["video"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["audio"] then			
data[tostring(target)]["settings"]["audio"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["voice"] then			
data[tostring(target)]["settings"]["voice"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["sticker"] then			
data[tostring(target)]["settings"]["sticker"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["contact"] then			
data[tostring(target)]["settings"]["contact"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["forward"] then			
data[tostring(target)]["settings"]["forward"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["view"] then			
data[tostring(target)]["settings"]["view"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["location"] then			
data[tostring(target)]["settings"]["location"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["document"] then			
data[tostring(target)]["settings"]["document"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tgservice"] then			
data[tostring(target)]["settings"]["lock_tgservice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["inline"] then			
data[tostring(target)]["settings"]["inline"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["game"] then			
data[tostring(target)]["settings"]["game"] = "غير مفعل"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["keyboard"] then			
data[tostring(target)]["settings"]["keyboard"] = "غير مفعل"		
end
end
 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_join"] then			
 data[tostring(target)]["settings"]["lock_join"] = "no"		
 end
 end
 local expire_date = ''
local expi = redis:ttl('ExpireDate1:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'غير محدود'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' يوم'
else
	expire_date = day..' Days'
end
end
if not lang then

local settings = data[tostring(target)]["settings"] 
 text = "*Group Settings:*\n_Edit message :_ *"..settings.edit.."*\n_Text message :_ *"..settings.text.."*\n_Links message :_ *"..settings.link.."*\n_Tags message :_ *"..settings.tag.."*\n_Mention message :_ *"..settings.mention.."*\n_Arabic message :_ *"..settings.arabic.."*\n_Webpage message :_ *"..settings.webpage.."*\n_Markdown message :_ *"..settings.markdown.."*\n_Forward message :_ *"..settings.forward.."*\n_Sticker policy :_ *"..settings.sticker.."*\n_Video policy :_ *"..settings.video.."*\n_Audio policy :_ *"..settings.audio.."*\n_Voice policy :_ *"..settings.voice.."*\n_Photo policy :_ *"..settings.photo.."*\n_Document policy :_ *"..settings.document.."*\n_Location policy :_ *"..settings.location.."*\n_Gif policy :_ *"..settings.gif.."*\n_Chat policy :_ *"..settings.chat.."*\n_View policy :_ *"..settings.view.."*\n_Contact policy :_ *"..settings.contact.."*\n_Inline policy :_ *"..settings.inline.."*\n_Keyboard policy :_ *"..settings.keyboard.."*\n_Group welcome :_ *"..settings.welcome.."*\n_Lock Join :_ *"..settings.lock_join.."*\n_Lock pin message :_ *"..settings.lock_pin.."*\n_Lock TgService :_ *"..settings.lock_tgservice.."*\n_Bots protection :_ *"..settings.lock_bots.."*\n_Anti flood :_ *"..settings.flood.."*\n_Anti spam :_ *"..settings.spam.."*\n_Flood sensitivity :_ *"..NUM_MSG_MAX.."*\n_Character sensitivity :_ *"..SETCHAR.."*\n_Flood check time :_ *"..TIME_CHECK.."*\n*____________________*\n_Expire Date :_ *"..expire_date.."*\n*Bot channel*: @islamchanal1\n*Group Language* : *EN*\n `use /learn for learn about locks status`"
else
local settings = data[tostring(target)]["settings"] 
 text = "*اعدادات المجموعة:*\n_قفل التعديل :_ *"..settings.edit.."*\n_قفل النصوص :_ *"..settings.text.."*\n_قفل الروابط :_ *"..settings.link.."*\n_قفل المعرفات :_ *"..settings.tag.."*\n_قفل المنشن :_ *"..settings.mention.."*\n_قفل العربية :_ *"..settings.arabic.."*\n_قفل روابط المواقع :_ *"..settings.webpage.."*\n_قفل الماركداون :_ *"..settings.markdown.."*\n_قفل اعادة التوجيه :_ *"..settings.forward.."*\n_قفل الملصقات :_ *"..settings.sticker.."*\n_قفل الفيديو :_ *"..settings.video.."*\n_قفل الصوتيات :_ *"..settings.audio.."*\n_قفل التسجيلات :_ *"..settings.voice.."*\n_قفل الصور :_ *"..settings.photo.."*\n_قفل الملفات :_ *"..settings.document.."*\n_قفل مشاركة الموقع :_ *"..settings.location.."*\n_قفل صور المتحركة :_ *"..settings.gif.."*\n_قفل المجموعة :_ *"..settings.chat.."*\n_قفل جهات اتصال :_ *"..settings.contact.."*\n_قفل ازرار شفافة :_ *"..settings.inline.."*\n_قفل كيبورد :_ *"..settings.keyboard.."*\n_قفل توجيه القنوات :_ *"..settings.view.."*\n_الترحيب :_ *"..settings.welcome.."*\n_قفل دخول الاعضاء :_ *"..settings.lock_join.."*\n_قفل التثبيت :_ *"..settings.lock_pin.."*\n_قفل الاشعارات :_ *"..settings.lock_tgservice.."*\n_قفل دخول البوتات :_ *"..settings.lock_bots.."*\n_قفل التكرار :_ *"..settings.flood.."*\n_قفل السبام :_ *"..settings.spam.."*\n_حد عدد التكرار :_ *"..NUM_MSG_MAX.." رسالة*\n_حد حروف الرسائل :_ *"..SETCHAR.." حرف*\n_زمن التكرار :_ *"..TIME_CHECK.." ثانية*\n*____________________*\n_صلاحية البوت :_ *"..expire_date.."*\n*قناتنا*: @BrotherSTeam\n*لغة المجموعة* : *العربية*"
end
return text
end

---------------Lock TgService-------------------
local function lock_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "للمشرفين فقط"
end
end

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"] 
if lock_tgservice == "yes" then
if not lang then
 return "*TgService* _Is Already Locked_"
elseif lang then
 return "_قفل الاشعارات مفعل من قبل 🔐_"
end
else
 data[tostring(target)]["settings"]["lock_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "*TgService* _Has Been locked_"
else
return "_تم قفل الاشعارات 🔐_"
end
end
end

local function unlock_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "للمشرفين فقط"
end 
end

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"]
 if lock_tgservice == "no" then
if not lang then
return "*Mute TgService* _Is Already Unlocked_"
elseif lang then
return "_قفل الاشعارات غير مفعل 🔓_"
end 
else 
data[tostring(target)]["settings"]["lock_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "*TgService* _Has Been Unlocked_"
else
return "_تم الغاء قفل الاشعارات 🔓_"
end 
end
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if msg.to.type ~= 'pv' then
if ((matches[1] == "run" and not Clang) or (matches[1] == "تفعيل" and Clang)) then
return modadd(msg)
end
if ((matches[1] == "rem" and not Clang) or (matches[1] == "تعطيل" and Clang)) then
return modrem(msg)
end
if not data[tostring(msg.to.id)] then return end
if (matches[1] == "id" and not Clang) or (matches[1] == "ایدی" and Clang) then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
   if data.photos_[0] then
       if not lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'Chat ID : '..msg.to.id..'\nUser ID : '..msg.from.id,dl_cb,nil)
       elseif lang then
          tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'شناسه گروه : '..msg.to.id..'\nشناسه شما : '..msg.from.id,dl_cb,nil)
     end
   else
       if not lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "`You Have Not Profile Photo...!`\n\n> *Chat ID :* `"..msg.to.id.."`\n*User ID :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "_شما هیچ عکسی ندارید...!_\n\n> _شناسه گروه :_ `"..msg.to.id.."`\n_شناسه شما :_ `"..msg.from.id.."`", 1, 'md')
            end
        end
   end
   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)
end
if msg.reply_id and not matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="id"})
  end
if matches[2] and is_mod(msg) then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if ((matches[1] == "pin" and not Clang) or (matches[1] == "تثبيت" and Clang)) and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
local text = '📌 تم تثبيت الرسالة بنجاح ✅'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=25, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
local text = '📌 تم تثبيت الرسالة بنجاح ✅'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=25, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
end
end
end
if ((matches[1] == 'unpin' and not Clang) or (matches[1] == "الغاء التثبيت" and Clang)) and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
local text = '📌 تم الغاء تثبيت الرسالة ❎'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=26, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == 'no' then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
local text = '📌 تم الغاء تثبيت الرسالة ❎'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=26, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
end
end
end
if ((matches[1]:lower() == "whitelist" and not Clang) or (matches[1] == "القائمة البيضاء" and Clang)) and matches[2] == "+" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="setwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="setwhitelist"})
      end
   end
if ((matches[1]:lower() == "whitelist" and not Clang) or (matches[1] == "القائمة البيضاء" and Clang)) and matches[2] == "-" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="remwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="remwhitelist"})
      end
   end
if ((matches[1] == "setowner" and not Clang) or (matches[1] == 'رفع مدير' and Clang)) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if ((matches[1] == "remowner" and not Clang) or (matches[1] == "حذف مدير" and Clang)) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if ((matches[1] == "promote" and not Clang) or (matches[1] == "رفع ادمن" and Clang)) and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if ((matches[1] == "demote" and not Clang) or (matches[1] == "حذف ادمن" and Clang)) and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end

---------------------Links Settings------------------
if ((matches[1] == "link" and not Clang) or (matches[1] == "قفل الروابط" and Clang)) and is_mod(msg) then
local link = data[tostring(msg.to.id)]["settings"]["link"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["link"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Link messages.*\n_Users will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل الروابط` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["link"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Link messages.*\n*Link messages* _will be_ *delete*"
    else
    return "`🔐 تم قفل الروابط` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["link"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Link messages.*\n_Users will now be_ *removed* _automatically for_ *Link posting*"
    else
    return "`🔐 تم قفل الروابط` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["link"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Link messages.*\n_Users will now be_ *banned* _automatically for_ *Link posting*"
    else
    return "`🔐 تم قفل الروابط` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if link == "غير مفعل" then
   if not lang then
    return "*Link posting* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل الروابط غير مفعل_"
   end
end
  local offender = 'link_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["link"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group now allow_ *Link messages.*"
    else
    return "_🔓 تم الغاء قفل الروابط_"
       end
   end
end

---------------------Tag Settings------------------
if ((matches[1] == "tag" and not Clang) or (matches[1] == "قفل المعرفات" and Clang)) and is_mod(msg) then
local tags = data[tostring(msg.to.id)]["settings"]["tag"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["tag"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Tags messages.*\n_Users will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل المعرفات` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["tag"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Tags messages.*\n*Tags messages* _will be_ *delete*"
    else
    return "`🔐 تم قفل المعرفات` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["tag"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Tags messages.*\n_Users will now be_ *removed* _automatically for_ *Tags posting*"
    else
    return "`🔐 تم قفل المعرفات` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["tag"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Tags messages.*\n_Users will now be_ *banned* _automatically for_ *Tags posting*"
    else
    return "`🔐 تم قفل المعرفات` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if tags == "غير مفعل" then
   if not lang then
    return "*Tags posting* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل المعرفات غير مفعل_"
   end
end
  local offender = 'tag_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["tag"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group now allow_ *Tags messages.*"
    else
    return "_🔓 تم الغاء قفل المعرفات_"
       end
   end
end

---------------------Text Settings------------------
if ((matches[1] == "text" and not Clang) or (matches[1] == "قفل النصوص" and Clang)) and is_mod(msg) then
local text = data[tostring(msg.to.id)]["settings"]["text"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["text"] = "warn"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Text messages.*\n_Users will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل النصوص` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["text"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Text messages.*\n*Text messages* _will be_ *delete*"
    else
    return "`🔐 تم قفل النصوص` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["text"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Text messages.*\n_Users will now be_ *removed* _automatically for_ *Text message*"
    else
    return "`🔐 تم قفل النصوص` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["text"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Text messages.*\n_Users will now be_ *banned* _automatically for_ *Text message*"
    else
    return "`🔐 تم قفل النصوص` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if text == "غير مفعل" then
   if not lang then
    return "*Text message* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل النصوص غير مفعل_"
   end
end
  local offender = 'text_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["text"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group now allow_ *Text messages.*"
    else
    return "_🔓 تم الغاء قفل النصوص_"
       end
   end
end

---------------------Chat Settings------------------
if ((matches[1] == "chat" and not Clang) or (matches[1] == "قفل المجموعة" and Clang)) and is_mod(msg) then
local chats = data[tostring(msg.to.id)]["settings"]["chat"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["chat"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Chatting.*\n_Users will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل المجموعة` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["chat"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Chatting.*\n*All messages* _will be_ *delete*"
    else
    return "`🔐 تم قفل المجموعة` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["chat"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Chatting.*\n_Users will now be_ *removed* _automatically for_ *Chatting*"
    else
    return "`🔐 تم قفل المجموعة` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["chat"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Chatting.*\n_Users will now be_ *banned* _automatically for_ *Chatting*"
    else
    return "`🔐 تم قفل المجموعة` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if chats == "غير مفعل" then
   if not lang then
    return "*Chat* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل المجموعة غير مفعل_"
   end
end
  local offender = 'chat_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["chat"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group now allow_ *Chatting.*"
    else
    return "_🔓 تم الغاء قفل المجموعة_"
       end
   end
end

---------------------Arabic Settings------------------
if ((matches[1] == "arabic" and not Clang) or (matches[1] == "قفل العربية" and Clang)) and is_mod(msg) then
local arabic = data[tostring(msg.to.id)]["settings"]["arabic"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Arabic messages.*\n_Users will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل العربية` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Arabic messages.*\n*Arabic messages* _will be_ *delete*"
    else
    return "`🔐 تم قفل العربية` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Arabic messages.*\n_Users will now be_ *removed* _automatically for_ *Arabic message*"
    else
    return "`🔐 تم قفل العربية` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Arabic messages.*\n_Users will now be_ *banned* _automatically for_ *Arabic message*"
    else
    return "`🔐 تم قفل العربية` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if arabic == "غير مفعل" then
   if not lang then
    return "*Arabic message* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل العربية غير مفعل_"
   end
end
  local offender = 'arabic_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["arabic"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group now allow_ *Arabic messages.*"
    else
    return "_🔓 تم الغاء قفل العربية_"
       end
   end
end

---------------------Edit Settings------------------
if ((matches[1] == "edit" and not Clang) or (matches[1] == "قفل التعديل" and Clang)) and is_mod(msg) then
local edit = data[tostring(msg.to.id)]["settings"]["edit"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["edit"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Edit messages.*\n_Users will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل التعديل` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["edit"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Edited messages.*\n*Edited messages* _will be_ *delete*"
    else
    return "`🔐 تم قفل التعديل` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["edit"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Edit messages.*\n_Users will now be_ *removed* _automatically for_ *Edit message*"
    else
    return "`🔐 تم قفل التعديل` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["edit"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Edit messages.*\n_Users will now be_ *banned* _automatically for_ *Edit message*"
    else
    return "`🔐 تم قفل التعديل` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if edit == "غير مفعل" then
   if not lang then
    return "*Edit message* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل التعديل غير مفعل_"
   end
end
  local offender = 'edit_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["edit"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group now allow_ *Edit messages.*"
    else
    return "_🔓 تم الغاء قفل التعديل_"
       end
   end
end

---------------------MarkDown Settings------------------
if ((matches[1] == "markdown" and not Clang) or (matches[1] == "قفل الماركداون" and Clang)) and is_mod(msg) then
local markdown = data[tostring(msg.to.id)]["settings"]["markdown"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Markdown messages.*\n_Users will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل الماركداون` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Markdown messages.*\n*Markdown messages* _will be_ *delete*"
    else
    return "`🔐 تم قفل الماركداون` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Markdown messages.*\n_Users will now be_ *removed* _automatically for_ *Markdown message*"
    else
    return "`🔐 تم قفل الماركداون` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Markdown messages.*\n_Users will now be_ *banned* _automatically for_ *Markdown message*"
    else
    return "`🔐 تم قفل الماركداون` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if markdown == "غير مفعل" then
   if not lang then
    return "*Markdown message* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل الماركداون غير مفعل_"
   end
end
  local offender = 'markdown_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["markdown"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group now allow_ *Markdown messages.*"
    else
    return "_🔓 تم الغاء قفل الماركداون_"
       end
   end
end

---------------------Mention Settings------------------
if ((matches[1] == "mention" and not Clang) or (matches[1] == "قفل المنشن" and Clang)) and is_mod(msg) then
local mention = data[tostring(msg.to.id)]["settings"]["mention"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["mention"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *mention messages.*\n_Users will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل المنشن` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["mention"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *mention messages.*\n*Mention messages* _will be_ *delete*"
    else
    return "`🔐 تم قفل المنشن` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["mention"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *mention messages.*\n_Users will now be_ *removed* _automatically for_ *Mention message*"
    else
    return "`🔐 تم قفل المنشن` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["mention"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *mention messages.*\n_Users will now be_ *banned* _automatically for_ *Mention message*"
    else
    return "`🔐 تم قفل المنشن` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if mention == "غير مفعل" then
   if not lang then
    return "*mention message* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل المنشن غير مفعل_"
   end
end
  local offender = 'mention_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["mention"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group now allow_ *mention messages.*"
    else
    return "_🔓 تم الغاء قفل المنشن_"
       end
   end
end

---------------------Flood Settings------------------
if ((matches[1] == "antiflood" and not Clang) or (matches[1] == "قفل التكرار" and Clang)) and is_mod(msg) then
local flood = data[tostring(msg.to.id)]["settings"]["flood"] 
if ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["flood"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Anti flood* _protection already_ *enabled*.\n_Offender will be_ *kicked*"
    else
    return "`🔐 تم قفل التكرار` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["flood"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Anti flood* _protection already_ *enabled*.\n_Offender will be_ *banned*"
    else
    return "`🔐 تم قفل التكرار` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "disable" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if flood == "disable" then
   if not lang then
    return "*Anti flood* _protection is not_ *enabled.*"
    else
    return "_🔓 قفل التكرار غير مفعل_"
   end
end
data[tostring(msg.to.id)]["settings"]["flood"] = "disable"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Anti flood* _protection has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل التكرار_"
       end
   end
end

---------------------Spam Settings------------------
if ((matches[1] == "antispam" and not Clang) or (matches[1] == "قفل السبام" and Clang)) and is_mod(msg) then
local spam = data[tostring(msg.to.id)]["settings"]["spam"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["spam"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Anti Spam* _protection already_ *enabled*.\n_Offender will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل السبام` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["spam"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
     return "*Anti spam* _protection already_ *enabled*.\n_Spam messages will be_ *delete*"
    else
    return "`🔐 تم قفل السبام` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["spam"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Anti spam* _protection already_ *enabled*.\n_Offender will be_ *banned*"
    else
    return "`🔐 تم قفل السبام` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["spam"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
     return "*Anti spam* _protection already_ *enabled*.\n_Offender will be_ *banned*"
    else
    return "`🔐 تم قفل السبام` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "disable" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if spam == "disable" then
   if not lang then
    return "*Anti spam* _protection is not_ *enabled.*"
    else
    return "_🔓 قفل السبام غير مفعل_"
   end
end
  local offender = 'spam_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["spam"] = "disable"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Anti spam* _protection has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل السبام_"
       end
   end
end

---------------------Webpage Settings------------------
if ((matches[1] == "webpage" and not Clang) or (matches[1] == "قفل روابط المواقع" and Clang)) and is_mod(msg) then
local webpage = data[tostring(msg.to.id)]["settings"]["webpage"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *webpage messages.*\n_Users will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل روابط المواقع` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Webpage messages.*\n*Webpage messages* _will be_ *delete*"
    else
    return "`🔐 تم قفل روابط المواقع` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *Webpage messages.*\n_Users will now be_ *removed* _automatically for_ *Webpage message*"
    else
    return "`🔐 تم قفل روابط المواقع` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *webpage messages.*\n_Users will now be_ *banned* _automatically for_ *Webpage message*"
    else
    return "`🔐 تم قفل روابط المواقع` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if webpage == "غير مفعل" then
   if not lang then
    return "*webpage message* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل روابط المواقع غير مفعل_"
   end
end
  local offender = 'webpage_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["webpage"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group now allow_ *webpage messages.*"
    else
    return "_🔓 تم الغاء قفل روابط المواقع_"
       end
   end
end

---------------------Forward Settings------------------
if ((matches[1] == "forward" and not Clang) or (matches[1] == "قفل اعادة التوجيه" and Clang)) and is_mod(msg) then
local forward = data[tostring(msg.to.id)]["settings"]["forward"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["forward"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *forward messages.*\n_Users will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل اعادة التوجيه` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["forward"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *forward messages.*\n*Forward messages* _will be_ *delete*"
    else
    return "`🔐 تم قفل اعادة التوجيه` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["forward"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *forward messages.*\n_Users will now be_ *removed* _automatically for_ *Forward message*"
    else
    return "`🔐 تم قفل اعادة التوجيه` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["forward"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *forward messages.*\n_Users will now be_ *banned* _automatically for_ *Forward message*"
    else
    return "`🔐 تم قفل اعادة توجيه` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if forward == "غير مفعل" then
   if not lang then
    return "*forward message* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل اعادة التوجيه غير مفعل_"
   end
end
  local offender = 'forward_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["forward"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group now allow_ *forward messages.*"
    else
    return "_🔓 تم الغاء قفل اعادة التوجيه_"
       end
   end
end

---------------------View Settings------------------
if ((matches[1] == "view" and not Clang) or (matches[1] == "قفل توجيه القنوات" and Clang)) and is_mod(msg) then
local view = data[tostring(msg.to.id)]["settings"]["view"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["view"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *forward from channel.*\n_Users will be_ *warned* _first, then_ *kicked* _for second infringements_"
    else
    return "`🔐 تم قفل توجيه القنوات` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["view"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *forward from channel.*\n*forwarded messages from channel* _will be_ *delete*"
    else
    return "`🔐 تم قفل توجيه القنوات` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["view"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *forward from channel.*\n_Users will now be_ *removed* _automatically for_ *Forward from channel*"
    else
    return "`🔐 تم قفل توجيه القنوات` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["view"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group does not allow_ *forward from channel.*\n_Users will now be_ *banned* _automatically for_ *Forward from channel*"
    else
    return "`🔐 تم قفل توجيه القنوات` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if view == "غير مفعل" then
   if not lang then
    return "*forward from channel* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل توجيه القنوات غير مفعل_"
   end
end
  local offender = 'view_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["view"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "_This group now allow_ *forward from channel.*"
    else
    return "_🔓 تم الغاء قفل توجيه القنوات_"
       end
   end
end

---------------------Sticker Settings------------------
if ((matches[1] == "sticker" and not Clang) or (matches[1] == "قفل الملصقات" and Clang)) and is_mod(msg) then
local sticker = data[tostring(msg.to.id)]["settings"]["sticker"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Stickers* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل الملصقات` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Stickers* _already_ *prohibited.*\n*Stickers* _will be_ *delete*"
    else
    return "`🔐 تم قفل الملصقات` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Stickers* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل الملصقات` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Stickers* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل الملصقات` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if sticker == "غير مفعل" then
   if not lang then
    return "*Stickers* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل الملصقات غير مفعل_"
   end
end
  local offender = 'sticker_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["sticker"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Stickers* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل الملصقات_"
       end
   end
end

---------------------Photo Settings------------------
if ((matches[1] == "photo" and not Clang) or (matches[1] == "قفل الصور" and Clang)) and is_mod(msg) then
local photo = data[tostring(msg.to.id)]["settings"]["photo"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["photo"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Photo* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل الصور` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["photo"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Photo* _already_ *prohibited.*\n*Photo* _will be_ *delete*"
    else
    return "`🔐 تم قفل الصور` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["photo"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Photo* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل الصور` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["photo"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Photo* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل الصور` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if photo == "غير مفعل" then
   if not lang then
    return "*Photo* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل الصور غير مفعل_"
   end
end
  local offender = 'photo_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["photo"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Photo* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل الصور_"
       end
   end
end

---------------------Video Settings------------------
if ((matches[1] == "video" and not Clang) or (matches[1] == "قفل الفيديو" and Clang)) and is_mod(msg) then
local video = data[tostring(msg.to.id)]["settings"]["video"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["video"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Video* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل الفيديو` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["video"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Video* _already_ *prohibited.*\n*Photo* _will be_ *delete*"
    else
    return "`🔐 تم قفل الفيديو` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["video"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Video* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل الفيديو` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["video"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Video* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل الفيديو` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if video == "غير مفعل" then
   if not lang then
    return "*Video* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل الفيديو غير مفعل_"
   end
end
  local offender = 'video_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["video"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Video* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل الفيديو_"
       end
   end
end

---------------------Gif Settings------------------
if ((matches[1] == "gif" and not Clang) or (matches[1] == "قفل صور المتحركة" and Clang)) and is_mod(msg) then
local gif = data[tostring(msg.to.id)]["settings"]["gif"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["gif"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Gif* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل صور المتحركة` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["gif"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Gif* _already_ *prohibited.*\n*Gif* _will be_ *delete*"
    else
    return "`🔐 تم قفل صور المتحركة` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["gif"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Gif* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل صور المتحركة` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["gif"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Gif* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل صور المتحركة` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if gif == "غير مفعل" then
   if not lang then
    return "*Gif* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل صور المتحركة غير مفعل_"
   end
end
  local offender = 'gif_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["gif"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Gif* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل صور المتحركة_"
       end
   end
end

---------------------Keyboard Settings------------------
if ((matches[1] == "keyboard" and not Clang) or (matches[1] == "قفل كيبورد" and Clang)) and is_mod(msg) then
local keyboard = data[tostring(msg.to.id)]["settings"]["keyboard"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Keyboard* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل كيبورد` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Keyboard* _already_ *prohibited.*\n*Keyboard* _will be_ *delete*"
    else
    return "`🔐 تم قفل كيبورد` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Keyboard* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل كيبورد` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Keyboard* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل كيبورد` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if keyboard == "غير مفعل" then
   if not lang then
    return "*Keyboard* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل كيبورد غير مفعل_"
   end
end
  local offender = 'keyboard_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["keyboard"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Keyboard* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل كيبورد_"
       end
   end
end

---------------------Document Settings------------------
if ((matches[1] == "document" and not Clang) or (matches[1] == "قفل الملفات" and Clang)) and is_mod(msg) then
local document = data[tostring(msg.to.id)]["settings"]["document"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["document"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Document* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل الملفات` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["document"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Document* _already_ *prohibited.*\n*Photo* _will be_ *delete*"
    else
    return "`🔐 تم قفل الملفات` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["document"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Document* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل الملفات` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["document"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Document* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل الملفات` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if document == "غير مفعل" then
   if not lang then
    return "*Document* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل الملفات غير مفعل_"
   end
end
  local offender = 'document_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["document"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Document* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل الملفات_"
       end
   end
end

---------------------Location Settings------------------
if ((matches[1] == "location" and not Clang) or (matches[1] == "قفل مشاركة الموقع" and Clang)) and is_mod(msg) then
local location = data[tostring(msg.to.id)]["settings"]["location"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["location"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Location* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل مشاركة الموقع` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["location"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Location* _already_ *prohibited.*\n*Location* _will be_ *delete*"
    else
    return "`🔐 تم قفل مشاركة الموقع` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["location"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Location* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل مشاركة الموقع` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["location"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Location* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل مشاركة الموقع` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if location == "غير مفعل" then
   if not lang then
    return "*Location* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل مشاركة الموقع غير مفعل_"
   end
end
  local offender = 'location_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["location"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Location* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل مشاركة الموقع_"
       end
   end
end

---------------------Contact Settings------------------
if ((matches[1] == "contact" and not Clang) or (matches[1] == "قفل جهات اتصال" and Clang)) and is_mod(msg) then
local contact = data[tostring(msg.to.id)]["settings"]["contact"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["contact"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Contact* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل جهات اتصال` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["contact"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Contact* _already_ *prohibited.*\n*Contact* _will be_ *delete*"
    else
    return "`🔐 تم قفل جهات اتصال` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["contact"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Contact* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل جهات اتصال` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["contact"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Contact* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل جهات اتصال` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if contact == "غير مفعل" then
   if not lang then
    return "*Contact* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل جهات اتصال غير مفعل_"
   end
end
  local offender = 'contact_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["contact"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Contact* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل جهات اتصال_"
       end
   end
end

---------------------Audio Settings------------------
if ((matches[1] == "audio" and not Clang) or (matches[1] == "قفل الصوتيات" and Clang)) and is_mod(msg) then
local audio = data[tostring(msg.to.id)]["settings"]["audio"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["audio"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Audio* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل الصوتيات` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["audio"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Audio* _already_ *prohibited.*\n*Audio* _will be_ *delete*"
    else
    return "`🔐 تم قفل الصوتيات` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["audio"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Audio* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل الصوتيات` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["audio"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Audio* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل الصوتيات` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if audio == "غير مفعل" then
   if not lang then
    return "*Audio* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل الصوتيات غير مفعل_"
   end
end
  local offender = 'audio_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["audio"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Audio* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل الصوتيات_"
       end
   end
end

---------------------Game Settings------------------
if ((matches[1] == "game" and not Clang) or (matches[1] == "قفل الالعاب" and Clang)) and is_mod(msg) then
local game = data[tostring(msg.to.id)]["settings"]["game"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["game"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Game* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل الالعاب` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["game"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Game* _already_ *prohibited.*\n*Game* _will be_ *delete*"
    else
    return "`🔐 تم قفل الالعاب` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["game"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Game* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل الالعاب` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["game"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Game* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل الالعاب` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if game == "غير مفعل" then
   if not lang then
    return "*Game* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل الالعاب غير مفعل_"
   end
end
  local offender = 'game_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["game"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Game* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل الالعاب_"
       end
   end
end

---------------------Inline Settings------------------
if ((matches[1] == "inline" and not Clang) or (matches[1] == "قفل ازرار شفافة" and Clang)) and is_mod(msg) then
local inline = data[tostring(msg.to.id)]["settings"]["inline"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["inline"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Inline* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل ازرار شفافة` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["inline"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Inline* _already_ *prohibited.*\n*Inline* _will be_ *delete*"
    else
    return "`🔐 تم قفل ازرار شفافة` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["inline"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Inline* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل ازرار شفافة` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["inline"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Inline* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل ازرار شفافة` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if inline == "غير مفعل" then
   if not lang then
    return "*Inline* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل ازرار شفافة غير مفعل_"
   end
end
  local offender = 'inline_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["inline"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Inline* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل ازرار شفافة_"
       end
   end
end

---------------------Voice Settings------------------
if ((matches[1] == "voice" and not Clang) or (matches[1] == "قفل التسجيلات" and Clang)) and is_mod(msg) then
local voice = data[tostring(msg.to.id)]["settings"]["voice"] 
if ((matches[2] == "warn" and not Clang) or (matches[2] == "بالتحذير" and Clang)) then
data[tostring(msg.to.id)]["settings"]["voice"] = "بالتحذير"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Voice* _already_ *prohibited*.\n_Sender will be_ *warned* _first, then_ *kicked* _for second violation._"
    else
    return "`🔐 تم قفل التسجيلات` _⚠️ بالتحذير ⚠️_"
   end
elseif ((matches[2] == "del" and not Clang) or (matches[2] == "بالحذف" and Clang)) then
data[tostring(msg.to.id)]["settings"]["voice"] = "بالحذف"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Voice* _already_ *prohibited.*\n*Voice* _will be_ *delete*"
    else
    return "`🔐 تم قفل التسجيلات` _🗑 بالحذف 🗑_"
   end
elseif ((matches[2] == "kick" and not Clang) or (matches[2] == "بالطرد" and Clang)) then
data[tostring(msg.to.id)]["settings"]["voice"] = "بالطرد"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Voice* _already_ *prohibited.*\n_Sender will be_ *kicked*"
    else
    return "`🔐 تم قفل التسجيلات` _⛔️ بالطرد ⛔️_"
   end
elseif ((matches[2] == "ban" and not Clang) or (matches[2] == "بالتصميت" and Clang)) then
data[tostring(msg.to.id)]["settings"]["voice"] = "بالتصميت"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Voice* _already_ *prohibited.*\n_Sender will be_ *banned*"
    else
    return "`🔐 تم قفل التسجيلات` _🔇 بالتصميت 🔇_"
   end
elseif ((matches[2] == "ok" and not Clang) or (matches[2] == "تعطيل" and Clang)) then
  if voice == "غير مفعل" then
   if not lang then
    return "*Voice* _restriction is not_ *enabled.*"
    else
    return "_🔓 قفل التسجيلات غير مفعل_"
   end
end
  local offender = 'voice_offender:'..msg.to.id
   redis:del(offender)
data[tostring(msg.to.id)]["settings"]["voice"] = "غير مفعل"
 save_data(_config.moderation.data, data)
   if not lang then
    return "*Voice* _restriction has been_ *disabled.*"
    else
    return "_🔓 تم الغاء قفل التسجيلات_"
       end
   end
end

if ((matches[1] == "lock" and not Clang) or (matches[1] == "قفل" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "bots" and not Clang) or (matches[2] == "دخول البوتات" and Clang)) then
return lock_bots(msg, data, target)
end
if ((matches[2] == "pin" and not Clang) or (matches[2] == "التثبيت" and Clang)) and is_owner(msg) then
return lock_pin(msg, data, target)
end
if ((matches[2] == "join" and not Clang) or (matches[2] == "دخول الاعضاء" and Clang)) then
return lock_join(msg, data, target)
end
if ((matches[2] == "tgservice" and not Clang) or (matches[2] == "قفل الاشعارات" and Clang)) then
return lock_tgservice(msg ,data, target)
end
end

if ((matches[1] == "unlock" and not Clang) or (matches[1] == "فتح" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "bots" and not Clang) or (matches[2] == "دخول البوتات" and Clang)) then
return unlock_bots(msg, data, target)
end
if ((matches[2] == "pin" and not Clang) or (matches[2] == "التثبيت" and Clang)) and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if ((matches[2] == "join" and not Clang) or (matches[2] == "دخول الاعضاء" and Clang)) then
return unlock_join(msg, data, target)
end
if ((matches[2] == "tgservice" and not Clang) or (matches[2] == "الاشعارات" and Clang)) then
return unlock_tgservice(msg ,data, target)
end
end

if (matches[1]:lower() == "gpinfo" or matches[1] == 'معلومات المجموعة') and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
if not lang then
ginfo = "*Group Info :*\n_Admin Count :_ *"..data.administrator_count_.."*\n_Member Count :_ *"..data.member_count_.."*\n_Kicked Count :_ *"..data.kicked_count_.."*\n_Group ID :_ *"..data.channel_.id_.."*"
elseif lang then
ginfo = "*معلومات المجموعة :*\n_المشرفين:_ *"..data.administrator_count_.."*\n_الاعضاء :_ *"..data.member_count_.."*\n_المطرودين :_ *"..data.kicked_count_.."*\n_ايدي المجموعة :_ *"..data.channel_.id_.."*"
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if (matches[1]:lower() == 'newlink' or matches[1] == 'رابط جديد') and is_mod(msg) and not matches[2] then
	local function callback_link (arg, data)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bot is not group creator_\n_set a link for group with using_ /setlink", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_البوت ليس منشئ المجموعة_\n_قم بحفظ الرابط بأمر_ /setlink", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Newlink Created*", 1, 'md')
        elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_تم انشاء رابط_", 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if (matches[1]:lower() == 'newlink' or matches[1] == 'رابط جديد') and is_mod(msg) and (matches[2] == 'pv' or matches[2] == 'خاص') then
	local function callback_link (arg, data)
		local result = data.invite_link_
		local administration = load_data(_config.moderation.data) 
				if not result then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bot is not group creator_\n_set a link for group with using_ /setlink", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_البوت ليس منشئ المجموعة_\n_قم بحفظ الرابط بأمر_ /setlink", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = result
					save_data(_config.moderation.data, administration)
        if not lang then
		tdcli.sendMessage(user, msg.id, 1, "*Newlink Group* _:_ `"..msg.to.id.."`\n"..result, 1, 'md')
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*New link Was Send In Your Private Message*", 1, 'md')
        elseif lang then
		tdcli.sendMessage(user, msg.id, 1, "*رابط المجموعة :* _:_ `"..msg.to.id.."`\n"..result, 1, 'md')
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_لقد قمت بإرسال الرابط على الخاص_", 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if (matches[1]:lower() == 'setlink' or matches[1] == 'تعيين رابط') and is_owner(msg) then
		if not matches[2] then
		data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
			if not lang then
			return '_Please send the new group_ *link* _now_'
    else 
         return '_ارسل رابط المجموعة الان_'
       end
	   end
		 data[tostring(chat)]['settings']['linkgp'] = matches[2]
			 save_data(_config.moderation.data, data)
      if not lang then
			return '_Group Link Was Saved Successfully._'
    else 
         return '_تم حفظ رابط المجموعة_'
       end
		end
		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "*Newlink* _has been set_"
           else
           return "_تم تعيين الرابط الجديد_"
		 	end
       end
		end
    if (matches[1]:lower() == 'link' or matches[1] == 'الراب82838ط') and is_mod(msg) and not matches[2] then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "_اولا قم بصنع رابط بإستخدام_ /newlink\n_اذا لم البوت منشئ المجموعة استخدم الامر_ /setlink"
      end
      end
     if not lang then
       text = "<b>Group Link :</b>\n"..linkgp
     else
      text = "<b>رابط المجموعة :</b>\n"..linkgp
         end
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
     if ((matches[1] == "hlink" and not Clang) or (matches[1] == "الرابط" and Clang)) and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "_اولا قم بصنع رابط بإستخدام_ /newlink\n_اذا لم البوت منشئ المجموعة استخدم الامر_ /setlink"
      end
      end
    if not lang then
    texth = "Tab Here For Join To ➣"
        elseif lang then
    texth = "📎 اضغط هنا للنسخ رابط المجموعة "
    end
local function inline_link_cb(TM, BD)
      if BD.results_ and BD.results_[0] then
tdcli.sendInlineQueryResultMessage(msg.to.id, 0, 0, 1, BD.inline_query_id_, BD.results_[0].id_, dl_cb, nil)
    else
     if not lang then
       text = "<b>Bold is offline</b>\n\n<b>Group Link :</b>\n"..linkgp
     else
      text = "رابط المجموعة :\n\n"..linkgp
         end
  return tdcli.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
   end
end
tdcli.getInlineQueryResults(107705060, msg.to.id, 0, 0, "["..texth.." "..msg.to.title.."]("..linkgp..")", 0, inline_link_cb, nil)
end
     
     
    if (matches[1]:lower() == 'link' or matches[1] == 'الرابط') and (matches[2] == 'pv' or matches[2] == 'خاص') then
	if is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "_اولا قم بصنع رابط بإستخدام_ /newlink\n_اذا لم البوت منشئ المجموعة استخدم الامر_ /setlink"
      end
      end
     if not lang then
	 tdcli.sendMessage(chat, msg.id, 1, "<b>link Was Send In Your Private Message</b>", 1, 'html')
     tdcli.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
     else
	 tdcli.sendMessage(chat, msg.id, 1, "<b>تم ارسال الرابط في الخاص</b>", 1, 'html')
      tdcli.sendMessage(user, "", 1, "<b>رابط المجموعة "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
         end
     end
	 end
  if (matches[1]:lower() == "setrules" or matches[1] == 'تعيين قوانين') and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "*Group rules* _has been set_"
   else 
  return "تم تعيين القوانين"
   end
  end
  if matches[1]:lower() == "قوانين" or matches[1] == 'rules' then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "*ℹ️ Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.*\n@islamchanal1"
    elseif lang then
      rules = "_ℹ️ القوانين :\n1⃣ ممنوع الاعلانات \n2⃣ ممنوع السبام. \n3⃣ تبلیغ ممنوع.\n4⃣ ممنوع الملصقات.\n5⃣ ممنوع الصور المتحركة.\n➡️ اي عضو يخالف القوانين يستم حظره._\n@islamchanal1"
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if ((matches[1] == "res" and not Clang) or (matches[1] == "من هو" and Clang)) and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if ((matches[1] == "whois" and not Clang) or (matches[1] == "العضو" and Clang)) and matches[2] and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
		if ((matches[1]:lower() == 'setchar' and not Clang) or (matches[1] == "الحد الاقصى للحروف" and Clang)) then
			if not is_mod(msg) then
				return
			end
			local chars_max = matches[2]
			data[tostring(msg.to.id)]['settings']['set_char'] = chars_max
			save_data(_config.moderation.data, data)
    if not lang then
     return "*Character sensitivity* _has been set to :_ *[ "..matches[2].." ]*"
   else
     return "`تم تحديد عدد رسائل الحروف هو :` *[ "..matches[2].." ]* `حرف`"
		end
  end
  if ((matches[1]:lower() == 'setflood' and not Clang) or (matches[1] == "تحديد التكرار" and Clang)) and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "_يمكنك اخيار فقط بين_ *[2-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "_Group_ *flood* _sensitivity has been set to :_ *[ "..matches[2].." ]*"
    else
    return '`تم تحديد عدد رسائل التكرار الى` *'..tonumber(matches[2])..'* `رسالة`'
    end
       end
  if ((matches[1]:lower() == 'setfloodtime' and not Clang) or (matches[1] == "تحديد وقت التكرار" and Clang)) and is_mod(msg) then
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then
				return "_يمكنك اختيار فقط بين_ *[2-10]*"
      end
			local time_max = matches[2]
			data[tostring(chat)]['settings']['time_check'] = time_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "_Group_ *flood* _check time has been set to :_ *[ "..matches[2].." ]*"
    else
    return "`تم تحديد زمن تكرار الرسائل هو  :` *[ "..matches[2].." ]* `ثواني`"
    end
       end
		if ((matches[1]:lower() == 'clean' and not Clang) or (matches[1] == "تنظيف" and Clang)) and is_owner(msg) then
			if ((matches[2] == 'mods' and not Clang) or (matches[2] == "الادمن" and Clang)) then
				if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
					return "_No_ *moderators* _in this group_"
             else
                return "`قائمة الادمن فارغة`"
				end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "_All_ *moderators* _has been demoted_"
          else
            return "`تم تنظيف قائمة الادمن`"
			end
         end
			if ((matches[2] == 'filterlist' and not Clang) or (matches[2] == "قائمة فلتر" and Clang)) then
				if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
					return "*Filtered words list* _is empty_"
         else
					return "_قائمة الكلمات المحظورة فارغة_"
             end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
       if not lang then
				return "*Filtered words list* _has been cleaned_"
           else
				return "_تم تنظيف قائمة الكلمات محظورة_"
           end
			end
			if ((matches[2] == 'rules' and not Clang) or (matches[2] == "القوانين" and Clang)) then
				if not data[tostring(chat)]['rules'] then
            if not lang then
					return "_No_ *rules* _available_"
             else
               return "`لا توجد قوانين حاليا`"
             end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*Group rules* _has been cleaned_"
          else
            return "`تم تنظيف القوانين`"
			end
       end
			if ((matches[2] == 'welcome' and not Clang) or (matches[2] == "ترحيب" and Clang)) then
				if not data[tostring(chat)]['setwelcome'] then
            if not lang then
					return "*Welcome Message not set*"
             else
               return "`لا توجد رسالة ترحيب مخصصة مسبقا`"
             end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*Welcome message* _has been cleaned_"
          else
            return "`تم حذف رسالة الترحيب وتعيين التلقائية`"
			end
       end
			if ((matches[2] == 'about' and not Clang) or (matches[2] == "وصف" and Clang)) then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
            if not lang then
					return "_No_ *description* _available_"
            else
              return "لا يوجد وصف للمجموعة"
          end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
             if not lang then
				return "*Group description* _has been cleaned_"
           else
              return "تم تنظيف وصف المجموعة"
             end
		   	end
        end
		if ((matches[1]:lower() == 'clean' and not Clang) or (matches[1] == "تنظيف" and Clang)) and is_admin(msg) then
			if ((matches[2] == 'owners' and not Clang) or (matches[2] == "المدراء" and Clang)) then
				if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
					return "_No_ *owners* _in this group_"
            else
                return "`لا يوجد مدراء في المجموعة`"
            end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "_All_ *owners* _has been demoted_"
           else
            return "`تم تنظيف قائمة المدراء`"
          end
			end
     end
if ((matches[1] == "setname" and not Clang) or (matches[1] == "تعيين اسم" and Clang)) and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if ((matches[1] == "setabout" and not Clang) or (matches[1] == "تعيين وصف" and Clang)) and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Group description* _has been set_"
    else
     return "`تم وضع ترحيب للمجموعة`"
      end
  end
  if ((matches[1] == "about" and not Clang) or (matches[1] == "الوصف" and Clang)) and msg.to.type == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "_No_ *description* _available_"
      elseif lang then
      about = "`لا يوجد وصف للمجموعة`"
       end
        else
     about = "*Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if ((matches[1] == 'filter' and not Clang) or (matches[1] == "فلتر" and Clang)) and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if ((matches[1] == 'unfilter' and not Clang) or (matches[1] == "حذف فلتر" and Clang)) and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if ((matches[1] == 'filterlist' and not Clang) or (matches[1] == "قائمة فلتر" and Clang)) and is_mod(msg) then
    return filter_list(msg)
  end
if ((matches[1] == "settings" and not Clang) or (matches[1] == "الاعدادات" and Clang)) then
return group_settings(msg, target)
end
if ((matches[1] == "mutelist" and not Clang) or (matches[1] == "اعدادات قفل" and Clang)) then
return mutes(msg, target)
end
if ((matches[1] == "modlist" and not Clang) or (matches[1] == "قائمة الادمن" and Clang)) then
return modlist(msg)
end
if ((matches[1] == "ownerlist" and not Clang) or (matches[1] == "قائمة المدراء" and Clang)) and is_owner(msg) then
return ownerlist(msg)
end
if ((matches[1] == "whitelist" and not Clang) or (matches[1] == "اعضاء القائمة البيضاء" and Clang)) and not matches[2] and is_mod(msg) then
return whitelist(msg.to.id)
end

if ((matches[1]:lower() == "option" and not Clang) or (matches[1] == "الضبط" and Clang)) and is_mod(msg) then
local function inline_query_cb(arg, data)
      if data.results_ and data.results_[0] then
tdcli.sendInlineQueryResultMessage(msg.to.id, 0, 0, 1, data.inline_query_id_, data.results_[0].id_, dl_cb, nil)
    else
    if not lang then
    text = "*Helper is offline*\n\n"
        elseif lang then
    text = "_ازرار الشفافة غير مفعلة_\n\n"
    end
  return tdcli.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
   end
end
tdcli.getInlineQueryResults(helper_id, msg.to.id, 0, 0, msg.to.id, 0, inline_query_cb, nil)
end

if ((matches[1]:lower() == "option pv" and not Clang) or (matches[1] == "الضبط خاص" and Clang)) and is_mod(msg) then
local function inline_query_cb(arg, data)
      if data.results_ and data.results_[0] then
    if not lang then
    text = "*Group Option* _Was Send In Your_ *Private Chat*\n\n"
        elseif lang then
    text = "_✅ تم ارسال اعدادات الشفافة الى الخاص ⚙\n\n⚠️ اذا لم تصل ارسل اولا رسالة للبوت خاص ثم اعد الامر_\n\n"
    end
tdcli.sendInlineQueryResultMessage(msg.from.id, 0, 0, 1, data.inline_query_id_, data.results_[0].id_, dl_cb, nil)
  return tdcli.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
    else
    if not lang then
    text = "*Helper is offline*\n\n"
        elseif lang then
    text = "_ازرار الشفافة غير مفعلة_\n\n"
    end
  return tdcli.sendMessage(msg.from.id, msg.id, 0, text, 0, "md")
   end
end
tdcli.getInlineQueryResults(helper_id, msg.to.id, 0, 0, msg.to.id, 0, inline_query_cb, nil)
end

if (matches[1]:lower() == "setlang" and not Clang) and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
if matches[2] == "ar" then
redis:set(hash, true)
return "`تم تغيير لغة البوت الى :` _العربية_ "..msg_caption
  elseif matches[2] == "en" then
 redis:del(hash)
return "_Group Language Set To:_ EN"..msg_caption
end
end
if (matches[1] == 'لغة' and Clang) and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
if matches[2] == "عربي" then
redis:set(hash, true)
return "`تم تغيير لغة البوت الى :` _العربية_ "..msg_caption
  elseif matches[2] == "انجليزي" then
 redis:del(hash)
return "_Group Language Set To:_ EN"..msg_caption
end
end

if (matches[1]:lower() == "setcmd" and not Clang) and is_owner(msg) then
local hash = "cmd_lang:"..msg.to.id
if matches[2] == "ar" then
redis:set(hash, true)
   if lang then
return "`تم تغيير لغة الاوامر الى :` _العربية_ "..msg_caption
else
return "_Bot Commands Language Set To:_ Fa"..msg_caption
end
end
end

if (matches[1]:lower() == "اوامر انجليزي" and Clang) and is_owner(msg) then
local hash = "cmd_lang:"..msg.to.id
redis:del(hash)
   if lang then
return "`تم تغيير لغة الاوامر الى :` _العربية_ "..msg_caption
else
return "_Bot Commands Language Set To:_ EN"..msg_caption
end
end

if ((matches[1]:lower() == "learn" and not Clang) or (matches[1] == "یادگیری" and Clang)) and is_mod(msg) then
if not lang then
text = [[
*Learn About Locks Status :*

*If status = warn*
_Sender will be_ *warned* _first, then_ *kicked* _for second violation._

*If status = del*
_Message will be_ *delete* _only_

*If status = kick*
_Sender will be_ *kicked* _for violation._

*If status = ban*
_Sender will be_ *banned* _for violation._

*If status = ok or disable*
_Bot does not react._

*Good Luck :)*]]
elseif lang then
text = [[
_یادگیری وضعیت قفل ها :_

_اگر وضعیت warn باشد_
_متخلف برای بار اول اخطار دریافت میکند, و در صورت تکرار اخراج خواهد شد_

_اگر وضیعت del باشد_
_تنها پیام شخص متخلف پاک خواهد شد_

_اگر وضعیت kick باشد_
_متخلف از گروه اخراج خواهد شد_

_اگر وضعیت ban باشد_
_متخلف از گروه محروم خواهد شد_

_اگر وضعیت ok یا disable باشد_
_ربات واکنشی نشان نخواهد داد_

_موفق باشید_ *:)*]]
     end
  return text
end

if (matches[1]:lower() == "helpsettings" and not Clang) and is_mod(msg) then
if not lang then
text = [[
*Beyond Settings Commands :*

*!setflood* `[1-50]`
_Set Flooding Number_

*!setchar* `[Number]`
_Set Flooding Characters_

*!setfloodtime* `[1-10]`
_Set Flooding Time_

*!lock* `[join | pin | bots | tgservice]`
_If This Actions Lock, Bot Check Actions And Delete Them_

*!unlock* `[join | pin | bots | tgservice]`
_If This Actions Unlock, Bot Not Delete Them_

*!link* `[warn | del | kick | ban | ok]`
_Change Anti Link Status_

*!tag* `[warn | del | kick | ban | ok]`
_Change Anti Tag Status_

*!webpage* `[warn | del | kick | ban | ok]`
_Change Anti Webpage Status_

*!markdown* `[warn | del | kick | ban | ok]`
_Change Anti Markdown Status_

*!mention* `[warn | del | kick | ban | ok]`
_Change Anti Mention Status_

*!edit* `[warn | del | kick | ban | ok]`
_Change Anti Edit Status_

*!arabic* `[warn | del | kick | ban | ok]`
_Change Anti Arabic Status_

*!text* `[warn | del | kick | ban | ok]`
_Change Anti Text Status_

*!gif* `[warn | del | kick | ban | ok]`
_Change Anti Gif Status_

*!photo* `[warn | del | kick | ban | ok]`
_Change Anti Photo Status_

*!video* `[warn | del | kick | ban | ok]`
_Change Anti Video Status_

*!voice* `[warn | del | kick | ban | ok]`
_Change Anti Voice Status_

*!audio* `[warn | del | kick | ban | ok]`
_Change Anti Audio Status_

*!document* `[warn | del | kick | ban | ok]`
_Change Anti Document Status_

*!location* `[warn | del | kick | ban | ok]`
_Change Anti Location Status_

*!inline* `[warn | del | kick | ban | ok]`
_Change Anti Inline Status_

*!keyboard* `[warn | del | kick | ban | ok]`
_Change Anti Keyboard Status_

*!chat* `[warn | del | kick | ban | ok]`
_Change Anti Chat Status_

*!contact* `[warn | del | kick | ban | ok]`
_Change Anti Contact Status_

*!forward* `[warn | del | kick | ban | ok]`
_Change Anti Forward Status_

*!view* `[warn | del | kick | ban | ok]`
_Change Anti Forwarded Messages From Channel Status_

*!sticker* `[warn | del | kick | ban | ok]`
_Change Anti Sticker Status_

*!antispam* `[warn | del | kick | ban | disable]`
_Change Anti Spam Status_

*!antiflood* `[kick | ban | disable]`
_Change Anti Flood Status_

*!option*
_Show Group Options_

*!option pv*
_Send Group Options In Your Pv_

*Good Luck :)*]]
elseif lang then
text = [[
_راهنمای تنظیمات بیوند :_

*!setflood* `[1-50]`
_تنظیم حداکثر تعداد پیام مکرر_

*!setchar* `[Number]`
_تنظیم حداکثر کاراکتر پیام مکرر_

*!setfloodtime* `[1-10]`
_تنظیم زمان ارسال پیام مکرر_

*!lock* `[join | pin | bots | tgservice]`
_در صورت قفل بودن فعالیت ها, ربات آنهارا حذف خواهد کرد_

*!unlock* `[join | pin | bots | tgservice]`
_در صورت قفل نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد_

*!link* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد لینک_

*!tag* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد تگ_

*!webpage* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد لینک وب سایت_

*!markdown* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد فونت(مارکدان)_

*!mention* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد فراخوانی(منشن)_

*!edit* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد ویرایش پیام_

*!arabic* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد عربی_

*!text* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد پیام متنی_

*!gif* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد تصاویر متحرک_

*!photo* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد عکس_

*!video* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد فیلم_

*!voice* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد صدا_

*!audio* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد اهنگ_

*!document* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد فایل_

*!location* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد موقعیت مکانی_

*!inline* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد اینلاین_

*!keyboard* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد کیبورد شیشه ای_

*!chat* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد چت_

*!contact* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد مخاطب_

*!forward* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد فوروارد_

*!view* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد پیام های فوروارد شده از کانال_

*!sticker* `[warn | del | kick | ban | ok]`
_تغییر وضعیت ضد استیکر_

*!antispam* `[warn | del | kick | ban | disable]`
_تغییر وضعیت ضد هرزنامه_

*!antiflood* `[kick | ban | disable]`
_تغییر وضعیت ضد پیام های مکرر_

*!option*
_نمایش تنظیمات کلی گروه_

*!option pv*
_ارسال تنظیمات کلی گروه در پیوی شما_

_موفق باشید_ *:)*]]
     end
  return text
end

if (matches[1] == "راهنمای تنظیمات" and Clang) and is_mod(msg) then
if not lang then
text = [[
*Beyond Settings Commands :*

*تنظیم پیام مکرر* `[1-50]`
_Set Flooding Number_

*حداکثر حروف مجاز* `[عدد]`
_Set Flooding Characters_

*تنظیم زمان بررسی* `[1-10]`
_Set Flooding Time_

*قفل* `[پین | ورود | خدمات تلگرام | ربات]`
_If This Actions Lock, Bot Check Actions And Delete Them_

*باز کردن* `[پین | ورود | خدمات تلگرام | ربات]`
_If This Actions Unlock, Bot Not Delete Them_

*لینک* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Link Status_

*تگ* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Tag Status_

*صفحات وب* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Webpage Status_

*فونت* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Markdown Status_

*فراخوانی* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Mention Status_

*ویرایش* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Edit Status_

*عربی* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Arabic Status_

*متن* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Text Status_

*گیف* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Gif Status_

*عکس* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Photo Status_

*فیلم* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Video Status_

*صدا* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Voice Status_

*اهنگ* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Audio Status_

*فایل* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Document Status_

*موقعیت* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Location Status_

*اینلاین* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Inline Status_

*کیبورد* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Keyboard Status_

*چت* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Chat Status_

*مخاطب* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Contact Status_

*فوروارد* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Forward Status_

*فوروارد از کانال* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Forwarded Messages From Channel Status_

*استیکر* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Sticker Status_

*هرزنامه* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_Change Anti Spam Status_

*پیام های مکرر* `[اخراج | محرومیت | غیرفعال]`
_Change Anti Flood Status_

*تنظیمات کلی*
_Show Group Options_

*تنظیمات کلی خصوصی*
_Send Group Options In Your Pv_

*Good Luck :)*]]
elseif lang then
text = [[
_راهنمای تنظیمات بیوند :_

*تنظیم پیام مکرر* `[2-50]`
_تنظیم حداکثر تعداد پیام مکرر_

*حداکثر حروف مجاز* `[عدد]`
_تنظیم حداکثر کاراکتر پیام مکرر_

*تنظیم زمان بررسی* `[1-10]`
_تنظیم زمان ارسال پیام مکرر_

*قفل* `[پین | ورود | خدمات تلگرام | ربات]`
_در صورت قفل بودن فعالیت ها, ربات آنهارا حذف خواهد کرد_

*باز کردن* `[پین | ورود | خدمات تلگرام | ربات]`
_در صورت قفل نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد_

*لینک* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد لینک_

*تگ* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد تگ_

*صفحات وب* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد لینک وب سایت_

*فونت* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد فونت(مارکدان)_

*فراخوانی* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد فراخوانی(منشن)_

*ویرایش* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد ویرایش پیام_

*عربی* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد عربی_

*متن* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد پیام متنی_

*گیف* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد تصاویر متحرک_

*عکس* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد عکس_

*فیلم* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد فیلم_

*صدا* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد صدا_

*اهنگ* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد اهنگ_

*فایل* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد فایل_

*موقعیت* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد موقعیت مکانی_

*اینلاین* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد اینلاین_

*کیبورد* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد کیبورد شیشه ای_

*چت* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد چت_

*مخاطب* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد مخاطب_

*فوروارد* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد فوروارد_

*فوروارد از کانال* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد پیام های فوروارد شده از کانال_

*استیکر* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد استیکر_

*هرزنامه* `[اخطار | حذف | اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد هرزنامه_

*پیام های مکرر* `[اخراج | محرومیت | غیرفعال]`
_تغییر وضعیت ضد پیام های مکرر_

*تنظیمات کلی*
_نمایش تنظیمات کلی گروه_

*تنظیمات کلی خصوصی*
_ارسال تنظیمات کلی گروه در پیوی شما_

_موفق باشید_ *:)*]]
     end
  return text
end

if (matches[1] == "help" and not Clang) and is_mod(msg) then
if not lang then
text = [[
*Beyond Bot Commands:*

*!setowner* `[username|id|reply]` 
_Set Group Owner(Multi Owner)_

*!remowner* `[username|id|reply]` 
 _Remove User From Owner List_

*!promote* `[username|id|reply]` 
_Promote User To Group Admin_

*!demote* `[username|id|reply]` 
_Demote User From Group Admins List_

*!silent* `[username|id|reply]` 
_Silent User From Group_

*!unsilent* `[username|id|reply]` 
_Unsilent User From Group_

*!kick* `[username|id|reply]` 
_Kick User From Group_

*!ban* `[username|id|reply]` 
_Ban User From Group_

*!unban* `[username|id|reply]` 
_UnBan User From Group_

*!whitelist* [+-] `[username|id|reply]` 
_Add Or Remove User From White List_

*!res* `[username]`
_Show User ID_

*!id* `[reply]`
_Show User ID_

*!whois* `[id]`
_Show User's Username And Name_

*!set*`[rules | name | link | about | welcome]`
_Bot Set Them_

*!clean* `[bans | mods | bots | rules | about | silentlist | filtelist | whitelist | welcome]`   
_Bot Clean Them_

*!filter* `[word]`
_Word filter_

*!unfilter* `[word]`
_Word unfilter_

*!pin* `[reply]`
_Pin Your Message_

*!unpin* 
_Unpin Pinned Message_

*!welcome enable/disable*
_Enable Or Disable Group Welcome_

*!settings*
_Show Group Settings_

*!mutelist*
_Show Mutes List_

*!silentlist*
_Show Silented Users List_

*!filterlist*
_Show Filtered Words List_

*!banlist*
_Show Banned Users List_

*!ownerlist*
_Show Group Owners List_ 

*!modlist* 
_Show Group Moderators List_

*!whitelist* 
_Show Group White List Users_

*!rules*
_Show Group Rules_

*!about*
_Show Group Description_

*!id*
_Show Your And Chat ID_

*!gpinfo*
_Show Group Information_

*!newlink*
_Create A New Link_

*!link*
_Show Group Link_

*!linkpv*
_Send Group Link In Your Private Message_

*!setwelcome [text]*
_set Welcome Message_

*!setlang [fa | en]*
_Set Persian/English Language_

*!setcmd fa*
_Set CMD Persian Language_

*!helptools*
_Show Tools Help_

*!helpsettings*
_Show Settings Help_

*!helpfun*
_Show Fun Help_

_You Can Use_ *[!/#]* _To Run The Commands_
_This Help List Only For_ *Moderators/Owners!*
_Its Means, Only Group_ *Moderators/Owners* _Can Use It!_

*Good luck ;)*]]

elseif lang then

text = [[
_دستورات ربات بیوند:_

*!setowner* `[username|id|reply]`
_انتخاب مالک گروه(قابل انتخاب چند مالک)_

*!remowner* `[username|id|reply]`
_حذف کردن فرد از فهرست مالکان گروه_

*!promote* `[username|id|reply]`
_ارتقا مقام کاربر به مدیر گروه_

*!demote* `[username|id|reply]`
_تنزیل مقام مدیر به کاربر_

*!silent* `[username|id|reply]`
_بیصدا کردن کاربر در گروه_

*!unsilent* `[username|id|reply]`
_در آوردن کاربر از حالت بیصدا در گروه_

*!kick* `[username|id|reply]`
_حذف کاربر از گروه_

*!ban* `[username|id|reply]`
_مسدود کردن کاربر از گروه_

*!unban* `[username|id|reply]`
_در آوردن از حالت مسدودیت کاربر از گروه_

*!whitelist* `[+|-]` `[یوزرنیم|ایدی|ریپلی]` 
_افزودن افراد به لیست سفید_

*!res* `[username]`
_نمایش شناسه کاربر_

*!id* `[reply]`
نمایش شناسه کاربر

*!whois* `[id]`
_نمایش نام کاربر, نام کاربری و اطلاعات حساب_

*!set*`[rules | name | link | about | welcome]`
_ربات آنهارا ثبت خواهد کرد_

*!clean* `[bans | mods | rules | about | silentlist | filterlist | welcome]`
_ربات آنهارا پاک خواهد کرد_

*!filter* `[word]`
_فیلتر‌کلمه مورد نظر_

*!unfilter* `[word]`
_ازاد کردن کلمه مورد نظر_

*!pin* `[reply]`
_ربات پیام شمارا در گروه سنجاق خواهد کرد_

*!unpin *
ربات پیام سنجاق شده در گروه را حذف خواهد کرد

*!welcome* `enable/disable`
_فعال یا غیرفعال کردن خوشامد گویی_

*!settings*
_نمایش تنظیمات گروه_

*!mutelist*
_نمایش فهرست بیصدا های گروه_

*!silentlist*
_نمایش فهرست افراد بیصدا_

*!filterlist*
_نمایش لیست کلمات فیلتر شده_

*!banlist*
_نمایش افراد مسدود شده از گروه_

*!ownerlist*
_نمایش فهرست مالکان گروه_

*!modlist*
_نمایش فهرست مدیران گروه_

*!whitelist*
_نمایش افراد سفید شده از گروه_

*!rules*
_نمایش قوانین گروه_

*!about*
_نمایش درباره گروه_

*!id*
_نمایش شناسه شما و گروه_

*!gpinfo*
_نمایش اطلاعات گروه_

*!newlink*
_ساخت لینک جدید_

*!setlink*
_تنظیم لینک جدید_

*!link*
_نمایش لینک گروه_

*!linkpv*
_ارسال لینک گروه به چت خصوصی شما_

*!setwelcome* `[text]`
_ثبت پیام خوش آمد گویی_

*!setlang* `[fa | en]`
_تنظیم زبان ربات به فارسی یا انگلیسی_

*!setcmd* `fa`
_تنظیم زبان دستورات ربات به فارسی_

*!helptools*
_نمایش راهنمای ابزار_

*!helpsettings*
_نمایش راهنمای تنظیمات_

*!helpfun*
_نمایش راهنمای سرگرمی_

_شما میتوانید از [!/#] در اول دستورات برای اجرای آنها بهره بگیرید_

_این راهنما فقط برای مدیران/مالکان گروه میباشد!_

_این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!_

_موفق باشید_ *;)*
]]
end
return text..msg_caption
end

if (matches[1] == "راهنما" and Clang) and is_mod(msg) then
if not lang then
text = [[
*Beyond Bot Commands:*

*مالک* `[username|id|reply]` 
_Set Group Owner(Multi Owner)_

*حذف مالک* `[username|id|reply]` 
 _Remove User From Owner List_

*مدیر* `[username|id|reply]` 
_Promote User To Group Admin_

*حذف مدیر* `[username|id|reply]` 
_Demote User From Group Admins List_

*سکوت* `[username|id|reply]` 
_Silent User From Group_

*حذف سکوت* `[username|id|reply]` 
_Unsilent User From Group_

*اخراج* `[username|id|reply]` 
_Kick User From Group_

*بن* `[username|id|reply]` 
_Ban User From Group_

*حذف بن* `[username|id|reply]` 
_UnBan User From Group_

*لیست سفید* [+-] `[username|id|reply]` 
_Add Or Remove User From White List_

*کاربری* `[username]`
_Show User ID_

*ایدی* `[reply]`
_Show User ID_

*شناسه* `[id]`
_Show User's Username And Name_

*تنظیم*`[قوانین | نام | لینک | درباره | خوشامد]`
_Bot Set Them_

*پاک کردن* `[بن | مدیران | ربات | قوانین | درباره | لیست سکوت | خوشامد]`   
_Bot Clean Them_

*فیلتر* `[word]`
_Word filter_

*حذف فیلتر* `[word]`
_Word unfilter_

*سنجاق* `[reply]`
_Pin Your Message_

*حذف سنجاق* 
_Unpin Pinned Message_

*خوشامد فعال/غیرفعال*
_Enable Or Disable Group Welcome_

*تنظیمات*
_Show Group Settings_

*لیست بیصدا*
_Show Mutes List_

*لیست سکوت*
_Show Silented Users List_

*لیست فیلتر*
_Show Filtered Words List_

*لیست بن*
_Show Banned Users List_

*لیست مالکان*
_Show Group Owners List_ 

*لیست مدیران* 
_Show Group Moderators List_

*لیست سفید* 
_Show Group White List Users_

*قوانین*
_Show Group Rules_

*درباره*
_Show Group Description_

*ایدی*
_Show Your And Chat ID_

*اطلاعات گروه*
_Show Group Information_

*لینک جدید*
_Create A New Link_

*تنظیم لینک*
_Set A New Link_

*لینک*
_Show Group Link_

*لینک خصوصی*
_Send Group Link In Your Private Message_

*تنظیم خوشامد [text]*
_set Welcome Message_

*زبان [فارسی | انگلیسی]*
_Set Persian/English Language_

*اوامر انجليزي*
_Set CMD English Language_

*راهنمای ابزار*
_Show Tools Help_

*راهنمای تنظیمات*
_Show Settings Help_

*راهنمای سرگرمی*
_Show Fun Help_

_This Help List Only For_ *Moderators/Owners!*
_Its Means, Only Group_ *Moderators/Owners* _Can Use It!_

*Good luck ;)*]]

elseif lang then

text = [[
*دستورات ربات بیوند:*

*مالک* `[یوزرنیم|ایدی|ریپلی]` 
_انتخاب مالک گروه(قابل انتخاب چند مالک)_

*حذف مالک* `[یوزرنیم|ایدی|ریپلی]` 
 _حذف کردن فرد از فهرست مالکان گروه_

*مدیر* `[یوزرنیم|ایدی|ریپلی]` 
_ارتقا مقام کاربر به مدیر گروه_

*حذف مدیر* `[یوزرنیم|ایدی|ریپلی]` 
_تنزیل مقام مدیر به کاربر_

*سکوت* `[یوزرنیم|ایدی|ریپلی]` 
_بیصدا کردن کاربر در گروه_

*حذف سکوت* `[یوزرنیم|ایدی|ریپلی]` 
_در آوردن کاربر از حالت بیصدا در گروه_

*اخراج* `[یوزرنیم|ایدی|ریپلی]` 
_حذف کاربر از گروه_

*بن* `[یوزرنیم|ایدی|ریپلی]` 
_مسدود کردن کاربر از گروه_

*حذف بن* `[یوزرنیم|ایدی|ریپلی]` 
_در آوردن از حالت مسدودیت کاربر از گروه_

*کاربری* `[یوزرنیم]`
_نمایش شناسه کاربر_

*ایدی* `[ریپلی]`
_نمایش شناسه کاربر_

*شناسه* `[ایدی]`
_نمایش نام کاربر, نام کاربری و اطلاعات حساب_

*تنظیم*`[قوانین | نام | لینک | درباره | خوشامد]`
_ربات آنهارا ثبت خواهد کرد_

*پاک کردن* `[بن | مدیران | ربات | قوانین | درباره | لیست سکوت | خوشامد]`   
_ربات آنهارا پاک خواهد کرد_

*لیست سفید* `[+|-]` `[یوزرنیم|ایدی|ریپلی]` 
_افزودن افراد به لیست سفید_

*فیلتر* `[کلمه]`
_فیلتر‌کلمه مورد نظر_

*حذف فیلتر* `[کلمه]`
_ازاد کردن کلمه مورد نظر_

*سنجاق* `[reply]`
_ربات پیام شمارا در گروه سنجاق خواهد کرد_

*حذف سنجاق* 
_ربات پیام سنجاق شده در گروه را حذف خواهد کرد_

*!خوشامد فعال/غیرفعال*
_فعال یا غیرفعال کردن خوشامد گویی_

*تنظیمات*
_نمایش تنظیمات گروه_

*لیست بیصدا*
_نمایش فهرست بیصدا های گروه_

*لیست سکوت*
_نمایش فهرست افراد بیصدا_

*لیست فیلتر*
_نمایش لیست کلمات فیلتر شده_

*لیست سفید*
_نمایش افراد سفید شده از گروه_

*لیست بن*
_نمایش افراد مسدود شده از گروه_

*لیست مالکان*
_نمایش فهرست مالکان گروه_ 

*لیست مدیران* 
_نمایش فهرست مدیران گروه_

*قوانین*
_نمایش قوانین گروه_

*درباره*
_نمایش درباره گروه_

*ایدی*
_نمایش شناسه شما و گروه_

*اطلاعات گروه*
_نمایش اطلاعات گروه_

*لینک جدید*
_ساخت لینک جدید_

*لینک*
_نمایش لینک گروه_

*تنظیم لینک*
_تنظیم لینک جدید برای گروه_

*لینک خصوصی*
_ارسال لینک گروه به چت خصوصی شما_

*زبان انگلیسی/فارسی*
_تنظیم زبان به انگلیسی و یا فارسی_

*اوامر انجليزي*
_تنظیم اوامر انجليزي_

*تنظیم خوشامد [متن]*
_ثبت پیام خوش آمد گویی_

*راهنمای ابزار*
_نمایش راهنمای ابزار_

*راهنمای تنظیمات*
_نمایش راهنمای تنظیمات_

*راهنمای سرگرمی*
_نمایش راهنمای سرگرمی_

_این راهنما فقط برای مدیران/مالکان گروه میباشد!
این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!_
*موفق باشید ;)*]]
end
return text..msg_caption
end

if (matches[1] == 'silenttime' or matches[1] == 'زمان بیصدا') and is_mod(msg) then
local hash = 'muteall:'..msg.to.id
local hour = tonumber(matches[2])
local num1 = (tonumber(hour) * 3600)
local minutes = tonumber(matches[3])
local num2 = (tonumber(minutes) * 60)
local second = tonumber(matches[4])
local num3 = tonumber(second) 
local num4 = tonumber(num1 + num2 + num3)
redis:setex(hash, num4, true)
if not lang then
 return "_Mute all has been enabled for_ \n⏺ *hours :* `"..matches[2].."`\n⏺ *minutes :* `"..matches[3].."`\n⏺ *seconds :* `"..matches[4].."`"
 elseif lang then
 return "⏰ تم وضع الصامت للمجموعة للمدة \n⏺ ساعات : "..matches[2].."\n⏺ دقائق : "..matches[3].."\n⏺ الثواني : "..matches[4]
 end
 end
 if (matches[1] == 'silenth' or matches[1]== 'الصامت ساعات') and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
local hour = matches[2]
local num1 = tonumber(hour) * 3600
local num4 = tonumber(num1)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ hours : "..matches[2]
 elseif lang then
 return "⏰ تم وضع الصامت للمجموعة للمدة \n🔕 ساعات : "..matches[2]
 end
 end
  if (matches[1] == 'silentm' or matches[1]== 'الصامت دقائق')  and is_mod(msg) then
 local hash = 'muteall:'..msg.to.id
local minutes = matches[2]
local num2 = tonumber(minutes) * 60
local num4 = tonumber(num2)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n🔕 minutes : "..matches[2]
 elseif lang then
 return "⏰ تم وضع الصامت للمجموعة للمدة \n🔕 دقائق : "..matches[2]
 end
 end
  if (matches[1] == 'silents' or matches[1] == 'الصامت ثواني') and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
local second = matches[2]
local num3 = tonumber(second) 
local num4 = tonumber(num3)
redis:setex(hash, num3, true)
if not lang then
 return "Mute all has been enabled for \n🔕 seconds : "..matches[2]
 elseif lang then
 return "⏰ تم وضع الصامت للمجموعة للمدة \n🔕 ثواني : "..matches[2]
 end
 end
 if (matches[1] == 'silent' or matches[1] == 'الصامت') and (matches[2] == 'status' or matches[2] == 'احصائية') and is_mod(msg) then
         local hash = 'muteall:'..msg.to.id
      local mute_time = redis:ttl(hash)
		
		if tonumber(mute_time) < 0 then
		if not lang then
		return '_Mute All is Disable._'
		else
		return '`🔕 الصامت غير مفعل مسبقا`'
		end
		else
		if not lang then
          return mute_time.." Sec"
		  elseif lang then
		  return "⏳ *"..mute_time.."* ثانية المتبقي للفتح الصامت"
		end
		end
  end
--------------------- Welcome -----------------------
	if (matches[1]:lower() == "welcome" or matches[1] == 'الترحيب') and is_mod(msg) then
	if not lang then
		if matches[2] == "enable" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
				return "_Group_ *welcome* _is already enabled_"
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
				return "_Group_ *welcome* _has been enabled_"
			end
		end
		
		if matches[2] == "disable" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
				return "_Group_ *Welcome* _is already disabled_"
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
				return "_Group_ *welcome* _has been disabled_"
			end
		end
		else
				if matches[2] == "تفعيل" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
				local text = 'الترحيب مفعل مسبقا ✅'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=20, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
				local text = 'تم تفعيل الترحيب بنجاح ✅'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=24, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
			end
		end
		
		if matches[2] == "تعطيل" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
				local text = 'الترحيب غير مفعل مسبقا ❎'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=24, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
				local text = 'تم الغاء الترحيب في المجموعة ❎'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=30, user_id_=msg.sender_user_id_}}}}, dl_cb, nil)
			end
		end
		end
	end
	if (matches[1]:lower() == "setwelcome" or matches[1] == 'تعيين ترحيب') and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "_Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"
       else
		return "_تم حفظ الترحيب الجديد 👇 :_\n*"..matches[2].."*\n\n*بعض اضافات الى الترحيب*\n_{gpname} اسم المجموعة_\n_{rules} ➣ قوانين المجموعة_\n_{name} ➣ اسم العضو الجديد_\n_{username} ➣ معرف العضو_"
       end
     end
	end
end
local checkmod = true

local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if tonumber(msg.adduser) == tonumber(our_id) and is_admin(msg) then
  if msg.from.username then
    username = "@"..check_markdown(msg.from.username)
     else
    username = check_markdown(msg.from.print_name)
   end
   modadd(msg)
   		if not redis:get('ExpireDate1:'..msg.to.id) then
			redis:set('ExpireDate1:'..msg.to.id,true)
			redis:setex('ExpireDate1:'..msg.to.id, 180, true)
     end
				if not redis:get('CheckExpire1::'..msg.to.id) then
					redis:set('CheckExpire1::'..msg.to.id,true)
				end
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '``', 1, 'md')
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_تم شحن البوت 3 دقائق للضبط الاعدادات_', 1, 'md')
		tdcli.sendMessage(_config.master_id, "", 0, "_User_ "..username.." `"..msg.from.id.."` _Add Me To_ *"..check_markdown(msg.to.title).."* _and_ *group* _has been_ *added*", 0, "md")
   end
 if checkmod and msg.text and msg.to.type == 'channel' then
 	checkmod = false
	tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
	local secchk = true
		for k,v in pairs(b.members_) do
			if v.user_id_ == tonumber(our_id) then
				secchk = false
			end
		end
		if secchk then
			checkmod = false
			if not lang then
				return tdcli.sendMessage(msg.to.id, 0, 1, '_Robot isn\'t Administrator, Please promote to Admin!_', 1, "md")
			else
				return tdcli.sendMessage(msg.to.id, 0, 1, '_البوت ليس اداري الرجاء رفعه اداري_', 1, "md")
			end
		end
	end, nil)
 end
	local function welcome_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*Welcome Dude*"
    elseif lang then
     welcome = "_👋 مرحبا "..msg.from.print_name..' نورت(ي) في مجموعة '..msg.to.title..'_\n\n`⛔️ التزم بقوانين المجموعة`'
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
  	return "_Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{time} ➣ Show time english _\n_{date} ➣ Show date english _\n_{timefa} ➣ Show time persian _\n_{datefa} ➣ show date persian _\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"
       else
		 rules = "_ℹ️ القوانين :\n1⃣ ممنوع الاعلانات \n2⃣ ممنوع السبام. \n3⃣ تبلیغ ممنوع.\n4⃣ ممنوع الملصقات.\n5⃣ ممنوع الصور المتحركة.\n➡️ اي عضو يخالف القوانين يستم حظره._\n@islamchanal1"
       end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_..' '..(data.last_name_ or '')))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli.getUser(msg.sender_user_id_, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
        end
		end
	end
 end
 
return {
patterns ={
"^[!/#](id)$",
"^[!/#](id) (.*)$",
"^[!/#](pin)$",
"^[!/#](unpin)$",
"^[!/#](gpinfo)$",
"^[!/#](test)$",
"^[!/#](run)$",
"^[!/#](rem)$",
"^[!/#](option)$",
"^[!/#](option pv)$",
"^[!/#](learn)$",
"^[!/#](link) (.*)$",
"^[!/#](tag) (.*)$",
"^[!/#](webpage) (.*)$",
"^[#!/](antispam) (.*)$",
"^[#!/](antiflood) (.*)$",
"^[!/#](markdown) (.*)$",
"^[!/#](mention) (.*)$",
"^[!/#](arabic) (.*)$",
"^[!/#](forward) (.*)$",
"^[!/#](view) (.*)$",
"^[#!/](voice) (.*)$",
"^[#!/](gif) (.*)$",
"^[#!/](video) (.*)$",
"^[#!/](audio) (.*)$",
"^[!/#](chat) (.*)$",
"^[!/#](photo) (.*)$",
"^[!/#](inline) (.*)$",
"^[!/#](keyboard) (.*)$",
"^[#!/](contact) (.*)$",
"^[#!/](document) (.*)$",
"^[!/#](location) (.*)$",
"^[!/#](text) (.*)$",
"^[!/#](edit) (.*)$",
"^[!/#](sticker) (.*)$",
"^[!/#](whitelist) ([+-])$",
"^[!/#](whitelist) ([+-]) (.*)$",
"^[#!/](whitelist)$",
"^[!/#](setowner)$",
"^[!/#](setowner) (.*)$",
"^[!/#](remowner)$",
"^[!/#](remowner) (.*)$",
"^[!/#](promote)$",
"^[!/#](promote) (.*)$",
"^[!/#](demote)$",
"^[!/#](demote) (.*)$",
"^[!/#](modlist)$",
"^[!/#](ownerlist)$",
"^[!/#](lock) (.*)$",
"^[!/#](unlock) (.*)$",
"^[!/#](settings)$",
"^[!/#](mutelist)$",
"^[!/#](mute) (.*)$",
"^[!/#](unmute) (.*)$",
"^[!/#](link)$",
"^[!/#](hlink)$",
"^[!/#](linkpv)$",
"^[!/#](setlink)$",
"^[!/#](newlink)$",
"^[!/#](rules)$",
"^[!/#](setrules) (.*)$",
"^[!/#](about)$",
"^[!/#](setabout) (.*)$",
"^[!/#](setname) (.*)$",
"^[!/#](clean) (.*)$",
"^[!/#](setflood) (%d+)$",
"^[!/#](setchar) (%d+)$",
"^[!/#](setfloodtime) (%d+)$",
"^[!/#](res) (.*)$",
"^[!/#](whois) (%d+)$",
--"^[!/#](help)$",
--"^[!/#](helpsettings)$",
"^[!/#](setlang) (.*)$",
"^[!/#](setcmd) (.*)$",
"^[#!/](filter) (.*)$",
"^[#!/](unfilter) (.*)$",
"^[#!/](filterlist)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^[!/#](setwelcome) (.*)",
"^[!/#](welcome) (.*)$",
'^(الضبط خاص)$',
"^(قفل الروابط) (.*)$",
"^(قفل المعرفات) (.*)$",
"^(قفل روابط المواقع) (.*)$",
"^(قفل السبام) (.*)$",
"^(قفل التكرار) (.*)$",
"^(قفل الماركداون) (.*)$",
"^(قفل المنشن) (.*)$",
"^(قفل العربية) (.*)$",
"^(قفل اعادة التوجيه) (.*)$",
"^(قفل توجيه القنوات) (.*)$",
"^(قفل التسجيلات) (.*)$",
"^(قفل صور المتحركة) (.*)$",
"^(قفل الصوتيات) (.*)$",
"^(قفل الفيديو) (.*)$",
"^(قفل المجموعة) (.*)$",
"^(قفل الصور) (.*)$",
"^(قفل ازرار شفافة) (.*)$",
"^(قفل كيبورد) (.*)$",
"^(قفل جهات اتصال) (.*)$",
"^(قفل الملفات) (.*)$",
"^(قفل مشاركة الموقع) (.*)$",
"^(قفل النصوص) (.*)$",
"^(قفل التعديل) (.*)$",
"^(قفل الملصقات) (.*)$",
"^(لغة) (.*)$",
"^(اوامر انجليزي)$",
--'^(ايدي)$',
'^(الضبط)$',
'^(ايدي) (.*)$',
'^(الاعدادات)$',
'^(تثبيت)$',
'^(الغاء التثبيت)$',
'^(تفعيل)$',
'^(تعطيل)$',
--'^(رفع مشرف)$',
--'^(رفع مشرف) (.*)$',
--'^(حذف مشرف) (.*)$',
--'^(حذف مشرف)$',
'^(القائمة البيضاء) ([+-]) (.*)$',
'^(القائمة البيضاء) ([+-])$',
'^(اعضاء القائمة البيضاء)$',
'^(رفع مدير)$',
'^(رفع مدير) (.*)$',
'^(حذف مدير) (.*)$',
'^(حذف مدير)$',
'^(رفع ادمن)$',
'^(رفع ادمن) (.*)$',
'^(حذف ادمن)$',
'^(حذف ادمن) (.*)$',
'^(قفل) (.*)$',
'^(فتح) (.*)$',
--'^(قفل) (.*)$',
--'^(فتح) (.*)$',
'^(رابط جديد)$',
'^(رابط جديد) (خاص)$',
'^(معلومات المجموعة)$',
'^(الاوامر) (.*)$',
--'^(قوانین)$',
'^(الرابط)$',
'^(تعيين رابط)$',
'^(تعيين رابط) ([https?://w]*.?telegram.me/joinchat/%S+)$',
'^(تعيين رابط) ([https?://w]*.?t.me/joinchat/%S+)$',
'^(تعيين قوانين) (.*)$',
'^(الرابط) (خاص)$',
'^(من هو) (.*)$',
'^(العضو) (%d+)$',
'^(تحديد التكرار) (%d+)$',
'^(تحديد وقت التكرار) (%d+)$',
'^(الحد الاقصى للحروف) (%d+)$',
'^(تنظيف) (.*)$',
'^(الوصف)$',
'^(تعيين اسم) (.*)$',
'^(تعيين وصف) (.*)$',
'^(قائمة فلتر)$',
'^(اعدادات قفل)$',
'^(قائمة المدراء)$',
'^(قائمة الادمن)$',
--'^(الاوامر)$',
'^(التكوين)$',
'^(فلتر) (.*)$',
'^(حذف فلتر) (.*)$',
'^(الترحيب) (.*)$',
'^(تعيين ترحيب) (.*)$',
'^(قوانين)$',
'^(الصامت ساعات) (%d+)$',
'^(الصامت دقائق) (%d+)$',
'^(الصامت ثواني) (%d+)$',
'^(الصامت) (احصائية)$',
'^(الصامت) (%d+) (%d+) (%d+)$',
'^(تحويل اللغة)$',
'^([https?://w]*.?telegram.me/joinchat/%S+)$',
'^([https?://w]*.?t.me/joinchat/%S+)$'


},
run=run,
pre_process = pre_process
}
--end groupmanager.lua #beyond team#
