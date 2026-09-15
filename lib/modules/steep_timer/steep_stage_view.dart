import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tea_steep_controller.dart';
import '../../common/tea_theme.dart';

class SteepStageView extends StatelessWidget {
  const SteepStageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<TeaSteepController>();
    final mins = (ctrl.remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final secs = (ctrl.remainingSeconds % 60).toString().padLeft(2, '0');
    final progress = 1.0 - (ctrl.remainingSeconds / ctrl.selectedTea.steepSeconds).clamp(0.0, 1.0);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: TeaTheme.warmGrey),
            ),
            child: Row(
              children: [
                const Icon(Icons.emoji_nature, color: TeaTheme.matchaGreen),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ctrl.selectedTea.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Target Temp: ${ctrl.selectedTea.idealTempC}°C | ${ctrl.selectedTea.type} Tea',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 220,
                height: 220,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 10,
                  backgroundColor: TeaTheme.warmGrey,
                  color: TeaTheme.oolongAmber,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$mins:$secs',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: TeaTheme.darkBark,
                        fontFeatures: [],
                      )),
                  const SizedBox(height: 4),
                  Text(ctrl.isSteeping ? 'INFUSING...' : 'READY',
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: ctrl.isSteeping ? TeaTheme.matchaGreen : Colors.grey,
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filledTonal(
                onPressed: () => ctrl.resetTimer(),
                icon: const Icon(Icons.replay),
                iconSize: 28,
              ),
              const SizedBox(width: 20),
              FilledButton.icon(
                onPressed: () => ctrl.toggleTimer(),
                icon: Icon(ctrl.isSteeping ? Icons.pause : Icons.play_arrow),
                label: Text(ctrl.isSteeping ? 'Pause Infusion' : 'Start Steeping'),
                style: FilledButton.styleFrom(
                  backgroundColor: TeaTheme.matchaGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: TeaTheme.warmGrey),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Infusions Completed',
                          style: TextStyle(fontSize: 13, color: Colors.grey)),
                      Text('${ctrl.completedSteepsCount} pots',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: TeaTheme.darkBark)),
                    ],
                  ),
                ),
                const Icon(Icons.local_cafe, color: TeaTheme.oolongAmber, size: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
