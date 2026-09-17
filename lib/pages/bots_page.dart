import 'package:dev_web/pages/tg_bot_calculator_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// 1. Простой локальный сервис/синглтон для смены языка на всех страницах
class LanguageService {
  static final ValueNotifier<String> currentLanguage = ValueNotifier<String>('RU'); // 'RU', 'KG', 'EN'

  static void changeLanguage(String lang) {
    currentLanguage.value = lang;
  }
}

class BotPage extends StatefulWidget {
  const BotPage({super.key});

  @override
  State<BotPage> createState() => _BotPageState();
}

class _BotPageState extends State<BotPage> {
  int _selectedCategoryIndex = 0;

  // Тексты для разных языков
  final Map<String, Map<String, String>> _translations = {
    'RU': {
      'appbar_title': 'Разработка Telegram & Web Ботов',
      'intro': 'Автоматизируйте продажи и работу с клиентами с помощью умных ботов',
      'select_category': 'Выберите категорию бота',
      'online': 'online',
      'message_placeholder': 'Сообщение...',
      'order_telegram': 'Заказать бота в Telegram',
      'order_whatsapp': 'Написать в WhatsApp',
      'calculate_cost': 'Рассчитать стоимость бота',
      'click_snack': 'Клик: ',

      // Категории
      'cat_ecommerce': 'E-Commerce & Еда',
      'cat_booking': 'Запись & Клиника',
      'cat_crm': 'CRM & Техподдержка',
      'cat_ai': 'ChatGPT & ИИ Ассистент',
      'cat_courses': 'Курсы & Обучение',

      // Сообщения ботов
      'msg_ecommerce': '👋 Привет! Я бот для заказа еды.\nВыберите категорию меню:',
      'msg_booking': '🏥 Запись к врачу за 1 минуту.\nВыберите направление:',
      'msg_crm': '🤖 Автоматическая поддержка 24/7.\nЧем могу помочь?',
      'msg_ai': '⚡ Я нейросетевой ассистент.\nГотов обработать ваш запрос или сгенерировать текст.',
      'msg_courses': '🎓 Добро пожаловать в онлайн-школу!\nВыберите курс для старта:',

      // Кнопки ботов
      'btn_pizza': '🍕 Пицца',
      'btn_burgers': '🍔 Бургеры',
      'btn_drinks': '🥤 Напитки',
      'btn_cart': '🛒 Корзина (0)',

      'btn_therapist': '👨‍⚕️ Терапевт',
      'btn_dentist': '🦷 Стоматолог',
      'btn_my_records': '📅 Мои записи',

      'btn_faq': '❓ Частые вопросы',
      'btn_operator': '👨‍💻 Связь с оператором',
      'btn_status': '📊 Статус заявки',

      'btn_write_post': '✍️ Написать пост',
      'btn_data_analysis': '🔍 Анализ данных',
      'btn_ai_settings': '⚙️ Настройки ИИ',

      'btn_lesson_1': '🚀 Урок 1: Введение',
      'btn_materials': '📚 Материалы',
      'btn_certificate': '🏆 Сертификат',
    },
    'KG': {
      'appbar_title': 'Telegram жана Web ботторду иштеп чыгуу',
      'intro': 'Акылдуу боттор менен сатууларды жана кардарлар менен иштөөнү автоматташтырыңыз',
      'select_category': 'Боттун категориясын тандаңыз',
      'online': 'онлайн',
      'message_placeholder': 'Билдирүү...',
      'order_telegram': 'Telegram аркылуу бот заказ кылуу',
      'order_whatsapp': 'WhatsApp\'ка жазуу',
      'calculate_cost': 'Боттун баасын эсептөө',
      'click_snack': 'Басылды: ',

      // Категории
      'cat_ecommerce': 'E-Commerce & Тамак-аш',
      'cat_booking': 'Кабыл алуу & Клиника',
      'cat_crm': 'CRM & Колдоо кызматы',
      'cat_ai': 'ChatGPT & ИИ Жардамчы',
      'cat_courses': 'Курстар & Окутуу',

      // Сообщения ботов
      'msg_ecommerce': '👋 Салам! Мен тамак-аш заказ кылуучу ботмун.\nМеню категориясын тандаңыз:',
      'msg_booking': '🏥 Дарыгерге 1 мүнөттө жазылуу.\nБагытты тандаңыз:',
      'msg_crm': '🤖 Автоматтык колдоо 24/7.\nКандай жардам бере алам?',
      'msg_ai': '⚡ Мен жасалма интеллект жардамчысымын.\nТапшырмаңызды аткарууга же текст жазууга даярмын.',
      'msg_courses': '🎓 Онлайн-мектепке кош келиңиз!\nБаштоо үчүн курсту тандаңыз:',

      // Кнопки ботов
      'btn_pizza': '🍕 Пицца',
      'btn_burgers': '🍔 Бургерлер',
      'btn_drinks': '🥤 Суусундуктар',
      'btn_cart': '🛒 Себет (0)',

      'btn_therapist': '👨‍⚕️ Терапевт',
      'btn_dentist': '🦷 Стоматолог',
      'btn_my_records': '📅 Менин жазууларым',

      'btn_faq': '❓ Көп берилүүчү суроолор',
      'btn_operator': '👨‍💻 Оператор менен байланышуу',
      'btn_status': '📊 Өтүнмөнүн абалы',

      'btn_write_post': '✍️ Пост жазуу',
      'btn_data_analysis': '🔍 Маалыматтарды анализдөө',
      'btn_ai_settings': '⚙️ ИИ жөндөөлөрү',

      'btn_lesson_1': '🚀 1-сабак: Киришүү',
      'btn_materials': '📚 Материалдар',
      'btn_certificate': '🏆 Сертификат',
    },
    'EN': {
      'appbar_title': 'Telegram & Web Bot Development',
      'intro': 'Automate sales and customer communication using smart bots powered by Python & Node.js',
      'select_category': 'Select a bot category',
      'online': 'online',
      'message_placeholder': 'Message...',
      'order_telegram': 'Order Bot in Telegram',
      'order_whatsapp': 'Write on WhatsApp',
      'calculate_cost': 'Calculate Bot Cost',
      'click_snack': 'Clicked: ',

      // Categories
      'cat_ecommerce': 'E-Commerce & Food',
      'cat_booking': 'Booking & Healthcare',
      'cat_crm': 'CRM & Support',
      'cat_ai': 'ChatGPT & AI Assistant',
      'cat_courses': 'Courses & Education',

      // Bot Messages
      'msg_ecommerce': '👋 Hello! I am a food ordering bot.\nChoose a menu category:',
      'msg_booking': '🏥 Book a doctor appointment in 1 minute.\nSelect a department:',
      'msg_crm': '🤖 Automated support 24/7.\nHow can I help you?',
      'msg_ai': '⚡ I am an AI assistant.\nReady to process your request or generate text.',
      'msg_courses': '🎓 Welcome to the online academy!\nSelect a course to start:',

      // Bot Buttons
      'btn_pizza': '🍕 Pizza',
      'btn_burgers': '🍔 Burgers',
      'btn_drinks': '🥤 Drinks',
      'btn_cart': '🛒 Cart (0)',

      'btn_therapist': '👨‍⚕️ Therapist',
      'btn_dentist': '🦷 Dentist',
      'btn_my_records': '📅 My Appointments',

      'btn_faq': '❓ FAQ',
      'btn_operator': '👨‍💻 Contact Operator',
      'btn_status': '📊 Request Status',

      'btn_write_post': '✍️ Write Post',
      'btn_data_analysis': '🔍 Data Analysis',
      'btn_ai_settings': '⚙️ AI Settings',

      'btn_lesson_1': '🚀 Lesson 1: Intro',
      'btn_materials': '📚 Materials',
      'btn_certificate': '🏆 Certificate',
    },
  };

  String _t(String key) {
    final lang = LanguageService.currentLanguage.value;
    return _translations[lang]?[key] ?? _translations['RU']![key]!;
  }

  List<Map<String, dynamic>> _getBotCategories() {
    return [
      {
        'title': _t('cat_ecommerce'),
        'icon': Icons.shopping_bag_outlined,
        'color': Colors.orangeAccent,
        'botName': 'FoodOrder_Bot',
        'welcomeMsg': _t('msg_ecommerce'),
        'buttons': [_t('btn_pizza'), _t('btn_burgers'), _t('btn_drinks'), _t('btn_cart')],
      },
      {
        'title': _t('cat_booking'),
        'icon': Icons.calendar_today_outlined,
        'color': Colors.redAccent,
        'botName': 'ClinicBooking_Bot',
        'welcomeMsg': _t('msg_booking'),
        'buttons': [_t('btn_therapist'), _t('btn_dentist'), _t('btn_my_records')],
      },
      {
        'title': _t('cat_crm'),
        'icon': Icons.headset_mic_outlined,
        'color': Colors.cyanAccent,
        'botName': 'Support24_Bot',
        'welcomeMsg': _t('msg_crm'),
        'buttons': [_t('btn_faq'), _t('btn_operator'), _t('btn_status')],
      },
      {
        'title': _t('cat_ai'),
        'icon': Icons.auto_awesome,
        'color': Colors.purpleAccent,
        'botName': 'AiAssistant_Bot',
        'welcomeMsg': _t('msg_ai'),
        'buttons': [_t('btn_write_post'), _t('btn_data_analysis'), _t('btn_ai_settings')],
      },
      {
        'title': _t('cat_courses'),
        'icon': Icons.school_outlined,
        'color': Colors.tealAccent,
        'botName': 'Academy_Bot',
        'welcomeMsg': _t('msg_courses'),
        'buttons': [_t('btn_lesson_1'), _t('btn_materials'), _t('btn_certificate')],
      },
    ];
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Ошибка открытия ссылки: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.currentLanguage,
      builder: (context, currentLang, _) {
        final botCategories = _getBotCategories();
        final activeBot = botCategories[_selectedCategoryIndex];
        final Color activeColor = activeBot['color'];

        return Scaffold(
          backgroundColor: const Color(0xFF0D0D11),
          appBar: AppBar(
            backgroundColor: const Color(0xFF13131A),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.cyanAccent,
                size: 18,
              ),
              onPressed: () => context.go('/'),
            ),
            title: Text(
              _t('appbar_title'),
              style: GoogleFonts.notoSerif(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              // ПЕРЕКЛЮЧАТЕЛЬ ЯЗЫКА В ШАПКЕ
              PopupMenuButton<String>(
                icon: const Icon(Icons.language, color: Colors.cyanAccent, size: 22),
                color: const Color(0xFF1B1B24),
                onSelected: (String lang) {
                  LanguageService.changeLanguage(lang);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'RU',
                    child: Text('🇷🇺 RU', style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem<String>(
                    value: 'KG',
                    child: Text('🇰🇬 KG', style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem<String>(
                    value: 'EN',
                    child: Text('🇺🇸 EN', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              children: [
                // ===== INTRO =====
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [activeColor.withValues(alpha: .12), Colors.transparent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: activeColor.withValues(alpha: .25)),
                  ),
                  child: Text(
                    _t('intro'),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13.5,
                      color: Colors.white70,
                      height: 1.45,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Text(
                  _t('select_category'),
                  style: GoogleFonts.notoSerif(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 14),

                // ===== КАТЕГОРИИ =====
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: List.generate(botCategories.length, (index) {
                    final item = botCategories[index];
                    final isSelected = _selectedCategoryIndex == index;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategoryIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? item['color'].withOpacity(0.18)
                              : const Color(0xFF1B1B24),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? item['color']
                                : Colors.white.withValues(alpha: .08),
                            width: isSelected ? 1.5 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: item['color'].withOpacity(0.25),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              item['icon'],
                              size: 17,
                              color: isSelected ? item['color'] : Colors.white70,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item['title'],
                              style: TextStyle(
                                color: isSelected ? item['color'] : Colors.white,
                                fontSize: 12.5,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 28),

                // ===== TELEGRAM CHAT MOCKUP =====
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E1621),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: activeColor.withValues(alpha: .35),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: activeColor.withValues(alpha: .18),
                        blurRadius: 24,
                        spreadRadius: 1,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Шапка Telegram
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF17212B),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white.withValues(alpha: .05),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Аватар
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    activeColor.withValues(alpha: .7),
                                    activeColor.withValues(alpha: .3),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Icon(
                                activeBot['icon'],
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activeBot['botName'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Container(
                                        width: 7,
                                        height: 7,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF4CAF50),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        _t('online'),
                                        style: const TextStyle(
                                          color: Color(0xFF64B5F6),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.more_vert,
                              color: Colors.white.withValues(alpha: .5),
                              size: 22,
                            ),
                          ],
                        ),
                      ),

                      // Область чата
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
                        constraints: const BoxConstraints(minHeight: 240),
                        decoration: const BoxDecoration(color: Color(0xFF0E1621)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Сообщение бота
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.78,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 11,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF182533),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: .25),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  activeBot['welcomeMsg'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Inline-кнопки
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: (activeBot['buttons'] as List<String>).map((
                                btnText,
                              ) {
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${_t('click_snack')}$btnText'),
                                          duration: const Duration(seconds: 1),
                                          backgroundColor: activeColor,
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF2B5278,
                                        ).withValues(alpha: .85),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.white.withValues(alpha: .08),
                                        ),
                                      ),
                                      child: Text(
                                        btnText,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      // Нижняя панель ввода (декоративная)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF17212B),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                          border: Border(
                            top: BorderSide(color: Colors.white.withValues(alpha: .05)),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_file,
                              color: Colors.white.withValues(alpha: .4),
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 36,
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0E1621),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _t('message_placeholder'),
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: .35),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: activeColor.withValues(alpha: .9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.mic,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // ===== КНОПКИ ДЕЙСТВИЙ =====
                _actionButton(
                  onTap: () => _launchURL('https://t.me/996551771108'),
                  icon: Icons.telegram,
                  label: _t('order_telegram'),
                  color: const Color(0xFF0088CC),
                ),
                const SizedBox(height: 12),
                _actionButton(
                  onTap: () => _launchURL('https://wa.me/996551771108'),
                  icon: Icons.chat_bubble,
                  label: _t('order_whatsapp'),
                  color: const Color(0xFF25D366),
                ),
                const SizedBox(height: 12),
                _actionButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BotCalculatorPage()),
                    );
                  },
                  icon: Icons.calculate_outlined,
                  label: _t('calculate_cost'),
                  color: Colors.cyanAccent,
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionButton({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    required Color color,
    Color textColor = Colors.white,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: textColor, size: 22),
        label: Text(
          label,
          style: GoogleFonts.notoSerif(
            fontWeight: FontWeight.bold,
            fontSize: 14.5,
            color: textColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}