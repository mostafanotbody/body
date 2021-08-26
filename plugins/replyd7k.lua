--start by edit by @mohammadrezajiii
local datebase = {
  "دوووم الضحكة يا رب ❤️ ",
  "دوووم كل يوم ☺️ ",
  }
local function run(msg, matches) 
return datebase[math.random(#datebase)]
end
return { 
  patterns = { 
"^😂😂😂",
"^😂😂😂",
  }, 
  run = run 
}
--end by edit by @mohammadrezajiii
--Channel 
