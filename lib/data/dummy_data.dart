
import 'models/component_model.dart';
import 'models/learning_material_model.dart';
import 'models/quiz_question_model.dart';
import 'models/match_item_model.dart';
import 'additional_content.dart';

/// Data dummy komponen perangkat keras komputer.
final List<ComponentModel> dummyComponents = [
  // ── Motherboard ──────────────────────────────────────────────
  const ComponentModel(
    id: 'motherboard',
    name: 'Motherboard',
    shortDescription:
        'Papan sirkuit utama yang menghubungkan seluruh komponen komputer.',
    fullDescription:
        'Motherboard adalah papan sirkuit cetak (PCB) utama dalam sebuah komputer. '
        'Motherboard berfungsi sebagai penghubung antar seluruh komponen seperti CPU, '
        'RAM, kartu grafis, dan perangkat penyimpanan. Motherboard menyediakan jalur '
        'listrik dan data (bus) agar komponen-komponen tersebut dapat saling '
        'berkomunikasi. Komponen penting pada motherboard antara lain chipset, '
        'slot ekspansi (PCIe), soket CPU, slot RAM, konektor SATA, dan port I/O.',
    category: 'Komponen Utama',
    modelPath: 'assets/models/motherboard_components.glb',
    hotspots: [
      HotspotModel(
        id: 'mb_cpu_socket',
        label: 'Soket CPU',
        description: 'Tempat pemasangan prosesor (CPU).',
        positionX: 0.0,
        positionY: 1.0,
        positionZ: 0.0,
      ),
      HotspotModel(
        id: 'mb_ram_slot',
        label: 'Slot RAM',
        description: 'Slot untuk memasang modul memori RAM.',
        positionX: 1.0,
        positionY: 1.0,
        positionZ: 0.0,
      ),
      HotspotModel(
        id: 'mb_pcie_slot',
        label: 'Slot PCIe',
        description: 'Slot ekspansi untuk kartu grafis dan perangkat tambahan.',
        positionX: 0.0,
        positionY: -1.0,
        positionZ: 0.0,
      ),
    ],
  ),

  // ── CPU ──────────────────────────────────────────────────────
  const ComponentModel(
    id: 'cpu',
    name: 'CPU (Prosesor)',
    shortDescription:
        'Otak komputer yang menjalankan instruksi dan perhitungan.',
    fullDescription:
        'CPU (Central Processing Unit) adalah komponen utama komputer yang bertugas '
        'menjalankan instruksi program. CPU melakukan operasi aritmatika, logika, '
        'kontrol, dan input/output sesuai instruksi yang diberikan. Kecepatan CPU '
        'diukur dalam GHz (Gigahertz). CPU modern memiliki banyak inti (core) yang '
        'memungkinkan pemrosesan paralel. Produsen CPU terkemuka adalah Intel dan AMD. '
        'CPU dipasang pada soket khusus di motherboard dan membutuhkan pendingin '
        '(heatsink/fan) untuk menjaga suhu operasi.',
    category: 'Komponen Utama',
    modelPath: 'assets/models/cpu_am4.glb',
    hotspots: [
      HotspotModel(
        id: 'cpu_die',
        label: 'Die / Chip',
        description: 'Inti silikon yang berisi miliaran transistor.',
        positionX: 0.0,
        positionY: 0.5,
        positionZ: 0.0,
      ),
      HotspotModel(
        id: 'cpu_pins',
        label: 'Pin / Kontak',
        description: 'Pin logam untuk koneksi ke soket motherboard.',
        positionX: 0.0,
        positionY: -0.5,
        positionZ: 0.0,
      ),
    ],
  ),

  // ── RAM ──────────────────────────────────────────────────────
  const ComponentModel(
    id: 'ram',
    name: 'RAM (Memori)',
    shortDescription:
        'Memori sementara untuk menyimpan data yang sedang diproses.',
    fullDescription:
        'RAM (Random Access Memory) adalah memori volatile yang digunakan komputer '
        'untuk menyimpan data dan instruksi yang sedang aktif diproses oleh CPU. '
        'Semakin besar kapasitas RAM, semakin banyak program yang dapat berjalan '
        'bersamaan. Tipe RAM yang umum saat ini adalah DDR4 dan DDR5. RAM dipasang '
        'pada slot DIMM di motherboard. Data pada RAM akan hilang saat komputer '
        'dimatikan, sehingga disebut memori volatile.',
    category: 'Komponen Utama',
    modelPath: 'assets/models/memory_ram.glb',
    specs: {
      'JENIS': 'DDR4 / DDR5',
      'KAPASITAS': '4GB - 32GB+',
      'KECEPATAN': '1333 - 6000 MHz',
    },
    hotspots: [
      HotspotModel(
        id: 'ram_chips',
        label: 'Chip Memori',
        description: 'IC penyimpan data sementara berkecepatan tinggi.',
        positionX: 0.0,
        positionY: 0.5,
        positionZ: 0.0,
      ),
      HotspotModel(
        id: 'ram_notch',
        label: 'Notch (Lekukan)',
        description: 'Lekukan untuk memastikan pemasangan yang benar.',
        positionX: 0.5,
        positionY: -0.5,
        positionZ: 0.0,
      ),
    ],
  ),

  // ── VGA / GPU ────────────────────────────────────────────────
  const ComponentModel(
    id: 'vga',
    name: 'VGA / Kartu Grafis (GPU)',
    shortDescription:
        'Kartu yang memproses dan menampilkan grafis ke layar monitor.',
    fullDescription:
        'VGA (Video Graphics Array) atau Kartu Grafis adalah komponen yang bertugas '
        'memproses data grafis dan menampilkannya ke monitor. GPU (Graphics Processing '
        'Unit) di dalam kartu grafis dirancang khusus untuk pemrosesan paralel yang '
        'dibutuhkan untuk rendering gambar, video, dan game 3D. Kartu grafis modern '
        'memiliki memori VRAM sendiri (GDDR6/GDDR6X) dan dipasang pada slot PCIe x16 '
        'di motherboard. Produsen GPU terkemuka adalah NVIDIA dan AMD.',
    category: 'Komponen Utama',
    modelPath: 'assets/models/gpu_rtx4090.glb',
    hotspots: [
      HotspotModel(
        id: 'vga_gpu_chip',
        label: 'Chip GPU',
        description: 'Prosesor grafis utama untuk rendering.',
        positionX: 0.0,
        positionY: 0.5,
        positionZ: 0.0,
      ),
      HotspotModel(
        id: 'vga_vram',
        label: 'VRAM',
        description: 'Memori video untuk menyimpan data tekstur dan frame.',
        positionX: 1.0,
        positionY: 0.0,
        positionZ: 0.0,
      ),
      HotspotModel(
        id: 'vga_fan',
        label: 'Kipas Pendingin',
        description: 'Sistem pendingin untuk menjaga suhu GPU.',
        positionX: 0.0,
        positionY: -0.5,
        positionZ: 0.5,
      ),
    ],
  ),
  ...additionalComponents,
];

/// Data dummy materi pembelajaran.
final List<LearningMaterialModel> dummyMaterials = [
  ...additionalMaterials,
  // Motherboard
  const LearningMaterialModel(
    id: 'mat_mb_01',
    componentId: 'motherboard',
    title: 'Pengenalan Motherboard',
    content:
        'Motherboard adalah papan sirkuit utama yang menjadi tempat terhubungnya berbagai komponen komputer. '
        'Komponen seperti CPU, RAM, kartu grafis, dan media penyimpanan bekerja sama melalui jalur komunikasi pada motherboard. '
        'Motherboard juga menyalurkan daya dari konektor power ke bagian-bagian tertentu serta menyediakan konektor untuk perangkat tambahan. '
        'Jenis motherboard menentukan kompatibilitas komponen, misalnya jenis soket CPU, tipe RAM, dan slot ekspansi yang tersedia. '
        'Motherboard umumnya berada di dalam casing komputer. Saat memilih motherboard, perhatikan ukuran papan, soket processor, dukungan RAM, dan konektor yang dibutuhkan.'
  ),
  const LearningMaterialModel(
    id: 'mat_mb_02',
    componentId: 'motherboard',
    title: 'Komponen pada Motherboard',
    content:
        'Motherboard memiliki beberapa bagian dengan fungsi berbeda. Soket CPU adalah tempat memasang processor, sedangkan slot DIMM digunakan untuk memasang modul RAM. '
        'Slot PCI Express (PCIe) digunakan untuk memasang kartu ekspansi, misalnya kartu grafis atau kartu tambahan lainnya. Konektor SATA dapat digunakan untuk menghubungkan HDD atau SSD yang memakai antarmuka SATA. '
        'Konektor daya utama dan konektor daya CPU menyalurkan listrik ke motherboard serta processor. Header front panel menghubungkan tombol power dan lampu indikator pada casing. '
        'Pada bagian belakang motherboard terdapat port I/O, seperti USB, Ethernet untuk jaringan kabel, serta port audio. Sebagian motherboard juga menyediakan HDMI atau DisplayPort, tetapi port tampilan tersebut hanya berfungsi jika sistem mendukung grafis terintegrasi. '
        'Chipset membantu mengatur komunikasi antara processor dan perangkat tertentu. Desain motherboard modern berbeda-beda, sehingga posisi dan jumlah slot maupun konektornya tidak selalu sama.'
  ),

  // CPU
  const LearningMaterialModel(
    id: 'mat_cpu_01',
    componentId: 'cpu',
    title: 'Apa itu CPU?',
    content:
        'CPU (Central Processing Unit) atau processor adalah komponen yang menjalankan instruksi program dan mengolah data. CPU sering disebut sebagai otak komputer karena berperan penting dalam menjalankan sistem operasi, aplikasi, dan berbagai perintah pengguna. '
        'Secara sederhana, CPU mengambil instruksi, menerjemahkan instruksi tersebut, lalu menjalankan operasi yang diperlukan. Operasinya dapat berupa perhitungan matematika, perbandingan logika, dan pengaturan jalannya proses komputer. '
        'Kecepatan kerja CPU sering dinyatakan dalam GHz, tetapi performa tidak ditentukan oleh kecepatan saja. Jumlah core, rancangan arsitektur, cache, dan kebutuhan aplikasi juga berpengaruh. Core adalah unit pemrosesan di dalam CPU; beberapa core memungkinkan lebih banyak pekerjaan diproses secara bersamaan. '
        'CPU dipasang pada soket yang sesuai di motherboard. Karena menghasilkan panas saat bekerja, CPU biasanya dilengkapi heatsink dan kipas atau sistem pendingin lain. Jenis soket dan dukungan motherboard harus cocok dengan processor yang digunakan.'
  ),
  const LearningMaterialModel(
    id: 'mat_cpu_02',
    componentId: 'cpu',
    title: 'Arsitektur CPU Modern',
    content:
        'CPU modern tersusun dari beberapa bagian yang bekerja bersama. ALU (Arithmetic Logic Unit) menjalankan operasi aritmatika dan logika, sedangkan Control Unit mengatur jalannya instruksi. Register merupakan tempat penyimpanan sangat kecil dan cepat yang digunakan saat pemrosesan berlangsung. '
        'Cache adalah memori berkecepatan tinggi di dalam atau dekat CPU yang menyimpan data dan instruksi yang sering digunakan. Cache umumnya memiliki beberapa tingkat, seperti L1, L2, dan L3. Cache membantu CPU mengakses data lebih cepat dibandingkan jika harus selalu mengambilnya dari RAM. '
        'CPU juga memiliki core, dan pada beberapa model satu core dapat menangani lebih dari satu thread. Core dan thread dapat membantu menjalankan beberapa tugas, tetapi hasilnya tetap bergantung pada rancangan CPU dan dukungan perangkat lunak. '
        'Arsitektur x86-64 banyak digunakan pada komputer desktop dan laptop berbasis Intel atau AMD, sedangkan ARM digunakan pada berbagai perangkat, termasuk sebagian komputer dan perangkat mobile. Arsitektur adalah rancangan dan kumpulan aturan yang digunakan CPU untuk menjalankan instruksi. Tidak semua CPU memiliki susunan atau kemampuan yang sama.'
  ),

  // RAM
  const LearningMaterialModel(
    id: 'mat_ram_01',
    componentId: 'ram',
    title: 'Fungsi RAM',
    content:
        'RAM (Random Access Memory) adalah memori utama yang menyimpan data dan instruksi yang sedang dibutuhkan oleh sistem operasi serta aplikasi. Ketika aplikasi dibuka, sebagian data yang diperlukan dimuat ke RAM agar CPU dapat mengaksesnya dengan cepat. '
        'RAM bersifat volatile, artinya data yang tersimpan di dalamnya akan hilang ketika aliran listrik terputus atau komputer dimatikan. Karena itu, RAM berbeda dengan HDD atau SSD yang digunakan untuk menyimpan file dalam jangka panjang. '
        'Kapasitas RAM memengaruhi jumlah dan ukuran aplikasi yang dapat dijalankan dengan nyaman secara bersamaan. Jika RAM tidak mencukupi, sistem dapat menggunakan sebagian ruang penyimpanan sebagai memori virtual, tetapi proses ini umumnya lebih lambat daripada menggunakan RAM langsung. '
        'RAM desktop biasanya dipasang pada slot DIMM di motherboard, sedangkan laptop tertentu menggunakan modul SO-DIMM atau RAM yang terpasang langsung. Saat menambah RAM, periksa tipe yang didukung motherboard, kapasitas maksimum, dan jumlah slot yang tersedia.'
  ),
  const LearningMaterialModel(
    id: 'mat_ram_02',
    componentId: 'ram',
    title: 'Jenis-jenis RAM',
    content:
        'RAM memiliki beberapa jenis dan generasi. DDR (Double Data Rate) merupakan keluarga teknologi RAM yang mengirimkan data dua kali dalam satu siklus clock. DDR4 dan DDR5 adalah dua generasi yang banyak dijumpai pada komputer modern. '
        'DDR4 dan DDR5 memiliki perbedaan pada rancangan, kecepatan transfer, kebutuhan daya, serta bentuk posisi lekukan konektornya. Keduanya tidak dapat dipertukarkan secara langsung karena slot dan dukungan motherboard berbeda. '
        'Kapasitas RAM dinyatakan dalam GB, sedangkan kecepatan transfer biasanya dinyatakan dalam MT/s; pada spesifikasi sehari-hari sering juga ditulis dengan angka MHz. Kapasitas yang dibutuhkan bergantung pada sistem operasi dan aplikasi. Komputer untuk tugas dasar dapat memiliki kebutuhan berbeda dari komputer untuk desain, editing, atau pekerjaan berat. '
        'RAM juga dapat dipasang dalam konfigurasi satu atau beberapa modul. Pada platform yang mendukungnya, penggunaan dua modul yang sesuai dapat mengaktifkan mode dual-channel dan meningkatkan bandwidth memori. Namun, peningkatan kinerja bergantung pada perangkat dan jenis beban kerja.'
  ),

  // VGA
  const LearningMaterialModel(
    id: 'mat_vga_01',
    componentId: 'vga',
    title: 'Peran Kartu Grafis',
    content:
        'Kartu grafis atau VGA adalah perangkat keras yang mengolah data grafis agar dapat ditampilkan sebagai gambar pada monitor. GPU (Graphics Processing Unit) merupakan prosesor grafis yang melakukan banyak perhitungan untuk membentuk tampilan, efek visual, dan objek tiga dimensi. '
        'Kartu grafis dapat membantu pekerjaan seperti bermain game, desain grafis, pemodelan 3D, dan penyuntingan video. Besarnya manfaat bergantung pada kebutuhan aplikasi dan kemampuan GPU. Untuk pekerjaan dasar, grafis terintegrasi yang berada di dalam CPU atau sistem juga dapat mencukupi tanpa kartu grafis terpisah. '
        'Kartu grafis terpisah umumnya dipasang pada slot PCIe di motherboard dan memiliki konektor keluaran layar, misalnya HDMI atau DisplayPort. Sebagian kartu grafis juga memerlukan kabel daya tambahan dari power supply. Bentuk, ukuran, dan kebutuhan dayanya berbeda-beda. '
        'Selain GPU, kartu grafis dapat memiliki VRAM dan sistem pendingin berupa heatsink serta kipas. Saat memilih kartu grafis, perhatikan dukungan motherboard, ruang di dalam casing, kapasitas power supply, dan konektor monitor.'
  ),
  const LearningMaterialModel(
    id: 'mat_vga_02',
    componentId: 'vga',
    title: 'VRAM dan Performa GPU',
    content:
        'VRAM (Video Random Access Memory) adalah memori yang digunakan GPU untuk menyimpan data grafis yang sedang diproses, seperti tekstur, gambar, dan frame buffer. VRAM membantu GPU mengakses data visual tanpa harus terus-menerus mengambilnya dari memori utama. '
        'Kapasitas VRAM yang lebih besar dapat membantu ketika aplikasi menggunakan resolusi tinggi, tekstur berukuran besar, atau model 3D yang kompleks. Namun, VRAM yang besar tidak selalu membuat kartu grafis lebih cepat karena performa juga dipengaruhi kemampuan GPU, bandwidth memori, sistem pendingin, dan kebutuhan aplikasi. '
        'Kartu grafis modern dapat menggunakan jenis memori seperti GDDR6 atau GDDR6X, bergantung pada modelnya. Jenis dan kapasitas VRAM biasanya ditentukan oleh produsen kartu grafis dan tidak sama pada setiap produk. '
        'Saat GPU bekerja berat, suhu komponen dapat meningkat. Heatsink membantu menyerap dan menyebarkan panas, sedangkan kipas membantu membuang panas dari kartu grafis. Pendinginan yang baik membantu menjaga kestabilan kerja dan mengurangi risiko penurunan performa akibat suhu tinggi.'
  ),
];

/// Data dummy soal kuis (Total tepat 25 Soal).
final List<QuizQuestionModel> dummyQuizQuestions = [
  // ── Kategori: Pengenalan Dasar Komponen (Soal 1 - 5) ────────
  const QuizQuestionModel(
    id: 'quiz_cc_01',
    question: 'Komponen yang berfungsi sebagai pusat pemrosesan data pada komputer adalah …',
    options: ['RAM', 'CPU', 'PSU', 'Hard Disk'],
    correctAnswerIndex: 1, // B. CPU
    componentId: 'cpu',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_02',
    question: 'Komponen yang berfungsi menyimpan data sementara ketika komputer sedang digunakan adalah …',
    options: ['RAM', 'SSD', 'Motherboard', 'PSU'],
    correctAnswerIndex: 0, // A. RAM
    componentId: 'ram',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_03',
    question: 'Komponen yang menjadi tempat terpasangnya berbagai komponen utama komputer disebut …',
    options: ['VGA', 'Processor', 'Motherboard', 'Power Supply'],
    correctAnswerIndex: 2, // C. Motherboard
    componentId: 'motherboard',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_04',
    question: 'Komponen yang berfungsi mengolah dan menghasilkan tampilan grafis ke monitor adalah …',
    options: ['RAM', 'VGA', 'CPU', 'SSD'],
    correctAnswerIndex: 1, // B. VGA
    componentId: 'vga',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_05',
    question: 'Komponen yang berfungsi menyediakan dan menyalurkan daya listrik ke komponen komputer adalah …',
    options: ['PSU', 'RAM', 'CPU', 'Motherboard'],
    correctAnswerIndex: 0, // A. PSU
    componentId: 'power_supply',
  ),

  // ── Kategori: Fungsi dan Penggunaan (Soal 6 - 10) ──────────
  const QuizQuestionModel(
    id: 'quiz_cc_06',
    question: 'Jika komputer membutuhkan penyimpanan data secara permanen, komponen yang digunakan adalah …',
    options: ['RAM', 'CPU', 'SSD', 'Heatsink'],
    correctAnswerIndex: 2, // C. SSD
    componentId: 'storage',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_07',
    question: 'Komponen yang berfungsi membantu mendinginkan processor adalah …',
    options: ['Heatsink dan fan', 'RAM', 'SSD', 'VGA'],
    correctAnswerIndex: 0, // A. Heatsink dan fan
    componentId: 'cooling',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_08',
    question: 'Manakah yang termasuk perangkat penyimpanan data?',
    options: ['CPU', 'RAM', 'SSD', 'Heatsink'],
    correctAnswerIndex: 2, // C. SSD
    componentId: 'storage',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_09',
    question: 'Komponen yang biasanya memiliki slot untuk memasang RAM adalah …',
    options: ['PSU', 'Motherboard', 'VGA', 'SSD'],
    correctAnswerIndex: 1, // B. Motherboard
    componentId: 'motherboard',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_10',
    question: 'Apa fungsi utama CPU pada komputer?',
    options: ['Menyimpan file secara permanen', 'Mengolah instruksi dan data', 'Menampilkan gambar ke monitor', 'Menyediakan listrik'],
    correctAnswerIndex: 1, // B. Mengolah instruksi dan data
    componentId: 'cpu',
  ),

  // ── Kategori: Karakteristik dan Cara Kerja (Soal 11 - 15) ──
  const QuizQuestionModel(
    id: 'quiz_cc_11',
    question: 'Komponen manakah yang datanya akan hilang ketika komputer dimatikan?',
    options: ['SSD', 'HDD', 'RAM', 'Flash Drive'],
    correctAnswerIndex: 2, // C. RAM
    componentId: 'ram',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_12',
    question: 'VGA paling berhubungan dengan proses …',
    options: ['Penyimpanan file', 'Pengolahan grafis', 'Penyediaan daya', 'Pendinginan processor'],
    correctAnswerIndex: 1, // B. Pengolahan grafis
    componentId: 'vga',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_13',
    question: 'Jika pengguna ingin meningkatkan kapasitas penyimpanan komputer, komponen yang dapat ditambahkan adalah …',
    options: ['SSD', 'Heatsink', 'CPU', 'Fan'],
    correctAnswerIndex: 0, // A. SSD
    componentId: 'storage',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_14',
    question: 'Komponen yang menghubungkan dan menjadi tempat berbagai komponen komputer bekerja bersama adalah …',
    options: ['Motherboard', 'RAM', 'PSU', 'SSD'],
    correctAnswerIndex: 0, // A. Motherboard
    componentId: 'motherboard',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_15',
    question: 'Apa fungsi PSU pada komputer?',
    options: ['Mengolah data', 'Menyimpan data', 'Menyalurkan daya listrik', 'Mengolah gambar'],
    correctAnswerIndex: 2, // C. Menyalurkan daya listrik
    componentId: 'power_supply',
  ),

  // ── Kategori: Penerapan Sederhana (Soal 16 - 20) ────────────
  const QuizQuestionModel(
    id: 'quiz_cc_16',
    question: 'Komponen berikut yang termasuk perangkat keras komputer adalah …',
    options: ['Windows', 'Microsoft Word', 'RAM', 'Google Chrome'],
    correctAnswerIndex: 2, // C. RAM
    componentId: 'ram',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_17',
    question: 'Komponen yang biasanya berbentuk keping kecil dan dipasang pada slot khusus di motherboard adalah …',
    options: ['RAM', 'PSU', 'Fan casing', 'SSD eksternal'],
    correctAnswerIndex: 0, // A. RAM
    componentId: 'ram',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_18',
    question: 'Mengapa processor membutuhkan sistem pendingin?',
    options: ['Agar kapasitas penyimpanan bertambah', 'Agar processor tidak mengalami panas berlebih', 'Agar komputer dapat terhubung internet', 'Agar RAM dapat menyimpan data permanen'],
    correctAnswerIndex: 1, // B. Agar processor tidak mengalami panas berlebih
    componentId: 'cooling',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_19',
    question: 'Seorang pengguna ingin memainkan game dengan grafis yang lebih berat. Komponen yang berperan penting dalam pengolahan grafis adalah …',
    options: ['VGA', 'PSU', 'RAM', 'SSD'],
    correctAnswerIndex: 0, // A. VGA
    componentId: 'vga',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_20',
    question: 'Jika sebuah komponen komputer mengalami kerusakan dan komputer tidak mendapatkan daya listrik, komponen yang perlu diperiksa adalah …',
    options: ['VGA', 'PSU', 'RAM', 'SSD'],
    correctAnswerIndex: 1, // B. PSU
    componentId: 'power_supply',
  ),

  // ── Kategori Tambahan: Soal 21 - 25 (Pas 25 Soal) ──────────
  const QuizQuestionModel(
    id: 'quiz_cc_21',
    question: 'Manakah port atau slot yang biasanya digunakan untuk menghubungkan monitor ke komputer melalui kartu grafis?',
    options: ['SATA', 'HDMI / DisplayPort', 'DIMM slot', 'PCIe x1'],
    correctAnswerIndex: 1, // B. HDMI / DisplayPort
    componentId: 'vga',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_22',
    question: 'Apa akibatnya jika kapasitas RAM pada komputer terlalu kecil saat membuka banyak aplikasi?',
    options: ['Komputer menjadi sangat lambat (lag)', 'Kapasitas SSD bertambah', 'Daya listrik PSU naik', 'Processor menjadi dingin'],
    correctAnswerIndex: 0, // A. Komputer menjadi sangat lambat (lag)
    componentId: 'ram',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_23',
    question: 'Bagian pada motherboard tempat menancapkan kartu grafis (GPU) berukuran besar adalah …',
    options: ['Slot RAM', 'Slot PCIe x16', 'Konektor SATA', 'Soket CPU'],
    correctAnswerIndex: 1, // B. Slot PCIe x16
    componentId: 'motherboard',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_24',
    question: 'Manakah media penyimpanan data yang menggunakan teknologi chip flash tanpa komponen mekanik bergerak?',
    options: ['Hard Disk Drive (HDD)', 'Solid State Drive (SSD)', 'Kaset CD', 'Disket'],
    correctAnswerIndex: 1, // B. Solid State Drive (SSD)
    componentId: 'storage',
  ),
  const QuizQuestionModel(
    id: 'quiz_cc_25',
    question: 'Sebelum merakit komputer, komponen apa yang harus dipastikan kompatibel terlebih dahulu dengan Processor (CPU)?',
    options: ['Motherboard', 'Kabel Power', 'Monitor', 'Keyboard'],
    correctAnswerIndex: 0, // A. Motherboard
    componentId: 'motherboard',
  ),
];

/// Data dummy item matching game.
final List<MatchItemModel> dummyMatchItems = [
  const MatchItemModel(
    id: 'match_mb',
    imageName: 'motherboard.png',
    targetLabel: 'Motherboard',
  ),
  const MatchItemModel(
    id: 'match_cpu',
    imageName: 'cpu.png',
    targetLabel: 'CPU',
  ),
  const MatchItemModel(
    id: 'match_ram',
    imageName: 'ram.png',
    targetLabel: 'RAM',
  ),
  const MatchItemModel(
    id: 'match_vga',
    imageName: 'vga.png',
    targetLabel: 'VGA / Kartu Grafis',
  ),
];
