#!/bin/bash
COUNTER=1
while(true) do
./adam1.sh
curl "https://api.telegram.org/bot252710146:AAHnqrKPc97-pD7AREaO6rDeuSb-Cg7gztM/sendmessage" -F "chat_id=157059515" -F "text=#ExtraBeyond-#Reloaded-${COUNTER}-!times"
let COUNTER=COUNTER+1 
done
