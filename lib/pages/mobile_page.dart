import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'mobile_calculator_page.dart';

class MobilePage extends StatefulWidget {
  const MobilePage({super.key});

  @override
  State<MobilePage> createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {
  int _selectedDemoIndex = 0;
  String _currentLang = 'RU';

  // --- ЛОКАЛИЗАЦИЯ (Тексты для RU, KG, EN) ---
  final Map<String, Map<String, dynamic>> _localizedValues = {
    'RU': {
      'appBarTitle': 'Разработка мобильных приложений',
      'subtitle': 'Создаем кроссплатформенные мобильные приложения',
      'chooseDemo': 'Выберите направление для демо',
      'contactDev': 'Связаться с разработчиком',
      'writeWhatsapp': 'Написать в WhatsApp',
      'openCalc': 'Открыть калькулятор проекта',
      'categories': [
        'Доставка еды',
        'Такси & Карго',
        'Финтех & Банк',
        'Маркетплейс / ТЦ',
        'Фитнес & Спорт',
        'Медицина & Клиника',
        'Отели & Туризм',
        'Онлайн-Обучение',
        'Недвижимость',
        'Соцсеть / Чат',
      ],
      'demoContent': {
        'food': {
          'title': 'Доставка Еды',
          'banner': '🔥 Скидка 20% на сет пицц!',
        },
        'taxi': {'title': 'Такси & Доставка', 'btn': 'Вызвать такси'},
        'fintech': {'title': 'Мой Банк', 'card': 'Баланс карты Visa'},
        'marketplace': {'title': 'Маркетплейс'},
        'fitness': {
          'title': 'Фитнес Трекер',
          'goal': '⚡ Цель: 10,000 шагов (75%)',
        },
        'medical': {
          'title': 'Запись к Врачу',
          'clinic': '🏥 Клиника "Здоровье"',
        },
        'tourism': {'title': 'Отели & Туры', 'place': '🏝 Озеро Иссык-Куль'},
        'education': {
          'title': 'Онлайн Академия',
          'course': '🎓 Курс',
        },
        'realty': {'title': 'Аренда & Продажа'},
        'chat': {'title': 'Мессенджер'},
      },
    },
    'KG': {
      'appBarTitle': 'Мобилдик тиркемелерди иштеп чыгуу',
      'subtitle':
          'Кроссплатформалуу мобилдик тиркемелерди түзөбүз',
      'chooseDemo': 'Демо үчүн багытты тандаңыз',
      'contactDev': 'Иштеп чыгуучу менен байланышуу',
      'writeWhatsapp': 'WhatsApp аркылуу жазуу',
      'openCalc': 'Долбоор калькуляторун ачуу',
      'categories': [
        'Тамак-аш жеткирүү',
        'Такси & Карго',
        'Финтех & Банк',
        'Маркетплейс / Соода борбору',
        'Фитнес & Спорт',
        'Медицина & Клиника',
        'Мейманканалар & Туризм',
        'Онлайн-Окутуу',
        'Кыймылсыз мүлк',
        'Соцтармак / Чат',
      ],
      'demoContent': {
        'food': {
          'title': 'Тамак жеткирүү',
          'banner': '🔥 Пицца топтомуна 20% арзандатуу!',
        },
        'taxi': {'title': 'Такси & Жеткирүү', 'btn': 'Такси чакыруу'},
        'fintech': {'title': 'Менин Банкым', 'card': 'Visa картасынын балансы'},
        'marketplace': {'title': 'Маркетплейс'},
        'fitness': {
          'title': 'Фитнес Трекер',
          'goal': '⚡ Максат: 10,000 кадам (75%)',
        },
        'medical': {
          'title': 'Дарыгерге жазылуу',
          'clinic': '🏥 "Ден соолук" клиникасы',
        },
        'tourism': {'title': 'Мейманканалар & Турлар', 'place': '🏝 Ысык-Көл'},
        'education': {
          'title': 'Онлайн Академия',
          'course': '🎓 Курс',
        },
        'realty': {'title': 'Ижара & Сатуу'},
        'chat': {'title': 'Мессенджер'},
      },
    },
    'EN': {
      'appBarTitle': 'Mobile Application Development',
      'subtitle': 'Building cross-platform mobile apps with Flutter',
      'chooseDemo': 'Choose a direction for demo',
      'contactDev': 'Contact Developer',
      'writeWhatsapp': 'Message on WhatsApp',
      'openCalc': 'Open Project Calculator',
      'categories': [
        'Food Delivery',
        'Taxi & Cargo',
        'Fintech & Bank',
        'Marketplace / Mall',
        'Fitness & Sport',
        'Medical & Clinic',
        'Hotels & Tourism',
        'Online Learning',
        'Real Estate',
        'Social Network / Chat',
      ],
      'demoContent': {
        'food': {'title': 'Food Delivery', 'banner': '🔥 20% OFF Pizza Set!'},
        'taxi': {'title': 'Taxi & Delivery', 'btn': 'Call a Taxi'},
        'fintech': {'title': 'My Bank', 'card': 'Visa Card Balance'},
        'marketplace': {'title': 'Marketplace'},
        'fitness': {
          'title': 'Fitness Tracker',
          'goal': '⚡ Goal: 10,000 steps (75%)',
        },
        'medical': {
          'title': 'Doctor Appointment',
          'clinic': '🏥 "Health" Clinic',
        },
        'tourism': {'title': 'Hotels & Tours', 'place': '🏝 Issyk-Kul Lake'},
        'education': {
          'title': 'Online Academy',
          'course': '🎓 Course: Flutter Development',
        },
        'realty': {'title': 'Rent & Sale'},
        'chat': {'title': 'Messenger'},
      },
    },
  };

  final List<IconData> _demoIcons = [
    Icons.fastfood_outlined,
    Icons.local_taxi_outlined,
    Icons.account_balance_wallet_outlined,
    Icons.shopping_bag_outlined,
    Icons.fitness_center_outlined,
    Icons.medical_services_outlined,
    Icons.hotel_outlined,
    Icons.school_outlined,
    Icons.home_work_outlined,
    Icons.forum_outlined,
  ];

  final List<Color> _demoColors = [
    Colors.orangeAccent,
    Colors.amber,
    Colors.cyanAccent,
    Colors.purpleAccent,
    Colors.greenAccent,
    Colors.redAccent,
    Colors.blueAccent,
    Colors.tealAccent,
    Colors.deepOrangeAccent,
    Colors.pinkAccent,
  ];

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
    final langData = _localizedValues[_currentLang] ?? _localizedValues['RU']!;
    final List<String> categories = List<String>.from(langData['categories']);

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
          langData['appBarTitle'],
          style: GoogleFonts.notoSerif(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        // === ПЕРЕКЛЮЧАТЕЛЬ ЯЗЫКОВ В APPBAR ===
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: ['RU', 'KG', 'EN'].map((lang) {
                final isSelected = _currentLang == lang;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentLang = lang;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.cyanAccent.withValues(alpha: .2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isSelected ? Colors.cyanAccent : Colors.white24,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      lang,
                      style: TextStyle(
                        color: isSelected ? Colors.cyanAccent : Colors.white70,
                        fontSize: 11,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Text(
              langData['subtitle'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              langData['chooseDemo'],
              style: GoogleFonts.notoSerif(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            // КНОПКИ КАТЕГОРИЙ
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: List.generate(categories.length, (index) {
                final isSelected = _selectedDemoIndex == index;
                final color = _demoColors[index];

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedDemoIndex = index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? color.withValues(alpha: .18)
                          : const Color(0xFF1B1B24),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? color
                            : Colors.white.withValues(alpha: .08),
                        width: isSelected ? 1.5 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: .25),
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
                          _demoIcons[index],
                          size: 18,
                          color: isSelected ? color : Colors.white70,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected ? color : Colors.white,
                            fontSize: 13,
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

            const SizedBox(height: 20),

            // ИНТЕРАКТИВНЫЙ СМАРТФОН
            Container(
              width: 290,
              height: 540,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF13131A),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white24, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: .12),
                    blurRadius: 25,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: const Color(0xFF181820),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: KeyedSubtree(
                      key: ValueKey<String>('$_selectedDemoIndex$_currentLang'),
                      child: _buildRichPhoneContent(
                        _selectedDemoIndex,
                        langData,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // === 1. TELEGRAM ===
            SizedBox(
              width: 360,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => _launchURL('https://t.me/996551771108'),
                icon: const Icon(Icons.telegram, color: Colors.white, size: 22),
                label: Text(
                  langData['contactDev'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0088CC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 4,
                  
                ),
              ),
            ),

            const SizedBox(height: 12),

            // === 2. WHATSAPP ===
            SizedBox(
              width: 360,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => _launchURL('https://wa.me/996551771108'),
                icon: const Icon(
                  Icons.chat_bubble,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
                  langData['writeWhatsapp'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 4,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // === 3. КАЛЬКУЛЯТОР ===
            SizedBox(
              width: 360,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MobileCalculatorPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.calculate_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                label: Text(
                  langData['openCalc'],
                  style: GoogleFonts.notoSerif(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // === ЭКРАНЫ СМАРТФОНА С ПОДДЕРЖКОЙ ЛОКАЛИЗАЦИИ ===
  Widget _buildRichPhoneContent(int index, Map<String, dynamic> langData) {
    final demoText = langData['demoContent'];

    switch (index) {
      case 0: // Доставка еды
        return Column(
          children: [
            _phoneHeader(
              demoText['food']['title'],
              Icons.search,
              Colors.orangeAccent,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  _banner(demoText['food']['banner'], Colors.orangeAccent),
                  const SizedBox(height: 8),
                  _productRow(
                    'Пицца Маргарита',
                    '380 c',
                    Icons.local_pizza,
                    Colors.orangeAccent,
                  ),
                  _productRow(
                    'Чизбургер XXL',
                    '280 c',
                    Icons.lunch_dining,
                    Colors.orangeAccent,
                  ),
                  _productRow(
                    'Филадельфия Сет',
                    '750 c',
                    Icons.set_meal,
                    Colors.orangeAccent,
                  ),
                ],
              ),
            ),
          ],
        );

      case 1: // Такси & Карго
        return Column(
          children: [
            _phoneHeader(
              demoText['taxi']['title'],
              Icons.my_location,
              Colors.amber,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: const Color(0xFF121218),
                    child: const Center(
                      child: Icon(
                        Icons.map_outlined,
                        size: 90,
                        color: Colors.white10,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22222E),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.amber.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '🚕 Eco: 140c',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '🚗 Business: 300c',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              minimumSize: const Size(double.infinity, 32),
                            ),
                            child: Text(
                              demoText['taxi']['btn'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      case 2: // Финтех & Банк
        return Column(
          children: [
            _phoneHeader(
              demoText['fintech']['title'],
              Icons.notifications_none,
              Colors.cyanAccent,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.cyanAccent, Colors.blueAccent],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      demoText['fintech']['card'],
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '148,250 KGS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  _productRow(
                    'Transfer',
                    '- 1,200 c',
                    Icons.arrow_upward,
                    Colors.redAccent,
                  ),
                  _productRow(
                    'Deposit',
                    '+ 15,000 c',
                    Icons.arrow_downward,
                    Colors.greenAccent,
                  ),
                ],
              ),
            ),
          ],
        );

      case 3: // Маркетплейс
        return Column(
          children: [
            _phoneHeader(
              demoText['marketplace']['title'],
              Icons.shopping_cart_outlined,
              Colors.purpleAccent,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(8),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: [
                  _gridTile(
                    'Nike Air Max',
                    '6,500c',
                    Colors.purpleAccent,
                    Icons.style,
                  ),
                  _gridTile(
                    'Smart Watch',
                    '3,200c',
                    Colors.purpleAccent,
                    Icons.watch,
                  ),
                  _gridTile(
                    'AirPods Pro',
                    '12,000c',
                    Colors.purpleAccent,
                    Icons.headphones,
                  ),
                  _gridTile(
                    'Urban Pack',
                    '2,400c',
                    Colors.purpleAccent,
                    Icons.backpack,
                  ),
                ],
              ),
            ),
          ],
        );

      case 4: // Фитнес
        return Column(
          children: [
            _phoneHeader(
              demoText['fitness']['title'],
              Icons.bolt,
              Colors.greenAccent,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: _banner(demoText['fitness']['goal'], Colors.greenAccent),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  _productRow(
                    'Running',
                    '4.2 km • 280 kcal',
                    Icons.directions_run,
                    Colors.greenAccent,
                  ),
                  _productRow(
                    'Workout',
                    '45 min • 340 kcal',
                    Icons.fitness_center,
                    Colors.greenAccent,
                  ),
                ],
              ),
            ),
          ],
        );

      case 5: // Медицина
        return Column(
          children: [
            _phoneHeader(
              demoText['medical']['title'],
              Icons.calendar_month,
              Colors.redAccent,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  _banner(demoText['medical']['clinic'], Colors.redAccent),
                  const SizedBox(height: 8),
                  _productRow(
                    'Dr. Smith',
                    '15:30 Today',
                    Icons.person_outlined,
                    Colors.redAccent,
                  ),
                  _productRow(
                    'Dr. Adams',
                    '10:00 Tomorrow',
                    Icons.favorite_border,
                    Colors.redAccent,
                  ),
                ],
              ),
            ),
          ],
        );

      case 6: // Отели & Туризм
        return Column(
          children: [
            _phoneHeader(
              demoText['tourism']['title'],
              Icons.flight_takeoff,
              Colors.blueAccent,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  _banner(demoText['tourism']['place'], Colors.blueAccent),
                  const SizedBox(height: 8),
                  _productRow(
                    'Hotel "Caprice"',
                    '4,500c / night',
                    Icons.hotel,
                    Colors.blueAccent,
                  ),
                  _productRow(
                    'Resort "Raduga"',
                    '8,000c / night',
                    Icons.house,
                    Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ],
        );

      case 7: // Онлайн-Обучение
        return Column(
          children: [
            _phoneHeader(
              demoText['education']['title'],
              Icons.play_circle_outline,
              Colors.tealAccent,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  _banner(demoText['education']['course'], Colors.tealAccent),
                  const SizedBox(height: 8),
                  _productRow(
                    'Lesson 1: Dart',
                    'Completed',
                    Icons.check_circle,
                    Colors.tealAccent,
                  ),
                  _productRow(
                    'Lesson 2: Flutter',
                    '15 min',
                    Icons.play_arrow,
                    Colors.tealAccent,
                  ),
                ],
              ),
            ),
          ],
        );

      case 8: // Недвижимость
        return Column(
          children: [
            _phoneHeader(
              demoText['realty']['title'],
              Icons.filter_list,
              Colors.deepOrangeAccent,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  _productRow(
                    '2-Room Apartment',
                    '\$650 / mo',
                    Icons.apartment,
                    Colors.deepOrangeAccent,
                  ),
                  _productRow(
                    'Penthouse Center',
                    '\$1,200 / mo',
                    Icons.domain,
                    Colors.deepOrangeAccent,
                  ),
                ],
              ),
            ),
          ],
        );

      case 9: // Соцсеть / Чат
      default:
        return Column(
          children: [
            _phoneHeader(
              demoText['chat']['title'],
              Icons.edit,
              Colors.pinkAccent,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  _productRow(
                    'NM DEV Support',
                    'Project launched! 🔥',
                    Icons.chat_bubble_outline,
                    Colors.pinkAccent,
                  ),
                  _productRow(
                    'Client',
                    'Thanks for the app!',
                    Icons.account_circle,
                    Colors.pinkAccent,
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }

  // === ВСПОМОГАТЕЛЬНЫЕ ВИДЖЕТЫ ===
  Widget _phoneHeader(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: const Color(0xFF22222E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          Icon(icon, color: color, size: 16),
        ],
      ),
    );
  }

  Widget _banner(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _productRow(String name, String sub, IconData icon, Color color) {
    return Card(
      color: const Color(0xFF22222E),
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: color, size: 18),
        title: Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
        subtitle: Text(sub, style: TextStyle(color: color, fontSize: 10)),
      ),
    );
  }

  Widget _gridTile(String title, String price, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF22222E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: .3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(price, style: TextStyle(color: color, fontSize: 9)),
        ],
      ),
    );
  }
}
