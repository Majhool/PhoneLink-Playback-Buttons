#Requires AutoHotkey v2.0
#include "UIA.ahk"

; -------------------------------------------------------------------
; |                      القائمة المخصصة بالعربية                    |
; -------------------------------------------------------------------

; إزالة القائمة الافتراضية
A_TrayMenu.Delete()

; إنشاء القائمة الجديدة
MyMenu := Menu()
MyMenu.Add("✨ رابط الاداة ✨", OpenToolLink) ; أضف النص الذي تريده في الأعلى
MyMenu.Add() ; خط فاصل
MyMenu.Add("تعليق التشغيل السريع", SuspendScript)
MyMenu.Add("إيقاف مؤقت للسكريبت", PauseScript)
MyMenu.Add("إعادة تشغيل الاداة", ReloadScript)
MyMenu.Add() ; خط فاصل
MyMenu.Add("خروج", ExitScript)

OpenToolLink(ItemName, ItemPos, MyMenu){
    Run ""
}

SuspendScript(ItemName, ItemPos, MyMenu) {
    Suspend(!A_IsSuspended)
}

PauseScript(ItemName, ItemPos, MyMenu) {
    Pause(!A_IsPaused)
}

ReloadScript(ItemName, ItemPos, MyMenu) {
    Reload()
}

ExitScript(ItemName, ItemPos, MyMenu) {
    ExitApp()
}


; -------------------------------------------------------------------
; |                  الكود الأساسي للتحكم في Phone Link             |
; -------------------------------------------------------------------
HandlePhoneLinkButton(identifier, isAutomationId := false) {
    hwnd := WinExist("ahk_exe PhoneExperienceHost.exe")
    if !hwnd
        return

    ; نستخدم ElementFromHandle بدون تنشيط النافذة
    root := UIA.ElementFromHandle(hwnd)
    if !root
        return

    condition := isAutomationId ? {AutomationId: identifier} : {Name: identifier}
    btn := root.FindElement(condition)
    if btn
        if btn.LegacyIAccessiblePattern
    	    btn.LegacyIAccessiblePattern.DoDefaultAction()
	else
    	    btn.Invoke() ; fallback إذا ما كان في LegacyIAccessible

}

Media_Play_Pause::HandlePhoneLinkButton("PlayPauseButton", true)
Media_Next::HandlePhoneLinkButton("Next")
Media_Prev::HandlePhoneLinkButton("Previous")
