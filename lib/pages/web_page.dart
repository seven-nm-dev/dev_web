import 'package:dev_web/pages/web_calculator_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// Простой сервис смены языка (если он у вас вынесен в отдельный файл, импортируйте его оттуда)
class LanguageService {
  static final ValueNotifier<String> currentLanguage = ValueNotifier<String>(
    'RU',
  ); // 'RU', 'KG', 'EN'

  static void changeLanguage(String lang) {
    currentLanguage.value = lang;
  }
}

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  int _selectedCategoryIndex = 0;

  // Тексты для разных языков
  final Map<String, Map<String, String>> _translations = {
    'RU': {
      'appbar_title': 'Разработка Веб-Сайтов',
      'sidebar_title': 'КАТЕГОРИИ ВЕБ-ПРОЕКТОВ',
      'web_platform': 'WEB PLATFORM',
      'calc_button': 'Калькулятор',

      // Categories
      'cat_ecommerce': 'Интернет-магазин',
      'cat_crm': 'CRM & Аналитика',
      'cat_delivery': 'Доставка & Еда',
      'cat_taxi': 'Такси & Логистика',
      'cat_fintech': 'Финтех & Платёжка',
      'cat_education': 'Онлайн-Обучение',
      'cat_realty': 'Недвижимость',
      'cat_medicine': 'Медицина & Запись',
      'cat_hotels': 'Отели & Бронирование',
      'cat_saas': 'SaaS & Соцсеть',

      // Descriptions
      'desc_ecommerce':
          'Современный интернет-магазин с корзиной, фильтрами, оплатой и админ-панелью.',
      'desc_crm':
          'CRM-система с аналитикой, воронками продаж и отчётами в реальном времени.',
      'desc_delivery':
          'Сервис доставки еды с меню, статусами заказов и отслеживанием курьера.',
      'desc_taxi':
          'Платформа такси и логистики с картой, тарифами и онлайн-оплатой.',
      'desc_fintech':
          'Финтех-решение: переводы, платежи, кошелёк и безопасность транзакций.',
      'desc_education':
          'Онлайн-школа с курсами, видеоуроками, тестами и личным кабинетом.',
      'desc_realty':
          'Платформа недвижимости: каталог объектов, фильтры и заявки на просмотр.',
      'desc_medicine':
          'Медицинский сервис: запись к врачам, расписание и электронные карты.',
      'desc_hotels':
          'Система бронирования отелей с календарём, оплатой и отзывами.',
      'desc_saas':
          'SaaS-платформа и социальная сеть с лентой, чатами и профилями.',

      // Stats Titles
      'st_orders_today': 'Заказы сегодня',
      'st_avg_check': 'Средний чек',
      'st_conversion': 'Конверсия',
      'st_active_leads': 'Активные лиды',
      'st_deals_in_progress': 'Сделки в работе',
      'st_funnel_conversion': 'Конверсия воронки',
      'st_active_orders': 'Заказы в работе',
      'st_avg_time': 'Среднее время',
      'st_courier_rating': 'Рейтинг курьеров',
      'st_active_rides': 'Активные поездки',
      'st_drivers_online': 'Водители онлайн',
      'st_transactions': 'Транзакций сегодня',
      'st_turnover': 'Оборот',
      'st_success_payments': 'Успешных платежей',
      'st_active_students': 'Активных студентов',
      'st_finished_lessons': 'Завершённых уроков',
      'st_avg_progress': 'Средний прогресс',
      'st_properties': 'Объектов в базе',
      'st_requests_today': 'Заявок сегодня',
      'st_avg_price': 'Средняя цена',
      'st_appointments_today': 'Записей сегодня',
      'st_doctors_online': 'Врачей онлайн',
      'st_avg_wait': 'Среднее ожидание',
      'st_bookings': 'Бронирований',
      'st_room_occupancy': 'Загрузка номеров',
      'st_active_users': 'Активных пользователей',
      'st_messages_today': 'Сообщений сегодня',
      'st_new_registrations': 'Новых регистраций',
    },
    'KG': {
      'appbar_title': 'Веб-сайттарды иштеп чыгуу',
      'sidebar_title': 'ВЕБ-ДОЛБООРЛОРДУН КАТЕГОРИЯЛАРЫ',
      'web_platform': 'ВЕБ ПЛАТФОРМА',
      'calc_button': 'Калькулятор',

      // Categories
      'cat_ecommerce': 'Интернет-дүкөн',
      'cat_crm': 'CRM & Аналитика',
      'cat_delivery': 'Жеткирүү & Тамак-аш',
      'cat_taxi': 'Такси & Логистика',
      'cat_fintech': 'Финтех & Төлөмдөр',
      'cat_education': 'Онлайн-Окутуу',
      'cat_realty': 'Кыймылсыз мүлк',
      'cat_medicine': 'Медицина & Жазылуу',
      'cat_hotels': 'Мейманканалар & Брондоо',
      'cat_saas': 'SaaS & Соцтармак',

      // Descriptions
      'desc_ecommerce':
          'Себет, чыпкалар, төлөм жана админ-панель менен заманбап интернет-дүкөн.',
      'desc_crm':
          'Аналитика, сатуу куйгучтөрү жана реалдуу убакыттагы отчеттор менен CRM-система.',
      'desc_delivery':
          'Меню, буйрутма статустары жана курьерди көзөмөлдөө менен тамак жеткирүү кызматы.',
      'desc_taxi':
          'Карта, тарифтер жана онлайн төлөм менен такси жана логистика платформасы.',
      'desc_fintech':
          'Финтех-чечим: которуулар, төлөмдөр, капчык жана транзакциялардын коопсуздугу.',
      'desc_education':
          'Курстар, видеосабактар, тесттер жана жеке кабинет менен онлайн-мектеп.',
      'desc_realty':
          'Кыймылсыз мүлк платформасы: объекттер каталогу, чыпкалар жана көрүүгө өтүнмөлөр.',
      'desc_medicine':
          'Медициналык кызмат: дарыгерлерге жазылуу, иш графиги жана электрондук карталар.',
      'desc_hotels':
          'Календарь, төлөм жана пикирлер менен мейманканаларды брондоо системасы.',
      'desc_saas':
          'Лента, чаттар жана профилдер менен SaaS-платформа жана социалдык тармак.',

      // Stats Titles
      'st_orders_today': 'Бүгүнкү буйрутмалар',
      'st_avg_check': 'Орточо чек',
      'st_conversion': 'Конверсия',
      'st_active_leads': 'Активдүү лиддер',
      'st_deals_in_progress': 'Иштеги келишимдер',
      'st_funnel_conversion': 'Куйгуч конверсиясы',
      'st_active_orders': 'Иштеги буйрутмалар',
      'st_avg_time': 'Орточо убакыт',
      'st_courier_rating': 'Курьерлердин рейтинги',
      'st_active_rides': 'Активдүү сапарлар',
      'st_drivers_online': 'Онлайн айдоочулар',
      'st_transactions': 'Бүгүнкү транзакциялар',
      'st_turnover': 'Айлануу',
      'st_success_payments': 'Ийгиликтүү төлөмдөр',
      'st_active_students': 'Активдүү студенттер',
      'st_finished_lessons': 'Аяктаган сабактар',
      'st_avg_progress': 'Орточо прогресс',
      'st_properties': 'Базадагы объекттер',
      'st_requests_today': 'Бүгүнкү өтүнмөлөр',
      'st_avg_price': 'Орточо баа',
      'st_appointments_today': 'Бүгүнкү жазуулар',
      'st_doctors_online': 'Онлайн дарыгерлер',
      'st_avg_wait': 'Орточо күтүү',
      'st_bookings': 'Брондоолор',
      'st_room_occupancy': 'Бөлмөлөрдүн ээлениши',
      'st_active_users': 'Активдүү колдонуучулар',
      'st_messages_today': 'Бүгүнкү билдирүүлөр',
      'st_new_registrations': 'Жаңы катталуулар',
    },
    'EN': {
      'appbar_title': 'Web Development & Web Applications',
      'sidebar_title': 'WEB PROJECT CATEGORIES',
      'web_platform': 'WEB PLATFORM',
      'calc_button': 'Calculator',

      // Categories
      'cat_ecommerce': 'E-Commerce',
      'cat_crm': 'CRM & Analytics',
      'cat_delivery': 'Delivery & Food',
      'cat_taxi': 'Taxi & Logistics',
      'cat_fintech': 'Fintech & Payments',
      'cat_education': 'Online Education',
      'cat_realty': 'Real Estate',
      'cat_medicine': 'Medicine & Booking',
      'cat_hotels': 'Hotels & Reservation',
      'cat_saas': 'SaaS & Social Network',

      // Descriptions
      'desc_ecommerce':
          'Modern online store with shopping cart, filters, payments and admin panel.',
      'desc_crm':
          'CRM system with analytics, sales funnels, and real-time reports.',
      'desc_delivery':
          'Food delivery service with menu, order statuses, and courier tracking.',
      'desc_taxi':
          'Taxi & logistics platform with map, tariffs, and online payment.',
      'desc_fintech':
          'Fintech solution: transfers, payments, wallet, and transaction security.',
      'desc_education':
          'Online academy with courses, video lessons, tests, and user dashboard.',
      'desc_realty':
          'Real estate platform: property catalog, filters, and tour requests.',
      'desc_medicine':
          'Medical platform: doctor booking, schedules, and electronic medical records.',
      'desc_hotels':
          'Hotel reservation system with calendar, payments, and user reviews.',
      'desc_saas':
          'SaaS platform and social network with feeds, chats, and user profiles.',

      // Stats Titles
      'st_orders_today': 'Orders Today',
      'st_avg_check': 'Average Check',
      'st_conversion': 'Conversion Rate',
      'st_active_leads': 'Active Leads',
      'st_deals_in_progress': 'Deals in Progress',
      'st_funnel_conversion': 'Funnel Conversion',
      'st_active_orders': 'Active Orders',
      'st_avg_time': 'Average Time',
      'st_courier_rating': 'Courier Rating',
      'st_active_rides': 'Active Rides',
      'st_drivers_online': 'Drivers Online',
      'st_transactions': 'Transactions Today',
      'st_turnover': 'Turnover',
      'st_success_payments': 'Successful Payments',
      'st_active_students': 'Active Students',
      'st_finished_lessons': 'Completed Lessons',
      'st_avg_progress': 'Average Progress',
      'st_properties': 'Database Properties',
      'st_requests_today': 'Requests Today',
      'st_avg_price': 'Average Price',
      'st_appointments_today': 'Appointments Today',
      'st_doctors_online': 'Doctors Online',
      'st_avg_wait': 'Average Wait Time',
      'st_bookings': 'Bookings',
      'st_room_occupancy': 'Room Occupancy',
      'st_active_users': 'Active Users',
      'st_messages_today': 'Messages Today',
      'st_new_registrations': 'New Registrations',
    },
  };

  String _t(String key) {
    final lang = LanguageService.currentLanguage.value;
    return _translations[lang]?[key] ?? _translations['RU']![key]!;
  }

  List<Map<String, dynamic>> _getWebCategories() {
    return [
      {
        'title': _t('cat_ecommerce'),
        'icon': Icons.shopping_cart_outlined,
        'color': Colors.purpleAccent,
      },
      {
        'title': _t('cat_crm'),
        'icon': Icons.insights_outlined,
        'color': Colors.cyanAccent,
      },
      {
        'title': _t('cat_delivery'),
        'icon': Icons.fastfood_outlined,
        'color': Colors.orangeAccent,
      },
      {
        'title': _t('cat_taxi'),
        'icon': Icons.local_taxi_outlined,
        'color': Colors.amber,
      },
      {
        'title': _t('cat_fintech'),
        'icon': Icons.account_balance_outlined,
        'color': Colors.greenAccent,
      },
      {
        'title': _t('cat_education'),
        'icon': Icons.school_outlined,
        'color': Colors.tealAccent,
      },
      {
        'title': _t('cat_realty'),
        'icon': Icons.business_outlined,
        'color': Colors.deepOrangeAccent,
      },
      {
        'title': _t('cat_medicine'),
        'icon': Icons.medical_services_outlined,
        'color': Colors.redAccent,
      },
      {
        'title': _t('cat_hotels'),
        'icon': Icons.hotel_outlined,
        'color': Colors.blueAccent,
      },
      {
        'title': _t('cat_saas'),
        'icon': Icons.hub_outlined,
        'color': Colors.pinkAccent,
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
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return ValueListenableBuilder<String>(
      valueListenable: LanguageService.currentLanguage,
      builder: (context, currentLang, _) {
        final webCategories = _getWebCategories();

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
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              // ПЕРЕКЛЮЧАТЕЛЬ ЯЗЫКА В ШАПКЕ
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.language,
                  color: Colors.cyanAccent,
                  size: 22,
                ),
                color: const Color(0xFF1B1B24),
                onSelected: (String lang) {
                  LanguageService.changeLanguage(lang);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'RU',
                    child: Text(
                      '🇷🇺 RU',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'KG',
                    child: Text(
                      '🇰🇬 KG',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'EN',
                    child: Text(
                      '🇺🇸 EN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Row(
            children: [
              // 1. БОКОВАЯ ПАНЕЛЬ (Sidebar для десктопа)
              if (isDesktop)
                Container(
                  width: 280,
                  color: const Color(0xFF13131A),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _t('sidebar_title'),
                        style: GoogleFonts.inter(
                          color: Colors.white38,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: webCategories.length,
                          itemBuilder: (context, index) {
                            final item = webCategories[index];
                            final isSelected = _selectedCategoryIndex == index;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: InkWell(
                                onTap: () => setState(
                                  () => _selectedCategoryIndex = index,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? item['color'].withOpacity(0.15)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? item['color']
                                          : Colors.transparent,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        item['icon'],
                                        color: isSelected
                                            ? item['color']
                                            : Colors.white60,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          item['title'],
                                          style: TextStyle(
                                            color: isSelected
                                                ? item['color']
                                                : Colors.white70,
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(color: Colors.white10),
                      _buildSideActionButtons(),
                    ],
                  ),
                ),

              // 2. ОСНОВНАЯ ОБЛАСТЬ
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Горизонтальные категории для мобильных
                      if (!isDesktop) ...[
                        SizedBox(
                          height: 45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: webCategories.length,
                            itemBuilder: (context, index) {
                              final item = webCategories[index];
                              final isSelected =
                                  _selectedCategoryIndex == index;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ChoiceChip(
                                  label: Text(item['title']),
                                  selected: isSelected,
                                  selectedColor: item['color'].withOpacity(0.2),
                                  backgroundColor: const Color(0xFF1B1B24),
                                  labelStyle: TextStyle(
                                    color: isSelected
                                        ? item['color']
                                        : Colors.white,
                                  ),
                                  onSelected: (_) => setState(
                                    () => _selectedCategoryIndex = index,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // ЭМУЛЯТОР ВЕБ-БРАУЗЕРА
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF181820),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .5),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Шапка браузера
                            Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFF22222E),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.redAccent,
                                  ),
                                  const SizedBox(width: 6),
                                  const CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.amber,
                                  ),
                                  const SizedBox(width: 6),
                                  const CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.greenAccent,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Container(
                                      height: 32,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'https://demo-web.nm-dev.com/${webCategories[_selectedCategoryIndex]['title'].toString().toLowerCase()}',
                                          style: const TextStyle(
                                            color: Colors.white38,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Контент
                            Container(
                              padding: const EdgeInsets.all(24),
                              constraints: const BoxConstraints(minHeight: 450),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: _buildWebContent(
                                  _selectedCategoryIndex,
                                  webCategories,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Кнопки для мобильных
                      if (!isDesktop) ...[
                        const SizedBox(height: 24),
                        _buildSideActionButtons(),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ВЕБ-КОНТЕНТ
  Widget _buildWebContent(int index, List<Map<String, dynamic>> webCategories) {
    final activeColor = webCategories[index]['color'] as Color;
    final title = webCategories[index]['title'] as String;

    // Разный контент под каждую категорию
    final List<Map<String, dynamic>> stats = _getStatsForCategory(index);

    return Column(
      key: ValueKey<int>(index),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [activeColor.withValues(alpha: .2), Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: activeColor.withValues(alpha: .3)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _t('web_platform'),
                      style: TextStyle(
                        color: activeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: GoogleFonts.notoSerif(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getDescription(index),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                webCategories[index]['icon'],
                size: 60,
                color: activeColor.withValues(alpha: .8),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Сетка статистики
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 3 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: MediaQuery.of(context).size.width > 1200
              ? 2.0
              : 1.7,
          children: stats.map((stat) {
            return _webStatCard(
              stat['title'],
              stat['value'],
              stat['change'],
              activeColor,
              stat['icon'],
            );
          }).toList(),
        ),
      ],
    );
  }

  // === Разные описания с поддержкой языков ===
  String _getDescription(int index) {
    switch (index) {
      case 0:
        return _t('desc_ecommerce');
      case 1:
        return _t('desc_crm');
      case 2:
        return _t('desc_delivery');
      case 3:
        return _t('desc_taxi');
      case 4:
        return _t('desc_fintech');
      case 5:
        return _t('desc_education');
      case 6:
        return _t('desc_realty');
      case 7:
        return _t('desc_medicine');
      case 8:
        return _t('desc_hotels');
      case 9:
        return _t('desc_saas');
      default:
        return _t('desc_ecommerce');
    }
  }

  // === Разные статистические карточки ===
  List<Map<String, dynamic>> _getStatsForCategory(int index) {
    switch (index) {
      case 0: // Интернет-магазин
        return [
          {
            'title': _t('st_orders_today'),
            'value': '384',
            'change': '+22%',
            'icon': Icons.shopping_bag,
          },
          {
            'title': _t('st_avg_check'),
            'value': '3,450 c',
            'change': '+9%',
            'icon': Icons.payments,
          },
          {
            'title': _t('st_conversion'),
            'value': '4.8%',
            'change': '+1.1%',
            'icon': Icons.trending_up,
          },
        ];
      case 1: // CRM
        return [
          {
            'title': _t('st_active_leads'),
            'value': '1,248',
            'change': '+15%',
            'icon': Icons.people,
          },
          {
            'title': _t('st_deals_in_progress'),
            'value': '87',
            'change': '+6%',
            'icon': Icons.handshake,
          },
          {
            'title': _t('st_funnel_conversion'),
            'value': '31%',
            'change': '+4%',
            'icon': Icons.insights,
          },
        ];
      case 2: // Доставка еды
        return [
          {
            'title': _t('st_active_orders'),
            'value': '156',
            'change': '+18%',
            'icon': Icons.delivery_dining,
          },
          {
            'title': _t('st_avg_time'),
            'value': '28 min',
            'change': '-12%',
            'icon': Icons.timer,
          },
          {
            'title': _t('st_courier_rating'),
            'value': '4.9',
            'change': '+0.2',
            'icon': Icons.star,
          },
        ];
      case 3: // Такси
        return [
          {
            'title': _t('st_active_rides'),
            'value': '412',
            'change': '+27%',
            'icon': Icons.local_taxi,
          },
          {
            'title': _t('st_drivers_online'),
            'value': '89',
            'change': '+11%',
            'icon': Icons.person_pin_circle,
          },
          {
            'title': _t('st_avg_check'),
            'value': '280 c',
            'change': '+8%',
            'icon': Icons.attach_money,
          },
        ];
      case 4: // Финтех
        return [
          {
            'title': _t('st_transactions'),
            'value': '8,940',
            'change': '+31%',
            'icon': Icons.swap_horiz,
          },
          {
            'title': _t('st_turnover'),
            'value': '2.4M c',
            'change': '+19%',
            'icon': Icons.account_balance,
          },
          {
            'title': _t('st_success_payments'),
            'value': '99.2%',
            'change': '+0.4%',
            'icon': Icons.verified,
          },
        ];
      case 5: // Обучение
        return [
          {
            'title': _t('st_active_students'),
            'value': '3,120',
            'change': '+14%',
            'icon': Icons.school,
          },
          {
            'title': _t('st_finished_lessons'),
            'value': '18,450',
            'change': '+23%',
            'icon': Icons.play_circle,
          },
          {
            'title': _t('st_avg_progress'),
            'value': '67%',
            'change': '+5%',
            'icon': Icons.trending_up,
          },
        ];
      case 6: // Недвижимость
        return [
          {
            'title': _t('st_properties'),
            'value': '1,870',
            'change': '+9%',
            'icon': Icons.home_work,
          },
          {
            'title': _t('st_requests_today'),
            'value': '94',
            'change': '+17%',
            'icon': Icons.assignment,
          },
          {
            'title': _t('st_avg_price'),
            'value': '\$85k',
            'change': '+3%',
            'icon': Icons.attach_money,
          },
        ];
      case 7: // Медицина
        return [
          {
            'title': _t('st_appointments_today'),
            'value': '218',
            'change': '+12%',
            'icon': Icons.calendar_month,
          },
          {
            'title': _t('st_doctors_online'),
            'value': '34',
            'change': '+5%',
            'icon': Icons.medical_services,
          },
          {
            'title': _t('st_avg_wait'),
            'value': '12 min',
            'change': '-8%',
            'icon': Icons.timer,
          },
        ];
      case 8: // Отели
        return [
          {
            'title': _t('st_bookings'),
            'value': '167',
            'change': '+21%',
            'icon': Icons.hotel,
          },
          {
            'title': _t('st_room_occupancy'),
            'value': '78%',
            'change': '+6%',
            'icon': Icons.bed,
          },
          {
            'title': _t('st_avg_check'),
            'value': '6,800 c',
            'change': '+11%',
            'icon': Icons.payments,
          },
        ];
      case 9: // SaaS / Соцсеть
        return [
          {
            'title': _t('st_active_users'),
            'value': '24.8k',
            'change': '+16%',
            'icon': Icons.people,
          },
          {
            'title': _t('st_messages_today'),
            'value': '58k',
            'change': '+29%',
            'icon': Icons.chat,
          },
          {
            'title': _t('st_new_registrations'),
            'value': '1,240',
            'change': '+18%',
            'icon': Icons.person_add,
          },
        ];
      default:
        return [];
    }
  }

  Widget _webStatCard(
    String title,
    String value,
    String change,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF22222E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: .05)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: .15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          change,
                          style: TextStyle(
                            color: color,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildSideActionButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => _launchURL('https://t.me/996551771108'),
          icon: const Icon(Icons.telegram, size: 18, color: Colors.white),
          label: const Text(
            'Telegram',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0088CC),
            minimumSize: const Size(double.infinity, 42),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _launchURL('https://wa.me/996551771108'),
          icon: const Icon(Icons.chat_bubble, size: 16, color: Colors.white),
          label: const Text(
            'WhatsApp',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF25D366),
            minimumSize: const Size(double.infinity, 42),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WebCalculatorPage(),
              ),
            );
          },
          icon: const Icon(Icons.calculate, size: 18, color: Colors.cyanAccent),
          label: Text(
            _t('calc_button'),
            style: const TextStyle(color: Colors.cyanAccent, fontSize: 12),
          ),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 42),
            side: const BorderSide(color: Colors.cyanAccent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
