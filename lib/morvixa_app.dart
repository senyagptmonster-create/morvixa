import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/tea_theme.dart';
import 'modules/steep_timer/tea_steep_controller.dart';
import 'modules/steep_timer/steep_stage_view.dart';
import 'modules/tea_library/tea_leaves_view.dart';
import 'modules/tasting_notes/tasting_notes_view.dart';
import 'modules/water_temp/water_temp_view.dart';

class MorvixaApp extends StatelessWidget {
  const MorvixaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TeaSteepController(),
      child: MaterialApp(
        title: 'Morvixa Tea Infusions',
        theme: TeaTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const MorvixaHomeScaffold(),
      ),
    );
  }
}

class MorvixaHomeScaffold extends StatefulWidget {
  const MorvixaHomeScaffold({super.key});

  @override
  State<MorvixaHomeScaffold> createState() => _MorvixaHomeScaffoldState();
}

class _MorvixaHomeScaffoldState extends State<MorvixaHomeScaffold> {
  int _currentIndex = 0;

  final _titles = ['Steep Timer', 'Tea Leaves', 'Tasting Notes', 'Water Temp'];
  final _screens = const [
    SteepStageView(),
    TeaLeavesView(),
    TastingNotesView(),
    WaterTempView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.timer_outlined), selectedIcon: Icon(Icons.timer), label: 'Timer'),
          NavigationDestination(icon: Icon(Icons.eco_outlined), selectedIcon: Icon(Icons.eco), label: 'Leaves'),
          NavigationDestination(icon: Icon(Icons.rate_review_outlined), selectedIcon: Icon(Icons.rate_review), label: 'Tasting'),
          NavigationDestination(icon: Icon(Icons.device_thermostat_outlined), selectedIcon: Icon(Icons.device_thermostat), label: 'Water'),
        ],
      ),
    );
  }
}
