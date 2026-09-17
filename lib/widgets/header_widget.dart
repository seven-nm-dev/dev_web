import 'dart:async';
import 'package:flutter/material.dart';
import '../providers/language_provider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF13131A),
        border: Border(bottom: BorderSide(color: Colors.white10, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const PulsingLogo(),
          const NmDevLogo(),
          const LanguageSwitcher(), // ← только глобус + меню
        ],
      ),
    );
  }
}

// === Глобус + выпадающее меню ===
class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageProvider(),
      builder: (context, _) {
        final lang = LanguageProvider();
        final current = lang.currentLanguage;

        return PopupMenuButton<AppLanguage>(
          tooltip: 'Language',
          offset: const Offset(0, 45),
          color: const Color(0xFF1A1A24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.white12),
          ),
          onSelected: (AppLanguage value) {
            lang.setLanguage(value);
          },
          itemBuilder: (context) => [
            _buildItem(AppLanguage.ru, 'Русский', current),
            _buildItem(AppLanguage.ky, 'Кыргызча', current),
            _buildItem(AppLanguage.en, 'English', current),
          ],
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              padding: const EdgeInsets.all(10),
           
              child: const Icon(
                Icons.language_rounded,
                size: 22,
                color: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }

  PopupMenuItem<AppLanguage> _buildItem(
    AppLanguage value,
    String title,
    AppLanguage current,
  ) {
    final isSelected = value == current;

    return PopupMenuItem<AppLanguage>(
      value: value,
      child: Row(
        children: [
          if (isSelected)
            const Icon(Icons.check, size: 18, color: Colors.cyanAccent)
          else
            const SizedBox(width: 18),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.cyanAccent : Colors.white,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// === Остальной код (PulsingLogo + NmDevLogo) оставляем без изменений ===
class PulsingLogo extends StatefulWidget {
  const PulsingLogo({super.key});

  @override
  State<PulsingLogo> createState() => _PulsingLogoState();
}

class _PulsingLogoState extends State<PulsingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.12,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _glowAnimation = Tween<double>(
      begin: 4.0,
      end: 20.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orangeAccent.withValues(
                        alpha: .35 * _controller.value + 0.1,
                      ),
                      blurRadius: _glowAnimation.value,
                      spreadRadius: 2 * _controller.value,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.orangeAccent.withValues(alpha: .3),
                        ),
                      ),
                      child: const Icon(
                        Icons.filter_7_rounded,
                        color: Colors.orangeAccent,
                        size: 24,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

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

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    _typeText();
    _loopTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _typeText();
    });
  }

  void _typeText() {
    if (!mounted) return;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentText,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        letterSpacing: 3,
        color: Colors.white,
        fontFamily: 'monospace',
      ),
    );
  }
}
