# COMPI 3D — Implementation Plan dan Audit

## Pembaruan implementasi: aset pengguna

- [x] Impor dan validasi tujuh GLB pengguna; sumber asli tidak diubah.
- [x] Tambahkan Storage, PSU, Cooling System, Casing beserta delapan materi dan empat soal baru. Total 8 komponen, 16 materi, 12 soal. Semua ID materi lama dipertahankan.
- [x] Buat delapan ilustrasi hardware dan tampilkan pada kartu Library serta detail materi.
- [x] Animasi logo 3,2 detik lalu form nama; identitas tersimpan terisi otomatis, tanpa melewati form.
- [x] Cantumkan kredit pembuat model dari metadata GLB di aplikasi dan dokumentasi aset.
- [x] Cooling GLB Corsair H150i ditambahkan pada 12 Oktober 2026; tersedia melalui materi dan Explore 3D.
- [ ] Pengujian performa semua model di Android target masih menunggu perangkat.

Kondisi empat komponen dan aset menunggu pengguna pada bagian audit berikut adalah catatan sebelum pembaruan ini.

## Kondisi proyek

Repository adalah Flutter/Dart dengan `provider`, `shared_preferences`, dan `model_viewer_plus`. Struktur utama: `lib/data` (model, konten lokal, repository), `lib/ui/providers`, `lib/ui/core`, dan `lib/ui/features`. Navigasi menggunakan `Navigator` dan tiga tab utama. Model 3D lokal: motherboard, CPU, RAM, VGA. Delapan materi memakai ID stabil `mat_*`; kuis dan Match memakai data lokal. Data progres tersimpan sebagai JSON pada key `user_progress` dan memuat `completedMaterials`, `highestQuizScore`, `unlockedBadges`.

Layar yang ada: Splash, Identitas, Beranda, Library, Explore 3D, detail materi, menu game, Component Challenge, Match the Component, hasil, Profil. Audit awal menemukan identitas tidak disimpan, skor tertinggi tidak diperbarui setelah game, Match memakai hasil kuis, serta sejumlah angka/waktu/XP/streak contoh. Search Library telah berjalan meski PRD menyebutnya di luar scope. Folder `references/` belum tersedia. Referensi aktual berada di lokasi Downloads yang diberikan pemilik proyek.

## Fitur yang dipertahankan dan konflik scope

- Pertahankan alur Explore → Learn → Play → Progress, empat model `.glb`, pencarian dan filter, semua ID materi, dua mode permainan, serta key progres lokal. Tidak ada migrasi atau reset storage.
- Identitas disimpan terpisah pada key `student_identity` tanpa autentikasi server. Beranda dan Profil menggunakan data tersebut.
- Model PC rakitan dan hotspot yang menempel pada objek, empat kategori hardware tambahan, XP/streak/badge lengkap, serta simulasi pemasangan adalah pekerjaan lanjutan karena aset/data dan perilakunya belum tersedia. Jangan menampilkan klaim palsu.
- Laporan Final dan PRD/SRD menjadi dasar fungsi; screenshot menjadi dasar visual. Ilustrasi terpisah akan disediakan pengguna. `DESIGN.md` starter menjadi masukan, bukan sumber yang mengalahkan kode dan brief terbaru.

## Pemetaan referensi

| Screenshot | Implementasi Flutter | Status |
|---|---|---|
| 1. Home.png | `SplashScreen` | Remake visual |
| 2.Login.png | `LoginScreen` | Remake + identitas lokal |
| 3.Beranda.png | `HomeScreen` | Remake + progres aktual |
| 4.Materi.png | `LibraryScreen` | Remake + pencarian yang dipertahankan |
| 5.Explore 3D.png | `Explore3DScreen` | Remake + empat model nyata |
| 6.Materi.png | `MaterialDetailScreen` | Remake + selesai membaca |
| 7.Quiz.png | `GamesScreen` | Remake + dua mode |
| 8.Quiz.png | `QuizScreen` | Remake + skor dan progres aktual |

## Tahap implementasi

- [x] Fondasi visual: token, latar circuit, panel, CTA, header, navigasi tiga tab. Uji: render layar kecil/besar tanpa overflow.
- [x] Identitas: simpan lokal dan tampilkan pada Beranda/Profil. Uji: relaunch tetap menunjukkan identitas dan progres lama.
- [x] Beranda/Library: progres berasal dari jumlah materi nyata, daftar hanya komponen yang tersedia. Uji: cari/filter, buka materi, tandai selesai, lalu lihat progres.
- [x] Explore/Materi: tetap gunakan `ModelViewer` dan `.glb`; kontrol reset memuat ulang viewer, pilihan model nyata, materi terkait terbuka. Uji: rotate/zoom/reset dan akses materi di Android.
- [x] Game/Profil: hasil dua mode memakai jumlah benar/total, skor tertinggi disimpan; metrik palsu dihapus. Uji: soal benar/salah, pencocokan benar/salah, relaunch.
- [ ] Integrasi ilustrasi terpisah setelah diberikan pengguna: optimalkan aset, deklarasikan di `pubspec.yaml`, dan cocokkan satu per satu dengan screenshot.
- [ ] Model PC rakitan, hotspot 3D, kategori tambahan, serta reward baru: spesifikasi dan aset terpisah sebelum implementasi.

## Perubahan file dan risiko

Perubahan utama berada di `lib/ui/core/`, screen dalam `lib/ui/features/`, `lib/ui/providers/`, `lib/main.dart`, dan getter non-migrasi pada `ProgressRepository`. Data konten dan key `user_progress` tetap. Risiko: WebView viewer pada Android/offline, model VGA yang kecil, aset ilustrasi yang belum tersedia, layout/teks pada perangkat sempit, serta nilai progres lama dengan ID materi yang tidak dikenal. Mitigasi: pertahankan ID dan model, gunakan scroll dan `SafeArea`, tampilkan angka dari state, uji pada perangkat nyata dan mode pesawat. Aset baru tidak boleh berupa screenshot penuh.

## Pengujian dan acceptance criteria

1. Jalankan `dart format`, `flutter analyze`, dan `flutter test`. Lakukan smoke test Android untuk splash → identitas → Beranda, Library → materi → selesai, Explore 3D → materi, dua game → hasil → Profil.
2. Uji ulang setelah aplikasi ditutup: nama/NISN, materi selesai, dan skor tertinggi masih sama. Data `user_progress` lama harus terbaca.
3. Bandingkan delapan screen dengan screenshot pada 360×800, 393×873, dan ponsel besar; periksa teks diperbesar, keyboard, overflow, cropping, warna, panel, CTA, serta bottom navigation.
4. Uji tanpa jaringan: materi dan progres tetap tersedia, keempat model 3D dapat dibuka. Viewer harus dapat diputar dan diperbesar; gambar statis tidak memenuhi acceptance criteria.
5. Semua tombol yang terlihat aktif harus memiliki aksi. Angka progress/skor berasal dari state; fitur yang belum tersedia diberi keterangan jelas atau tidak ditampilkan.

Rekomendasi tahap berikutnya setelah validasi dasar: integrasi ilustrasi hardware terpisah dari pemilik proyek untuk menaikkan fidelity visual.
