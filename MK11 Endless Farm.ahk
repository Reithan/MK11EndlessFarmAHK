#NoEnv
#SingleInstance ignore
#IfWinActive Mortal Kombat 11
					
class Functor {
	__Call(method, args*) {
		if ( method = "")
			return this.Call(args*)
		if (IsObject(method))
			return this.Call(method, args*)
	}	
}

; Define Character List
global CharacterSelect := {}
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
name := file.ReadLine()
StringLower, name, name, T
global Character := {}
Character[1] := [name, file.ReadChar() - 49]
file.ReadLine()
global FarmMode := SubStr(file.ReadLine(),1,4)
StringLower, FarmMode, FarmMode, T
global Difficulty := SubStr(file.ReadLine(),1,4)
StringLower, Difficulty, Difficulty, T

; Pre-Load Images for Search
class ScreenCheck extends Functor
{
	__New(file, coords, range := 0)
	{
		this.fileName := file
		this.pngHandle := LoadPicture(file)
		this.screenCoords := coords
		this.shadeRange := range
		return this
	}
	
	Call(obj, params*)
	{
		CoordMode, Pixel, Relative
		ImageSearch, OutputVarX, OutputVarY, this.screenCoords[1], this.screenCoords[2], this.screenCoords[3], this.screenCoords[4], % "*" . this.shadeRange . " HBITMAP:*" . this.pngHandle
		if (ErrorLevel = 2) {
			MsgBox % "ERROR: ImageSearch Failed(" . this.fileName . "!"
			ExitApp
		}
		return ErrorLevel = 0
	}
	
	fileName := ""
	pngHandle := 0
	screenCoords := [0,0,0,0]
	shadeRange := 0
}


global ScreenChecks := {}
ScreenChecks["skipRewardsButton"] := new ScreenCheck("ImageKeys\SKIP REWARDS Button.png", [250, 1000, 450, 1050], 60)
ScreenChecks["toggleDetailsButton"] := new ScreenCheck("ImageKeys\TOGGLE DETAILS Button.png", [270, 1025, 450, 1050], 60)
ScreenChecks["skipButton"] := new ScreenCheck("ImageKeys\SKIP Button.png", [960, 1020, 1060, 1070])
ScreenChecks["pauseHeader"] := new ScreenCheck("ImageKeys\PAUSE Header.png", [230, 110, 500, 175])
ScreenChecks["kontinueButton1"] := new ScreenCheck("ImageKeys\KONTINUE Button1.png", [800, 825, 1130, 1010], 60)
ScreenChecks["kontinueButton2"] := new ScreenCheck("ImageKeys\KONTINUE Button2.png", [910, 1020, 1090, 1065], 100)
ScreenChecks["kontinueButton3"] := new ScreenCheck("ImageKeys\KONTINUE Button3.png", [910, 1020, 1070, 1065], 100)
ScreenChecks["vsBadge"] := new ScreenCheck("ImageKeys\VS Badge.png", [525, 725, 675, 875])
ScreenChecks["klassicHeader1"] := new ScreenCheck("ImageKeys\KLASSIC Header1.png", [130, 20, 300, 80])
ScreenChecks["klassicHeader2"] := new ScreenCheck("ImageKeys\KLASSIC Header2.png", [130, 20, 300, 80])
ScreenChecks["aiBattleHeader"] := new ScreenCheck("ImageKeys\AI BATTLE Header.png", [1430, 115, 1640, 135])
ScreenChecks["kombatKardFooter"] := new ScreenCheck("ImageKeys\KOMBAT KARD Footer.png", [155, 1030, 360, 1080])
ScreenChecks["noviceHeader"] := new ScreenCheck("ImageKeys\NOVICE Header.png", [1580, 125, 1700, 140])
ScreenChecks["warriorHeader"] := new ScreenCheck("ImageKeys\WARRIOR Header.png", [1580, 125, 1700, 140])
ScreenChecks["championHeader"] := new ScreenCheck("ImageKeys\CHAMPION Header.png", [1580, 125, 1700, 140])
ScreenChecks["survivorHeader"] := new ScreenCheck("ImageKeys\SURVIVOR Header.png", [1580, 125, 1700, 140])
ScreenChecks["endlessHeader"] := new ScreenCheck("ImageKeys\ENDLESS Header.png", [1570, 110, 1700, 150])
ScreenChecks["loadingBarTip"] := new ScreenCheck("ImageKeys\LOADING BAR tip.png", [500, 850, 600, 1080])
ScreenChecks["konquerHeader"] := new ScreenCheck("ImageKeys\KONQUER Header.png", [345, 135, 480, 150], 20)
ScreenChecks["notKonquerHeader"] := new ScreenCheck("ImageKeys\NOT KONQUER Header.png", [345, 135, 480, 150], 20)
ScreenChecks["konquerBadge"] := new ScreenCheck("ImageKeys\KONQUER Badge.png", [375, 600, 545, 655], 100)
ScreenChecks["mainMenuBadge"] := new ScreenCheck("ImageKeys\MAIN MENU Badge.png", [920, 1010, 1010, 1070], 60)
ScreenChecks["mainSubmenuBadge"] := new ScreenCheck("ImageKeys\MAIN SUBMENU Badge.png", [240, 130, 270, 160])
ScreenChecks["klassicTowersBadge"] := new ScreenCheck("ImageKeys\KLASSIC TOWERS Badge.png", [1050, 600, 1240, 655], 100)
ScreenChecks["pressAnyBadge"] := new ScreenCheck("ImageKeys\PRESS ANY Badge.png", [920, 640, 1010, 840], 100)
ScreenChecks["groupBattleBadge"] := new ScreenCheck("ImageKeys\GROUP BATTLE Badge.png", [860, 305, 1060, 320])
ScreenChecks["aiToggleBadge"] := new ScreenCheck("ImageKeys\AI TOGGLE Badge.png", [300, 965, 410, 975])
ScreenChecks["attackingTeamBadge"] := new ScreenCheck("ImageKeys\ATTACKING TEAM Badge.png", [195, 190, 420, 205])
ScreenChecks["inMatchBadge"] := new ScreenCheck("ImageKeys\IN MATCH Badge.png", [1840, 1000, 1885, 1045], 60)
ScreenChecks["charSelectBadge"] := new ScreenCheck("ImageKeys\CHAR SELECT Badge.png", [250, 925, 275, 950], 10)
ScreenChecks["findAiBattleHeader"] := new ScreenCheck("ImageKeys\FIND AI BATTLE Header.png", [280, 180, 395, 205])
ScreenChecks["selectAiOpponentHeader"] := new ScreenCheck("ImageKeys\SELECT AI OPPONENT Header.png", [840, 105, 1050, 130])
ScreenChecks["enableFastForwardBadge"] := new ScreenCheck("ImageKeys\ENABLE FAST FORWARD Badge.png", [865, 955, 1110, 975], 60)
ScreenChecks["fightSubmenuHeader"] := new ScreenCheck("ImageKeys\FIGHT SUBMENU Header.png", [735, 130, 825, 155])
ScreenChecks["aiBattleBadge"] := new ScreenCheck("ImageKeys\AI BATTLE Badge.png", [1370, 605, 1535, 650], 100)
ScreenChecks["aiAttackFinishedHeader"] := new ScreenCheck("ImageKeys\AI ATTACK FINISHED Header.png", [265, 140, 330, 155], 100)
ScreenChecks["aiBattlesFinishedBadge"] := new ScreenCheck("ImageKeys\AI BATTLES FINISHED Badge.png", [1420, 175, 1480, 210])
ScreenChecks["retryButton1"] := new ScreenCheck("ImageKeys\RETRY Button1.png", [915, 880, 1005, 940], 60)
ScreenChecks["towersOfTimeBadge"] := new ScreenCheck("ImageKeys\TOWERS OF TIME Badge.png", [795, 620, 945, 635], 100)
ScreenChecks["difficultyBadge"] := new ScreenCheck("ImageKeys\DIFFICULTY Badge.png", [865, 755, 1045, 770])
ScreenChecks["veasyDifficultyBadge"] := new ScreenCheck("ImageKeys\VEASY DIFFICULTY Badge.png", [900, 840, 1020, 855])
ScreenChecks["easyDifficultyBadge"] := new ScreenCheck("ImageKeys\EASY DIFFICULTY Badge.png", [900, 840, 1020, 855])
ScreenChecks["mediumDifficultyBadge"] := new ScreenCheck("ImageKeys\MEDIUM DIFFICULTY Badge.png", [900, 840, 1020, 855])
ScreenChecks["hardDifficultyBadge"] := new ScreenCheck("ImageKeys\HARD DIFFICULTY Badge.png", [900, 840, 1020, 855])
ScreenChecks["vhardDifficultyBadge"] := new ScreenCheck("ImageKeys\VHARD DIFFICULTY Badge.png", [900, 840, 1020, 855])
ScreenChecks["towerSelectButton"] := new ScreenCheck("ImageKeys\TOWER SELECT Button.png", [910, 945, 1030, 960], 100)
ScreenChecks["quitBadge"] := new ScreenCheck("ImageKeys\QUIT Badge.png", [895, 515, 1045, 530])

class State {
	runState() {
		; bool : retain this state on stack
		; string : push this state to stack
		return [false, ""]
	}
}

class UnknownState extends State {
	runState() {
		; current screen is unknown - find out which

		; press any key
		if (ScreenChecks["pressAnyBadge"]()) {
			thrashKey := 0
			sendKeyPress("Enter")
			Sleep, 5000
			return [true, "mainMenu"]
		}
		; exit quit menu
		if(ScreenChecks["quitBadge"]()) {
			sendKeyPress("Esc")
			Sleep, 100
			return [true, ""]
		}
		; main submenu
		if (ScreenChecks["mainSubmenuBadge"]()) {
			thrashKey := 0
			return [true, "mainSubmenu"]
		}
		; main menu
		if (ScreenChecks["mainMenuBadge"]()) {
			thrashKey := 0
			return [true, "mainMenu"]
		}
		; Klassic tower screen
		if (ScreenChecks["klassicHeader1"]() || ScreenChecks["klassicHeader2"]()) {
			thrashKey := 0
			return [true, "klassicTowers"]
		}
		; AI Battle screen
		if (ScreenChecks["aiBattleHeader"]()) {
			thrashKey := 0
			return [true, "aiBattleSelect"]
		}
		; tower load screen
		if (ScreenChecks["vsBadge"]()) {
			thrashKey := 0
			return [true, "towerRun"]
		}
		; select ai opponent
		if (ScreenChecks["selectAiOpponentHeader"]()) {
			thrashKey := 0
			return [true, "selectAiOpponent"]
		}
		; character select
		if (ScreenChecks["attackingTeamBadge"]() || ScreenChecks["charSelectBadge"]()) {
			thrashKey := 0
			return [true, "charSelect"]
		}
		; match loading screen
		if (ScreenChecks["loadingBarTip"]()) {
			thrashKey := 0
			return [true, "matchLoading"]
		}
		; in match
		if (ScreenChecks["pauseHeader"]() || ScreenChecks["inMatchBadge"]()) {
			thrashKey := 0
			return [true, "inMatch"]
		}
		; match loss
		if (ScreenChecks["retryButton1"]() || ScreenChecks["retryButton2"]()) {
			thrashKey := 0
			sendKeyPress("Up")
			Sleep, 100
			sendKeyPress("Enter")
			Sleep, 100
			sendKeyPress("Right")
			Sleep, 100
			sendKeyPress("Enter")
			Sleep, 2500
			return [true, ""]			
		}
		if (ScreenChecks["towerSelectButton"]()) {
			thrashKey := 0
			sendKeyPress("Enter")
			Sleep, 100
			sendKeyPress("Right")
			Sleep, 100
			sendKeyPress("Enter")
			Sleep, 2500
			return [true, ""]			
		}
		; kontinue screen
		canKontinue := ScreenChecks["kontinueButton3"]()
		canKontinue |= ScreenChecks["kontinueButton2"]()
		canKontinue |= ScreenChecks["kontinueButton1"]()
		canKontinue |= ScreenChecks["aiAttackFinishedHeader"]()
		if (canKontinue) {
			thrashKey := 0
			sendKeyPress("Enter")
			Sleep, 1500
			return [true, ""]
		}
		; unknown state - try to leave
		if (this.thrashKey < 2) {
			sendKeyPress("Esc")
		}
		if (this.thrashKey++ = 2) {
			sendKeyPress("Enter")
			this.thrashKey := 0
		}
		Sleep, 3000
		return [true, ""]
	}
	thrashKey := 0
}

class MainMenuState extends State {
	runState() {
		if (!ScreenChecks["mainMenuBadge"]()) {
			return [false, ""]
		}
		; exit quit menu
		if(ScreenChecks["quitBadge"]()) {
			sendKeyPress("Esc")
			Sleep, 100
			return [true, ""]
		}
		; go to submenu and navigate from there
		if (!ScreenChecks["mainSubmenuBadge"]()) {
			sendKeyPress("Enter")
			Sleep, 1000
			return [true, "mainSubmenu"]
		} else {
			return [true, "mainSubmenu"]
		}
	}
}

class MainSubmenuState extends State {
	runState() {
		; determine submenu
		Random, randNum, 0, 1
		if (((FarmMode = "Rand" && randNum) || FarmMode != "Aiba" || this.isAiBattleDone) && ScreenChecks["konquerHeader"]()) {
			this.searchCount := 0
			Sleep, 2500
			return [true, "konquerMenu"]
		} 
		if (((FarmMode = "Rand" && !randNum) || FarmMode = "Aiba" || !this.isAiBattleDone) && ScreenChecks["fightSubmenuHeader"]()) {
			this.searchCount := 0
			Sleep, 2500
			return [true, "fightMenu"]
		}
		if (!ScreenChecks["mainSubmenuBadge"]()) {
			this.searchCount := 0
			return [false, ""]
		} else {
			if (this.searchCount++ = 3) {
				this.searchCount := 0
				return [false, ""]
			}
			; didn't capture submenu, pick a different one
			sendKeyPress("Q")
			Sleep, 100
			return [true, ""]
		}
	}
	searchCount := 0
	isAiBattleDone := true ; false
}

class KonquerMenuState extends State {
	runState() {
		; navigate to Klassic Towers
		Random, randNum, 0, 10
		isKlassicTowerTarget := (FarmMode = "Rand" && randNum > 3)
		isKlassicTowerTarget |= FarmMode = "Novi"
		isKlassicTowerTarget |= FarmMode = "Warr"
		isKlassicTowerTarget |= FarmMode = "Cham"
		isKlassicTowerTarget |= FarmMode = "Surv"		
		isKlassicTowerTarget |= FarmMode = "Endl"
		if (!isKlassicTowerTarget && FarmMode != "Time" && !(FarmMode = "Rand" && randNum)) {
			return [false, ""]
		}
		if (isKlassicTowerTarget && ScreenChecks["klassicTowersBadge"]()) {
			this.searchCount := 0
			sendKeyPress("Enter")
			Sleep, 3500
			return [false, "klassicTowers"]
		}
		if ((FarmMode = "Time" || (FarmMode = "Rand" && randNum < 4)) && ScreenChecks["towersOfTimeBadge"]()){
			this.searchCount := 0
			; sendKeyPress("Enter")
			; Sleep, 3500
			; return [false, "towersOfTime"]
			return [true, ""]
		} else if (!ScreenChecks["konquerHeader"]()) {
			this.searchCount := 0
			return [false, ""]
		} else {
			if (this.searchCount++ = 3) {
				this.searchCount := 0
				return [false, ""]
			}
			sendKeyPress("Right")
			Sleep, 2500
			return [true, ""]
		}
	}
	searchCount := 0
}

class FightMenuState extends State {
	runState() {
		Random, randNum, 0, 10
		if (FarmMode != "Aiba" && !(FarmMode = "Rand" && randNum)) {
			return [false, ""]
		}
		if (ScreenChecks["aiBattleBadge"]()) {
			this.searchCount := 0
			sendKeyPress("Enter")
			Sleep, 3500
			return [false, "aiBattleSelect"]
		}
		if (!ScreenChecks["fightSubmenuHeader"]()) {
			this.searchCount := 0
			return [false, ""]
		} else {
			if (this.searchCount++ = 3) {
				this.searchCount := 0
				return [false, ""]
			}
			sendKeyPress("Left")
			Sleep, 2500
			return [true, ""]
		}
	}
	searchCount := 0
}

class KlassicTowersState extends State {
	runState() {
		if (!ScreenChecks["klassicHeader1"]() && !ScreenChecks["klassicHeader2"]()) {
			this.searchCount := 0
			; not in klassic
			return [false, ""]
		} else {
			Random, randNum, 0, 10
			isKlassicTowerTarget := (FarmMode = "Rand" && randNum)
			isKlassicTowerTarget |= FarmMode = "Novi"
			isKlassicTowerTarget |= FarmMode = "Warr"
			isKlassicTowerTarget |= FarmMode = "Cham"
			isKlassicTowerTarget |= FarmMode = "Surv"		
			isKlassicTowerTarget |= FarmMode = "Endl"
			isKlassicTowerTarget &= States["mainSubmenu"].isAiBattleDone
			if (!isKlassicTowerTarget) {
				this.searchCount := 0
				sendKeyPress("Esc")
				Sleep, 3500
				return [false, ""]
			}
			correctTower := FarmMode = "Rand" && randNum > 5
			correctTower |= FarmMode = "Novi" && ScreenChecks["noviceHeader"]()
			correctTower |= FarmMode = "Warr" && ScreenChecks["warriorHeader"]()
			correctTower |= FarmMode = "Cham" && ScreenChecks["championHeader"]()
			correctTower |= FarmMode = "Endl" && ScreenChecks["endlessHeader"]()
			correctTower |= FarmMode = "Surv" && ScreenChecks["survivorHeader"]()
			if (!correctTower) {
				if (!ScreenChecks["kombatKardFooter"]()) {
					; Wrong tower selected
					sendKeyPress("Esc")
					Sleep, 2000
					return [true, ""]
				} else {
					; Wrong tower hovered
					if (this.searchCount++ = 4) {
						this.searchCount := 0
						return [false, ""]
					}
					sendKeyPress("Left")
					return [true, ""]
				}
			} else {
				this.searchCount := 0
				if (ScreenChecks["kombatKardFooter"]()) {
					Sleep, 250
					; enter char select
					sendKeyPress("Enter")
					Sleep, 1500
				}
				; run tower
				return [true, "charSelect"]
			}
		}
	}
	searchCount := 0
}

class AIBattleSelectState extends State {
	runState() {
		Random, randNum, 0, 1
		if (FarmMode != "Aiba" && !(FarmMode = "Rand" && randNum) && ScreenChecks["aiBattlesFinishedBadge"]()) {
			this.searchCount := 0
			States["mainSubmenu"].isAiBattleDone := true
			sendKeyPress("Esc")
			Sleep, 1000
			return [false, ""]
		}
		if (!ScreenChecks["aiBattleHeader"]()) {
			this.searchCount := 0
			return [false, ""]
		}
		if (!ScreenChecks["findAiBattleHeader"]()) {
			if (this.searchCount++ = 3) {
				this.searchCount := 0
				return [false, ""]
			}
			if (this.isLeft) {
				sendKeyPress("Left")
			} else {
				sendKeyPress("Up")
			}
			this.isLeft := !this.isLeft
			return [true, ""]
		} else {
			this.searchCount := 0
			sendKeyPress("Enter")
			Sleep, 3500
			return [true, "selectAiOpponent"]
		}
	}
	isLeft := false
	searchCount := 0
}

class SelectAIOpponentState extends State {
	runState() {
		if (!ScreenChecks["selectAiOpponentHeader"]()) {
			this.searchCount := 0
			return [false, ""]
		}
		if (this.searchCount++ = 2) {
			this.searchCount := 0
			return [false, ""]
		}
		sendKeyPress("Enter")
		Sleep, 2500
		return [false, "charSelect"]
	}
	searchCount := 0
}

class CharSelectState extends State {
	runState() {
		if (ScreenChecks["groupBattleBadge"]()) {
			; can't send AI to group battles
			sendKeyPress("Esc")
			return [false, ""]
		}
		if (ScreenChecks["charSelectBadge"]()) {
			selectCharacter(Character[1][1], Character[1][2])
			if (ScreenChecks["aiToggleBadge"]()) {
				; Turn on AI
				sendKeyPress("A")
				; Lock in
				sendKeyPress("Enter")
				if (FarmMode != "Endl") {
					; Enter Difficulty
					Sleep, 1500
					if (ScreenChecks["difficultyBadge"]()) {
						Loop {
							Random, randNum, 0, 5
							correctDifficulty := Difficulty = "Rand" && !randNum
							correctDifficulty |= Difficulty = "Veas" && ScreenChecks["veasyDifficultyBadge"]()
							correctDifficulty |= Difficulty = "Easy" && ScreenChecks["easyDifficultyBadge"]()
							correctDifficulty |= Difficulty = "Medi" && ScreenChecks["mediumDifficultyBadge"]()
							correctDifficulty |= Difficulty = "Hard" && ScreenChecks["hardDifficultyBadge"]()
							correctDifficulty |= Difficulty = "Vhar" && ScreenChecks["vhardDifficultyBadge"]()
							
							if (!correctDifficulty) {
								sendKeyPress("Right")
								Sleep, 100
							}
						} Until correctDifficulty
						sendKeyPress("Enter")
					}
				}
				
				; start tower run
				return [false, "towerRun"]
			}
		}
		if (ScreenChecks["attackingTeamBadge"]()) {
			; Lock in 3 - selections are pre-saved by game
			sendKeyPress("Enter")
			Sleep, 100
			sendKeyPress("Enter")
			Sleep, 100
			sendKeyPress("Enter")
			Sleep, 100
			sendKeyPress("Enter")
			Sleep, 100
			sendKeyPress("Enter")
			Sleep, 100
			sendKeyPress("Enter")
			; wait for confirm window
			Sleep, 3000
			; confirm battle
			sendKeyPress("Enter")
			return [false, "matchLoading"]
		} else {
			; ai not available
			sendKeyPress("Esc")
			sendKeyPress("Esc")
			return [false, ""]
		}
	}
}

class TowerRunState extends State {
	runState() {
		application.statusText := "Run " . this.thisRun . "  |  Best " . this.bestRun
		application.statusText .= "`nMatches Played " . this.numMatches
		application.statusText .= " (" . this.numWins . ":" . this.numLosses . ")"
		if (ScreenChecks["vsBadge"]()) {
			this.searchCount := 0
			this.retryCount := 0
			if (this.IsMatchStarted) {
				++this.numWins
				if (++this.thisRun > this.bestRun) {
					this.bestRun := this.thisRun
				}
			} else {
				; additional delay for initial tower load
				Sleep, 1000
			}
			; delay to ensure input is active
			Sleep, 500
			; Start Tower Fight
			sendKeyPress("Enter")
			++this.numMatches
			this.IsMatchStarted := true
			return [true, "matchLoading"]
		}
		; Are we on kontinue?
		canKontinue := ScreenChecks["kontinueButton3"]()
		canKontinue |= ScreenChecks["kontinueButton2"]()
		canKontinue |= ScreenChecks["kontinueButton1"]()
		if (canKontinue) {
			this.searchCount := 0
			sendKeyPress("Enter")
			if (this.IsMatchStarted) {
				if (FarmMode = "Endl") {
					++this.numLosses
				} else {
					++this.numWins
					if (++this.thisRun > this.bestRun) {
						this.bestRun := this.thisRun
					}
				}
				this.thisRun := 0
				this.IsMatchStarted := false
			}
			Sleep, 1500
			return [false, ""]
		}
		isRetry := ScreenChecks["retryButton1"]() || ScreenChecks["retryButton2"]()
		if (isRetry || ScreenChecks["towerSelectButton"]()) {
			this.searchCount := 0
			++this.numLosses
			if (isRetry && ++this.retryCount < 3) {
				; TODO - select konsumables?
				sendKeyPress("Enter")
				++this.numMatches
				Sleep, 1000
				return [true, "matchLoading"]
			} else {
				if (isRetry) {
					sendKeyPress("Up")
					Sleep, 100
					sendKeyPress("Up")
					Sleep, 100
				}
				sendKeyPress("Enter")
				Sleep, 100
				sendKeyPress("Right")
				Sleep, 100
				sendKeyPress("Enter")
				this.retryCount := 0
				this.thisRun := 0
				this.IsMatchStarted := false
				Sleep, 2500
				return [false, ""]
			}
		} else if (this.searchCount++ = 10) {
			if (this.IsMatchStarted) {
				this.thisRun := 0
				this.IsMatchStarted := false
				this.retryCount := 0
			}
			this.searchCount := 0
			return [false, ""]
		} else {
			Sleep, 500
			return [true, ""]
		}
	}
	
	numMatches := 0
	numWins := 0
	numLosses := 0
	thisRun := 0
	bestRun := 0
	IsMatchStarted := false
	searchCount := 0
	retryCount := 0
}

class MatchLoadingState extends State {
	runState() {
		if (!this.IsLoadingStarted && ScreenChecks["loadingBarTip"]()) {
			this.searchCount := 0
			this.IsLoadingStarted := true
			return [true, ""]
		}
		if (this.IsLoadingStarted && !ScreenChecks["loadingBarTip"]()) {
			this.searchCount := 0
			this.IsLoadingStarted := false
			; Skip Intros
			Sleep, 2000
			sendKeyPress("Enter")
			return [false, "inMatch"]
		}
		if (ScreenChecks["enableFastForwardBadge"]()) {
			this.searchCount := 0
			sendKeyPress("M")
			Sleep, 100
			return [true, ""]
		}
		if (this.IsLoadingStarted && this.searchCount++ = 40) {
			this.searchCount := 0
			return [false, ""]
		} else if (!this.IsLoadingStarted && this.searchCount++ = 8) {
			this.searchCount := 0
			return [false, ""]
		} else {
			Sleep, 500
			return [true, ""]
		}
	}
	IsLoadingStarted := false
	searchCount := 0
}

class InMatchState extends State {
	runState() {
		; unpause if necessary
		if (ScreenChecks["pauseHeader"]()) {
			sendKeyPress("Esc")
			Sleep, 500
			return [true, ""]
		}

		; Detect any post-match conditions
		processAny := false
		skipDelay := 0
		Loop {
			proccessPostMatch := false
			; we lost
			if (ScreenChecks["retryButton1"]() || ScreenChecks["towerSelectButton"]()) {
				return [false, ""]
			}

			; Can we skip to kontinue?
			if (ScreenChecks["skipButton"]()) {
				sendKeyPress("Enter")
				proccessPostMatch := true
			}
			; Can we kontinue?
			canKontinue := ScreenChecks["kontinueButton3"]()
			canKontinue |= ScreenChecks["kontinueButton2"]()
			canKontinue |= ScreenChecks["kontinueButton1"]()
			canKontinue |= ScreenChecks["aiAttackFinishedHeader"]()
			if (canKontinue) {
				sendKeyPress("Enter")
				proccessPostMatch := true
			}

			; Can we skip rewards?
			if (!proccessPostMatch && ScreenChecks["skipRewardsButton"]() || ScreenChecks["toggleDetailsButton"]()) {
				; don't spam
				if (++skipDelay = 4) {
					skipDelay := 0
					sendKeyPress("Enter")
				}
				Sleep, 400
				proccessPostMatch := true
			}
			if (proccessPostMatch) {
				this.isPostMatch := true
				Sleep, 100
			}
			processAny |= proccessPostMatch
		} Until !proccessPostMatch
		

		if(!this.isPostMatch) {
			sendKeyPress("Enter")
			Sleep, 1000
		}
		; Are we still in match?
		if (this.isPostMatch && processAny) {
			Sleep, 3500
		}
		if (!this.isPostMatch || processAny) {
			return [true, ""]
		} else {
			this.isPostMatch := false
			return [false, ""]
		}
	}
	isPostMatch := false
}

global States := {}
States["unknown"] := new UnknownState()
States["mainMenu"] := new MainMenuState()
States["mainSubmenu"] := new MainSubmenuState()
States["konquerMenu"] := new KonquerMenuState()
States["fightMenu"] := new FightMenuState()
States["klassicTowers"] := new KlassicTowersState()
States["aiBattleSelect"] := new AIBattleSelectState()
States["selectAiOpponent"] := new SelectAIOpponentState()
States["charSelect"] := new CharSelectState()
States["towerRun"] := new TowerRunState()
States["matchLoading"] := new MatchLoadingState()
States["inMatch"] := new InMatchState()

class StateMachine {
	run() {
		this.Push(States["unknown"])

		Loop {
			; show/hide gui
			if (this.guiActive && !WinActive("Mortal Kombat 11")) {
				Gui, StatusGui:Hide
				Gui, TooltipGui:Hide
				this.guiActive := false
			} else if (!this.guiActive && WinActive("Mortal Kombat 11")) {
				Gui, StatusGui:Show, NoActivate
				Gui, TooltipGui:Show, NoActivate
				this.guiActive := true
			}
			
			this.shouldRedraw |= (this.statusText != this.prevStatus)
			if (this.shouldRedraw) {
				GuiControl, StatusGui:, Status, % (this.isEnabled ? "[ Enabled] " : "[Disabled] ") . this.statusText
				this.prevStatus := this.statusText
				this.shouldRedraw := false
			}
			
			; skip processing is disabled
			If (!this.isEnabled) {
				Sleep, 500
				continue
			}
			
			; check to ensure MK11 is running
			if (!WinActive("Mortal Kombat 11")) {
				WinActivate Mortal Kombat 11
				if (!WinActive("Mortal Kombat 11")) {
					Process, Exist, MK11.exe
					if (ErrorLevel != 0 && FileExist("MK11.lnk")) {
						; Reset states
						While (this.Pop()) {
						}
						this.Push(States["unknown"])
						this.statusText := ""
						Sleep, 5000
						Run, MK11.lnk
						Process, Wait, Mortal Kombat 11, 30
					}
					continue
				}
			}
			
			CoordMode, Pixel, Relative
			; Get the mouse out of the way
			MouseGetPos, mouseX, mouseY
			if (mouseX != 1920 || mouseY != 1080) {
				MouseMove, 1920, 1080, 0
				Sleep, 33
			}
			
			state := this.Pop()
			stateReturn := state.runState()
			if (stateReturn[1]) {
				this.Push(state)
			}
			if (stateReturn[2]) {
				; this.statusText := "`n" . stateReturn[2]
				this.Push(States[stateReturn[2]])
			}
			if (States.Count() == 0) {
				break
			}
		}
	}

	guiActive := true
	isEnabled := true
	statusText := ""
	shouldRedraw := true
}

Gui, StatusGui:New, +AlwaysOnTop -Caption +Disabled +ToolWindow
Gui, Show, W200 H40 X0 Y0, Hide StatusGui
Gui, StatusGui:Add, Text, vStatus, % "[ Enabled] Run 0000  |  Best 0000`nMatches Played 0000 (0000:0000)"
GuiControl, StatusGui:, Status, [ Enabled]

bottomHeight := A_ScreenHeight - 40
Gui, TooltipGui:New, +AlwaysOnTop -Caption +Disabled +ToolWindow
Gui, Show, X0 Y%bottomHeight% W100 H40, Hide TooltipGui
Gui, TooltipGui:Add, Text, , F3: Toggle Script`nF4: Quit

global StatusGui
global Status
global TooltipGui

global application := new StateMachine()
application.run()

F3::
	application.isEnabled := !application.isEnabled
	application.shouldRedraw := true
	return

F4::ExitApp

selectCharacter(name, build) {
	global CharacterSelect
	
	if(SubStr(name,1,4) = "Rand") {
		; randomselect
		sendKeyPress("W")
		Sleep, 100
		sendKeyPress("Enter")
		Sleep, 2750
	} else {
		; Find character data
		selected := false
		Loop, 2 {
			selected := CharacterSelect[SubStr(name,1,A_Index+2)]
			if (selected)
				break
		}
		if (!selected) {
			MsgBox ERROR: Unknown Character
			ExitApp
		}
		
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
	}
	; Select build
	Random, randNum, 0, 5
	loops := (build = -1 ? randNum : build)
	Loop, %loops% {
		sendKeyPress("Right")
	}
	Sleep % Max(0, 300 - loops * 100)
}

sendKeyPress(key) {
	Send, {%key% down}
	Sleep, 33
	Send, {%key% up}
	Sleep, 33
}