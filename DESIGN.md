# COMPI 3D — Design System

## Sumber dan prioritas

Kode Flutter aktual menentukan kemampuan dan batas teknis. Delapan screenshot di `D:/AL/11.Downloads/COMPI V2/` menentukan arah visual; PRD/SRD menentukan fungsi; Laporan Final memberi konteks. Folder `references/` dari brief belum ada di repository. Screenshot adalah referensi, bukan aset runtime satu halaman. Ilustrasi hardware terpisah akan disediakan pemilik proyek.

## Identitas visual

- Karakter: media belajar TKJ yang ekspresif dan terasa seperti permainan edukasi. Hampir seluruh bidang memakai biru, cyan, pola grid/circuit, dan aksen sudut oranye/kuning. Panel baca memakai biru sangat muda agar teks gelap terbaca.
- Token aktif di `lib/ui/core/app_colors.dart`: `primary #0757D8`, `primaryDark #062E83`, `cyan #04BDF0`, `sky #5DDCFF`, `orange #FF7817`, `yellow #FFC42E`, `ink #071B51`, `surface #F2FBFF`.
- Heading besar dan tebal; body minimum sekitar 14–16sp. Konten penting tetap berupa teks Flutter, bukan teks yang dibakar ke gambar. Gunakan `Roboto` sampai font merek disediakan.
- Spacing dasar 8dp, jarak halaman 16dp, radius panel sekitar 18–24dp, target sentuh minimal 48dp. Seluruh konten tinggi memakai scroll; inset sistem dipenuhi lewat `SafeArea`.
- Komponen bersama: `CircuitBackground`, `CompiHeader`, `CompiPanel`, `SectionBanner`, `CompiButton` di `lib/ui/core/compi_widgets.dart`. Navigasi utama memiliki tiga tab: Beranda, Materi, Praktik. Profil diakses lewat tombol pada header.

## Spesifikasi layar

| Referensi | Layar | Hierarki utama |
|---|---|---|
| 1. Home.png | Splash | Latar circuit, logo/ilustrasi di panel utama, judul COMPI 3D, subjudul |
| 2.Login.png | Identitas | Header, hero hardware, panel form, CTA oranye |
| 3.Beranda.png | Beranda | Sapaan, hero belajar, progres nyata, akses cepat, lanjut materi |
| 4.Materi.png | Library | Header, pencarian, filter, grid komponen, akses 3D |
| 5.Explore 3D.png | Explore | Viewport model nyata, instruksi gestur, info komponen, pilihan model |
| 6.Materi.png | Materi | Hero komponen, konten terstruktur, tandai selesai, link 3D/kuis |
| 7.Quiz.png | Menu Praktik | Hero challenge, skor tertinggi, dua mode game |
| 8.Quiz.png | Kuis | Header, progres soal, panel pertanyaan, pilihan besar, kirim jawaban |

Match, hasil game, dan Profil tidak memiliki screenshot baru. Ketiganya memakai komponen dan token yang sama. Screenshot menampilkan PC rakitan, delapan kategori, serta XP/streak; data dan model itu belum tersedia. UI tidak menampilkan angka contoh sebagai data nyata.

## Aset dan 3D

Saat ini runtime memiliki `app_logo.png`, `splash_cube.png`, `hardware_banner.png`, dan empat `.glb` komponen. Model tetap dirender oleh `model_viewer_plus` dengan gestur kamera. Pemilihan empat model dilakukan lewat daftar; hotspot langsung pada model menunggu aset/model yang mendukungnya. Setelah ilustrasi baru diterima, pisahkan tiap gambar hardware dari dekorasi panel, optimalkan ukuran, tambahkan ke `pubspec.yaml`, dan catat asal serta izin pakai. Jangan memasang screenshot penuh sebagai background layar.

## Pemeriksaan visual

Bandingkan Android screenshot pada 360×800, 393×873, dan ponsel besar. Periksa dominasi biru/cyan, CTA oranye, keterbacaan, cropping aset, grid dua kolom, keyboard pada form, text scale, status/navigation bar, dan tidak ada overflow. Uji viewer 3D pada perangkat Android serta offline.
