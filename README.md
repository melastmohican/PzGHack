# Panzer General Hack, Editor 
Orinally written in Delphi for Windows 95

Readme from 1997:

1. Running PzGHack

You can put PzGHack in any directory on your hard drive. You may create shortcut the PzGHack.exe or run it directly from Start menu. Since PzGHack is Windows program it uses its file open 
dialogs to locate and open saved game files.

2. Basic Operation

I tried to make the interface as user friendly as possible. Everything is on a screen when you start program. There are two commands in File menu: Open and Save. Save is also 
available from toolbar thru disk icon. When you choose to open a saved game file common Windows file open dialog will appear. The you
can find your saved game files and choose one to open. Main screen is divided into three panels. In header there are some basic information about file like
file name and participants of the game. Below there two panels. In left you can select side you want to edit. Then click on unit you want to change and its description will appear in right window.

All changes are stored in file immediately after switching to another unit or when you change side.
You can also press disk icon to save unit record.
 
3. Effects of editing
There are no limits in editing any feature of unit. In theory you put Battleship on a truck and then put the this truck on a plane. Maybe there are values that program would 
reject so better make copy of you files before editing.

3.1 Experience
No side effects of changing this value.  

3.2. Strength
By default unit can have strength between 10 and 15 but editor will allow you to enter bigger values up to 255. Be careful, sometime game will crash when
you set strength larger than 15.

3.3 Fuel
No noticeable effects, all the way up to 255 fuel.  

3.4 Ammo
No noticeable effects, up to 255 ammo.

3.5 Entrenchment
Up to 255 ammo. Actually I cannot use that feature at all. Any ideas???

3.6 Movement.
Up to 255 movement points.

3.7 Position
However program will allow you to enter values greater than 255 (word is used to store position values) I really do not know what are limits of game map. The upper left corner 
of the map is listed as (1,0) (x position is 1, y position is 0).By changing these values, you can move any unit to any location! Better use values up to 255.

3.8 Prestige.  
After reaching a value of 65535, prestige reset to 0. 

4. Revision History
1.0 	Original version.  
1.01	Three-state mounting added: None, Transport, Carrier
1.10    Small bug with misplaced list removed. Renamed to PzGHack
