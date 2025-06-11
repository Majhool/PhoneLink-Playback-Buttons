#Requires AutoHotkey v2.0
#SingleInstance force
#include "UIA.ahk"
; -------------------------------------------------------------------
; |                      تشغيل سكربت الإصلاح الأولي                   |
; -------------------------------------------------------------------
; هذا السطر يقوم بتشغيل سكربت PowerShell في الخلفية لإصلاح مشكلة قارئ الشاشة
; يتم هذا تلقائيًا عند بدء تشغيل الأداة
FileInstall("SolvePowerShell.ps1", A_Temp . "\SolvePowerShell.ps1", true)
Run(A_ComSpec ' /c powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "' A_ScriptDir '\SolvePowerShell.ps1"', , 'Hide')

; -------------------------------------------------------
; |       تعريف مسارات الأيقونات لكل حالة Tray        |
; -------------------------------------------------------
; في أول سطر من الملف
FileInstall "icons\play.ico", A_Temp . "\play.ico", 1
FileInstall "icons\pause.ico", A_Temp . "\pause.ico", 1  
FileInstall "play_pause_icon_137298.ico", A_Temp . "\idle.ico", 1

; باقي الكود هنا...
TrayIcons := {
    playing: A_Temp . "\play.ico",
    paused: A_Temp . "\pause.ico", 
    idle: A_Temp . "\idle.ico"
}

; حدّد أيقونتك الابتدائية (idle) فور الإقلاع
TraySetIcon TrayIcons.idle


; -------------------------------------------------------------------
; |                      متغيرات Now Playing                         |
; -------------------------------------------------------------------
; متغيرات لحفظ معلومات المسار الحالي
CurrentTrack := {
    source: "",
    title: "",
    artist: "",
    isPlaying: false,
    hasAudio: false
}

global g_fastUpdateCounter := 0

; -------------------------------------------------------------------
; |                   وظائف حلقة التحديث السريع                    |
; -------------------------------------------------------------------
StartFastUpdate() {
    global g_fastUpdateCounter := 0 ; إعادة تصفير العداد عند كل ضغطة جديدة
    SetTimer(FastUpdateChecker, 100) ; بدء/إعادة تشغيل المؤقت ليعمل كل 100ms
}

FastUpdateChecker() {
    global g_fastUpdateCounter
    UpdateNowPlaying()
    g_fastUpdateCounter += 1

    ; إيقاف الحلقة بعد 10 دورات (أي ثانية واحدة)
    if (g_fastUpdateCounter > 10) {
        SetTimer(FastUpdateChecker, 0) ; <--- هذا هو السطر الصحيح لإيقاف المؤقت في v2
    }
}

; -------------------------------------------------------------------
; |                      إعداد القائمة والأيقونة                     |
; -------------------------------------------------------------------
; إزالة القائمة الافتراضية وإنشاء القائمة الجديدة (كليك يمين)
Tray := A_TrayMenu
Tray.Delete()
Tray.Add("✨ رابط الاداة ✨", OpenToolLink)
Tray.Add(Chr(0x202B) . "✨ رابط حسابي على Github ✨" . Chr(0x202C), OpenAccountLink)
Tray.Add() ; خط فاصل
Tray.Add("تعليق التشغيل السريع", SuspendScript)
Tray.Add("إيقاف مؤقت للاداة", PauseScript)
Tray.Add("إعادة تشغيل الاداة", ReloadScript)
Tray.Add() ; خط فاصل
Tray.Add("خروج", ExitScript)

; إعداد الكليك الشمال على الأيقونة
A_IconTip := "Phone Link - لا يوجد شيء قيد التشغيل"
OnMessage(0x404, TrayIconClick) ; WM_USER + 4

; بدء مراقبة Now Playing
SetTimer(UpdateNowPlaying, 2000) ; تحديث كل ثانيتين
UpdateNowPlaying() ; تحديث فوري

; -------------------------------------------------------------------
; |                      معالج الكليك على الأيقونة                   |
; -------------------------------------------------------------------
TrayIconClick(wParam, lParam, msg, hwnd) {
    if (lParam = 0x202) { ; WM_LBUTTONUP - كليك شمال
        ShowMediaControls()
    }
}

ShowMediaControls() {
    if CurrentTrack.hasAudio {
        ; إنشاء قائمة الميديا
        mediaMenu := Menu()

        ; عرض معلومات المسار
        cleanTitle := RegExReplace(CurrentTrack.title, "\.(mp3|m4a|m4b|aac|flac|wav|ogg|opus|wma|alac|aiff|ape|mp4|mkv|webm|avi|mov|wmv|flv|mpg|mpeg|3gp)$", "")
        if StrLen(cleanTitle) > 50
            cleanTitle := SubStr(cleanTitle, 1, 47) . "..."

        status := CurrentTrack.isPlaying ? "▶️ يعمل الآن" : "⏸️ متوقف مؤقتاً"
        mediaMenu.Add(status, ShowCurrentTrackDetails)
        mediaMenu.Add("🎵 " . cleanTitle, ShowCurrentTrackDetails)
        if CurrentTrack.artist != "" && CurrentTrack.artist != CurrentTrack.source
            mediaMenu.Add("👤 " . CurrentTrack.artist, ShowCurrentTrackDetails)

        mediaMenu.Add() ; خط فاصل

        ; أزرار التحكم
        playPauseText := CurrentTrack.isPlaying ? "⏸️ إيقاف مؤقت" : "▶️ تشغيل"
        mediaMenu.Add(playPauseText, PlayPauseFromMenu)
        mediaMenu.Add("⏮️ السابق", PrevFromMenu)
        mediaMenu.Add("⏭️ التالي", NextFromMenu)

        ; عرض القائمة عند موقع الماوس
        mediaMenu.Show()
    } else {
        ; إذا لم يكن هناك صوت، اعرض رسالة
        MsgBox("🎵 لا يوجد تشغيل صوتي حالياً", "Phone Link", "T3")
    }
}

; -------------------------------------------------------------------
; |                      وظائف قائمة الميديا                         |
; -------------------------------------------------------------------
ShowCurrentTrackDetails(*) {
    if CurrentTrack.hasAudio {
        status := CurrentTrack.isPlaying ? "▶️ يعمل الآن" : "⏸️ متوقف مؤقتاً"
        MsgBox(
            "🎵 " . status . "`n`n" .
            "📱 المصدر: " . CurrentTrack.source . "`n" .
            "🎵 المسار: " . CurrentTrack.title . "`n" .
            "👤 الفنان: " . CurrentTrack.artist,
            "معلومات المسار الحالي",
            "T8"
        )
    }
}

PlayPauseFromMenu(*) {
    HandlePhoneLinkButton("PlayPauseButton", true)
}

NextFromMenu(*) {
    HandlePhoneLinkButton("Next")
}

PrevFromMenu(*) {
    HandlePhoneLinkButton("Previous")
}

; -------------------------------------------------------------------
; |                      وظائف القائمة الرئيسية                      |
; -------------------------------------------------------------------
OpenToolLink(*) {
    Run "https://github.com/Majhool/PhoneLink-Playbook-Buttons"
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
; |                      وظيفة تحديث Now Playing                    |
; -------------------------------------------------------------------
UpdateNowPlaying() {
    try {
        hwnd := WinExist("ahk_exe PhoneExperienceHost.exe")
        if !hwnd {
            UpdateTrayForNoAudio()
            return
        }

        root := UIA.ElementFromHandle(hwnd)
        if !root {
            UpdateTrayForNoAudio()
            return
        }

        ; البحث عن مجموعة Audio Player
        audioGroup := root.FindElement({ AutomationId: "ShadowPanel" })
        if !audioGroup {
            UpdateTrayForNoAudio()
            return
        }

        ; استخراج معلومات المسار من النصوص
        try {
            textElements := audioGroup.FindElements({ Type: "Text" })
            if textElements.Length < 3 {
                UpdateTrayForNoAudio()
                return
            }

            ; النص الأول: مصدر الصوت
            source := textElements[1].Name
            ; النص الثاني: عنوان المسار
            title := textElements[2].Name
            ; النص الثالث: الفنان
            artist := textElements[3].Name

            ; ---  التحقق الجديد ---
            ; إذا كان العنوان فارغًا أو مطابقًا للمصدر (علامة على عدم وجود مسار محدد)،
            ; اعتبر أنه لا يوجد تشغيل صوتي.
            if (Trim(title) = "" or title = source) {
                UpdateTrayForNoAudio()
                return
            }
            ; --- نهاية التحقق الجديد ---

            ; التحقق من حالة التشغيل
            playPauseBtn := audioGroup.FindElement({ AutomationId: "PlayPauseButton" })
            isPlaying := playPauseBtn ? (playPauseBtn.Name = "Pause") : false

            ; تحديث المعلومات
            CurrentTrack.source := source
            CurrentTrack.title := title
            CurrentTrack.artist := artist
            CurrentTrack.isPlaying := isPlaying
            CurrentTrack.hasAudio := true

            UpdateTrayDisplay()
        } catch {
            UpdateTrayForNoAudio()
        }
    } catch {
        UpdateTrayForNoAudio()
    }
}

; -------------------------------------------------------------------
; |                      وظائف تحديث Tray                           |
; -------------------------------------------------------------------
UpdateTrayDisplay() {
    ; تنظيف عنوان المسار (إزالة امتداد الملف إن وجد)
    cleanTitle := RegExReplace(CurrentTrack.title, "\.(mp3|m4a|m4b|aac|flac|wav|ogg|opus|wma|alac|aiff|ape|mp4|mkv|webm|avi|mov|wmv|flv|mpg|mpeg|3gp)$", "")

    ; قطع النص إذا كان طويلاً
    if StrLen(cleanTitle) > 35
        cleanTitle := SubStr(cleanTitle, 1, 32) . "..."

    ; تحديث tooltip
    tooltipText := CurrentTrack.isPlaying ? "▶️ يعمل الآن: " : "⏸️ متوقف مؤقتاً: "
    tooltipText .= cleanTitle
    if CurrentTrack.artist != "" && CurrentTrack.artist != CurrentTrack.source {
        artistClean := CurrentTrack.artist
        if StrLen(artistClean) > 30
            artistClean := SubStr(artistClean, 1, 27) . "..."
        tooltipText .= " - " . artistClean
    }
    tooltipText .= "`n(انقر للمعلومات | انقر باليمين للقائمة)"

    A_IconTip := tooltipText

    if CurrentTrack.isPlaying
        TraySetIcon TrayIcons.playing
    else
        TraySetIcon TrayIcons.paused
}

UpdateTrayForNoAudio() {
    CurrentTrack.hasAudio := false
    CurrentTrack.source := ""
    CurrentTrack.title := ""
    CurrentTrack.artist := ""
    CurrentTrack.isPlaying := false

    A_IconTip := "Phone Link - لا يوجد تشغيل صوتي`n(انقر للمعلومات | انقر باليمين للقائمة)"
    TraySetIcon TrayIcons.idle
}

; -------------------------------------------------------------------
; |             الكود الأساسي للتحكم في Phone Link (النسخة الجديدة)     |
; -------------------------------------------------------------------
HandlePhoneLinkButton(identifier, isAutomationId := false) {
    hwnd := WinExist("ahk_exe PhoneExperienceHost.exe")
    if !hwnd
        return

    root := UIA.ElementFromHandle(hwnd)
    if !root
        return

    try {
        condition := isAutomationId ? { AutomationId: identifier } : { Name: identifier }
        btn := root.FindElement(condition)

        if btn {
            if btn.LegacyIAccessiblePattern
                btn.LegacyIAccessiblePattern.DoDefaultAction()
            else
                btn.Invoke()

            ; <<< التغيير الوحيد هنا: استدعاء حلقة التحديث السريع >>>
            StartFastUpdate()
        }
    } catch {
        ; تجاهل الخطأ إذا لم يكن الزر موجودًا
    }
}

; -------------------------------------------------------------------
; |                      اختصارات لوحة المفاتيح                     |
; -------------------------------------------------------------------
Media_Play_Pause:: HandlePhoneLinkButton("PlayPauseButton", true)
Media_Next:: HandlePhoneLinkButton("Next")
Media_Prev:: HandlePhoneLinkButton("Previous")