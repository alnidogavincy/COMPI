import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_result_screen.dart';
import '../../core/app_colors.dart';
import '../../core/app_typography.dart';
import '../../../data/dummy_data.dart';

class MatchUpScreen extends StatefulWidget {
  const MatchUpScreen({super.key});

  @override
  State<MatchUpScreen> createState() => _MatchUpScreenState();
}

class _MatchUpScreenState extends State<MatchUpScreen> {
  late final Map<String, String?> _matches;

  @override
  void initState() {
    super.initState();
    // Initialize matches map from dummy data
    _matches = {
      for (var item in dummyMatchItems) item.id: null
    };

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

    // Use a subset or shuffle for real games. Here we just take the first 3 for UI parity with original screen.
    final itemsToPlay = dummyMatchItems.take(3).toList();
    
    // Create target items (you might want to shuffle these independently in a real game)
    final targetItems = List.from(itemsToPlay);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textDark), onPressed: () => Navigator.pop(context)),
        title: Text('Match Up', style: AppTypography.heading3.copyWith(fontSize: 18)),
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
                  decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      const Icon(Icons.bolt, size: 14, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text('Level 1: Komponen Inti', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.cyan[100], borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 14, color: AppColors.textDark),
                      const SizedBox(width: 4),
                      Text('01:19', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.textDark)),
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
                        decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16)),
                        child: const Icon(Icons.route, color: AppColors.primary, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Tautkan Pin Sirkuit', style: AppTypography.heading3.copyWith(fontSize: 16)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
                                  child: Text('${itemsToPlay.length} Pasang', style: AppTypography.caption.copyWith(fontSize: 10, fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('Hubungkan terminal gambar komponen di kiri ke kartu fungsi arsitektur yang tepat di sebelah kanan.', style: AppTypography.caption.copyWith(color: AppColors.textGray, height: 1.4)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(color: AppColors.border),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                          const SizedBox(width: 6),
                          Text('Status Sambungan:', style: AppTypography.caption.copyWith(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                      Text('$connectedCount dari ${itemsToPlay.length} Terpasang', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
                      Text('Skor Akurasi +100 XP', style: AppTypography.caption.copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.teal[600])),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(itemsToPlay.length, (index) {
                        return _DraggableItem(
                          id: itemsToPlay[index].id, 
                          title: itemsToPlay[index].targetLabel, 
                          number: '#0${index + 1}'
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 24),
                  
                  // DragTargets (Texts)
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(targetItems.length, (index) {
                        final item = targetItems[index];
                        // Hardcoding definitions based on label just for mapping since we don't have descriptions in MatchItemModel.
                        String desc = 'Papan sirkuit utama interkoneksi seluruh lalu lintas data...';
                        IconData icon = Icons.developer_board;
                        if (item.targetLabel == 'CPU') {
                          desc = 'Unit pemroses logika utama (ALU & CU) yang menjalankan...';
                          icon = Icons.memory;
                        } else if (item.targetLabel == 'RAM') {
                          desc = 'Penyimpanan data komputasi sementara yang bersifat volatil...';
                          icon = Icons.view_list;
                        }

                        return _DragTargetItem(
                          id: item.id, 
                          title: item.targetLabel,
                          desc: desc, 
                          icon: icon,
                          connectedId: _matches.values.contains(item.id) ? item.id : null,
                          onAccept: (data) { setState(() { _matches[data] = item.id; _checkCompletion(); }); },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tips
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.lightbulb_outline, size: 16, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: AppTypography.caption.copyWith(fontSize: 10, height: 1.4),
                        children: [
                          TextSpan(text: 'Tips TKJ: ', style: AppTypography.caption.copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                          const TextSpan(text: 'Cocokkan bentuk lekukan notch pada stik RAM dan pin socket processor sebelum menekan kuncian.'),
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
                onPressed: connectedCount == itemsToPlay.length ? () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const GameResultScreen())) : null,
                icon: const Icon(Icons.verified_user_outlined, color: Colors.white, size: 20),
                label: Text('Kirim Jawaban & Uji', style: AppTypography.subtitle.copyWith(fontSize: 14, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: Colors.blue[300],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            TextButton(
              onPressed: () { setState(() { _matches.updateAll((key, value) => null); }); },
              child: Text('Atur Ulang Sambungan (Reset)', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
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
          decoration: BoxDecoration(color: AppColors.primaryLight.withOpacity(0.8), borderRadius: BorderRadius.circular(16)),
          child: const Center(child: Icon(Icons.touch_app, color: AppColors.primary, size: 40)),
        ),
      ),
      childWhenDragging: Container(
        height: 120,
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(16)),
        child: const Center(child: Icon(Icons.dashboard_customize, color: AppColors.textGray)),
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
                      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                      child: Text(number, style: AppTypography.caption.copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
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
                  Expanded(child: Text(title, style: AppTypography.caption.copyWith(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textDark), maxLines: 1)),
                  const Icon(Icons.drag_indicator, size: 14, color: AppColors.textGray),
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
            color: isConnected ? AppColors.primaryLight : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isConnected ? AppColors.primary : Colors.transparent),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(title, style: AppTypography.caption.copyWith(fontSize: 12, fontWeight: FontWeight.bold, color: isConnected ? AppColors.primary : AppColors.textDark), maxLines: 1)),
                  Icon(icon, size: 16, color: isConnected ? AppColors.primary : Colors.blueGrey),
                ],
              ),
              const SizedBox(height: 4),
              Text(desc, style: AppTypography.caption.copyWith(fontSize: 9, color: AppColors.textGray, height: 1.2), maxLines: 3, overflow: TextOverflow.ellipsis),
              const Spacer(),
              Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: isConnected ? AppColors.primary : AppColors.border, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text(isConnected ? 'Terhubung' : 'Siap Dihubungkan', style: AppTypography.caption.copyWith(fontSize: 9, fontWeight: FontWeight.bold, color: isConnected ? AppColors.primary : AppColors.textGray)),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
