--- Begin Get.lua
local function amir(msg, matches)
 if matches[1] == "بروفايل" then
 local function getpro(arg,data)
local id = matches[2]
if data.photos_[0] then
 tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'● للمشاهدة 5 صور بروفايل اخيرة للعضو ارسل 👇\n\nصورة2_'..id..'\nصورة3_'..id..'\nصورة4_'..id..'\nصورة5_'..id..'\n\nللدخول للعضو > المنشن_'..id..'')
   else
  return tdcli.sendMessage(msg.to.id,  msg.id,1, 'العضور '..id..' لا توجد صور بروفايل حاليا للعضو \n\n للدخول للمحادثة العضو ارسل \n\n المنشن_'..id..'  ',1,'html')
  end
  end
  tdcli_function ({ID ="GetUserProfilePhotos", user_id_ = matches[2], offset_ = 0, limit_ = 1 }, getpro, nil)   
   end
         if matches[1] == "صورة" then  
  if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 5 then
return "`يمكنك مشاهدة مشاهدة من 1 الى 5 فقط`"
end  
local function getpro(arg,data)
local x = matches[2]
if data.photos_[0] then
                  tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_)
else
    tdcli.sendMessage(msg.chat_id_, 0, 1,  'صورة العضو '..x..' غير موجودة', 1, 'md')

  end
  end
   tdcli_function ({ID ="GetUserProfilePhotos", user_id_ = matches[3], offset_ = matches[2]-1, limit_ = 5 }, getpro, nil)
   end
if matches[1] == "المنشن" then
            local text = 'Click Here To See The User...'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=29, user_id_=matches[2]}}}}, dl_cb, nil)
end

end
return { 
patterns = { 
"^(بروفايل) (.*)$",
"^(صورة)(.*)_(.*)$",
"^(المنشن)_(.*)$",
},
run = amir
}
---CerNerTeam @CerNer_Tm