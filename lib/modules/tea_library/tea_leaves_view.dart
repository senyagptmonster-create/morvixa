import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../steep_timer/tea_steep_controller.dart';
import '../../common/tea_theme.dart';

class TeaLeavesView extends StatelessWidget {
  const TeaLeavesView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<TeaSteepController>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ctrl.catalog.length,
      itemBuilder: (context, idx) {
        final tea = ctrl.catalog[idx];
        final isSelected = tea.id == ctrl.selectedTea.id;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: isSelected ? 2 : 0,
          color: isSelected ? const Color(0xFFEDF4EE) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: isSelected ? TeaTheme.matchaGreen : TeaTheme.warmGrey,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(tea.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(tea.infusionNotes, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: TeaTheme.warmGrey,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('${tea.steepSeconds} sec', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: TeaTheme.warmGrey,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('${tea.idealTempC}°C', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: TeaTheme.matchaGreen)
                : TextButton(
                    onPressed: () => ctrl.selectTea(tea),
                    child: const Text('Select'),
                  ),
          ),
        );
      },
    );
  }
}
