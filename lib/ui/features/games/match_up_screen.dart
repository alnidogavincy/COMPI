import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_result_screen.dart';

class MatchUpScreen extends StatefulWidget {
  const MatchUpScreen({super.key});

  @override
  State<MatchUpScreen> createState() => _MatchUpScreenState();
}

class _MatchUpScreenState extends State<MatchUpScreen> {
  final Map<String, String?> _matches = {
    'match_mb': null,
    'match_cpu': null,
    'match_ram': null,
  };

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.dispose();
  }

  void _checkCompletion() {
    if (_matches.values.every((val) => val != null)) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const GameResultScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int connectedCount = _matches.values.where((v) => v != null).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Match Up', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(radius: 14, backgroundColor: Colors.black12, child: Icon(Icons.person, size: 16, color: Colors.white)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(16)),
                  child: const Row(
                    children: [
                      Icon(Icons.bolt, size: 14, color: Color(0xFF2954E3)),
                      SizedBox(width: 4),
                      Text('Level 1: Komponen Inti', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.cyan[100], borderRadius: BorderRadius.circular(16)),
                  child: const Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 14, color: Color(0xFF1E293B)),
                      SizedBox(width: 4),
                      Text('01:19', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),

            // Instructions
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(16)),
                        child: const Icon(Icons.route, color: Color(0xFF2954E3), size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Tautkan Pin Sirkuit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                                  child: Text('3 Pasang', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                                )
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('Hubungkan terminal gambar komponen di kiri ke kartu fungsi arsitektur yang tepat di sebelah kanan.', style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.4)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF2954E3), shape: BoxShape.circle)),
                          const SizedBox(width: 6),
                          const Text('Status Sambungan:', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                      Text('$connectedCount dari 3 Terpasang', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                      Text('Skor Akurasi +100 XP', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.teal[600])),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Game Area
            Expanded(
              child: Row(
                children: [
                  // Draggables (Images)
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _DraggableItem(id: 'match_mb', title: 'Motherboard', number: '#01'),
                        const Spacer(),
                        _DraggableItem(id: 'match_cpu', title: 'CPU Socket', number: '#02'),
                        const Spacer(),
                        _DraggableItem(id: 'match_ram', title: 'DDR5 Module', number: '#03'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  
                  // DragTargets (Texts)
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        _DragTargetItem(
                          id: 'match_mb', title: 'Motherboard',
                          desc: 'Papan sirkuit utama interkoneksi seluruh lalu lintas data...', icon: Icons.developer_board,
                          connectedId: _matches.values.contains('match_mb') ? 'match_mb' : null,
                          onAccept: (data) { setState(() { _matches[data] = 'match_mb'; _checkCompletion(); }); },
                        ),
                        const Spacer(),
                        _DragTargetItem(
                          id: 'match_cpu', title: 'CPU (Processor)',
                          desc: 'Unit pemroses logika utama (ALU & CU) yang menjalankan...', icon: Icons.memory,
                          connectedId: _matches.values.contains('match_cpu') ? 'match_cpu' : null,
                          onAccept: (data) { setState(() { _matches[data] = 'match_cpu'; _checkCompletion(); }); },
                        ),
                        const Spacer(),
                        _DragTargetItem(
                          id: 'match_ram', title: 'RAM (Memori)',
                          desc: 'Penyimpanan data komputasi sementara yang bersifat volatil...', icon: Icons.view_list,
                          connectedId: _matches.values.contains('match_ram') ? 'match_ram' : null,
                          onAccept: (data) { setState(() { _matches[data] = 'match_ram'; _checkCompletion(); }); },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tips
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFE8EEFC), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.lightbulb_outline, size: 16, color: Color(0xFF2954E3)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 10, color: Colors.grey[700], height: 1.4),
                        children: const [
                          TextSpan(text: 'Tips TKJ: ', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                          TextSpan(text: 'Cocokkan bentuk lekukan notch pada stik RAM dan pin socket processor sebelum menekan kuncian.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: connectedCount == 3 ? () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const GameResultScreen())) : null,
                icon: const Icon(Icons.verified_user_outlined, color: Colors.white, size: 20),
                label: const Text('Kirim Jawaban & Uji', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2954E3),
                  disabledBackgroundColor: Colors.blue[300],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            TextButton(
              onPressed: () { setState(() { _matches.updateAll((key, value) => null); }); },
              child: const Text('Atur Ulang Sambungan (Reset)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
            ),
          ],
        ),
      ),
    );
  }
}

class _DraggableItem extends StatelessWidget {
  final String id;
  final String title;
  final String number;

  const _DraggableItem({required this.id, required this.title, required this.number});

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: id,
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          width: 120, height: 100,
          decoration: BoxDecoration(color: const Color(0xFFE8EEFC).withOpacity(0.8), borderRadius: BorderRadius.circular(16)),
          child: const Center(child: Icon(Icons.touch_app, color: Color(0xFF2954E3), size: 40)),
        ),
      ),
      childWhenDragging: Container(
        height: 120,
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
        child: const Center(child: Icon(Icons.dashboard_customize, color: Colors.grey)),
      ),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.blueGrey[50], borderRadius: const BorderRadius.vertical(top: Radius.circular(16))),
                    child: Center(child: Icon(Icons.memory, size: 40, color: Colors.blueGrey[200])), // Placeholder image
                  ),
                  Positioned(
                    top: 8, left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: const Color(0xFF2954E3).withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                      child: Text(number, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2954E3))),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)), maxLines: 1)),
                  const Icon(Icons.drag_indicator, size: 14, color: Colors.grey),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DragTargetItem extends StatelessWidget {
  final String id;
  final String title;
  final String desc;
  final IconData icon;
  final String? connectedId;
  final Function(String) onAccept;

  const _DragTargetItem({
    required this.id, required this.title, required this.desc, required this.icon, this.connectedId, required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    bool isConnected = connectedId != null;

    return DragTarget<String>(
      onAcceptWithDetails: (details) => onAccept(details.data),
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 120,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isConnected ? const Color(0xFFE8EEFC) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isConnected ? const Color(0xFF2954E3) : Colors.transparent),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isConnected ? const Color(0xFF2954E3) : const Color(0xFF1E293B)), maxLines: 1)),
                  Icon(icon, size: 16, color: isConnected ? const Color(0xFF2954E3) : Colors.blueGrey),
                ],
              ),
              const SizedBox(height: 4),
              Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey[600], height: 1.2), maxLines: 3, overflow: TextOverflow.ellipsis),
              const Spacer(),
              Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: isConnected ? const Color(0xFF2954E3) : Colors.grey[300], shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text(isConnected ? 'Terhubung' : 'Siap Dihubungkan', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: isConnected ? const Color(0xFF2954E3) : Colors.grey[500])),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
