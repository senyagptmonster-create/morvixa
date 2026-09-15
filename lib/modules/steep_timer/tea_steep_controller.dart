import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeaProfile {
  final String id;
  final String name;
  final String type;
  final int steepSeconds;
  final int idealTempC;
  final String infusionNotes;

  const TeaProfile({
    required this.id,
    required this.name,
    required this.type,
    required this.steepSeconds,
    required this.idealTempC,
    required this.infusionNotes,
  });
}

class TastingRecord {
  final String teaName;
  final int rating;
  final String notes;
  final DateTime date;

  TastingRecord({
    required this.teaName,
    required this.rating,
    required this.notes,
    required this.date,
  });
}

class TeaSteepController extends ChangeNotifier {
  final List<TeaProfile> _catalog = [
    const TeaProfile(
      id: 'sencha',
      name: 'Sencha Green',
      type: 'Green',
      steepSeconds: 90,
      idealTempC: 75,
      infusionNotes: 'Delicate vegetative notes, sweet umami finish.',
    ),
    const TeaProfile(
      id: 'da-hong-pao',
      name: 'Da Hong Pao Oolong',
      type: 'Oolong',
      steepSeconds: 150,
      idealTempC: 95,
      infusionNotes: 'Charcoal roasted, mineral-rich, floral orchid body.',
    ),
    const TeaProfile(
      id: 'assam-black',
      name: 'Assam Golden Tip',
      type: 'Black',
      steepSeconds: 210,
      idealTempC: 98,
      infusionNotes: 'Malty brisk boldness, great solo or with honey.',
    ),
    const TeaProfile(
      id: 'silver-needle',
      name: 'Bai Hao Silver Needle',
      type: 'White',
      steepSeconds: 240,
      idealTempC: 80,
      infusionNotes: 'Silky downy buds, light melon and honey aroma.',
    ),
    const TeaProfile(
      id: 'chamomile-herbal',
      name: 'Egyptian Chamomile',
      type: 'Herbal',
      steepSeconds: 300,
      idealTempC: 100,
      infusionNotes: 'Caffeine-free soothing floral apple-like profile.',
    ),
  ];

  late TeaProfile _selectedTea;
  int _remainingSeconds = 90;
  bool _isSteeping = false;
  int _completedSteepsCount = 0;
  final List<TastingRecord> _tastings = [];

  TeaSteepController() {
    _selectedTea = _catalog.first;
    _remainingSeconds = _selectedTea.steepSeconds;
    _loadPrefs();
  }

  List<TeaProfile> get catalog => _catalog;
  TeaProfile get selectedTea => _selectedTea;
  int get remainingSeconds => _remainingSeconds;
  bool get isSteeping => _isSteeping;
  int get completedSteepsCount => _completedSteepsCount;
  List<TastingRecord> get tastings => _tastings;

  void selectTea(TeaProfile tea) {
    _selectedTea = tea;
    _remainingSeconds = tea.steepSeconds;
    _isSteeping = false;
    notifyListeners();
  }

  void toggleTimer() {
    _isSteeping = !_isSteeping;
    notifyListeners();
  }

  void tick() {
    if (_isSteeping && _remainingSeconds > 0) {
      _remainingSeconds--;
      if (_remainingSeconds == 0) {
        _isSteeping = false;
        _completedSteepsCount++;
        _savePrefs();
      }
      notifyListeners();
    }
  }

  void resetTimer() {
    _isSteeping = false;
    _remainingSeconds = _selectedTea.steepSeconds;
    notifyListeners();
  }

  void addTasting(String teaName, int rating, String notes) {
    _tastings.insert(0, TastingRecord(
      teaName: teaName,
      rating: rating,
      notes: notes,
      date: DateTime.now(),
    ));
    notifyListeners();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _completedSteepsCount = prefs.getInt('morvixa_steeps') ?? 3;
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('morvixa_steeps', _completedSteepsCount);
  }
}
