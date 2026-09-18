import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../providers/language_provider.dart';
import '../widgets/footer_widget.dart';
import '../widgets/header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Column(
          children: [
            // 1. ШАПКА
            const HeaderWidget(),

            // 2. ЦЕНТРАЛЬНЫЙ БЛОК (Слушает изменения языка)
            Expanded(
              child: ListenableBuilder(
                listenable: LanguageProvider(),
                builder: (context, child) {
                  return Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: 20,
                        ),
                        child: Wrap(
                          spacing: 30,
                          runSpacing: 30,
                          alignment: WrapAlignment.center,
                          children: [
                            // ← убрали const
                            InteractiveCard(
                              titleKey: 'card_mobile_title',
                              subtitleKey: 'card_mobile_sub',
                              icon: Icons.phone_iphone_rounded,
                              color: Colors.blueAccent,
                              route: '/mobile',
                            ),
                            InteractiveCard(
                              titleKey: 'card_bots_title',
                              subtitleKey: 'card_bots_sub',
                              icon: Icons.smart_toy_rounded,
                              color: Colors.cyanAccent,
                              route: '/bots',
                            ),
                            InteractiveCard(
                              titleKey: 'card_web_title',
                              subtitleKey: 'card_web_sub',
                              icon: Icons.language_rounded,
                              color: Colors.purpleAccent,
                              route: '/web',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 3. ФУТЕР
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}

// === Интерактивные карточки направления ===
class InteractiveCard extends StatefulWidget {
  final String titleKey;
  final String subtitleKey;
  final IconData icon;
  final Color color;
  final String route;

  const InteractiveCard({
    super.key,
    required this.titleKey,
    required this.subtitleKey,
    required this.icon,
    required this.color,
    required this.route,
  });

  @override
  State<InteractiveCard> createState() => _InteractiveCardState();
}

class _InteractiveCardState extends State<InteractiveCard> {
  bool isHovered = false;
  bool isPressed = false;

  bool get isActive => isHovered || isPressed;

  @override
  Widget build(BuildContext context) {
    final lang = LanguageProvider();

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),
        onTap: () => context.go(widget.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 280,
          height: 360,
          padding: const EdgeInsets.all(24),
          transform: isActive
              ? (Matrix4.identity()..translate(0.0, -10.0, 0.0))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A24),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive ? widget.color : Colors.white10,
              width: 2,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 64, color: widget.color),
              const SizedBox(height: 24),
              Text(
                lang.getText(widget.titleKey),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                lang.getText(widget.subtitleKey),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isActive ? 1.0 : 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lang.getText('more_details'),
                      style: TextStyle(color: widget.color),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: widget.color,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
