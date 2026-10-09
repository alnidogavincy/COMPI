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
        'Motherboard adalah fondasi dari sebuah komputer. Semua komponen '
        'utama terhubung melalui motherboard. Motherboard menentukan jenis '
        'CPU, RAM, dan kartu ekspansi yang kompatibel dengan sistem.',
  ),
  const LearningMaterialModel(
    id: 'mat_mb_02',
    componentId: 'motherboard',
    title: 'Komponen pada Motherboard',
    content:
        'Motherboard memiliki banyak komponen penting seperti chipset '
        '(Northbridge & Southbridge), slot RAM (DIMM), slot PCIe, soket CPU, '
        'konektor SATA untuk penyimpanan, header front panel, dan port I/O '
        'belakang (USB, HDMI, Ethernet, Audio).',
  ),

  // CPU
  const LearningMaterialModel(
    id: 'mat_cpu_01',
    componentId: 'cpu',
    title: 'Apa itu CPU?',
    content:
        'CPU (Central Processing Unit) sering disebut sebagai otak komputer. '
        'CPU bertanggung jawab untuk mengeksekusi instruksi dari perangkat lunak. '
        'Kecepatan CPU diukur dalam GHz dan jumlah core menentukan kemampuan '
        'multitasking.',
  ),
  const LearningMaterialModel(
    id: 'mat_cpu_02',
    componentId: 'cpu',
    title: 'Arsitektur CPU Modern',
    content:
        'CPU modern menggunakan arsitektur x86-64 (Intel/AMD) atau ARM. '
        'Setiap CPU memiliki ALU (Arithmetic Logic Unit), Control Unit, '
        'Register, dan Cache (L1, L2, L3). Multi-core CPU memungkinkan '
        'eksekusi instruksi secara paralel untuk performa lebih tinggi.',
  ),

  // RAM
  const LearningMaterialModel(
    id: 'mat_ram_01',
    componentId: 'ram',
    title: 'Fungsi RAM',
    content:
        'RAM menyimpan data dan instruksi yang sedang aktif digunakan oleh CPU. '
        'Tanpa RAM yang cukup, komputer akan lambat karena harus membaca data '
        'dari penyimpanan yang jauh lebih lambat (HDD/SSD).',
  ),
  const LearningMaterialModel(
    id: 'mat_ram_02',
    componentId: 'ram',
    title: 'Jenis-jenis RAM',
    content:
        'RAM modern yang umum digunakan adalah DDR4 dan DDR5. DDR5 menawarkan '
        'bandwidth lebih tinggi dan efisiensi daya yang lebih baik. Kapasitas '
        'RAM untuk penggunaan umum berkisar 8-16 GB, sedangkan untuk profesional '
        'bisa mencapai 64 GB atau lebih.',
  ),

  // VGA
  const LearningMaterialModel(
    id: 'mat_vga_01',
    componentId: 'vga',
    title: 'Peran Kartu Grafis',
    content:
        'Kartu grafis (GPU) bertanggung jawab untuk merender gambar yang '
        'ditampilkan di monitor. GPU sangat penting untuk gaming, desain grafis, '
        'editing video, dan komputasi paralel seperti machine learning.',
  ),
  const LearningMaterialModel(
    id: 'mat_vga_02',
    componentId: 'vga',
    title: 'VRAM dan Performa GPU',
    content:
        'VRAM (Video RAM) adalah memori khusus pada kartu grafis yang menyimpan '
        'data tekstur, frame buffer, dan data grafis lainnya. Semakin besar '
        'VRAM, semakin baik kemampuan GPU dalam menangani resolusi tinggi dan '
        'tekstur detail. GPU modern menggunakan GDDR6 atau GDDR6X.',
  ),
];

/// Data dummy soal kuis.
final List<QuizQuestionModel> dummyQuizQuestions = [
  ...additionalQuestions,
  // Motherboard
  const QuizQuestionModel(
    id: 'quiz_mb_01',
    question: 'Apa fungsi utama motherboard dalam komputer?',
    options: [
      'Menyimpan data secara permanen',
      'Menghubungkan seluruh komponen komputer',
      'Memproses grafis untuk ditampilkan ke monitor',
      'Menjalankan instruksi program',
    ],
    correctAnswerIndex: 1,
    componentId: 'motherboard',
  ),
  const QuizQuestionModel(
    id: 'quiz_mb_02',
    question:
        'Slot apa yang digunakan untuk memasang kartu grafis pada motherboard?',
    options: ['Slot DIMM', 'Slot SATA', 'Slot PCIe x16', 'Soket LGA'],
    correctAnswerIndex: 2,
    componentId: 'motherboard',
  ),

  // CPU
  const QuizQuestionModel(
    id: 'quiz_cpu_01',
    question: 'Apa kepanjangan dari CPU?',
    options: [
      'Computer Processing Unit',
      'Central Processing Unit',
      'Central Program Utility',
      'Computer Program Unit',
    ],
    correctAnswerIndex: 1,
    componentId: 'cpu',
  ),
  const QuizQuestionModel(
    id: 'quiz_cpu_02',
    question: 'Satuan apa yang digunakan untuk mengukur kecepatan CPU?',
    options: ['Megabyte (MB)', 'Watt (W)', 'Gigahertz (GHz)', 'Megapixel (MP)'],
    correctAnswerIndex: 2,
    componentId: 'cpu',
  ),

  // RAM
  const QuizQuestionModel(
    id: 'quiz_ram_01',
    question: 'Mengapa RAM disebut memori volatile?',
    options: [
      'Karena harganya mudah berubah',
      'Karena kecepatannya tidak stabil',
      'Karena data hilang saat komputer dimatikan',
      'Karena kapasitasnya bisa bertambah sendiri',
    ],
    correctAnswerIndex: 2,
    componentId: 'ram',
  ),
  const QuizQuestionModel(
    id: 'quiz_ram_02',
    question: 'Tipe RAM apa yang paling baru dan umum digunakan saat ini?',
    options: ['DDR2', 'SDRAM', 'DDR3', 'DDR5'],
    correctAnswerIndex: 3,
    componentId: 'ram',
  ),

  // VGA
  const QuizQuestionModel(
    id: 'quiz_vga_01',
    question: 'Apa fungsi utama kartu grafis (GPU)?',
    options: [
      'Menyimpan file sistem operasi',
      'Memproses dan menampilkan grafis ke monitor',
      'Mengatur kecepatan kipas komputer',
      'Menghubungkan komputer ke internet',
    ],
    correctAnswerIndex: 1,
    componentId: 'vga',
  ),
  const QuizQuestionModel(
    id: 'quiz_vga_02',
    question: 'Apa kepanjangan dari VRAM?',
    options: [
      'Virtual Random Access Memory',
      'Video Read Access Memory',
      'Video Random Access Memory',
      'Variable RAM',
    ],
    correctAnswerIndex: 2,
    componentId: 'vga',
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
