"""Package the supplied PNG into the platform icon sizes (no artwork changes)."""
from pathlib import Path
import json
import shutil
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SOURCE = Path(r'D:\AL\11.Downloads\Desain tanpa judul.png')
image = Image.open(SOURCE).convert('RGBA')
print('Source:', image.size, 'alpha bounds:', image.getchannel('A').getbbox())
shutil.copy2(SOURCE, ROOT / 'assets/images/app_logo.png')

def export(relative, size, opaque=False):
    icon = image.resize((size, size), Image.Resampling.LANCZOS)
    if opaque:
        background = Image.new('RGB', icon.size, 'white')
        background.paste(icon, mask=icon.getchannel('A'))
        icon = background
    icon.save(ROOT / relative)
    with Image.open(ROOT / relative) as check:
        assert check.size == (size, size)

for density, size in [('mdpi',48), ('hdpi',72), ('xhdpi',96), ('xxhdpi',144), ('xxxhdpi',192)]:
    export(f'android/app/src/main/res/mipmap-{density}/ic_launcher.png', size)
for platform in ['ios', 'macos']:
    directory = Path(platform) / 'Runner/Assets.xcassets/AppIcon.appiconset'
    manifest = json.loads((ROOT / directory / 'Contents.json').read_text())
    for entry in manifest['images']:
        if 'filename' in entry:
            size = round(float(entry['size'].split('x')[0]) * float(entry['scale'].rstrip('x')))
            export(directory / entry['filename'], size, opaque=True)
for size in [192, 512]:
    export(f'web/icons/Icon-{size}.png', size)
    export(f'web/icons/Icon-maskable-{size}.png', size, opaque=True)
export('web/favicon.png', 32)
image.save(ROOT / 'windows/runner/resources/app_icon.ico', format='ICO', sizes=[(s,s) for s in [16,24,32,48,64,128,256]])

replacements = {
    'android/app/src/main/AndroidManifest.xml': [('android:label="compi"', 'android:label="Compi"')],
    'ios/Runner/Info.plist': [('<string>compi</string>', '<string>Compi</string>')],
    'macos/Runner/Configs/AppInfo.xcconfig': [('PRODUCT_NAME = compi', 'PRODUCT_NAME = Compi')],
    'windows/runner/main.cpp': [('L"compi"', 'L"Compi"')],
    'windows/runner/Runner.rc': [('"FileDescription", "compi"', '"FileDescription", "Compi"'), ('"ProductName", "compi"', '"ProductName", "Compi"')],
    'linux/runner/my_application.cc': [('"compi"', '"Compi"')],
    'web/index.html': [('content="compi"', 'content="Compi"'), ('<title>compi</title>', '<title>Compi</title>')],
    'web/manifest.json': [('"name": "compi"', '"name": "Compi"'), ('"short_name": "compi"', '"short_name": "Compi"')],
    'lib/main.dart': [("title: 'COMPI'", "title: 'Compi'")],
    'lib/ui/features/auth/splash_screen.dart': [("'assets/images/splash_cube.png'", "'assets/images/app_logo.png'")],
}
for relative, changes in replacements.items():
    path = ROOT / relative
    if not path.exists():
        continue
    with path.open('r', encoding='utf-8', newline='') as stream:
        text = stream.read()
    for old, new in changes:
        text = text.replace(old, new)
    with path.open('w', encoding='utf-8', newline='') as stream:
        stream.write(text)
print('UI logo, launcher icons, and display names updated.')
