import 'package:flutter/material.dart';

enum AppLanguage { ru, ky, en }

class LanguageProvider extends ChangeNotifier {
  static final LanguageProvider _instance = LanguageProvider._internal();
  factory LanguageProvider() => _instance;
  LanguageProvider._internal();

  AppLanguage _currentLanguage = AppLanguage.ru;

  AppLanguage get currentLanguage => _currentLanguage;

  void setLanguage(AppLanguage language) {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      notifyListeners();
    }
  }

  // === СЛОВАРЬ ПЕРЕВОДОВ ===
  static const Map<AppLanguage, Map<String, String>> _localizedValues = {
    AppLanguage.ru: {
      'app_title': 'NM DEV Портфолио',
      'nav_home': 'Главная',
      'nav_projects': 'Проекты',
      'nav_about': 'О обо мне',
      'nav_contact': 'Контакты',
      'settings_title': 'Настройки',
      'language_select_title': 'Выберите язык интерфейса',
      'lang_ru': 'Русский',
      'lang_ky': 'Кыргызча',
      'lang_en': 'English',
      'theme_title': 'Тема оформления',
      'theme_dark': 'Темная тема (По умолчанию)',
      'in_development': 'В разработке...',
      'save_button': 'Сохранить',

      'card_mobile_title': 'Мобильные\nприложения',
      'card_mobile_sub': 'iOS & Android',
      'card_bots_title': 'Telegram &\nWeb Боты',
      'card_bots_sub': 'Автоматизация и WebApp',
      'card_web_title': 'Веб-сайты &\nСервисы',
      'card_web_sub': 'Быстрые и адаптивные',
      'more_details': 'Подробнее',
    },
    AppLanguage.ky: {
      'app_title': 'NM DEV Портфолиосу',
      'nav_home': 'Башкы барак',
      'nav_projects': 'Долбоорлор',
      'nav_about': 'Мен жөнүндө',
      'nav_contact': 'Байланыш',
      'settings_title': 'Жөндөөлөр',
      'language_select_title': 'Интерфейс тилин тандаңыз',
      'lang_ru': 'Русский',
      'lang_ky': 'Кыргызча',
      'lang_en': 'English',
      'theme_title': 'Тема жасалгасы',
      'theme_dark': 'Караңгы тема (Демейки)',
      'in_development': 'Иштеп чыгууда...',
      'save_button': 'Сактоо',

      'card_mobile_title': 'Мобилдик\nтиркемелер',
      'card_mobile_sub': 'iOS & Android',
      'card_bots_title': 'Telegram &\nWeb Боттор',
      'card_bots_sub': 'Автоматташтыруу жана WebApp',
      'card_web_title': 'Веб-сайттар &\nСервистер',
      'card_web_sub': 'Ыкчам жана адаптивдүү',
      'more_details': 'Кененирээк',
    },
    AppLanguage.en: {
      'app_title': 'NM DEV Portfolio',
      'nav_home': 'Home',
      'nav_projects': 'Projects',
      'nav_about': 'About',
      'nav_contact': 'Contact',
      'settings_title': 'Settings',
      'language_select_title': 'Select Interface Language',
      'lang_ru': 'Russian',
      'lang_ky': 'Kyrgyz',
      'lang_en': 'English',
      'theme_title': 'Theme',
      'theme_dark': 'Dark Mode (Default)',
      'in_development': 'In development...',
      'save_button': 'Save',

      'card_mobile_title': 'Mobile\nApplications',
      'card_mobile_sub': 'iOS & Android with Flutter',
      'card_bots_title': 'Telegram &\nWeb Bots',
      'card_bots_sub': 'Automation & WebApp',
      'card_web_title': 'Websites &\nServices',
      'card_web_sub': 'Fast & Responsive',
      'more_details': 'Learn more',
    },
  };

  // Метод для получения текста по ключу
  String getText(String key) {
    return _localizedValues[_currentLanguage]?[key] ?? key;
  }
}
