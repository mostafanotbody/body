--start by edit by @mohammadrezajiii
local datebase = {
  "وعليكم السلام ورحمة الله وبركاته",
  "وعليكم السلام",
  }
local function run(msg, matches) 
return datebase[math.random(#datebase)]
end
return { 
  patterns = { 
"^السلام عليكم",
"^السلام عليكم",
  }, 
  run = run 
}
--end by edit by @mohammadrezajiii
--Channel 
