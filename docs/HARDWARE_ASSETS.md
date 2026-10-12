# Aset Hardware COMPI

Delapan ilustrasi kartu dibuat dengan built-in `image_gen` (bukan screenshot halaman dan bukan render dari GLB). Semua gambar sudah disalin ke repository. Ilustrasi mewakili kategori; detailnya dapat berbeda dari model 3D pengguna.

| Komponen | Gambar runtime |
|---|---|
| motherboard | `assets/images/hardware_motherboard.png` |
| cpu | `assets/images/hardware_cpu.png` |
| ram | `assets/images/hardware_ram.png` |
| vga | `assets/images/hardware_vga.png` |
| storage | `assets/images/hardware_storage.png` |
| psu | `assets/images/hardware_psu.png` |
| cooling | `assets/images/hardware_cooling.png` |
| casing | `assets/images/hardware_casing.png` |

## Prompt final

### motherboard

Use case: stylized-concept. Asset type: COMPI Indonesian computer hardware learning app card illustration. Create a polished realistic 3D product illustration of one black ATX desktop motherboard, clearly showing CPU socket, RAM slots and PCIe slots, three-quarter isometric angle, centered and fully contained with 12% margin. Landscape 3:2 composition. Vivid cyan and royal blue circuit-grid backdrop, cyan rim lighting, metallic detail, educational game art matching a colorful SMK hardware learning app. No text, no labels, no logo, no border, no buttons, no watermark. Subject must be clearly readable at thumbnail size.

### cpu

Use case: stylized-concept. Asset type: COMPI Indonesian computer hardware learning app card illustration. Create a polished realistic 3D product illustration of one desktop CPU processor with silver metal heatspreader, green substrate and gold edge contacts, three-quarter isometric angle, centered and fully contained with 12% margin. Landscape 3:2 composition. Vivid cyan and royal blue circuit-grid backdrop, cyan rim lighting, metallic detail, educational game art matching a colorful SMK hardware learning app. No text, no labels, no logo, no border, no buttons, no watermark. Subject must be clearly readable at thumbnail size.

### ram

Use case: stylized-concept. Asset type: COMPI Indonesian computer hardware learning app card illustration. Create a polished realistic 3D product illustration of two black desktop RAM memory DIMM sticks with cyan and purple light strips and gold connector fingers, three-quarter isometric angle, centered and fully contained with 12% margin. Landscape 3:2 composition. Vivid cyan and royal blue circuit-grid backdrop, cyan rim lighting, metallic detail, educational game art matching a colorful SMK hardware learning app. No text, no labels, no logo, no border, no buttons, no watermark. Subject must be clearly readable at thumbnail size.

### vga

Use case: stylized-concept. Asset type: COMPI Indonesian computer hardware learning app card illustration. Create a polished realistic 3D product illustration of one large black triple-fan desktop graphics card with visible heatsink and PCIe connector, three-quarter isometric angle, centered and fully contained with 12% margin. Landscape 3:2 composition. Vivid cyan and royal blue circuit-grid backdrop, cyan rim lighting, metallic detail, educational game art matching a colorful SMK hardware learning app. No text, no labels, no logo, no border, no buttons, no watermark. Subject must be clearly readable at thumbnail size.

### storage

Use case: stylized-concept. Asset type: COMPI Indonesian computer hardware learning app card illustration. Create a polished realistic 3D product illustration of a clearly separated group of one M.2 SSD circuit stick, one 2.5 inch SATA SSD and one hard disk drive with visible platter, three-quarter isometric angle, centered and fully contained with 12% margin. Landscape 3:2 composition. Vivid cyan and royal blue circuit-grid backdrop, cyan rim lighting, metallic detail, educational game art matching a colorful SMK hardware learning app. No text, no labels, no logo, no border, no buttons, no watermark. Subject must be clearly readable at thumbnail size.

### psu

Use case: stylized-concept. Asset type: COMPI Indonesian computer hardware learning app card illustration. Create a polished realistic 3D product illustration of one black desktop modular power supply unit showing circular fan grille and a small bundle of cables, three-quarter isometric angle, centered and fully contained with 12% margin. Landscape 3:2 composition. Vivid cyan and royal blue circuit-grid backdrop, cyan rim lighting, metallic detail, educational game art matching a colorful SMK hardware learning app. No text, no labels, no logo, no border, no buttons, no watermark. Subject must be clearly readable at thumbnail size.

### cooling

Use case: stylized-concept. Asset type: COMPI Indonesian computer hardware learning app card illustration. Create a polished realistic 3D product illustration of one tower CPU air cooler with metallic heatsink fins and a cyan-lit fan beside one dual-fan liquid cooling radiator with its tubes and pump, three-quarter isometric angle, centered and fully contained with 12% margin. Landscape 3:2 composition. Vivid cyan and royal blue circuit-grid backdrop, cyan rim lighting, metallic detail, educational game art matching a colorful SMK hardware learning app. No text, no labels, no logo, no border, no buttons, no watermark. Subject must be clearly readable at thumbnail size.

### casing

Use case: stylized-concept. Asset type: COMPI Indonesian computer hardware learning app card illustration. Create a polished realistic 3D product illustration of one empty black mid-tower computer chassis, side panel removed to clearly show empty interior, motherboard tray and front case fans, three-quarter isometric angle, centered and fully contained with 12% margin. Landscape 3:2 composition. Vivid cyan and royal blue circuit-grid backdrop, cyan rim lighting, metallic detail, educational game art matching a colorful SMK hardware learning app. No text, no labels, no logo, no border, no buttons, no watermark. Subject must be clearly readable at thumbnail size.

## Model 3D

## Verifikasi integrasi

- Lima tes Flutter lulus: katalog aset, kompatibilitas progres, skor, navigasi layar kecil, dan alur Splash menuju identitas.
- Pratinjau web memperlihatkan gambar Library dan detail Storage; model Storage berhasil dirender oleh viewer interaktif.
- Pengujian perangkat Android fisik belum dilakukan.

## Berkas model

Tujuh GLB diberikan pengguna; disalin tanpa mengubah berkas asli. Total sekitar 41 MB. Header GLB v2 dan dependensi buffer/gambar internal telah diperiksa. Model motherboard memiliki 720 mesh dan perlu diuji pada Android target.

Atribusi dari metadata model tersedia di `assets/models/CREDITS.md` dan panel Kredit model 3D pada Explore. Model casing berlisensi CC-BY-NC-4.0; enam model lain mencantumkan CC-BY-4.0. Cooling System belum memiliki GLB, sehingga memiliki materi dan ilustrasi tanpa tombol 3D.

