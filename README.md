<h1>التحكم في تشغيل الوسائط عبر Phone Link باستخدام لوحة المفاتيح</h1>

<p>الاداة بكل بساطة بتسمحلك تتحكم بمتحكم المحتوى في برنامج PhoneLink من Microsoft باستخدام الكيبورد</p>

<h2>✨ الميزات</h2>
<ul>
  <li><strong>التحكم من لوحة المفاتيح:</strong> استخدم أزرار الوسائط الفعلية على لوحة مفاتيحك للتحكم بالتشغيل.</li>
  <li><strong>أيقونة ديناميكية:</strong> تتغير في شريط المهام حسب حالة التشغيل (▶️، ⏸️).</li>
  <li><strong>قائمة سياق:</strong> انقر على الايقونة في شريط المهام للوصول السريع للتحكمات ومعرفة ما يتم تشغيله.</li>
</ul>

<h2>🚀 البدء (الطريقة السهلة)</h2>
<p>لا حاجة للتثبيت. ما عليك سوى تحميل الاداة وتشغيلها:</p>
<ol>
  <li>اذهب إلى <strong><a href="https://github.com/Majhool/PhoneLink-Playback-Buttons/releases/latest">صفحة الإصدارات (Releases)</a></strong>.</li>
  <li>قم بتحميل أحدث ملف <code>Playback.exe</code>.</li>
  <li>شغّله! هذا كل شيء. ستظهر الأداة في شريط المهام لديك.</li>
</ol>

<h2>⚠️ ملاحظة هامة: إعدادات أزرار لوحة المفاتيح</h2>
<p>تمت برمجة هذه الأداة بشكل افتراضي لاستخدام أزرار الوسائط القياسية:</p>
<ul>
  <li><code>Media_Play_Pause</code></li>
  <li><code>Media_Next</code></li>
  <li><code>Media_Prev</code></li>
</ul>
<p>إذا كانت لوحة مفاتيحك لا تحتوي على هذه الأزرار، أو كنت ترغب في استخدام مفاتيح مختلفة (مثل <code>F7</code>، <code>F8</code>، إلخ)، فانتقل لقسم <a href="#%EF%B8%8F-للمطورين-البناء-من-المصدر">للمطورين (البناء من المصدر)</a></p>

<h2>🛠️ للمطورين (البناء من المصدر)</h2>
<p>هذا الجزء مخصص لك إذا أردت تغيير الأزرار المستخدمة أو التعديل على الكود المصدري.</p>

<p><strong>متى تحتاج لهذا؟</strong> إذا كانت لوحة مفاتيحك لا تحتوي على أزرار وسائط، أو إذا كنت تفضل استخدام أزرار أخرى (مثل F-keys).</p>

<p><strong>ماذا ستحتاج؟</strong></p>
<ol>
  <li><strong>برنامج AutoHotkey v2:</strong> قم بتحميله وتثبيته من <a href="https://www.autohotkey.com/">موقعه الرسمي</a>.</li>
  <li><strong>الكود:</strong> قم بتحميل المشروع من <a href="https://github.com/Majhool/PhoneLink-Playback-Buttons/archive/refs/heads/main.zip">هنا</a>.</li>
</ol>

<p><strong>الخطوات:</strong></p>
<ol>
  <li>افتح ملف <code>Playback.ahk</code> باستخدام أي محرر نصوص.</li>
  <li>ابحث عن الأسطر التي تحتوي على <code>Media_Play_Pause</code>, <code>Media_Next</code>, <code>Media_Prev</code> وقم بتغييرها إلى أسماء الأزرار التي تريدها. (يمكنك إيجاد قائمة بأسماء المفاتيح في <a href="https://www.autohotkey.com/docs/v2/KeyList.htm">توثيق AutoHotkey</a>).</li>
</ol>

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

<h2>مصادر الملفات</h2>
<ul>
  <li>
    <strong>سكربت UIA:</strong>
    اساس المشروع من موقع
    <a href="https://github.com/Descolada/UIA-v2">https://github.com/Descolada/UIA-v2</a>
  </li>
  <li>
    <strong>حل مشكلة Powershell:</strong>
    من الموقع
    <a href="https://serverfault.com/a/1015682">https://serverfault.com/a/1015682</a>
  </li>
  <li>
    <strong>الايقونات:</strong>
    <a href="https://icon-icons.com">https://icon-icons.com</a>
  </li>
</ul>


يتم بناء الإصدارات الرسمية تلقائيًا باستخدام GitHub Actions، ويمكنك الاطلاع على ملفات `.github/workflows/build.yml` و `.github/actions/ahk-compiler/action.yml` لمعرفة كيفية عمل هذه العملية.
