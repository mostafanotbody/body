
--Begin Fun.lua By @islamchanal1
--Special Thx To @To0fan
--------------------------------

local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
--------------------------------
local api_key = nil
local base_api = "https://maps.googleapis.com/maps/api"
--------------------------------
local function get_latlong(area)
	local api      = base_api .. "/geocode/json?"
	local parameters = "address=".. (URL.escape(area) or "")
	if api_key ~= nil then
		parameters = parameters .. "&key="..api_key
	end
	local res, code = https.request(api..parameters)
	if code ~=200 then return nil  end
	local data = json:decode(res)
	if (data.status == "ZERO_RESULTS") then
		return nil
	end
	if (data.status == "OK") then
		lat  = data.results[1].geometry.location.lat
		lng  = data.results[1].geometry.location.lng
		acc  = data.results[1].geometry.location_type
		types= data.results[1].types
		return lat,lng,acc,types
	end
end
--------------------------------
local function get_staticmap(area)
	local api        = base_api .. "/staticmap?"
	local lat,lng,acc,types = get_latlong(area)
	local scale = types[1]
	if scale == "locality" then
		zoom=8
	elseif scale == "country" then 
		zoom=4
	else 
		zoom = 13 
	end
	local parameters =
		"size=600x300" ..
		"&zoom="  .. zoom ..
		"&center=" .. URL.escape(area) ..
		"&markers=color:red"..URL.escape("|"..area)
	if api_key ~= nil and api_key ~= "" then
		parameters = parameters .. "&key="..api_key
	end
	return lat, lng, api..parameters
end
--------------------------------
local function get_weather(location)
	print("Finding weather in ", location)
	local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
	local url = BASE_URL
	url = url..'?q='..location..'&APPID=eedbc05ba060c787ab0614cad1f2e12b'
	url = url..'&units=metric'
	local b, c, h = http.request(url)
	if c ~= 200 then return nil end
	local weather = json:decode(b)
	local city = weather.name
	local country = weather.sys.country
	local temp = 'المدينة '..city..' حاليا '..weather.main.temp..' درجة\n____________________\n @islamchanal1 :)'
	local conditions = 'احوال الطقس الحالية : '
	if weather.weather[1].main == 'Clear' then
		conditions = conditions .. 'مشمس☀'
	elseif weather.weather[1].main == 'Clouds' then
		conditions = conditions .. 'غائم ☁☁'
	elseif weather.weather[1].main == 'Rain' then
		conditions = conditions .. 'ماطر ☔'
	elseif weather.weather[1].main == 'Thunderstorm' then
		conditions = conditions .. 'عاصف ☔☔☔☔'
	elseif weather.weather[1].main == 'Mist' then
		conditions = conditions .. 'غبار 💨'
	end
	return temp .. '\n' .. conditions
end
--------------------------------
local function calc(exp)
	url = 'http://api.mathjs.org/v1/'
	url = url..'?expr='..URL.escape(exp)
	b,c = http.request(url)
	text = nil
	if c == 200 then
    text = 'المجموع = '..b..'\n____________________\n @islamchanal1 :)'
	elseif c == 400 then
		text = b
	else
		text = 'Unexpected error\n'
		..'Is api.mathjs.org up?'
	end
	return text
end
--------------------------------
function exi_file(path, suffix)
    local files = {}
    local pth = tostring(path)
	local psv = tostring(suffix)
    for k, v in pairs(scandir(pth)) do
        if (v:match('.'..psv..'$')) then
            table.insert(files, v)
        end
    end
    return files
end
--------------------------------
function file_exi(name, path, suffix)
	local fname = tostring(name)
	local pth = tostring(path)
	local psv = tostring(suffix)
    for k,v in pairs(exi_file(pth, psv)) do
        if fname == v then
            return true
        end
    end
    return false
end
--------------------------------
function run(msg, matches) 
if is_banned(msg.from.id, msg.to.id) or is_gbanned(msg.from.id, msg.to.id) or is_silent_user(msg.from.id, msg.to.id) then
return false
end
	if matches[1]:lower() == "calc" or matches[1]:lower() == "حساب" and matches[2] then 
		if msg.to.type == "pv" then 
			return 
       end
		return calc(matches[2])
	end
--------------------------------
	if matches[1]:lower() == 'praytime' or matches[1]:lower() == 'azan' or matches[1]:lower() == 'مواعيد الصلاة' or matches[1]:lower() == 'اذان' then
		if matches[2] then
			city = matches[2]
		elseif not matches[2] then
			city = 'riyath'
		end
		local lat,lng,url	= get_staticmap(city)
		local dumptime = run_bash('date +%s')
		local code = http.request('http://api.aladhan.com/timings/'..dumptime..'?latitude='..lat..'&longitude='..lng..'&timezonestring=Asia/Tehran&method=7')
		local jdat = json:decode(code)
		local data = jdat.data.timings
		local text = 'المدينة: '..city
		text = text..'\nالصبح: '..data.Fajr
		text = text..'\nشروق الشمس: '..data.Sunrise
		text = text..'\nالظهر: '..data.Dhuhr
		text = text..'\nالعصر: '..data.Sunset
		text = text..'\nالمغرب: '..data.Maghrib
		text = text..'\nالعشاء: '..data.Isha
		text = text..'\n@islamchanal1\n'
		return tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
	end
--------------------------------
	if matches[1]:lower() == 'tophoto' or matches[1]:lower() == "تحويل لصورة" and msg.reply_id then
		function tophoto(arg, data)
			function tophoto_cb(arg,data)
				if data.content_.sticker_ then
					local file = data.content_.sticker_.sticker_.path_
					local secp = tostring(tcpath)..'/data/sticker/'
					local ffile = string.gsub(file, '-', '')
					local fsecp = string.gsub(secp, '-', '')
					local name = string.gsub(ffile, fsecp, '')
					local sname = string.gsub(name, 'webp', 'jpg')
					local pfile = 'data/photos/'..sname
					local pasvand = 'webp'
					local apath = tostring(tcpath)..'/data/sticker'
					if file_exi(tostring(name), tostring(apath), tostring(pasvand)) then
						os.rename(file, pfile)
						tdcli.sendPhoto(msg.to.id, 0, 0, 1, nil, pfile, "@islamchanal1", dl_cb, nil)
					else
						tdcli.sendMessage(msg.to.id, msg.id_, 1, '_اعد ارسال الملصق من جديد او غيره_', 1, 'md')
					end
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_هذا ليس ملصق_', 1, 'md')
				end
			end
            tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, tophoto_cb, nil)
		end
		tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_id }, tophoto, nil)
    end
--------------------------------
	if matches[1]:lower() == 'tosticker' or matches[1]:lower() == "تحويل لملصق" and msg.reply_id then
		function tosticker(arg, data)
			function tosticker_cb(arg,data)
				if data.content_.ID == 'MessagePhoto' then
					file = data.content_.photo_.id_
					local pathf = tcpath..'/data/photo/'..file..'_(1).jpg'
					local pfile = 'data/photos/'..file..'.webp'
					if file_exi(file..'_(1).jpg', tcpath..'/data/photo', 'jpg') then
						os.rename(pathf, pfile)
						tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, pfile, '@islamchanal1', dl_cb, nil)
					else
						tdcli.sendMessage(msg.to.id, msg.id_, 1, '_اعد ارسال الصورة او غيرها_', 1, 'md')
					end
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_هذه ليست صورة_', 1, 'md')
				end
			end
			tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, tosticker_cb, nil)
		end
		tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_id }, tosticker, nil)
    end
--------------------------------
	if matches[1]:lower() == 'weather' or matches[1]:lower() == "الطقس" then
		city = matches[2]
		local wtext = get_weather(city)
		if not wtext then
			wtext = 'المكان غير صحيح'
		end
		return wtext
	end
--------------------------------
	if matches[1]:lower() == 'time' or matches[1]:lower() == "الساعة" then
		local url , res = http.request('http://irapi.ir/time')
		if res ~= 200 then
			return "No connection"
		end
		local colors = {'blue','green','yellow','magenta','Orange','DarkOrange','red'}
		local fonts = {'mathbf','mathit','mathfrak','mathrm'}
		local jdat = json:decode(url)
		local url = 'http://latex.codecogs.com/png.download?'..'\\dpi{600}%20\\huge%20\\'..fonts[math.random(#fonts)]..'{{\\color{'..colors[math.random(#colors)]..'}'..jdat.ENtime..'}}'
		local file = download_to_file(url,'time.webp')
		tdcli.sendDocument(msg.to.id, 0, 0, 1, nil, file, '', dl_cb, nil)

	end
--------------------------------
if matches[1]:lower() == 'voice' or matches[1]:lower() == "الصوت" then
 local text = matches[2]
    textc = text:gsub(' ','.')
    
  if msg.to.type == 'pv' then 
      return nil
      else
  local url = "http://tts.baidu.com/text2audio?lan=ar&ie=UTF-8&text="..textc
  local file = download_to_file(url,'StePhBot.mp3')
 				tdcli.sendDocument(msg.to.id, 0, 0, 1, nil, file, '@islamchanal1', dl_cb, nil)
   end
end

 --------------------------------
	if matches[1]:lower() == "tr" or matches[1]:lower() == "ترجمة" then 
		url = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang='..URL.escape(matches[2])..'&text='..URL.escape(matches[3]))
		data = json:decode(url)
		return 'اللغة : '..data.lang..'\nالترجمة : '..data.text[1]..'\n____________________\n @islamchanal1 :)'
	end
--------------------------------
	if matches[1]:lower() == 'short' or matches[1]:lower() == "اختصار" then
		if matches[2]:match("[Hh][Tt][Tt][Pp][Ss]://") then
			shortlink = matches[2]
		elseif not matches[2]:match("[Hh][Tt][Tt][Pp][Ss]://") then
			shortlink = "https://"..matches[2]
		end
		local yon = http.request('http://api.yon.ir/?url='..URL.escape(shortlink))
		local jdat = json:decode(yon)
		local bitly = https.request('https://api-ssl.bitly.com/v3/shorten?access_token=f2d0b4eabb524aaaf22fbc51ca620ae0fa16753d&longUrl='..URL.escape(shortlink))
		local data = json:decode(bitly)
		local yeo = http.request('http://yeo.ir/api.php?url='..URL.escape(shortlink)..'=')
		local opizo = http.request('http://api.gpmod.ir/shorten/?url='..URL.escape(shortlink)..'&username=mersad565@gmail.com')
		local u2s = http.request('http://u2s.ir/?api=1&return_text=1&url='..URL.escape(shortlink))
		local llink = http.request('http://llink.ir/yourls-api.php?signature=a13360d6d8&action=shorturl&url='..URL.escape(shortlink)..'&format=simple')
		local text = ' 🌐الرابط الاصلي :\n'..check_markdown(data.data.long_url)..'\n\nتم اختصار الرابط في ست مواقع : \n》اختصار عبر bitly :\n___________________________\n'..check_markdown(data.data.url)..'\n___________________________\n》اختصار عبر yeo :\n'..check_markdown(yeo)..'\n___________________________\n》اختصار عبر opizo :\n'..check_markdown(opizo)..'\n___________________________\n》اختصار عبر u2s :\n'..check_markdown(u2s)..'\n___________________________\n》اختصار عبر llink : \n'..check_markdown(llink)..'\n___________________________\n》اختصار عبر yon : \nyon.ir/'..check_markdown(jdat.output)..'\n____________________\n @islamchanal1 :)'
		return tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
	end
--------------------------------
	if matches[1]:lower() == "sticker" or matches[1]:lower() == "الملصق" then 
		local eq = URL.escape(matches[2])
		local w = "500"
		local h = "500"
		local txtsize = "100"
		local txtclr = "ff2e4357"
		if matches[3] then 
			txtclr = matches[3]
		end
		if matches[4] then 
			txtsize = matches[4]
		end
		if matches[5] and matches[6] then 
			w = matches[5]
			h = matches[6]
		end
		local url = "https://assets.imgix.net/examples/clouds.jpg?blur=150&w="..w.."&h="..h.."&fit=crop&txt="..eq.."&txtsize="..txtsize.."&txtclr="..txtclr.."&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=ff6598cc"
		local receiver = msg.to.id
		local  file = download_to_file(url,'text.webp')
		tdcli.sendDocument(msg.to.id, 0, 0, 1, nil, file, '', dl_cb, nil)
	end
--------------------------------
	if matches[1]:lower() == "photo" or matches[1]:lower() == "الصورة" then 
		local eq = URL.escape(matches[2])
		local w = "500"
		local h = "500"
		local txtsize = "100"
		local txtclr = "ff2e4357"
		if matches[3] then 
			txtclr = matches[3]
		end
		if matches[4] then 
			txtsize = matches[4]
		end
		if matches[5] and matches[6] then 
			w = matches[5]
			h = matches[6]
		end
		local url = "https://assets.imgix.net/examples/clouds.jpg?blur=150&w="..w.."&h="..h.."&fit=crop&txt="..eq.."&txtsize="..txtsize.."&txtclr="..txtclr.."&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=ff6598cc"
		local receiver = msg.to.id
		local  file = download_to_file(url,'text.jpg')
		tdcli.sendPhoto(msg.to.id, 0, 0, 1, nil, file, "@islamchanal1", dl_cb, nil)
	end
--------------------------------
if matches[1]:lower() == "me" or matches[1] == "انا"  then
if msg.from.username then
username = '@'..check_markdown(msg.from.username)
else
username = "لا يوجد"
end
  return "`اسم القروب :` _"..msg.to.title.."_\n`ايدي:` *"..msg.from.id.."*\n`المعرف:` "..username
end
--------------------------------
if matches[1]:lower() == 'clean' or matches[1] == 'تنظيف' and matches[2]:lower() == 'blacklist' or matches[2] == 'المطرودين' then
    if not is_mod(msg) then
      return -- «Mods allowed»
    end
	
    local function cleanbl(ext, res)
      if tonumber(res.total_count_) == 0 then -- «Blocklist is empty or maybe Bot is not group's admin»
        return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '⚠️ _قائمة المطرودين من المجموعة فارغة_ !', 1, 'md')
      end
      local x = 0
      for x,y in pairs(res.members_) do
        x = x + 1
        tdcli.changeChatMemberStatus(ext.chat_id, y.user_id_, 'Left', dl_cb, nil) -- «Changing user status to left, removes user from blocklist»
      end
      return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '✅ _ تم تنظيف قائمة المطرودين من المجموعة 🗑_ !', 1, 'md')
    end
	
    return tdcli.getChannelMembers(msg.to.id, 0, 'Kicked', 200, cleanbl, {chat_id = msg.to.id, msg_id = msg.id}) -- «Gets channel blocklist»
  end
--------------------------------
if matches[1] == 'addkick' or matches[1] == 'اضافة للمطرودين' and is_owner(msg) then
        if gp_type(msg.to.id) == "channel" then
            tdcli.getChannelMembers(msg.to.id, 0, "Kicked", 200, function (i, naji)
                for k,v in pairs(naji.members_) do
                    tdcli.addChatMember(i.chat_id, v.user_id_, 50, dl_cb, nil)
                end
            end, {chat_id=msg.to.id})
            return "`الاعضاء المحظورين هم مسبقا في القائمة`"
        end
        return "`في مجموعات السوبر فقط`"
    end
--------------------------------
local data = {
"_چخه_",
"_هن_",
"_انلاینم_",
"*online*",
"*pong*",
"*Im online ;D*"
}
if matches[1]:lower() == "ping" or matches[1] == "ربات" then
return data[math.random(#data)]
end
--------------------------------
if matches [1] == 'setnerkh' or matches[1] == 'تنظیم نرخ' then 
if not is_admin(msg) then 
return '_You are Not_ *Moderator*' 
end 
local nerkh = matches[2] 
redis:set('bot:nerkh',nerkh) 
return 'نرخ باموفقیت ثبت گردید😐❤️' 
end 
if matches[1] == 'nerkh' or matches[1] == 'نرخ' then 
if not is_mod(msg) then 
return 
end 
    local hash = ('bot:nerkh') 
    local nerkh = redis:get(hash) 
    if not nerkh then 
    return 'نرخ ثبت نشده📛' 
    else 
     tdcli.sendMessage(msg.chat_id_, 0, 1, nerkh, 1, 'html') 
    end 
    end 
if matches[1]== "delnerkh" or matches[1] == 'پاک کردن نرخ' then 
if not is_admin(msg) then 
return '_You are Not_ *Moderator*' 
end 
    local hash = ('bot:nerkh') 
    redis:del(hash) 
return 'نرخ پاک شد🗑' 
end 
--------------------------------
if matches[1]:lower() == 'echo' or matches[1] == 'الرد' then
local pext = matches[2]
tdcli.sendMessage(msg.to.id, 0,1, pext,1,'html')
end
--------------------------------
if matches[1]:lower() == 'edit' or matches[1] == 'ادیت' and msg.reply_to_message_id_ ~= 0 and is_sudo(msg) then
local Text = matches[2]
tdcli.editMessageText(msg.to.id, msg.reply_to_message_id_, nil, Text, 1, 'md')
end

if matches[1]:lower() == 'edit' or matches[1] == 'ادیت' and msg.reply_to_message_id_ ~= 0 and is_sudo(msg) then
local tExt = matches[2]
tdcli.editMessageCaption(msg.to.id, msg.reply_to_message_id_, nil, tExt)
end
end
--------------------------------
return {               
	patterns = {
	"^([Ww]eather) (.*)$",
	"^([Cc]alc) (.*)$",
	"^([Tt]ime)$",
	"^([Tt]ophoto)$",
	"^([Tt]osticker)$",
	"^([Vv]oice) +(.*)$",
	"^([Pp]raytime) (.*)$",
	"^([Pp]raytime)$",
	"^([Aa]zan) (.*)$",
	"^([Aa]zan)$",
	"^([Tt]r) ([^%s]+) (.*)$",
	"^([Ss]hort) (.*)$",
	"^([Pp]hoto) (.+)$",
	"^([Ss]ticker) (.+)$",
	"^([Mm]e)$",
	"^([Cc]lean) ([Bb]lacklist)$",
    "^([Aa]ddkick)$",
    "^([Pp]ing)$",
    "^([Dd]elnerkh)$",
    "^([Ss]etnerkh) (.*)$",
	"^([Nn]erkh)$",
	"^([Ee]dit) (.*)$",
	"^([Ee]dit) (.*)$",
	"^([Ee]cho) (.*)$",
  "^(الطقس) (.*)$",
	"^(حساب) (.*)$",
	"^(الساعة)$",
	"^(تحويل لصورة)$",
	"^(تحويل لملصق)$",
--	"^(الصوت) +(.*)$",
	"^(مواعيد الصلاة) (.*)$",
	"^(توقيت اذان)$",
	"^(اذان) (.*)$",
	"^(اذان)$",
	"^(ترجمة) ([^%s]+) (.*)$",
	"^(اختصار) (.*)$",
	"^(الصورة) (.+)$",
	"^(الملصق) (.+)$",
    "^(انا)$",
	"^(تنظيف) (المطرودين)$",
--	"^(ربات)$",
    "^(اضافة للمطرودين)$",
--	"^(نرخ)$",
--    "^(تنظیم نرخ) (.*)$",
--    "^(پاک کردن نرخ)$",
--    "^(ادیت) (.*)$",
--    "^(ادیت) (.*)$",
    "^(الرد) (.*)$"	
},
	run = run,
	}

--#by @islamchanal1 :)
