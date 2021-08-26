local function cerner(msg, matches) 
	   if matches[1] == 'mydel' or 'مسح رسائلي' then  
tdcli.deleteMessagesFromUser(msg.to.id, msg.sender_user_id_, dl_cb, cmd)        
           tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '` تم مسح جميع رسائلك بنجاح🗑`', 1, 'md')
           end
end
return {  
patterns ={  
'^(mydel)$' ,
 '^(مسح رسائلي)$' 
 }, 

 run = cerner
}
