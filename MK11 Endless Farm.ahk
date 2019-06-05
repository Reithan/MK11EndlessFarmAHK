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
;skipRewardsButton := LoadPicture("ImageKeys\SKIP REWARDS Button.png")
skipButton := LoadPicture("ImageKeys\SKIP Button.png")
pauseHeader := LoadPicture("ImageKeys\PAUSE Header.png")
kontinueButton1 := LoadPicture("ImageKeys\KONTINUE Button1.png")
kontinueButton2 := LoadPicture("ImageKeys\KONTINUE Button2.png")
kontinueButton3 := LoadPicture("ImageKeys\KONTINUE Button3.png")
vsBadge := LoadPicture("ImageKeys\VS Badge.png")
klassicHeader1 := LoadPicture("ImageKeys\KLASSIC Header1.png")
klassicHeader2 := LoadPicture("ImageKeys\KLASSIC Header2.png")
kombatKardFooter := LoadPicture("ImageKeys\KOMBAT KARD Footer.png")
endlessHeader := LoadPicture("ImageKeys\ENDLESS Header.png")
loadingBarTip := LoadPicture("ImageKeys\LOADING BAR tip.png")
konquerHeader := LoadPicture("ImageKeys\KONQUER Header.png")
mainMenuBadge := LoadPicture("ImageKeys\MAIN MENU Badge.png")
towersBadge := LoadPicture("ImageKeys\TOWERS Badge.png")

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
IsEnabled := false
MatchesPlayed := 0
Wins := 0
Losses := 0
Run := 0
BestRun := 0

Loop {
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
			IsEnabled = false
			continue
		}
	}
	
	CoordMode, Pixel, Relative
	
	; Skipping rewards doesn't work right now
	;ImageSearch, OutputVarX, OutputVarY, 250, 1000, 450, 1050, *0 HBITMAP:*%skipRewardsButton%
	;CanSkipRewards := ErrorLevel = 0
	;
	;if (CanSkipRewards) {
	;	Send, {J down}
	;	Sleep, 33
	;	Send, {J up}
	;	Sleep, 500
	;   continue
	;}
	
	ImageSearch, OutputVarX, OutputVarY, 960, 1020, 1060, 1070, *0 HBITMAP:*%skipButton%
	CanSkip := ErrorLevel = 0
	
	if (CanSkip) {
		Send, {Enter down}
		Sleep, 33
		Send, {Enter up}
		Sleep, 33
		continue
	}

	ImageSearch, OutputVarX, OutputVarY, 525, 725, 675, 875, *0 HBITMAP:*%vsBadge%
	IsTowerActive := ErrorLevel = 0

	if (IsTowerActive) {
		; delay to ensure input is active
		Sleep, 500
		; Start Tower Fight
		Send, {Enter down}
		Sleep, 33
		Send, {Enter up}
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
	ImageSearch, OutputVarX, OutputVarY, 130, 20, 300, 80, *0 HBITMAP:*%klassicHeader1%
	InKlassicMenu := ErrorLevel = 0
	if (!InKlassicMenu) {
		ImageSearch, OutputVarX, OutputVarY, 130, 20, 300, 80, *0 HBITMAP:*%klassicHeader2%
		InKlassicMenu := ErrorLevel = 0
		if(InKlassicMenu) {
			ImageSearch, OutputVarX, OutputVarY, 155, 1030, 360, 1080, *0 HBITMAP:*%kombatKardFooter%
			InCharSelect := ErrorLevel != 0	
		}
	}
	ImageSearch, OutputVarX, OutputVarY, 1570, 110, 1700, 150, *0 HBITMAP:*%endlessHeader%
	InEndlessTower := InKlassicMenu && ErrorLevel = 0
	
	if (InKlassicMenu) {
		if (IsMatchStarted) {
			++Losses
			++MatchesPlayed
			if(Run > BestRun) {
				BestRun := Run
			}
			Run = 0
			IsMatchStarted := false
		}
		if (!InEndlessTower) {
			if (InCharSelect) {
				; Wrong tower selected
				Send, {Esc down}
				Sleep, 33
				Send, {Esc up}
				Sleep, 2000
				continue
			} else {
				; Wrong tower hovered
				Send, {Left down}
				Sleep, 33
				Send, {Left up}
				Sleep, 33
				continue
			}
		} else if (!InCharSelect) {
			Send, {Enter down}
			Sleep, 33
			Send, {Enter up}
			Sleep, 1000
			continue
		} else {
			selectCharacter(charName, charBuild)
			; Turn on AI
			Send, {A down}
			Sleep, 33
			Send, {A up}
			Sleep, 33
			; Lock In
			Send, {Enter down}
			Sleep, 33
			Send, {Enter up}
			; Delay for initial Tower loading
			Sleep, 2000
			continue
		}
	}	

	ImageSearch, OutputVarX, OutputVarY, 230, 110, 500, 175, *0 HBITMAP:*%pauseHeader%
	IsPaused := ErrorLevel = 0
	
	if (IsPaused) {
		Send, {Esc down}
		Sleep, 33
		Send, {Esc up}
		Sleep, 500
		continue
	}
	
	ImageSearch, OutputVarX, OutputVarY, 500, 850, 600, 1080, *0 HBITMAP:*%loadingBarTip%
	IsMatchLoading := ErrorLevel = 0
	
	if (!IsMatchLoading && WasMatchLoading) {
		Sleep, 2000
		; Skip Intros
		Send, {Enter down}
		Sleep, 33
		Send, {Enter up}
		Sleep, 500
		IsMatchStarted := true
		WasMatchLoading := false
		continue
	}
	WasMatchLoading := IsMatchLoading

	ImageSearch, OutputVarX, OutputVarY, 910, 1020, 1090, 1065, *0 HBITMAP:*%kontinueButton2%
	CanKontinue := ErrorLevel = 0
	if(!CanKontinue) {
		ImageSearch, OutputVarX, OutputVarY, 910, 1020, 1070, 1065, *0 HBITMAP:*%kontinueButton3%
		CanKontinue := ErrorLevel = 0
	}
	if(!CanKontinue) {
		ImageSearch, OutputVarX, OutputVarY, 800, 825, 1130, 1010, *60 HBITMAP:*%kontinueButton1%
		CanKontinue := ErrorLevel = 0
	}	
	
	if (CanKontinue) {
		Send, {Enter down}
		Sleep, 33
		Send, {Enter up}
		Sleep, 500
		continue
	}

	ImageSearch, OutputVarX, OutputVarY, 1660, 940, 1760, 1010, *0 HBITMAP:*%mainMenuBadge%
	IsMainMenu := ErrorLevel = 0
	if (IsMainMenu) {
		ImageSearch, OutputVarX, OutputVarY, 335, 120, 485, 160, *0 HBITMAP:*%konquerHeader%
		OnKonquer := ErrorLevel = 0
		if (OnKonquer) {
			ImageSearch, OutputVarX, OutputVarY, 1050, 600, 1240, 655, *100 HBITMAP:*%towersBadge%
			if (ErrorLevel = 2)
				MsgBox Oops
			OnTowers := ErrorLevel = 0
			if (OnTowers) {
				Send, {Enter down}
				Sleep, 33
				Send, {Enter up}
				Sleep, 33
				continue
			} else {
				Send, {Right down}
				Sleep, 33
				Send, {Right up}
				Sleep, 500
				continue
			}
		} else {
			Send, {Q down}
			Sleep, 33
			Send, {Q up}
			Sleep, 33
			continue
		}
	}
}

F3::IsEnabled := !IsEnabled

F4::ExitApp

selectCharacter(name, build) {
	global CharacterSelect
	
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
	Loop % selected[1] {
		Send, {Right down}
		Sleep, 33
		Send, {Right up}
		Sleep, 33
	}	
	Loop % selected[2] {
		Send, {Left down}
		Sleep, 33
		Send, {Left up}
		Sleep, 33
	}	
	Loop % selected[3] {
		Send, {Up down}
		Sleep, 33
		Send, {Up up}
		Sleep, 33
	}	
	Loop % selected[4] {
		Send, {Down down}
		Sleep, 33
		Send, {Down up}
		Sleep, 33
	}	
	Send, {Enter down}
	Sleep, 33
	Send, {Enter up}
	Sleep, 33
	Loop, %build% {
		Send, {Right down}
		Sleep, 33
		Send, {Right up}
		Sleep, 33
	}
}
