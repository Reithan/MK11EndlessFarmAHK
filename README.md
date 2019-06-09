# MK11EndlessFarmAHK
AHK Script for Automating Endless Tower Farming

This script will navigate to a selected mode and continually run battles with a selected character and build.

# Usage
Run the AHK script through AutoHotKey, or use the pre-compiled executable. If you place a link to MK11 named MK11 in the directory of the script, it will handle launching and keeping MK11 open for you. When MK11 is running and the active window, a small GUI element will appear in the top and bottom right corners.

Press F3 to enable/disable the script, or F4 to exit the script.

This will read the character.txt file, which should contain the character you wish to use on line 1, the build # on line 2, the mode you want to farm on line 3, and the difficulty level to use (if applicable), on line 4.

The name should be at least 4 letters, 3 in the case of Jax and Liu Kang, omitting any non-alphabetical characters (D'Vorah will be DVorah, and Sub-Zero would be SubZero).

The script will navigate to the chosen character and move right through available builds to the # on line two of your file. I.E: 1 would indicate your default build, 2 would move 1 clicks to the right, 3 would move 2 clicks, etc.

The modes available to choose from are:
* Novice
* Warrior
* Champion
* Survival
* Endless
* AIBattle

Difficulties are:
* VEasy
* Easy
* Medium
* Hard
* VHard

Additionally, character name, mode, and difficulty may be specified as "Random" to have the script randomly select each time it chooses. For a random build, set build # to 0.
Outside of Random mode, the script will also attempt to ensure that you've hit yout 5/5 AI Battle attacks for the day before going to your selected mode.

# Limitations
This script currently operates at a 1920 x 1080 resolution on the primary monitor only.

As this script monitors the active MK11 window and gives inputs to it, you cannot use anything else in the meantime, this is only useful for fully AFK farming, or watching videos on your second monitor while it farms.

The script currently recognizes main menu screens, AI battle screens, and Tower/Match UI screens. If it's run in any other section of the game, it will attempt to recover, but may not be able to.
