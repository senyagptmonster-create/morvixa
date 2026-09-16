import 'package:flutter/material.dart';
import 'theme/morvixa_theme.dart';
import 'models/tea_entry.dart';
import 'state/tea_scope.dart';
import 'views/timer_steep_view.dart';
import 'views/library_view.dart';

class MorvixaApp extends StatefulWidget {
  const MorvixaApp({super.key});

  @override
  State<MorvixaApp> createState() => _MorvixaAppState();
}

class _MorvixaAppState extends State<MorvixaApp> {
  final List<TeaEntry> _teas = [
    const TeaEntry(
      name: 'Dragon Well (Longjing)',
      varietal: 'Pan-fired Green Tea',
      tempC: 80,
      steepSeconds: 150,
      notes: 'Toasted chestnut aroma with fresh sweet orchid finish.',
    ),
    const TeaEntry(
      name: 'Tie Guan Yin',
      varietal: 'Anxi Roasted Oolong',
      tempC: 90,
      steepSeconds: 180,
      notes: 'Velvety floral mouthfeel with lingering honey mineral sweetness.',
    ),
    const TeaEntry(
      name: 'Silver Needle (Baihao Yinzhen)',
      varietal: 'Fujian White Tea',
      tempC: 85,
      steepSeconds: 240,
      notes: 'Delicate cucumber sweetness with subtle melon and hay undertones.',
    ),
  ];

  int _selectedDrawer = 0;

  void _addNote(TeaEntry entry) {
    setState(() => _teas.add(entry));
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    String title;
    switch (_selectedDrawer) {
      case 0:
        content = const TimerSteepView();
        title = 'Steeping Timer';
        break;
      case 1:
      default:
        content = const LibraryView();
        title = 'Tea Leaves Library';
        break;
    }

    return TeaScope(
      teas: _teas,
      onAddNote: _addNote,
      child: MaterialApp(
        title: 'Morvixa Tea Botanicals',
        debugShowCheckedModeBanner: false,
        theme: MorvixaTheme.themeData,
        home: Scaffold(
          appBar: AppBar(
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(color: MorvixaTheme.accent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 24,
                        child: Icon(Icons.emoji_food_beverage, color: MorvixaTheme.accent, size: 28),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Morvixa Botanicals',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_teas.length} artisan teas catalogued',
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.timer_outlined),
                  title: const Text('Steeping Timer'),
                  selected: _selectedDrawer == 0,
                  onTap: () {
                    setState(() => _selectedDrawer = 0);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.local_florist_outlined),
                  title: const Text('Tea Leaves Library'),
                  selected: _selectedDrawer == 1,
                  onTap: () {
                    setState(() => _selectedDrawer = 1);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: content,
        ),
      ),
    );
  }
}
