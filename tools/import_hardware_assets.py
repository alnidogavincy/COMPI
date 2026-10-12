"""Validate and copy the user-supplied GLB assets without changing originals."""
from pathlib import Path
import json
import shutil
import struct
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--only', help='Import only this destination; retain other installed models.')
args = parser.parse_args()

ROOT = Path(__file__).resolve().parents[1]
SOURCE = Path(r'D:\AL\11.Downloads\File Asset 3D')
MODELS = {
    'am4_cpu__free.glb': 'cpu_am4.glb',
    'asus_rog_geforce_rtx_4090_v2.0.glb': 'gpu_rtx4090.glb',
    'computer_case.glb': 'computer_case.glb',
    'motherboard__components.glb': 'motherboard_components.glb',
    'psu_power_supply_unit.glb': 'psu.glb',
    'random_access_memory.glb': 'memory_ram.glb',
    'storage_ssd_hdd_m.2.glb': 'storage.glb',
    r'D:\AL\11.Downloads\corsair_h150i_elitie_cpu_liquid_cooler.glb': 'cooling.glb',
}

credits = {}
for original, destination in MODELS.items():
    target = ROOT / 'assets' / 'models' / destination
    importing = args.only is None or args.only == destination
    source = SOURCE / original if importing else target
    with source.open('rb') as stream:
        magic, version, size = struct.unpack('<4sII', stream.read(12))
        assert magic == b'glTF' and version == 2 and size == source.stat().st_size, original
        length, kind = struct.unpack('<II', stream.read(8))
        assert kind == 0x4E4F534A, original
        document = json.loads(stream.read(length))
    external = [x['uri'] for group in ('buffers', 'images') for x in document.get(group, []) if 'uri' in x and not x['uri'].startswith('data:')]
    assert not external, f'{original} has external dependencies: {external}'
    if importing:
        shutil.copy2(source, target)
    extra = document.get('asset', {}).get('extras', {})
    credits['assets/models/' + destination] = '\n'.join([extra.get('title', original), extra.get('author', ''), extra.get('license', ''), extra.get('source', ''), 'Model asli; tidak dimodifikasi.'])
    print(json.dumps({'file': destination, 'megabytes': round(size / 1048576, 2), 'meshes': len(document.get('meshes', [])), 'extensions': document.get('extensionsRequired', []), 'asset': document.get('asset', {})}, ensure_ascii=True))

(ROOT / 'lib/data/model_credits.dart').write_text('// Credits extracted from the supplied GLB metadata.\nconst modelCredits = <String, String>' + json.dumps(credits, ensure_ascii=True, indent=2) + ';\n', encoding='utf-8')
(ROOT / 'assets/models/CREDITS.md').write_text('# Model credits\n\n' + '\n\n'.join('## ' + key + '\n\n' + value for key, value in credits.items()), encoding='utf-8')
