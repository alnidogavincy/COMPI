# Deklarasi Transparansi Penggunaan AI

Catatan: Saya sudah lupa kalimat prompt yang persis, jadi contoh di bawah ditulis ulang berdasarkan fitur yang ada di proyek. Contoh ini bukan salinan percakapan asli. Pembagian tugas juga sebaiknya dicek lagi dengan anggota tim.

## Daftar Alat

| Alat | Penggunaan |
| --- | --- |
| GitHub Copilot | Membantu saat mengerjakan fitur kuis dan menyusun dokumentasi. |

Jika memakai alat AI lain seperti ChatGPT, Claude, atau Gemini, tambahkan namanya di sini.

## Pembagian Peran

Sederhananya, AI membantu bagian kode kuis. Isi materi dan soal saya susun sendiri.

| Bagian | Dikerjakan dengan bantuan |
| --- | --- |
| `lib/ui/providers/quiz_provider.dart` dan `lib/ui/features/games/quiz_screen.dart` | AI membantu membuat kode kuis. Saya memeriksa dan menyesuaikan beberapa bagian, seperti perhitungan skor dan alur menjawab. |
| `lib/data/dummy_data.dart` dan `lib/data/additional_content.dart` | Saya menulis isi materi, deskripsi komponen, dan data soal secara manual. |
| Dokumentasi, termasuk `AI_DECLARATION.md` | Dibuat dengan bantuan AI. |

## Contoh Penggunaan Prompt

### 1. Membuat logika kuis

**Contoh prompt yang ditulis ulang:**

> Tolong bantu buat fitur kuis. Soal bisa dijawab satu per satu, skor bertambah kalau jawabannya benar, lalu tampilkan hasil di akhir.

**Hasil awal AI:** AI membantu membuat kode dasar untuk menyimpan soal, jawaban, dan skor. Beberapa bagian masih perlu diperiksa, terutama agar satu soal tidak dihitung lebih dari sekali dan skor tetap benar kalau jumlah soalnya berbeda.

**Yang saya sesuaikan sendiri:** Saya memastikan jawaban untuk satu soal tidak bisa menambah skor berkali-kali. Saya juga menyesuaikan hitungan skor dengan jumlah soal yang ada dan memisahkan hasil kuis biasa dari hasil permainan mencocokkan komponen (Match).

### 2. Membuat tampilan kuis

**Contoh prompt yang ditulis ulang:**

> Tolong buat tampilan kuis yang menunjukkan pertanyaan dan pilihan jawaban. Setelah jawaban dikirim, beri tahu apakah jawabannya benar, lalu sediakan tombol untuk lanjut.

**Hasil awal AI:** AI membantu membuat tampilan pertanyaan, pilihan jawaban, dan tombol untuk mengirim atau melanjutkan.

**Yang saya sesuaikan sendiri:** Saya memastikan tombol kirim belum bisa dipakai sebelum ada jawaban yang dipilih. Setelah lanjut ke soal berikutnya, pilihan sebelumnya dibersihkan. Saya juga menambahkan tampilan pesan jika soal belum tersedia.

Penyesuaian di atas sesuai dengan kode kuis saat ini. Tes pada `test/persistence_and_quiz_test.dart` juga memeriksa hitungan skor berdasarkan jumlah soal.
