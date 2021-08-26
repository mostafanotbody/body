do

local function maraThon(msg, matches)
if matches[1] == "mention" or "منشن" then
            local text = 'اضغط هنا للدخول الى العضو...'
local id = matches[2]
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=28, user_id_=id}}}}, dl_cb, nil)
end
              end
return {
patterns ={ 
"^(mention) (.*)$",
"^(منشن) (.*)$",
}, 
  run = maraThon
}
end
