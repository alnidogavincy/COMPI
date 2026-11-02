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
- Profil menyediakan Ubah Foto Profil (galeri/pemilih berkas) dan Hapus Foto.
  Foto disimpan sebagai PNG lokal maksimal sisi 384 px, rasio asli dipertahankan;
  tampilan avatar berbentuk lingkaran. Input dibatasi 10 MB, data tersimpan
  dibatasi 1 MB. Foto tampil juga pada tombol profil di tab utama.
- Foto tersimpan pada `student_photo`, dihapus saat logout agar identitas
  berikutnya tidak memakai foto sebelumnya. Key `user_progress` tidak berubah.
- Catatan sumber audio tersimpan di assets/audio/CREDITS.md; tidak ada panel Kredit Audio di UI.

## Verifikasi

Tes otomatis mencakup mute/persistensi/background-resume, penyimpanan dan
penghapusan foto, preservasi rasio, batas ukuran, serta hover/press/disabled.
Tes navigasi layar kecil, profil/logout, kuis, dan Match turut dijalankan.

Uji perangkat yang masih diperlukan: dengarkan loop/transisi audio di Android,
background/resume saat viewer 3D aktif, pilih foto dari galeri nyata, dan uji
penolakan izin. Untuk web, klik halaman dahulu sebelum mengharapkan musik.

Tes katalog hardware lama menemukan kategori tanpa soal; ini tidak berkaitan
dengan perubahan audio/foto dan konten kuis tidak diubah dalam pekerjaan ini.
