local function run(msg,matches)
  local key = 'chat:gp'..msg.to.id
  if matches[1] == '+' and is_mod(msg) then
    redis:hset(key,matches[2],matches[3])
    return "`تم اضافة رد جديد ✅` \n\n`الكلمة :` _"..matches[2].."\n_`الرد :` _"..matches[3].."_"
  end
  
  if matches[1] == '-' and is_mod(msg) then
    redis:hdel(key,matches[2])
    return "تم حذف الكلمة  _"..matches[2].."_ من قائمة الردود"
  end
  
  if redis:hget(key,matches[1]) then
    return redis:hget(key,matches[1])
  end
end
 
return {
  patterns = {
    "^اضافة رد (+) (.*) / (.*)$",
    "^حذف رد (-) (.*)$",
    "^(.*)$"
    },
  run = run
}