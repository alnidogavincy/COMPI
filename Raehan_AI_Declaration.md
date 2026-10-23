Deklarasi Penggunaan AI

Daftar Alat:
GitHub Copilot untuk membantu penyusunan kerangka logika kode dan saran penyelesaian antarmuka di Flutter.


Pembagian Peran:
1. Modul yang Dibantu AI (GitHub Copilot):
- Navigasi dasar antarmuka: Copilot membantu memberikan kerangka awal kode tombol navigasi ke materi berikutnya pada halaman detail materi.
- Kerangka tombol menu profil: Copilot membantu menyusun struktur dasar tata letak tombol menu pada halaman profil.

2. Modul yang Murni Ditulis & Disesuaikan Manual:
- Fitur Navigasi "Lanjut ke Materi Berikutnya": Menghapus judul pengantar bawaan, merancang logika pemilih indeks komponen dinamis tanpa kartu pengantar, serta mengatur tombol langsung menyebutkan nama komponen tujuan berikutnya (misalnya: "Lanjut ke RAM").
- Halaman & Data Identitas Pengembang: Merancang berkas layar baru secara mandiri, mengetik langsung seluruh data identitas ketiga pengembang (Nama, NPM, S1 Pendidikan Teknologi Informasi, Universitas Lampung), menata kartu profil tim, serta mendaftarkan dan mengonfigurasi jalur aset foto di `pubspec.yaml`.


Studi Kasus Prompting:
1. Navigasi Tombol "Lanjut ke Materi Berikutnya"
Prompt:
> "Di setiap halaman materi, tolong tambahkan fitur lanjut ke materi berikutnya sehingga langsung masuk ke materi lain. Jangan selalu materi lainnya itu motherboard, misalnya awalnya lagi di CPU, terus di paling bawah ada tombol lanjut ke materi lain, RAM misalnya."

Hasil Awal AI (GitHub Copilot):
Copilot menyarankan tombol navigasi yang di atasnya diberi kontainer dan judul header bertuliskan "Materi Berikutnya: ..." sebelum tombol aksi. Selain itu, alur navigasinya masih kaku dan cenderung memuat daftar komponen secara berulang, sehingga tampilan bawah layar terasa terlalu sesak dan bertele-tele.

Penyesuaian Manual:
- Saya membuang elemen kartu dan judul "Materi Berikutnya: ..." di atas tombol agar antarmukanya tetap bersih, ringkas, dan fokus pada satu aksi utama (Call-to-Action).
- Saya merancang logika dinamis secara mandiri untuk membaca indeks komponen yang sedang aktif dari daftar materi, lalu mengubah teks tombol secara otomatis menjadi langsung menyebut nama komponen tujuan berikutnya (misalnya dari CPU langsung bertuliskan "Lanjut ke RAM").
- Saya mengatur transisi perpindahan layar menggunakan `Navigator.pushReplacement` agar navigasi langsung beralih ke materi selanjutnya secara mulus tanpa menumpuk riwayat halaman terlalu panjang.