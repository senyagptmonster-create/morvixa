import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/morvixa_theme.dart';
import '../painters/tea_steep_hourglass_painter.dart';

class TimerSteepView extends StatefulWidget {
  const TimerSteepView({super.key});

  @override
  State<TimerSteepView> createState() => _TimerSteepViewState();
}

class _TimerSteepViewState extends State<TimerSteepView> {
  int _targetSeconds = 180;
  int _secondsLeft = 180;
  bool _isSteeping = false;
  Timer? _timer;
  String _selectedTea = 'Dragon Well Green';

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleSteep() {
    setState(() {
      _isSteeping = !_isSteeping;
      if (_isSteeping) {
        _timer = Timer.periodic(const Duration(seconds: 1), (t) {
          if (_secondsLeft > 0) {
            setState(() => _secondsLeft--);
          } else {
            t.cancel();
            setState(() => _isSteeping = false);
          }
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isSteeping = false;
      _secondsLeft = _targetSeconds;
    });
  }

  void _selectTeaPreset(String name, int seconds) {
    _timer?.cancel();
    setState(() {
      _selectedTea = name;
      _targetSeconds = seconds;
      _secondsLeft = seconds;
      _isSteeping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_targetSeconds - _secondsLeft) / _targetSeconds;
    final mins = _secondsLeft ~/ 60;
    final secs = _secondsLeft % 60;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Tea Varietal Chip Selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                {'name': 'Dragon Well Green', 'sec': 150},
                {'name': 'Silver Needle White', 'sec': 240},
                {'name': 'Tieguanyin Oolong', 'sec': 180},
                {'name': 'Earl Grey Black', 'sec': 210},
              ].map((t) {
                final isSel = _selectedTea == t['name'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(t['name'] as String),
                    selected: isSel,
                    selectedColor: MorvixaTheme.accent,
                    labelStyle: TextStyle(
                      color: isSel ? Colors.white : MorvixaTheme.ink,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (_) => _selectTeaPreset(t['name'] as String, t['sec'] as int),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          // Graphic Tea Beaker
          Container(
            height: 220,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: MorvixaTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: MorvixaTheme.edge),
            ),
            child: CustomPaint(
              painter: TeaSteepHourglassPainter(
                progress: progress,
                isSteeping: _isSteeping,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Countdown Timer
          Text(
            '$mins:${secs.toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
              color: MorvixaTheme.ink,
              letterSpacing: -1,
            ),
          ),
          Text(
            _isSteeping ? 'INFUSION IN PROGRESS' : 'INFUSION PAUSED',
            style: const TextStyle(fontWeight: FontWeight.bold, color: MorvixaTheme.accent, letterSpacing: 1.5, fontSize: 12),
          ),
          const SizedBox(height: 24),
          // Control Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSteeping ? Colors.amber.shade800 : MorvixaTheme.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: _toggleSteep,
                  icon: Icon(_isSteeping ? Icons.pause : Icons.play_arrow),
                  label: Text(_isSteeping ? 'PAUSE INFUSION' : 'COMMENCE STEEPING',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              IconButton.filledTonal(
                onPressed: _resetTimer,
                icon: const Icon(Icons.refresh),
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: MorvixaTheme.surface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
