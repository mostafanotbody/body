function run(msg, matches)
		local text1 = matches[1]
        local text2 = matches[2]
		local url = "http://www.iloveheartstudio.com/-/p.php?t="..text1.."%20%EE%BB%AE%20"..text2.."&bc=FFC0CB&tc=000000&hc=ff0000&f=c&uc=true&ts=true&ff=PNG&w=500&ps=sq"
		 local  file = download_to_file(url,'love.webp')
			tdcli.sendPhoto(msg.to.id, 0, 0, 1, nil, file, "@m0nawa3a", dl_cb, nil)
	end

       


return {
  description = "تبدیل متن به لوگو",
  usage = {
    "/love text text: ساخت لوگو",
  },
  patterns = { 
"^love (.+) (.+)$",
"^قلب (.+) (.+)$",
  },
  run = run
}
-- by @sudo1
-- ch: @specialteam_ch
-- کپی بدون ذکر منبع حرام است.
    
