#Requires AutoHotkey v2.0
#include "UIA.ahk"

; -------------------------------------------------------------------
; |                      تشغيل سكربت الإصلاح الأولي                   |
; -------------------------------------------------------------------
; هذا السطر يقوم بتشغيل سكربت PowerShell في الخلفية لإصلاح مشكلة قارئ الشاشة
; يتم هذا تلقائيًا عند بدء تشغيل الأداة
Run('powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "' A_ScriptDir '\SolvePowerShell.ps1"')


; -------------------------------------------------------------------
; |                      القائمة المخصصة بالعربية                    |
; -------------------------------------------------------------------

; إزالة القائمة الافتراضية
Tray := A_TrayMenu

; إنشاء القائمة الجديدة
Tray.Delete()
Tray.Add("✨ رابط الاداة ✨", OpenToolLink) ; أضف النص الذي تريده في الأعلى
Tray.Add("✨ رابط حسابي على Github ✨", OpenAccountLink)
Tray.Add() ; خط فاصل
Tray.Add("تعليق التشغيل السريع", SuspendScript)
Tray.Add("إيقاف مؤقت للاداة", PauseScript)
Tray.Add("إعادة تشغيل الاداة", ReloadScript)
Tray.Add() ; خط فاصل
Tray.Add("خروج", ExitScript)

OpenToolLink(*) {
    Run "https://github.com/Majhool/PhoneLink-Playback-Buttons"
}

OpenAccountLink(*) {
    Run "https://github.com/Majhool"
}

SuspendScript(*) {
    Suspend(!A_IsSuspended)
}

PauseScript(*) {
    Pause(!A_IsPaused)
}

ReloadScript(*) {
    Reload()
}

ExitScript(*) {
    ExitApp()
}


; -------------------------------------------------------------------
; |                  الكود الأساسي للتحكم في Phone Link             |
; -------------------------------------------------------------------
HandlePhoneLinkButton(identifier, isAutomationId := false) {
    hwnd := WinExist("ahk_exe PhoneExperienceHost.exe")
    if !hwnd
        return

    ; نستخدم ElementFromHandle بدون تنشيط النافذة
    root := UIA.ElementFromHandle(hwnd)
    if !root
        return

    condition := isAutomationId ? { AutomationId: identifier } : { Name: identifier }
    btn := root.FindElement(condition)
    if btn
        if btn.LegacyIAccessiblePattern
            btn.LegacyIAccessiblePattern.DoDefaultAction()
        else
            btn.Invoke() ; fallback إذا ما كان في LegacyIAccessible

}

Media_Play_Pause:: HandlePhoneLinkButton("PlayPauseButton", true)
Media_Next:: HandlePhoneLinkButton("Next")
Media_Prev:: HandlePhoneLinkButton("Previous")