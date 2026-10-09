from pathlib import Path
import json
import shutil

root = Path(__file__).resolve().parents[1]
items = json.loads((root / 'tools/hardware_images.json').read_text(encoding='utf-8'))
for item in items:
    shutil.copy2(item['source'], root / item['destination'])
    print(item['destination'])
