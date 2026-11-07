# Audit sebelum rilis COMPI — 7 November 2026

## Ruang lingkup
Pemeriksaan seluruh lib/ melalui flutter analyze, seluruh test/, konfigurasi Android, dependensi viewer yang terpasang, alur identitas/progres/game, serta struktur 8 GLB. Audit ini bukan jaminan bebas celah dan bukan penetration test perangkat fisik.

## Perbaikan
- Pemuatan progres kini sinkron dari preferensi yang sudah tersedia: perubahan pertama tidak ditimpa hasil pemuatan awal.
- Antrean penyimpanan menulis snapshot secara berurutan; kegagalan tidak menjadi exception tak tertangani. Beranda menyediakan simpan ulang. Penutupan provider tidak memicu notify setelah dispose.
- Pembacaan progres mempertahankan ID valid walau ada item rusak, menghapus duplikasi, dan membatasi skor 0–100. Key user_progress dan ID materi lama dipertahankan.
- Penyimpanan identitas dari profil menampilkan pesan bila gagal.
- ID soal PSU disamakan dengan katalog psu; soal casing ditambahkan tanpa menghapus soal lama.
- Tes header disesuaikan dengan wordmark di layar detail dan logo horizontal di tab utama/login.
- Viewer memakai eager loading, AR dan auto-rotate dimatikan, log debug dimatikan di release. Event load/error dari viewer mengendalikan status. Sesudah 60 detik indikator diganti pesan serta aksi coba lagi; model yang akhirnya berhasil dimuat tetap ditampilkan. Ini penanganan kegagalan, bukan janji pemuatan instan.
- Backup otomatis Android dimatikan untuk mengurangi penyalinan identitas lokal. Ini tidak menghapus data instalasi yang ada dan tidak membatalkan backup yang sudah dibuat sebelumnya.

## Temuan keamanan
- Manifest hanya meminta INTERNET pada source utama. HTTP non-TLS dibatasi ke localhost/127.0.0.1, sesuai kebutuhan server loopback model_viewer_plus; HTTP ke host lain diblokir oleh base config.
- Seluruh model berasal dari aset lokal; tidak ada URL model yang berasal dari input pengguna. JavaScript diperlukan oleh viewer, bridge hanya menerima status loaded/error dan tidak mengeksekusi perintah dari pesan.
- Pemindaian source tidak menemukan token layanan/API atau password aplikasi. Identitas dan progres disimpan dalam SharedPreferences lokal, tidak terenkripsi; jangan gunakan sebagai penyimpanan password atau token rahasia.
- PENTING: release masih memakai debug signing dari konfigurasi lama. Untuk distribusi publik/Play Store siapkan keystore rilis privat dan backup kuncinya, lalu konfigurasi signing mengikuti dokumentasi Flutter. Jangan mengganti signature instalasi produksi tanpa rencana pembaruan karena dapat mengharuskan uninstall dan menghilangkan progres. Keystore/password tidak dibuat atau dimasukkan ke Git oleh audit ini.
- Pemeriksaan ini tidak mencakup pemindaian CVE lengkap seluruh dependensi transitif atau pengujian eksploitasi runtime.

## Verifikasi 3D
Semua 8 GLB berformat v2, panjang header sesuai file, gambar dan buffer tertanam; tidak memerlukan resource eksternal atau decoder yang dinyatakan sebagai extensionsRequired. Model terbesar sekitar 19,7 MB (cooling), sehingga waktu decode dan penggunaan GPU/RAM tetap bergantung HP. Satu viewer/model aktif ditampilkan per layar. WebView Android perlu mendukung WebGL.

## Uji fisik yang masih diperlukan
Perangkat pengguna: Infinix Hot 50, versi Android belum diketahui. Saat audit belum ada HP terhubung melalui ADB.
- Pasang APK terbaru sebagai update dengan signature yang sama; pastikan identitas/progres bertahan.
- Buka kedelapan model, putar/zoom, pindah model, keluar/masuk viewer berulang.
- Coba mode pesawat, aplikasi masuk background/resume, dan model cooling/motherboard yang lebih besar.
- Jika gagal, ambil logcat HP untuk membedakan kegagalan WebView, izin jaringan, atau GPU/memori; jangan menyimpulkan dari emulator saja.

## Referensi
- https://pub.dev/packages/model_viewer_plus
- https://docs.flutter.dev/deployment/android

## Hasil pemeriksaan otomatis
- flutter analyze --no-pub: tidak ada issue.
- flutter test --no-pub: seluruh 21 tes lulus, termasuk regresi progres dan validasi 8 GLB.
- git diff --check: tidak ada kesalahan whitespace.
- Build Android release dijalankan; hasil akhir dicatat setelah proses selesai.
- Build release pertama mendeteksi Android lint NetworkSecurityConfig: includeSubdomains wajib eksplisit. Diperbaiki false untuk kedua alamat loopback dan build diulang tanpa menonaktifkan lint.

- Build ulang release LULUS (146,4 detik), APK sekitar 120,2 MB. APK terverifikasi memuat arm64-v8a/armeabi-v7a/x86_64, model GLB, dan JavaScript viewer lokal.
- APK: build/app/outputs/flutter-apk/app-release.apk
- SHA256: 48ADF237BBBA1371ECD68889ED9C69C8FA36758D5C1D3FC6292FA334FBE23BDB
- Pengujian 3D langsung di Infinix Hot 50 masih menunggu koneksi USB/ADB.
