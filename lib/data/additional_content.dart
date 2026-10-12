import 'models/component_model.dart';
import 'models/learning_material_model.dart';
import 'models/quiz_question_model.dart';

const additionalComponents = [
  ComponentModel(
    id: 'storage',
    name: 'Storage',
    category: 'Penyimpanan',
    shortDescription: 'SSD, HDD & M.2 • penyimpanan data permanen.',
    fullDescription:
        'Storage menyimpan sistem operasi, aplikasi, dan file meskipun komputer dimatikan. HDD menggunakan piringan magnetik, sedangkan SSD memakai memori flash tanpa bagian bergerak. M.2 adalah bentuk modul; antarmukanya dapat berupa SATA atau PCIe dengan protokol NVMe, tergantung perangkat dan slot motherboard.',
    modelPath: 'assets/models/storage.glb',
    specs: {
      'TIPE': 'HDD / SSD',
      'BENTUK': '2,5 inci / M.2',
      'ANTARMUKA': 'SATA / PCIe',
    },
  ),
  ComponentModel(
    id: 'psu',
    name: 'Power Supply (PSU)',
    category: 'Catu Daya',
    shortDescription: 'Mengubah listrik AC menjadi daya DC untuk komponen.',
    fullDescription:
        'Power Supply Unit mengubah listrik AC dari sumber listrik menjadi tegangan DC yang digunakan komponen komputer. Kabel 24-pin memasok daya utama motherboard, konektor CPU memasok prosesor, dan konektor lain memasok kartu grafis serta penyimpanan. Pilih kapasitas dan konektor yang sesuai kebutuhan sistem.',
    modelPath: 'assets/models/psu.glb',
    specs: {'FUNGSI': 'AC ke DC', 'KONEKTOR': 'Motherboard / CPU / GPU'},
  ),
  ComponentModel(
    id: 'cooling',
    name: 'Cooling System',
    category: 'Pendinginan',
    shortDescription: 'Air cooler & liquid cooler • pengendali suhu.',
    fullDescription:
        'Sistem pendingin memindahkan panas dari komponen ke udara sekitar. Air cooler menggunakan heatsink dan kipas, sedangkan liquid cooler menggunakan cairan, pompa, dan radiator. Thermal paste membantu kontak antara permukaan prosesor dan pendingin. Aliran udara casing mendukung pelepasan panas.',
    modelPath: '',
    specs: {'TIPE': 'Air / Liquid', 'BAGIAN': 'Heatsink / Fan / Radiator'},
  ),
  ComponentModel(
    id: 'casing',
    name: 'Casing & Chassis',
    category: 'Casing',
    shortDescription: 'Rangka pelindung, aliran udara, dan manajemen kabel.',
    fullDescription:
        'Casing menjadi rangka pemasangan motherboard, penyimpanan, PSU, dan kipas. Pilih casing yang sesuai ukuran motherboard serta ruang untuk kartu grafis dan pendingin. Jalur kabel yang rapi memudahkan perawatan dan membantu menjaga aliran udara.',
    modelPath: 'assets/models/computer_case.glb',
    specs: {
      'FUNGSI': 'Rangka & pelindung',
      'PERHATIKAN': 'Ukuran / Airflow / Kabel',
    },
  ),
];

const additionalMaterials = [
  LearningMaterialModel(
    id: 'mat_storage_01',
    componentId: 'storage',
    title: 'Mengenal HDD, SSD, dan M.2',
    content:
        'HDD menyimpan data pada piringan magnetik yang berputar. SSD menggunakan memori flash sehingga tidak memiliki bagian mekanis bergerak. M.2 menunjukkan bentuk modul; SSD M.2 dapat memakai SATA atau NVMe melalui PCIe. Periksa dukungan slot sebelum memilih perangkat.',
  ),
  LearningMaterialModel(
    id: 'mat_storage_02',
    componentId: 'storage',
    title: 'Letak dan Sambungan Storage',
    content:
        'Drive SATA biasanya ditempatkan di dudukan drive casing, memakai kabel data ke motherboard dan kabel daya dari PSU. Modul SSD M.2 dipasang pada slot M.2 motherboard dan ditahan sekrup atau pengunci. Matikan komputer serta lepaskan sumber listrik sebelum pemasangan.',
  ),
  LearningMaterialModel(
    id: 'mat_psu_01',
    componentId: 'psu',
    title: 'Fungsi dan Konektor PSU',
    content:
        'PSU mengubah listrik AC menjadi DC untuk komputer. Motherboard memakai konektor utama 24-pin, CPU memiliki konektor daya tersendiri, dan GPU dapat memerlukan konektor tambahan. Bentuk konektor harus sesuai; jangan memaksa konektor yang berbeda.',
  ),
  LearningMaterialModel(
    id: 'mat_psu_02',
    componentId: 'psu',
    title: 'Memilih dan Menangani PSU',
    content:
        'Sesuaikan kapasitas daya dan kelengkapan konektor dengan sistem. Pada PSU modular, gunakan kabel yang memang sesuai model PSU tersebut. Jangan membuka rumah PSU karena kapasitor dapat menyimpan muatan listrik meskipun kabel daya telah dicabut.',
  ),
  LearningMaterialModel(
    id: 'mat_cooling_01',
    componentId: 'cooling',
    title: 'Air Cooler dan Liquid Cooler',
    content:
        'Air cooler membawa panas dari prosesor ke sirip heatsink lalu kipas mengalirkan udara melaluinya. Liquid cooler memindahkan panas melalui cairan menuju radiator. Keduanya memerlukan pemasangan yang sesuai soket dan kontak yang baik dengan prosesor.',
  ),
  LearningMaterialModel(
    id: 'mat_cooling_02',
    componentId: 'cooling',
    title: 'Thermal Paste dan Aliran Udara',
    content:
        'Thermal paste mengisi celah sangat kecil di antara prosesor dan alas pendingin. Ikuti petunjuk produsen saat mengoles dan memasang pendingin. Kipas intake memasukkan udara, sedangkan exhaust mengeluarkan udara hangat. Bersihkan debu ketika komputer mati dan sumber listrik terlepas.',
  ),
  LearningMaterialModel(
    id: 'mat_casing_01',
    componentId: 'casing',
    title: 'Fungsi Casing dan Kompatibilitas',
    content:
        'Casing menahan dan melindungi komponen komputer. Periksa dukungan ukuran motherboard seperti ATX atau micro-ATX, panjang GPU, tinggi pendingin CPU, serta ukuran PSU. Standoff motherboard harus berada pada posisi lubang pemasangan yang sesuai.',
  ),
  LearningMaterialModel(
    id: 'mat_casing_02',
    componentId: 'casing',
    title: 'Manajemen Kabel dan Airflow',
    content:
        'Rapikan kabel di jalur yang disediakan casing agar tidak menghalangi kipas dan mudah dirawat. Jangan menjepit kabel pada panel. Sambungkan tombol power dan indikator front panel mengikuti diagram motherboard. Pastikan jalur udara masuk dan keluar tidak tertutup.',
  ),
];

const additionalQuestions = [
  QuizQuestionModel(
    id: 'quiz_storage_01',
    componentId: 'storage',
    question: 'Apa yang membedakan SSD dari HDD?',
    options: [
      'SSD menggunakan piringan berputar',
      'SSD menggunakan memori flash',
      'SSD hanya menyimpan data saat ada listrik',
      'SSD menggantikan fungsi CPU',
    ],
    correctAnswerIndex: 1,
  ),
  QuizQuestionModel(
    id: 'quiz_psu_01',
    componentId: 'psu',
    question: 'Apa fungsi utama PSU?',
    options: [
      'Mengubah listrik AC menjadi DC',
      'Menyimpan file',
      'Menampilkan gambar',
      'Menjalankan instruksi program',
    ],
    correctAnswerIndex: 0,
  ),
  QuizQuestionModel(
    id: 'quiz_cooling_01',
    componentId: 'cooling',
    question: 'Apa fungsi heatsink pada pendingin CPU?',
    options: [
      'Menyimpan sistem operasi',
      'Memasok listrik AC',
      'Membantu melepaskan panas',
      'Menambah kapasitas RAM',
    ],
    correctAnswerIndex: 2,
  ),
  QuizQuestionModel(
    id: 'quiz_casing_01',
    componentId: 'casing',
    question: 'Apa yang perlu diperiksa saat memilih casing?',
    options: [
      'Warna ikon desktop',
      'Nama file pengguna',
      'Versi aplikasi perpesanan',
      'Ukuran motherboard dan ruang komponen',
    ],
    correctAnswerIndex: 3,
  ),
];
