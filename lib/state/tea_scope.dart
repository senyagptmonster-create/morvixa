import 'package:flutter/material.dart';
import '../models/tea_entry.dart';

class TeaScope extends InheritedWidget {
  final List<TeaEntry> teas;
  final Function(TeaEntry) onAddNote;

  const TeaScope({
    super.key,
    required this.teas,
    required this.onAddNote,
    required super.child,
  });

  static TeaScope of(BuildContext context) {
    final res = context.dependOnInheritedWidgetOfExactType<TeaScope>();
    assert(res != null, 'No TeaScope found in context');
    return res!;
  }

  @override
  bool updateShouldNotify(TeaScope oldWidget) => teas != oldWidget.teas;
}
