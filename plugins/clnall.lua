local function getChatId(chat_id)
  local chat = {}
  local chat_id = tostring(chat_id)
  if chat_id:match('^-100') then
    local channel_id = chat_id:gsub('-100', '')
    chat = {ID = channel_id, type = 'channel'}
  else
    local group_id = chat_id:gsub('-', '')
    chat = {ID = group_id, type = 'group'}
  end
  return chat
end
local function run(msg, matches)
    if matches[1] == 'clnall' or 'تنظيف المجموعة' and is_mod(msg) then
  local function pro(extra,result,success)
             local run = result.members_        
               for i=0 , #run do
                  tdcli.deleteMessagesFromUser(msg.chat_id_, run[i].user_id_)
               end
end
local function cb(arg,data)
for k,v in pairs(data.messages_) do
          tdcli.deletemessages(msg.chat_id_,{[0] = v.id_})
end
end
  tdcli.getChatHistory(msg.chat_id_, msg.id_,0 , 100,cb)
      tdcli.sendMessage(msg.chat_id_, msg.id_, 1,  '`تم تنظيف رسائل المجموعة 🗑`', 1,'md')      
  tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,offset_ = 0,limit_ = 5000}, pro, nil)
end
end 

return {  
patterns ={  
"^clnall$",
"^تنظيف المجموعة$"
 }, 
  run = run
}
--By @mohammad_lua

