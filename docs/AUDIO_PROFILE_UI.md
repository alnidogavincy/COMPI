# Audio, interaksi tombol, dan foto profil

- Aset runtime: sekitar 2,49 MB total (musik 2,42 MB dan SFX 70 KB).
- Hanya dua player yang digunakan ulang: musik loop dan satu efek sekaligus.
  Klik cepat dibatasi 100 ms dan antrean efek lama dibuang. Tidak ada decode
  FSB atau preload semua audio di runtime.
- Kontrol suara berbentuk bulat: kiri header Login dan kanan header Profil. Musik mulai pada interaksi pertama agar kompatibel dengan kebijakan autoplay
  browser. Volume musik 16%, efek 38%. Suara ON/OFF di Login dan Profil mengatur
  keduanya, tersimpan pada `sound_enabled` di SharedPreferences.
- Audio dijeda saat aplikasi inactive/hidden/paused; hanya musik yang dilanjutkan
  ketika kembali aktif dan suara masih ON. Player dilepas saat provider dibuang.
- Tombol, kartu yang bisa ditekan, pilihan kuis, dan chip filter memakai
  PhysicalButton: naik 3 px saat hover, turun ke +1 px saat ditekan, 140 ms.
  Tombol nonaktif dan preferensi reduced-motion tidak dianimasikan.
  Navigasi bawah tidak diubah dan tidak dibungkus efek ini.
- Profil menyediakan Ubah Avatar: empat karakter dari gambar tertanam pada
  komponen referensi pengguna, dan avatar default. Panel pilihan memakai
  Batal/Simpan; perubahan hanya diterapkan setelah Simpan. Seluruh gambar
  dibundel offline (~35 KB), tanpa izin galeri atau ketergantungan image_picker.
- ID avatar disimpan pada `student_avatar`; pilihan tidak dikenal kembali ke
  default. Avatar tampil pada profil dan tombol profil di tab utama.
  Foto lama tidak lagi ditampilkan; data `student_photo` lama dibersihkan saat
  logout, bersama pilihan avatar. Key `user_progress` tidak berubah.
- Catatan sumber audio tersimpan di assets/audio/CREDITS.md; tidak ada panel Kredit Audio di UI.

## Verifikasi

Tes otomatis mencakup mute/persistensi/background-resume, pemilihan/batal/simpan avatar, persistensi dan logout, serta hover/press/disabled.
Tes navigasi layar kecil, profil/logout, kuis, dan Match turut dijalankan.

Uji perangkat yang masih diperlukan: dengarkan loop/transisi audio di Android,
background/resume saat viewer 3D aktif, pemilihan avatar, relaunch, dan logout di perangkat nyata. Untuk web, klik halaman dahulu sebelum mengharapkan musik.

Tes katalog hardware lama menemukan kategori tanpa soal; ini tidak berkaitan
dengan perubahan audio/foto dan konten kuis tidak diubah dalam pekerjaan ini.
