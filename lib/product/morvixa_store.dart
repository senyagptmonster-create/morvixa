import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MorvixaStore extends ChangeNotifier {
  List<dynamic> teas = [];
  bool isLoading = true;

  Future<void> load(String jsonContent) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('morvixa_data')) {
      await prefs.setString('morvixa_data', jsonContent);
    }
    final data = json.decode(prefs.getString('morvixa_data')!);
    teas = List.from(data['teas'] ?? []);
    isLoading = false;
    notifyListeners();
  }
}
