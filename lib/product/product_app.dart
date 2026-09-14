import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../app/brand.dart';
import '../app/theme.dart';
import 'morvixa_store.dart';
import 'screens.dart';

class ProductApp extends StatefulWidget {
  const ProductApp({super.key});
  @override
  State<ProductApp> createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  final store = MorvixaStore();
  Widget _currentScreen = const SteepingTimerScreen();
  String _title = 'Steeping Timer';
  
  @override
  void initState() {
    super.initState();
    _init();
  }
  
  Future<void> _init() async {
    try {
      final content = await rootBundle.loadString('packages/morvixa/product/content.json');
      await store.load(content);
    } catch (e) {
      await store.load('{"teas":[]}');
    }
  }

  void _nav(Widget screen, String title) {
    setState(() {
      _currentScreen = screen;
      _title = title;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text(_title, style: AppTheme.display(cSurface)), backgroundColor: cBg),
          drawer: Drawer(
            backgroundColor: cSurface,
            child: ListView(
              children: [
                DrawerHeader(child: Text('Morvixa', style: AppTheme.display(cAccent))),
                ListTile(title: Text('Timer', style: AppTheme.text(cInk)), onTap: () => _nav(const SteepingTimerScreen(), 'Steeping Timer')),
                ListTile(title: Text('Library', style: AppTheme.text(cInk)), onTap: () => _nav(const TeaLibraryScreen(), 'Tea Library')),
                ListTile(title: Text('Notes', style: AppTheme.text(cInk)), onTap: () => _nav(const TastingNotesScreen(), 'Tasting Notes')),
                ListTile(title: Text('Temp Guide', style: AppTheme.text(cInk)), onTap: () => _nav(const WaterTempScreen(), 'Water Temp Guide')),
              ],
            ),
          ),
          body: _currentScreen,
        ),
      ),
    );
  }
}
