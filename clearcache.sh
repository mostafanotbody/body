#!/bin/bash 
 COUNTER=0
while [  $COUNTER -lt 5 ]; do
     rm -rf ~/.telegram-cli/data/sticker/*
     rm -rf ~/.telegram-cli/data/photo/*
     rm -rf ~/.telegram-cli/data/animation/*
     rm -rf ~/.telegram-cli/data/video/*
     rm -rf ~/.telegram-cli/data/audio/*
     rm -rf ~/.telegram-cli/data/voice/*
     rm -rf ~/.telegram-cli/data/temp/*
     rm -rf ~/.telegram-cli/data/thumb/*
     rm -rf ~/.telegram-cli/data/document/*
     rm -rf ~/.telegram-cli/data/profile_photo/*
     rm -rf ~/.telegram-cli/data/encrypted/*
   echo -e "     >>>>                       All Cache Cleared                             "
sleep 21600
#let COUNTER=COUNTER+1 
done
