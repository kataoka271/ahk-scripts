#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Screen

logDebug(hwnd) {
    WinGet, pid, PID, ahk_id %hwnd%
    WinGet, name, ProcessName, ahk_id %hwnd%
    WinGetTitle, title, ahk_id %hwnd%
    WinGetClass, wc, ahk_id %hwnd%
    OutputDebug, hwnd=%hwnd% . pid=%pid% . name=%name% . wc=%wc% . title=%title%
}

SetTimer, FocusOnMouse, 500
Return

FocusOnMouse:
    MouseGetPos, x, y, hwnd, , 3
    If (x = oldX and y = oldY) {
        Return
    }
    if (hwnd = oldHWnd) {
        Return
    }
    WinGetClass, wc, ahk_id %hwnd%
    If (wc != "Shell_TrayWnd" and wc != "Xaml_WindowedPopupClass" and wc != "TaskListThumbnailWnd") {
        IfWinNotActive, ahk_id %hwnd%
        {
            logDebug(hwnd)
            WinActivate, ahk_id %hwnd%
        }
    }
    oldX := x
    oldY := y
    oldHWnd := hwnd
    Return