# التحكم في تشغيل الوسائط عبر Phone Link باستخدام لوحة المفاتيح

الاداة بكل بساطة بتسمحلك تتحكم بمتحكم المحتوى في برنامج PhoneLink من Microsoft باستخدام الكيبورد

## ✨ الميزات

- **التحكم من لوحة المفاتيح:** استخدم أزرار الوسائط الفعلية على لوحة مفاتيحك للتحكم بالتشغيل.
- **أيقونة ديناميكية:** تتغير في شريط المهام حسب حالة التشغيل (▶️، ⏸️).
- **قائمة سياق:** انقر على الايقونة في شريط المهام للوصول السريع للتحكمات ومعرفة ما يتم تشغيله.

## 🚀 البدء (الطريقة السهلة)

لا حاجة للتثبيت. ما عليك سوى تحميل الاداة وتشغيلها:

1.  اذهب إلى **[صفحة الإصدارات (Releases)](https://github.com/Majhool/PhoneLink-Playback-Buttons/releases/latest)**.
2.  قم بتحميل أحدث ملف `Playback.exe`.
3.  شغّله\! هذا كل شيء. ستظهر الأداة في شريط المهام لديك.

## ⚠️ ملاحظة هامة: إعدادات أزرار لوحة المفاتيح

تمت برمجة هذه الأداة بشكل افتراضي لاستخدام أزرار الوسائط القياسية:

  * `Media_Play_Pause`
  * `Media_Next`
  * `Media_Prev`

إذا كانت لوحة مفاتيحك لا تحتوي على هذه الأزرار، أو كنت ترغب في استخدام مفاتيح مختلفة (مثل `F7`، `F8`، إلخ)، فانتقل لقسم [للمطورين (البناء من المصدر)](#%EF%B8%8F-للمطورين-البناء-من-المصدر)

## 🛠️ للمطورين (البناء من المصدر)
هذا الجزء مخصص لك إذا أردت تغيير الأزرار المستخدمة أو التعديل على الكود المصدري.

**متى تحتاج لهذا؟** إذا كانت لوحة مفاتيحك لا تحتوي على أزرار وسائط، أو إذا كنت تفضل استخدام أزرار أخرى (مثل F-keys).

**ماذا ستحتاج؟**

1.  **برنامج AutoHotkey v2:** قم بتحميله وتثبيته من [موقعه الرسمي](https://www.autohotkey.com/).
2.  **الكود:** قم بتحميل المشروع من [هنا](https://github.com/Majhool/PhoneLink-Playback-Buttons/archive/refs/heads/main.zip).

**الخطوات:**

1.  افتح ملف `Playback.ahk` باستخدام أي محرر نصوص.
2.  ابحث عن الأسطر التي تحتوي على `Media_Play_Pause`, `Media_Next`, `Media_Prev` وقم بتغييرها إلى أسماء الأزرار التي تريدها. (يمكنك إيجاد قائمة بأسماء المفاتيح في [توثيق AutoHotkey](https://www.autohotkey.com/docs/v2/KeyList.htm)).
<div dir="rtl">
<ol start="3">
  <li>
    بعد حفظ التعديلات، يمكنك:
    <ul>
      <li>
        <strong>تشغيل السكربت مباشرة:</strong> بالنقر المزدوج على ملف
        <code dir="ltr">Playback.ahk</code>.
      </li>
      <li>
        <strong>إعادة تجميعه (<span dir="ltr">Compile</span>):</strong> لتحويله إلى ملف
        <code dir="ltr">.exe</code> جديد ومستقل باستخدام برنامج <code dir="ltr">Ahk2Exe</code>.
      </li>
      <li>
        <strong>ملاحظة:</strong> عند تثبيت <span dir="ltr">AutoHotKeys</span> لا يثبت معه برنامج
        <code dir="ltr">Ahk2Exe</code>، يجب تثبيته من خلال برنامج <span dir="ltr">AutoHotkey Dash</span> ثم اختيار <span dir="ltr">compile</span> والموافقة على التنزيل.
      </li>
      <li>
        في حال عدم ظهور <span dir="ltr">AutoHotkey Dash</span>، يجب عليك الذهاب لمسار تثبيت
        التطبيق (افتراضياً):
        <ul>
          <li>
            في حال كان التثبيت لكل المستخدمين:
            <code dir="ltr">C:\Program Files\AutoHotkey\</code>
          </li>
          <li>
            في حال كان للمستخدم الحالي:
            <code dir="ltr">%localappdata%\Programs\AutoHotkey</code>
          </li>
        </ul>
      </li>
      <li>
        ثم الذهاب لمجلد <span dir="ltr">UX</span>، حيث يُفترض أن يتواجد ملف بهذا الاسم
        <code dir="ltr">install-ahk2exe.ahk</code>. قم بفتحه وتنزيل
        <code dir="ltr">Ahk2Exe</code>.
      </li>
    </ul>
  </li>
</ol>
</div>

  
يتم بناء الإصدارات الرسمية تلقائيًا باستخدام GitHub Actions، ويمكنك الاطلاع على ملفات `.github/workflows/build.yml` و `.github/actions/ahk-compiler/action.yml` لمعرفة كيفية عمل هذه العملية.
