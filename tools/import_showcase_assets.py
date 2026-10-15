"""Import the supplied hero image and bundle Acme for offline headings."""
from pathlib import Path
import shutil
from urllib.request import urlopen

root = Path(__file__).resolve().parents[1]
shutil.copy2(
    Path(r'D:\AL\11.Downloads\Futuristic Floating PC Hardware Showcase.png'),
    root / 'assets/images/hardware_showcase.png',
)
target = root / 'assets/fonts'
for source, name in [('Acme-Regular.ttf', 'Acme-Regular.ttf'), ('OFL.txt', 'Acme-OFL.txt')]:
    with urlopen('https://raw.githubusercontent.com/google/fonts/main/ofl/acme/' + source, timeout=60) as response:
        data = response.read()
    if source.endswith('.ttf'):
        assert data[:4] in (b'\x00\x01\x00\x00', b'OTTO')
    (target / name).write_bytes(data)
    print(name, len(data))
