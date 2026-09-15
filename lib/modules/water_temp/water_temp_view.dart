import 'package:flutter/material.dart';
import '../../common/tea_theme.dart';

class WaterTempView extends StatelessWidget {
  const WaterTempView({super.key});

  @override
  Widget build(BuildContext context) {
    final guides = [
      {'name': 'White & Delicate Greens', 'temp': '70°C - 75°C', 'bubble': 'Shrimp Eyes (tiny bubbles forming)'},
      {'name': 'Japanese Sencha & Gyokuro', 'temp': '75°C - 80°C', 'bubble': 'Crab Eyes (steam rises gently)'},
      {'name': 'Light Rolled Oolong', 'temp': '85°C - 90°C', 'bubble': 'Fish Eyes (medium pearls rising)'},
      {'name': 'Dark Oolong & Black Teas', 'temp': '92°C - 96°C', 'bubble': 'Rope of Pearls (steady continuous bubble stream)'},
      {'name': 'Pu-erh & Herbal Tisanes', 'temp': '98°C - 100°C', 'bubble': 'Raging Torrent (full rolling boil)'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: guides.length,
      itemBuilder: (context, idx) {
        final g = guides[idx];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: TeaTheme.warmGrey),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: TeaTheme.parchment,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.water_drop, color: TeaTheme.matchaGreen),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(g['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(g['temp']!, style: const TextStyle(color: TeaTheme.oolongAmber, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Visual cue: ${g['bubble']}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
