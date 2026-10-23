# COMPI 3D

**Belajar perangkat keras komputer jadi lebih seru, visual, dan interaktif.**

COMPI 3D adalah aplikasi pembelajaran berbasis Flutter untuk mengenal komponen komputer. Pengguna dapat mempelajari materi, melihat model komponen dalam tampilan 3D, lalu menguji pemahaman melalui kuis dan permainan mencocokkan.

[![Flutter](https://img.shields.io/badge/Flutter-SDK-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7%2B-0175C2?logo=dart)](https://dart.dev)

## ✨ Fitur utama

- **Materi terstruktur** untuk motherboard, CPU, RAM, GPU, storage, PSU, cooling system, dan casing.
- **Eksplorasi 3D interaktif** untuk melihat dan memutar model perangkat keras.
- **Belajar sambil bermain** melalui kuis dan permainan mencocokkan komponen.
- **Progres belajar tersimpan** pada perangkat, termasuk identitas pengguna.
- **Tampilan responsif** dengan navigasi Beranda, Materi, dan Praktik.

## 📸 Tangkapan layar

Lihat galeri screenshot antarmuka COMPI 3D di Google Drive:

<p align="center">
  <a href="https://drive.google.com/drive/folders/1X7_27bkN3wdltJ2-K08R9fiMUpRmeY8O?usp=drive_link">
    <img src="https://img.shields.io/badge/BUKA%20GALERI-Screenshot%20COMPI%203D-0757D8?style=for-the-badge&logo=google-drive&logoColor=white" alt="Buka galeri screenshot COMPI 3D di Google Drive">
  </a>
</p>

> Jika galeri tidak dapat dibuka, pastikan akses folder Google Drive telah dibagikan kepada pengguna yang memiliki tautan.

## 🚀 Menjalankan proyek

### Persyaratan

- [Flutter SDK](https://docs.flutter.dev/get-started/install) dengan Dart SDK **3.7 atau lebih baru**.
- Android Studio/emulator atau perangkat Android untuk menjalankan aplikasi Android.
- Google Chrome jika ingin menjalankan versi web.

### Langkah-langkah

1. **Clone repositori**

   ```bash
   git clone https://github.com/alnidogavincy/COMPI.git
   cd COMPI
   ```

2. **Pasang dependensi**

   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**

   Pastikan emulator atau perangkat sudah terhubung, lalu jalankan:

   ```bash
   flutter run
   ```

   Untuk menjalankan versi web di Chrome:

   ```bash
   flutter run -d chrome
   ```

### Menjalankan pengujian

```bash
flutter test
```

## 🧰 Teknologi

- [Flutter](https://flutter.dev) dan Dart
- Provider untuk pengelolaan state
- Shared Preferences untuk penyimpanan data lokal
- `model_viewer_plus` untuk menampilkan model 3D

## 📁 Struktur proyek

```text
lib/          Kode sumber aplikasi
assets/       Gambar, font, dan model 3D
test/         Pengujian aplikasi
docs/         Dokumentasi aset
```
