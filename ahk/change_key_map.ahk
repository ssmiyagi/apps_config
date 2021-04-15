;;sendkey のdelayを0にする
SetKeyDelay, -1
;;絶対位置に変換
CoordMode, ToolTip, Screen
CoordMode, Mouse, Screen

;;無変換キー自体を有効化 _たぶんいらない
/*
vk1D::
Send, {vk1D}
*/
;;画面移動
vk1D::
  KeyWait, vk1D
  if (A_PriorHotkey == A_ThisHotkey) && (400 > A_TimeSincePriorHotkey)
    Send,{Enter}
return

;input_mode := "normal"

;capsLock
sc03A::  Send, {Enter}

;Esc::
;  input_mode:= "normal"
;  Send,{Esc}
;return

;Esc::
;  Send,{Esc}
;  Send,{vkf3} 
;return

;マウスカーソル移動(上) Windowsキー + ↑
vk1D & K::
MouseMove 0,-10,0,R
return

;マウスカーソル移動(下) Windowsキー + ↓
vk1D & J::
MouseMove 0,10,0,R
return

;マウスカーソル移動(左) Windowsキー + ←
vk1D & H::
MouseMove -10,0,0,R
return

;マウスカーソル移動(右) Windowsキー + →
vk1D & L::
MouseMove 10,0,0,R
return

;マウス左クリック Windowsキー + Enter
vk1D & I::
MouseClick ,Left
return
;マウス右クリック Windowsキー + Enter
vk1D & O::
MouseClick ,right
return
;マウス右クリック Windowsキー + Enter
vk1D & Up::
MouseClick ,WheelUp, , ,2
return
;マウス右クリック Windowsキー + Enter
vk1D & Down::
MouseClick ,WheelDown, , ,2
return
;kill electron
Alt & Space::
			;Process, Close, cmd.exe
			;Process, Close, conhost.exe
			Process, Close, electron.exe
			return
;kill goyo18
vk1C & Space::
      Process, Close, Kaisou.exe
      Process, Close, KGASUKE.EXE
      Process, Close, KGASUKE.BIN
      return 
;;UI起動
;;Alt::
;;  KeyWait, Alt
;;  if (A_PriorHotkey == A_ThisHotkey) && (400 > A_TimeSincePriorHotkey)
;;    Run C:\Users\miyag\Desktop\App\shortcutkey\batFileSettings\Alt_x_2.bat
;;return

;;??テスト？
Ctrl & Alt::
  KeyWait, Alt
  if (A_PriorHotkey == A_ThisHotkey) && (400 > A_TimeSincePriorHotkey)
    Run "C:\Users\miyag\Desktop\App\shortcutkey\batFileSettings\Ctrl & Alt_x_2.bat"
return

;;UI起動(開発用)
Shift & Alt::
  KeyWait, Alt
  if (A_PriorHotkey == A_ThisHotkey) && (400 > A_TimeSincePriorHotkey)
    Run "C:\Users\miyag\Desktop\App\shortcutkey\batFileSettings\shift_&_ALT_x2.bat"
return


;;dev update
vk1C & D::
  Run "C:\Users\miyag\Desktop\App\automate\auto_svn_update\01dev_ui_update_npmInstall.bat"
return
;;new update
vk1C & N::
  Run "C:\Users\miyag\Desktop\App\automate\auto_svn_update\02new_ui_update_npmInstall.bat"
return

vk1C & C::
  Run "C:\Users\miyag\Desktop\App\automate\auto_svn_update\03copy_migraton_bookrack_accessor.bat"
return

RAlt & G::
  Run "C:\Users\miyag\Desktop\App\shortcutkey\batFileSettings\RunGoyo18.bat"
return

;;vim key-bind
Space & J::
  send {Down}
return

Space & K::
  send {Up}
return

Space & L::
  send {Right}
return

Space & H::
  send {Left}
return 

Space & W::
  send {Right}
  send ^{Right}
return

Space & B::
  send {Left}
  send ^{Left}
return

;; 無変換+0,$でhome,end
Space & 0::Send, {Home}
Space & 4::Send, {End}

Space & O::
  Send, {End}
  Send, {Enter}
return 

;;fix space button
Space::Space
return 

vk1C & A::
  MouseClick, left
return

vk1C & S::
  MouseClick, right
return
;network OnOff
adapter:="イーサネット"
vk1C & E::


return

;click goyowindow
vk1D & N::
  MouseClick, left, 1200, 120
  Sleep, 100
  MouseClick, left, 978, 361
  Sleep, 100
  MouseClick, right, 978, 361
  Sleep, 500
  ;MouseClick, left, 893, 419;メニュー切り替え
  ;Sleep, 100
  MouseClickDrag, left, 942, 105, 1246, 200
return
;construcion light click

vk1D & M::
  MouseClick, right, 375, 198
return

;click excel header
vk1D & U::
  MouseClick, left,228,17
return

;click excel center
vk1D & Y::
  MouseClick, left,228,500
return

vk1C & M::
  MouseGetPos, xpos, ypos 
  MsgBox, The cursor is at X%xpos% Y%ypos%. 
return

vk1D & 1::
MouseMove 970,340,
return

vk1D & 2::
MouseMove 1250,240,
return

vk1D & 3::
MouseMove 1520,350,
return

vk1D & 4::
MouseMove 990,680,
return

vk1D & 5::
MouseMove 1160,680,
return

vk1D & 6::
MouseMove 1370,680,
return
;一時的なショートカット
vk1C & T::
  send {F2}
  Sleep, 100
  send {Right}
  Sleep, 100
  send {BackSpace}
return

vk1C & I::
  Msgbox,"test", %input_mode%
  Run "C:\Users\miyag\Desktop\App\automate\auto_svn_update\test.bat"
return


RWin::AppsKey
return 

Alt & 2::
  send ^!{2}
  return

Alt & 1::
  send ^!{1}
  return
