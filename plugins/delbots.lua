--Start By Amu Sezar or @ImFazel

local function run(msg, matches) 
if matches[1] == 'cleanbot' or 'طرد البوتات' then 
  function clbot(arg, data) 
    for k, v in pairs(data.members_) do 
      kick_user(v.user_id_, msg.to.id) 
   end 
    tdcli.sendMessage(msg.to.id, msg.id, 1, '`تم طرد جميع بوتات API`', 1, 'md') 
  end 
  tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, clbot, nil) 
  end 
end 

return { 

patterns ={ 
		"^([Cc]leanbot)$",
"^(طرد البوتات)$",
},
	run = run,
	}
 --End By Amu Sezar or @ImFazel
 -- Channel @TeleSezarTeaM
 --Please Not Clean This Text