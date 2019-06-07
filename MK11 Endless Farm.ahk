#NoEnv
#SingleInstance ignore
#IfWinActive Mortal Kombat 11

; Define Character List
CharacterSelect := {}
CharacterSelect["Jax"]  := [3,0,0,0]
CharacterSelect["Liu"]  := [2,0,0,1]
CharacterSelect["Scor"] := [0,0,0,0]
CharacterSelect["Noob"] := [1,0,0,0]
CharacterSelect["Sub-"] := [0,1,0,0]
CharacterSelect["Bara"] := [2,0,0,0]
CharacterSelect["John"] := [1,0,1,0]
CharacterSelect["Kaba"] := [1,0,0,1]
CharacterSelect["Skar"] := [1,0,0,2]
CharacterSelect["Jacq"] := [0,2,0,0]
CharacterSelect["Raid"] := [3,0,0,0]
CharacterSelect["Kita"] := [3,0,0,1]
CharacterSelect["Kung"] := [0,2,0,1]
CharacterSelect["Jade"] := [0,1,0,1]
CharacterSelect["Erro"] := [2,0,0,2]
CharacterSelect["Dvor"] := [3,0,0,2]
CharacterSelect["Kota"] := [0,2,0,2]
CharacterSelect["Koll"] := [3,0,0,3]
CharacterSelect["Gera"] := [2,0,0,3]
CharacterSelect["Cetr"] := [2,0,0,4]
CharacterSelect["Sony"] := [2,0,1,0]
CharacterSelect["Cass"] := [3,0,1,0]
CharacterSelect["Fros"] := [3,0,2,0]
CharacterSelect["Shao"] := [2,0,2,0]

; Get Character to use from file
file := FileOpen("character.txt", "r")
charName := file.ReadLine()
charBuild := file.ReadInt() - 49

; Pre-Load Images for Search
class ScreenCheck
{
	__New(file, coords, range := 0)
	{
		this.pngHandle := LoadPicture(file)
		this.screenCoords := coords
		this.shadeRange := range
		return this
	}
	
	check()
	{
		CoordMode, Pixel, Relative
		ImageSearch, OutputVarX, OutputVarY, this.screenCoords[1], this.screenCoords[2], this.screenCoords[3], this.screenCoords[4], % "*" . this.shadeRange . " HBITMAP:*" . this.pngHandle
		if(ErrorLevel = 2)
			MsgBox IMAGESEARCH ERROR!
		return ErrorLevel = 0
	}
	
	pngHandle := 0
	screenCoords := [0,0,0,0]
	shadeRange := 0
}


ScreenChecks := {}
ScreenChecks["skipRewardsButton"] := new ScreenCheck("ImageKeys\SKIP REWARDS Button.png", [250, 1000, 450, 1050])
ScreenChecks["skipButton"] := new ScreenCheck("ImageKeys\SKIP Button.png", [960, 1020, 1060, 1070])
ScreenChecks["pauseHeader"] := new ScreenCheck("ImageKeys\PAUSE Header.png", [230, 110, 500, 175])
ScreenChecks["kontinueButton1"] := new ScreenCheck("ImageKeys\KONTINUE Button1.png", [800, 825, 1130, 1010], 60)
ScreenChecks["kontinueButton2"] := new ScreenCheck("ImageKeys\KONTINUE Button2.png", [910, 1020, 1090, 1065])
ScreenChecks["kontinueButton3"] := new ScreenCheck("ImageKeys\KONTINUE Button3.png", [910, 1020, 1070, 1065])
ScreenChecks["vsBadge"] := new ScreenCheck("ImageKeys\VS Badge.png", [525, 725, 675, 875])
ScreenChecks["klassicHeader1"] := new ScreenCheck("ImageKeys\KLASSIC Header1.png", [130, 20, 300, 80])
ScreenChecks["klassicHeader2"] := new ScreenCheck("ImageKeys\KLASSIC Header2.png", [130, 20, 300, 80])
ScreenChecks["kombatKardFooter"] := new ScreenCheck("ImageKeys\KOMBAT KARD Footer.png", [155, 1030, 360, 1080])
ScreenChecks["endlessHeader"] := new ScreenCheck("ImageKeys\ENDLESS Header.png", [1570, 110, 1700, 150])
ScreenChecks["loadingBarTip"] := new ScreenCheck("ImageKeys\LOADING BAR tip.png", [500, 850, 600, 1080])
ScreenChecks["konquerHeader"] := new ScreenCheck("ImageKeys\KONQUER Header.png", [335, 120, 485, 160])
ScreenChecks["notKonquerHeader"] := new ScreenCheck("ImageKeys\NOT KONQUER Header.png", [335, 120, 485, 160])
ScreenChecks["konquerBadge"] := new ScreenCheck("ImageKeys\KONQUER Badge.png", [375, 600, 545, 655], 100)
ScreenChecks["mainMenuBadge"] := new ScreenCheck("ImageKeys\MAIN MENU Badge.png", [920, 1010, 1010, 1070], 60)
ScreenChecks["towersBadge"] := new ScreenCheck("ImageKeys\TOWERS Badge.png", [1050, 600, 1240, 655], 100)
ScreenChecks["pressAnyBadge"] := new ScreenCheck("ImageKeys\PRESS ANY Badge.png", [920, 640, 1010, 840], 100)

; Setup GUI
Gui, StatusGui:New, +AlwaysOnTop -Caption +Disabled +ToolWindow
Gui, Show, W200 H40 X0 Y0, Hide StatusGui
prevStatus := "Matches Played 0000 (0000:0000)`n[Disabled] Run 0000  |  Best 0000"
Gui, StatusGui:Add, Text, vStatus, %prevStatus%

bottomHeight := A_ScreenHeight - 40
Gui, TooltipGui:New, +AlwaysOnTop -Caption +Disabled +ToolWindow
Gui, Show, X0 Y%bottomHeight% W100 H40, Hide TooltipGui
Gui, TooltipGui:Add, Text, , F3: Toggle Script`nF4: Quit

; Variables
guiActive := true
WasMatchLoading := false
IsMatchStarted := false
IsEnabled := true
MatchesPlayed := 0
Wins := 0
Losses := 0
Run := 0
BestRun := 0

Loop {
	if(Run > BestRun) {
		BestRun := Run
	}
	winsAndLosses := "(" . Wins . ":" . Losses . ")"
	args := [MatchesPlayed, winsAndLosses, Run, BestRun]
	statusText := "Matches Played " . Format("{:4d} {:-11s}`n" . (IsEnabled ? "[Enabled]" : "[Disabled]") . " Run {:4d}  |  Best {:4d}", args*)
	if(prevStatus != statusText) {
		GuiControl, StatusGui:, Status, %statusText%
		prevStatus := statusText
	}
	if (guiActive && !WinActive("Mortal Kombat 11")) {
		Gui, StatusGui:Hide
		Gui, TooltipGui:Hide
		guiActive := false
	} else if(!guiActive && WinActive("Mortal Kombat 11")) {
		Gui, StatusGui:Show, NoActivate
		Gui, TooltipGui:Show, NoActivate
		guiActive := true
	}

	If (!IsEnabled) {
		Sleep, 500
		continue
	}
	
	if (!WinActive("Mortal Kombat 11")) {
		WinActivate Mortal Kombat 11
		if (!WinActive("Mortal Kombat 11")) {
			Process, Exist, Mortal Kombat 11
			if (!ErrorLevel && FileExist("MK11.lnk")) {
				WasMatchLoading := false
				IsMatchStarted := false
				Run := 0
				Sleep, 5000
				Run, MK11.lnk
				Process, Wait, Mortal Kombat 11, 10
			}
			continue
		}
	}
	
	CoordMode, Pixel, Relative
	; Get the mouse out of the way
	MouseGetPos, mouseX, mouseY
	if(mouseX != 1920 || mouseY != 1080) {
		MouseMove, 1920, 1080, 0
		Sleep, 33
	}
	
	; Can we skip rewards
	if (ScreenChecks["skipRewardsButton"].check()) {
		sendKeyPress("J")
		Sleep, 500
	   continue
	}
	
	; Can we skip to kontinue
	if (ScreenChecks["skipButton"].check()) {
		sendKeyPress("Enter")
		continue
	}

	; Are we on the tower climb screen
	if (ScreenChecks["vsBadge"].check()) {
		; delay to ensure input is active
		Sleep, 500
		; Start Tower Fight
		sendKeyPress("Enter")
		Sleep, 500
		if (IsMatchStarted) {
			++Wins
			++MatchesPlayed
			++Run
			IsMatchStarted := false
		}
		continue
	}
	
	InCharSelect := false
	InKlassicMenu := ScreenChecks["klassicHeader1"].check()
	if (!InKlassicMenu) {
		InKlassicMenu := ScreenChecks["klassicHeader2"].check()
		if(InKlassicMenu) {
			InCharSelect := !ScreenChecks["kombatKardFooter"].check()
		}
	}
	InEndlessTower := InKlassicMenu && ScreenChecks["endlessHeader"].check()
	
	if (InKlassicMenu) {
		if (IsMatchStarted) {
			++Losses
			++MatchesPlayed
			Run = 0
			IsMatchStarted := false
		}
		if (!InEndlessTower) {
			if (InCharSelect) {
				; Wrong tower selected
				sendKeyPress("Esc")
				Sleep, 2000
				continue
			} else {
				; Wrong tower hovered
				sendKeyPress("Left")
				continue
			}
		} else if (!InCharSelect) {
			sendKeyPress("Enter")
			Sleep, 1000
			continue
		} else {
			selectCharacter(charName, charBuild)
			; Delay for initial Tower loading
			Sleep, 2000
			continue
		}
	}	

	; Is the game paused
	if (ScreenChecks["pauseHeader"].check()) {
		sendKeyPress("Esc")
		Sleep, 500
		continue
	}
	
	IsMatchLoading := ScreenChecks["loadingBarTip"].check()
	if (!IsMatchLoading && WasMatchLoading) {
		Sleep, 2000
		; Skip Intros
		sendKeyPress("Enter")
		Sleep, 500
		IsMatchStarted := true
		WasMatchLoading := false
		continue
	}
	WasMatchLoading := IsMatchLoading

	CanKontinue := ScreenChecks["kontinueButton2"].check() || ScreenChecks["kontinueButton3"].check() || ScreenChecks["kontinueButton1"].check()
	if (CanKontinue) {
		sendKeyPress("Enter")
		Sleep, 500
		continue
	}

	if (ScreenChecks["mainMenuBadge"].check()) {
		if (ScreenChecks["konquerHeader"].check()) {
			if (ScreenChecks["towersBadge"].check()) {
				sendKeyPress("Enter")
				Sleep, 500
				continue
			} else {
				sendKeyPress("Right")
				Sleep, 750
				continue
			}
		}
		if (ScreenChecks["notKonquerHeader"].check()) {
			sendKeyPress("Q")
			continue
		}	
		if (ScreenChecks["konquerBadge"].check()) {
			sendKeyPress("Enter")
			Sleep, 500
			continue
		} else {
			sendKeyPress("Left")
			Sleep, 750
			continue
		}
		continue
	}

	if (ScreenChecks["pressAnyBadge"].check()) {
		sendKeyPress("Enter")
		Sleep, 2000
		continue
	}
}

F3::IsEnabled := !IsEnabled

F4::ExitApp

selectCharacter(name, build) {
	global CharacterSelect
	
	; Find character data
	selected := false
	StringLower, title_name, name, T
	Loop, 2 {
		selected := CharacterSelect[SubStr(title_name,1,A_Index+2)]
		if (selected)
			break
	}
	if(!selected) {
		MsgBox ERROR: Unknown Character
		ExitApp
	}
	
	MsgBox % "Name: " . title_name . "Right: " . selected[1]
	; Navigate to character
	Loop % selected[1] {
		sendKeyPress("Right")
	}	
	Loop % selected[2] {
		sendKeyPress("Left")
	}	
	Loop % selected[3] {
		sendKeyPress("Up")
	}	
	Loop % selected[4] {
		sendKeyPress("Down")
	}
	
	; Select character
	sendKeyPress("Enter")
	
	; Select build
	Loop, %build% {
		sendKeyPress("Right")
	}
	
	; Turn on AI
	sendKeyPress("A")
	; Lock in
	sendKeyPress("Enter")
}

sendKeyPress(key) {
	Send, {%key% down}
	Sleep, 33
	Send, {%key% up}
	Sleep, 33
}