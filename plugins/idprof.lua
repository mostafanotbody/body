--[[
############################
#         *IDPro*          #
#    Writed By MohammadWH  #  
#      @GodOfDevelopers    # 
#        Ver: 1.0          #
#        2017/15/04        #
#     -------------------  #
#     Knight Channel:      #
#                          #
#      @Knight_Team        #
#                          #
############################
]]
do

function run(msg,matches)
local uhash = 'user:'..msg.from.id
local user = redis:hgetall(uhash)
local um_hash = 'msgs:'..msg.from.id..':'..msg.to.id
user_info_msgs = tonumber(redis:get(um_hash) or 0)
 if matches[1] == 'id' or 'ايدي' and msg.reply_to_message_id_ == 0  then
 if is_sudo(msg) then
  rank = '#المطور'
 elseif is_owner(msg) then
  rank = '#مدير'
 elseif is_mod(msg) then
  rank = '#ادمن'
 else
  rank = '#عضو'
 end
local function getpro(arg, data)

   if data.photos_[0] then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'\n● اسمك: '..msg.from.print_name..'\n● ايدي حسابك: '..msg.sender_user_id_..'\n● معرفك: @'..(msg.from.username or 'غير موجود')..'\n● رقم هاتفك: '..(msg.from.phone or 'ليس عندي رقم هاتفك!')..'\n● مكانك في مجموعة: '..rank..'\n● مجموع رسائلك: #'..user_info_msgs..'',msg.id_,msg.id_)
   else
      tdcli.sendMessage(msg.chat_id_, msg.id_, 1, "`لا توجد صورة للبروفايل !!`\n\n\n●` ايدي مجموعة:` *"..msg.chat_id_.."*\n●` ايدي:` *"..msg.sender_user_id_.."*\n●` معرفك:` @"..(msg.from.username or "----").."\n●` رقم الهاتف:` "..(msg.from.phone or "لا يوجد!").."\n●` رتبتك :` `"..rank..'`\n●` مجموع رسائلك:` '..user_info_msgs..'', 1, 'md')
   end
   end
   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.sender_user_id_,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)
	end
	
end

return {
patterns = {
	"^([Ii][Dd])$",
  "^(ايدي)$",
},
	run = run,
	}

end