local function pre_process(msg)
 if msg.content_.ID == "MessageUnsupported" and redis:get("mute-video-not"..msg.to.id) then
 tdcli.deleteMessages(msg.chat_id_, {[0] = tonumber(msg.id_)}) 
 end
end
local function run(msg, matches)
 if (matches[1] == "lock video-note" or matches[1] == "قفل فيديو سيلفي") and not redis:get("mute-video-not"..msg.to.id) and is_mod(msg) then
  hash = "mute-video-not"..msg.to.id
  redis:set(hash , true)
  tdcli.sendMessage(msg.to.id,msg.id_ ,0, "تم قفل ارسال فيديو سيلفي 🔐", 0, "md")
 elseif (matches[1] == "lock video-note" or matches[1] == "قفل فيديو سيلفي") and redis:get("mute-video-not"..msg.to.id) and is_mod(msg) then
  tdcli.sendMessage(msg.to.id,msg.id_ ,0, "قفل ارسال فيديو سيلفي مفعل من قبل 🔐", 0, "md")
 elseif matches[1] == "unlock video-note" or matches[1] == "فتح فيديو سيلفي" and not redis:get("mute-video-not"..msg.to.id) and is_mod(msg) then
  tdcli.sendMessage(msg.to.id,msg.id_ ,0, "تم الغاء قفل ارسال فيديو سيلفي 🔓", 0, "md")
 elseif matches[1] == "unlock video-note" or matches[1] == "فتح فيديو سيلفي" and redis:get("mute-video-not"..msg.to.id) and is_mod(msg) then
  redis:del("mute-video-not"..msg.to.id)
  tdcli.sendMessage(msg.to.id,msg.id_ ,0, "قفل ارسال فيديو سيلفي غير مفعل 🔓", 0, "md")
 end
end

return {
   patterns = {
      '^[/!#](lock vidoe-note)$',
      '^[/!#](unlock video-note)$',
	  '^(قفل فيديو سيلفي)$',
	  '^(فتح فيديو سيلفي)$',
 },
  run = run,
  pre_process = pre_process
}