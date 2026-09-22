# Rage-of-Mages-2-Astral-Ascension
A mod for Rage of Mages 2 GOG edition

### Disclaimer ###
All the modifications were done, by using help from AI, so use these modifications at your own risk. If you want more clarification about anything in this repo, you should probably ask an LLM to explain it.

### Table of contents ###
1. [Increased Stat and Skill limits](https://github.com/Rage-of-Mages-Astral-Ascension/Rage-of-Mages-2-Astral-Ascension/tree/main#1-increased-statskill-limits)
2. [A workaround for playing TCP/IP multiplayer in Virtual Networks (like Hamachi/Radmin)](https://github.com/Rage-of-Mages-Astral-Ascension/Rage-of-Mages-2-Astral-Ascension/tree/main#2-tcpip-multiplayer-workaround)
3. [More detailed look at the .exe modifications](https://github.com/Rage-of-Mages-Astral-Ascension/Rage-of-Mages-2-Astral-Ascension/tree/main#3-detailed-info-about-the-exe-hex-edit)

## 1. Increased Stat/Skill Limits ##
The files include a modified allods2.exe (GOG version) that includes:
- Stat caps for all characters increased by 5 - for example normally a male warrior can raise his Body stat to a max of 52 (using Potions), in this mod his max Body stat would be 57
- Skill caps for all characters increased by 50 - normally all characters can level their skill caps to a max of 100, but with this mod the max is 150

## 2. TCP/IP multiplayer workaround ##
I tried a lot to get RoM2 running TCP/IP using Hamachi/Radmin on Win 10, but it just keeps defaulting to the standard Ethernet adapter, if you have a real IP, this shouldn't be a problem for you, but in case you want to use Hamachi/Radmin to play with friends, there wasn't much luck.

Included in the dpfix folder is a script (install1.ps) that renames your original smackw32.dll and adds a custom smackw32.dll (rerouting video to the original) that tries to rewrite all traffic to a specific IP (the host's standard IP address - you can check it online with "Whats my IP") to a provided virtual address (i.e. his Hamachi/Radmin IP) - this should allow you to force traffic to go through Hamachi/Radmin allowing you to play with them in TCP/IP. 
- Only connecting people should need to use this script, as the host should be listening for any connection.
- You may need to rerun this script before any network play sessions as patched dll's may reset in the meantime.

Run the Powershell script using this command:
```
powershell -ExecutionPolicy Bypass -File .\install.ps1 -GameDir "<full path to your RoM2 folder>"
```
For example if you installed RoM in "C:\Rage of Mages II", this should be your script:
```
powershell -ExecutionPolicy Bypass -File .\install.ps1 -GameDir "C:\Rage of Mages II"
```
Before installing you should fill in dpfix.ini:
- **From** - Public IP of the host
- **To** - the Virtual (Hamachi/Radmin) IP of the host

The script also places the following in your RoM2 folder:
- dpfix.ini
- dpfix.log - the modified smackw32.dll logs what it does in this file

## 3. Detailed info about the .exe Hex edit ##
I include this info only if you care about what hex edits were made to the exe so you can modify them and make your own edits. I used CheatEngine to find the in memory addresses and then modified the exe using HexEdit.
Here are the in-memory addresses of the changes:
- 005136A5 - contains the values for the characters Stat caps
- 00512C63 - contains the check for the max value of skills

Modifying these in the actual exe using HexEdit was a bit trickier as if you overwrite instructions with longer ones you start writing over the next instruction. Where the modified instructions were longer I used code caves - jumps to an empty place in the code where you can fit more instructions.



