import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(url, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      debugPrint('Ошибка при открытии ссылки: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF09090D),
        border: Border(top: BorderSide(color: Colors.white10, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Левая часть — надпись
          Text(
            '© NM DEV',
            style: GoogleFonts.notoSerif(
              color: Colors.white24,
              fontSize: 10,
              letterSpacing: 1.0,
            ),
          ),

          // Правая часть — кнопки
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Instagram
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () =>
                      _launchURL('https://instagram.com/seve_seven.dev'),
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.pinkAccent,
                    size: 22,
                  ),
                  tooltip: 'Instagram: seve_seven.dev',
                ),
              ),
              const SizedBox(width: 16),

              // Telegram
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => _launchURL('https://t.me/996551771108'),
                  icon: const Icon(
                    Icons.telegram,
                    color: Colors.cyanAccent,
                    size: 24,
                  ),
                  tooltip: 'Telegram',
                ),
              ),
              const SizedBox(width: 16),

              // WhatsApp
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => _launchURL('https://wa.me/996551771108'),
                  icon: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Color(0xFF25D366),
                    size: 22,
                  ),
                  tooltip: 'WhatsApp',
                ),
              ),
              const SizedBox(width: 16),

              // Телефон
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                  onTap: () => _launchURL('tel:+996551771108'),
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: const Icon(
                    Icons.phone_outlined,
                    color: Colors.cyanAccent,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}