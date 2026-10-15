"""Bundle Poppins from the official Google Fonts repository for offline use."""
from pathlib import Path
from urllib.request import urlopen

target = Path(__file__).resolve().parents[1] / 'assets/fonts'
target.mkdir(exist_ok=True)
base = 'https://raw.githubusercontent.com/google/fonts/main/ofl/poppins/'
for name in ['Poppins-Regular.ttf', 'Poppins-Medium.ttf', 'Poppins-SemiBold.ttf',
             'Poppins-Bold.ttf', 'Poppins-ExtraBold.ttf', 'Poppins-Black.ttf', 'OFL.txt']:
    with urlopen(base + name, timeout=60) as response:
        data = response.read()
    if name.endswith('.ttf'):
        assert data[:4] in (b'\x00\x01\x00\x00', b'OTTO'), name
    (target / name).write_bytes(data)
    print(name, len(data))
