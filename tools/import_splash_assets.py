from pathlib import Path
from shutil import copyfile
from PIL import Image

assets = Path('assets/images')
for src, name in [
    (Path(r'C:\Users\alnid\Downloads\Latar Abstrak Kabut Biru Lembut.png'), 'splash_mist.png'),
    (Path(r'D:\AL\11.Downloads\COMPI (6).png'), 'splash_brand.png'),
]:
    image = Image.open(src)
    print(name, image.size, image.mode, image.getextrema())
    copyfile(src, assets / name)
