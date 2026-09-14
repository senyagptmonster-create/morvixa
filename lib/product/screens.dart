import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/brand.dart';
import '../app/theme.dart';
import 'morvixa_store.dart';

class SteepingTimerScreen extends StatelessWidget {
  const SteepingTimerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBg,
      body: Center(
        child: Text('03:00', style: AppTheme.display(cAccent)),
      ),
    );
  }
}

class TeaLibraryScreen extends StatelessWidget {
  const TeaLibraryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<MorvixaStore>();
    return Scaffold(
      backgroundColor: cBg,
      body: ListView.builder(
        itemCount: store.teas.length,
        itemBuilder: (context, index) {
          final tea = store.teas[index];
          return ListTile(
            title: Text(tea['name'], style: AppTheme.text(cInk)),
            subtitle: Text(tea['type'], style: AppTheme.text(cInk)),
          );
        },
      ),
    );
  }
}

class TastingNotesScreen extends StatelessWidget {
  const TastingNotesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBg,
      body: Center(
        child: Text('Floral notes, mild sweetness', style: AppTheme.text(cInk)),
      ),
    );
  }
}

class WaterTempScreen extends StatelessWidget {
  const WaterTempScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBg,
      body: Center(
        child: Text('Green Tea: 80°C\nBlack Tea: 100°C', style: AppTheme.display(cAccent2), textAlign: TextAlign.center),
      ),
    );
  }
}
