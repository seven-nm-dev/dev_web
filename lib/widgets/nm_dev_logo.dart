import 'dart:async';
import 'package:flutter/material.dart';

class NmDevLogo extends StatefulWidget {
  const NmDevLogo({super.key});

  @override
  State<NmDevLogo> createState() => _NmDevLogoState();
}

class _NmDevLogoState extends State<NmDevLogo> {
  final String fullText = "NM DEV";
  String currentText = "";
  Timer? _loopTimer;
  Timer? _typeTimer;
  bool _showCursor = true;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    // Мигание курсора (|)
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) setState(() => _showCursor = !_showCursor);
    });
  }

  void _startAnimation() {
    _typeText();
    // Повторять печать каждые 10 секунд
    _loopTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _typeText();
    });
  }

  void _typeText() {
    setState(() => currentText = "");
    int index = 0;
    _typeTimer?.cancel();
    _typeTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (index < fullText.length) {
        if (mounted) {
          setState(() {
            currentText += fullText[index];
          });
        }
        index++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _loopTimer?.cancel();
    _typeTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          currentText,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            color: Colors.white,
            fontFamily: 'monospace', // Моноширинный код-шрифт
          ),
        ),
        // Мигающий неоновый курсор
        AnimatedOpacity(
          opacity: _showCursor ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 100),
          child: const Text(
            '_',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }
}
