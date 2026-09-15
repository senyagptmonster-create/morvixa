import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../steep_timer/tea_steep_controller.dart';
import '../../common/tea_theme.dart';

class TastingNotesView extends StatefulWidget {
  const TastingNotesView({super.key});

  @override
  State<TastingNotesView> createState() => _TastingNotesViewState();
}

class _TastingNotesViewState extends State<TastingNotesView> {
  final _noteController = TextEditingController();
  int _stars = 5;

  void _submitNote() {
    final ctrl = context.read<TeaSteepController>();
    if (_noteController.text.trim().isNotEmpty) {
      ctrl.addTasting(ctrl.selectedTea.name, _stars, _noteController.text.trim());
      _noteController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tasting note recorded!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<TeaSteepController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: TeaTheme.warmGrey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Log Tasting Notes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text('Current tea: ${ctrl.selectedTea.name}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Rating: '),
                    for (int i = 1; i <= 5; i++)
                      GestureDetector(
                        onTap: () => setState(() => _stars = i),
                        child: Icon(
                          i <= _stars ? Icons.star : Icons.star_border,
                          color: TeaTheme.oolongAmber,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    hintText: 'Aroma, liquor hue, mouthfeel, sweetness...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitNote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TeaTheme.matchaGreen,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Save Tasting'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Recent Sessions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          if (ctrl.tastings.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: Text('No tasting notes yet. Brew and record one!', style: TextStyle(color: Colors.grey))),
            )
          else
            ...ctrl.tastings.map((t) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(t.teaName, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(t.notes),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: TeaTheme.oolongAmber, size: 16),
                        Text(' ${t.rating}/5'),
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
