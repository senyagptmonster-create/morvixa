import 'package:flutter/material.dart';
import '../theme/morvixa_theme.dart';
import '../state/tea_scope.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = TeaScope.of(context);

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: scope.teas.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, idx) {
        final tea = scope.teas[idx];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MorvixaTheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: MorvixaTheme.edge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tea.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('${tea.tempC}°C',
                      style: const TextStyle(color: MorvixaTheme.accent, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 4),
              Text('${tea.varietal} • ${tea.steepSeconds ~/ 60}m ${tea.steepSeconds % 60}s steep',
                  style: const TextStyle(color: MorvixaTheme.muted, fontSize: 13)),
              const SizedBox(height: 6),
              Text(tea.notes, style: const TextStyle(color: MorvixaTheme.ink, height: 1.3, fontSize: 13)),
            ],
          ),
        );
      },
    );
  }
}
