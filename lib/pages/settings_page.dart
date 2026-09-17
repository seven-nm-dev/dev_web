import 'package:dev_web/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final LanguageProvider _lang = LanguageProvider();
  late AppLanguage _selectedLanguage;

  @override
  void initState() {
    super.initState();
    // Инициализируем временно выбранный язык текущим языком из провайдера
    _selectedLanguage = _lang.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF13131A),
        elevation: 0,
        title: Text(
          _lang.getText('settings_title'),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. ЗАГОЛОВОК
              Text(
                _lang.getText('language_select_title'),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              // 2. ВЫПАДАЮЩИЙ СПИСОК (DROPDOWN)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF13131A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.cyanAccent.withValues(alpha: .4)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<AppLanguage>(
                    value: _selectedLanguage,
                    isExpanded: true,
                    dropdownColor: const Color(0xFF13131A),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.cyanAccent),
                    items: const [
                      DropdownMenuItem(
                        value: AppLanguage.ky,
                        child: Text(
                          'Кыргызча 🇰🇬',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      DropdownMenuItem(
                        value: AppLanguage.ru,
                        child: Text(
                          'Русский 🇷🇺',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      DropdownMenuItem(
                        value: AppLanguage.en,
                        child: Text(
                          'English 🇬🇧',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                    onChanged: (AppLanguage? newLang) {
                      if (newLang != null) {
                        setState(() {
                          _selectedLanguage = newLang;
                        });
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 3. КНОПКА "СОХРАНИТЬ"
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    // Применяем язык в глобальном провайдере
                    _lang.setLanguage(_selectedLanguage);

                    // Перебрасываем пользователя на главную страницу
                    context.go('/');
                  },
                  child: Text(
                    _lang.getText('save_button'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}