import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileCalculatorPage extends StatefulWidget {
  const MobileCalculatorPage({super.key});

  @override
  State<MobileCalculatorPage> createState() => _MobileCalculatorPageState();
}

class _MobileCalculatorPageState extends State<MobileCalculatorPage> {
  // Ключ для валидации формы
  final _formKey = GlobalKey<FormState>();

  // Контроллеры для формы отправки
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Переключение языка и валюты
  String _selectedLang = 'RU';
  String _selectedCurrency = 'KGS';

  // Локализация текстов
  final Map<String, Map<String, String>> _i18n = {
    'RU': {
      'title': 'Калькулятор проекта',
      'platforms': '1. Целевые платформы',
      'design': '2. Сложность UI/UX Дизайна',
      'features': '3. Необходимый функционал',
      'budget': 'Ориентировочный бюджет',
      'deadline': 'Сроки разработки: от 2 до 5 недель',
      'askDev': 'Есть вопросы по расчёту?',
      'askDevSub': 'Обсудите ТЗ напрямую с разработчиком:',
      'sendBtn': 'Отправить расчёт разработчику',
      'modalTitle': 'Оформление заявки',
      'modalSub': 'Укажите ваши контакты для отправки детальной сметы:',
      'nameLabel': 'Ваше имя *',
      'companyLabel': 'Название компании / Проекта',
      'phoneLabel': 'Номер телефона / WhatsApp *',
      'sendTelegram': 'Отправить в Telegram',
      'sendWhatsApp': 'Отправить в WhatsApp',
      'design0_title': 'Базовый',
      'design0_sub': 'Стандартный UI/UX',
      'design1_title': 'Уникальный',
      'design1_sub': 'Индивидуальный стиль',
      'design2_title': 'Премиум / 3D',
      'design2_sub': 'Анимации & 3D элементы',
      'selectOptionsAlert':
          'Пожалуйста, выберите хотя бы одну платформу или функцию!',
      'errNameRequired': 'Пожалуйста, введите ваше имя',
      'errNameShort': 'Имя должно содержать минимум 2 символа',
      'errPhoneRequired': 'Пожалуйста, введите номер телефона',
      'errPhoneInvalid': 'Введите корректный номер (напр. +996 550 123 456)',
    },
    'KG': {
      'title': 'Долбоор калькулятору',
      'platforms': '1. Максаттуу платформалар',
      'design': '2. UI/UX Дизайндын татаалдыгы',
      'features': '3. Керектүү функционал',
      'budget': 'Болжолдуу бюджет',
      'deadline': 'Иштеп чыгуу мөөнөтү: 2ден 5 жумага чейин',
      'askDev': 'Эсептөө боюнча суроолоруңуз барбы?',
      'askDevSub': 'Иштеп чыгуучу менен түз талкуулаңыз:',
      'sendBtn': 'Эсептөөнү иштеп чыгуучуга жөнөтүү',
      'modalTitle': 'Өтүнмөнү тариздөө',
      'modalSub': 'Смета алуу үчүн байланыш маалыматыңызды калтырыңыз:',
      'nameLabel': 'Атыңыз *',
      'companyLabel': 'Компаниянын же долбоордун аты',
      'phoneLabel': 'Телефон номери / WhatsApp *',
      'sendTelegram': 'Telegram аркылуу жөнөтүү',
      'sendWhatsApp': 'WhatsApp аркылуу жөнөтүү',
      'design0_title': 'Базалык',
      'design0_sub': 'Стандарттык UI/UX',
      'design1_title': 'Уникалдуу',
      'design1_sub': 'Жеке стиль',
      'design2_title': 'Премиум / 3D',
      'design2_sub': 'Анимация жана 3D элементтер',
      'selectOptionsAlert':
          'Сураныч, кеминде бир платформа же функционал тандаңыз!',
      'errNameRequired': 'Сураныч, атыңызды киргизиңиз',
      'errNameShort': 'Атыңыз кеминде 2 символдон турушу керек',
      'errPhoneRequired': 'Сураныч, телефон номериңизди киргизиңиз',
      'errPhoneInvalid':
          'Туура телефон номерин киргизиңиз (мис. +996 550 123 456)',
    },
    'EN': {
      'title': 'Project Calculator',
      'platforms': '1. Target Platforms',
      'design': '2. UI/UX Design Complexity',
      'features': '3. Required Features',
      'budget': 'Estimated Budget',
      'deadline': 'Development time: 2 to 5 weeks',
      'askDev': 'Have questions about the calculation?',
      'askDevSub': 'Discuss specifications directly with dev:',
      'sendBtn': 'Send calculation to developer',
      'modalTitle': 'Submit Request',
      'modalSub': 'Provide your contacts to receive a detailed quote:',
      'nameLabel': 'Your Name *',
      'companyLabel': 'Company / Project Name',
      'phoneLabel': 'Phone Number / WhatsApp *',
      'sendTelegram': 'Send via Telegram',
      'sendWhatsApp': 'Send via WhatsApp',
      'design0_title': 'Basic',
      'design0_sub': 'Standard UI/UX',
      'design1_title': 'Unique',
      'design1_sub': 'Custom style',
      'design2_title': 'Premium / 3D',
      'design2_sub': 'Animations & 3D elements',
      'selectOptionsAlert': 'Please select at least one platform or feature!',
      'errNameRequired': 'Please enter your name',
      'errNameShort': 'Name must be at least 2 characters',
      'errPhoneRequired': 'Please enter your phone number',
      'errPhoneInvalid': 'Enter a valid phone number (e.g. +996 550 123 456)',
    },
  };

  final Map<String, double> _currencyRates = {
    'USD': 1.0,
    'KGS': 89.0,
    'EUR': 0.92,
  };

  final Map<String, String> _currencySymbols = {
    'USD': '\$',
    'KGS': 'сом',
    'EUR': '€',
  };

  // Платформы по умолчанию СНЯТЫ
  bool _isIOS = false;
  bool _isAndroid = false;

  // Дизайн по умолчанию НЕ ВЫБРАН (-1)
  int _selectedDesignIndex = -1;

  // Все функции по умолчанию FALSE (сняты)
  final Map<String, bool> _features = {
    'Авторизация / Профиль (SMS, Google, Apple)': false,
    'Каталог / Поиск / Фильтры товаров': false,
    'Корзина / Онлайн-оплата (Visa, Элкарт, Stripe)': false,
    'Push-уведомления & Внутренний чат': false,
    'Геолокация & Карты (Yandex / 2GIS / Google)': false,
    'Админ-панель (CMS для управления системой)': false,
    'Интеграция с CRM / 1С / Внешними API': false,
    'Мультиязычность (RU / KG / EN)': false,
    'Темная и светлая тема оформления': false,
    'Отзывы, оценки и система рейтингов': false,
    'История заказов и аналитика пользователя': false,
  };

  final Map<String, int> _featurePricesUSD = {
    'Авторизация / Профиль (SMS, Google, Apple)': 150,
    'Каталог / Поиск / Фильтры товаров': 250,
    'Корзина / Онлайн-оплата (Visa, Элкарт, Stripe)': 300,
    'Push-уведомления & Внутренний чат': 200,
    'Геолокация & Карты (Yandex / 2GIS / Google)': 350,
    'Админ-панель (CMS для управления системой)': 400,
    'Интеграция с CRM / 1С / Внешними API': 450,
    'Мультиязычность (RU / KG / EN)': 180,
    'Темная и светлая тема оформления': 120,
    'Отзывы, оценки и система рейтингов': 160,
    'История заказов и аналитика пользователя': 220,
  };

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  int _calculateTotalUSD() {
    bool hasAnyFeature = _features.values.contains(true);
    if (!_isIOS &&
        !_isAndroid &&
        _selectedDesignIndex == -1 &&
        !hasAnyFeature) {
      return 0;
    }

    int basePrice = (_isIOS || _isAndroid) ? 500 : 0;
    List<int> designPrices = [200, 500, 900];
    int designPrice = _selectedDesignIndex != -1
        ? designPrices[_selectedDesignIndex]
        : 0;
    int featuresPrice = 0;

    _features.forEach((key, isSelected) {
      if (isSelected) {
        featuresPrice += _featurePricesUSD[key] ?? 0;
      }
    });

    return basePrice + designPrice + featuresPrice;
  }

  String _getFormattedPrice() {
    int totalUSD = _calculateTotalUSD();
    double rate = _currencyRates[_selectedCurrency] ?? 1.0;
    int converted = (totalUSD * rate).round();
    String symbol = _currencySymbols[_selectedCurrency] ?? '\$';

    if (_selectedCurrency == 'KGS') {
      return '$converted $symbol';
    }
    return '$symbol$converted';
  }

  String _txt(String key) {
    return _i18n[_selectedLang]?[key] ?? _i18n['RU']![key]!;
  }

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

  String _buildOrderMessage() {
    List<String> platforms = [];
    if (_isIOS) platforms.add('iOS');
    if (_isAndroid) platforms.add('Android');

    List<String> designNames = ['Базовый', 'Уникальный', 'Премиум / 3D'];
    String designName = _selectedDesignIndex != -1
        ? designNames[_selectedDesignIndex]
        : 'Не выбран';

    List<String> selectedFeatures = [];
    _features.forEach((key, val) {
      if (val) selectedFeatures.add('• $key');
    });

    String companyText = _companyController.text.trim().isNotEmpty
        ? _companyController.text.trim()
        : 'Не указано';

    return '''
🚀 *НОВАЯ ЗАЯВКА НА РАЗРАБОТКУ*

👤 *Клиент:* ${_nameController.text.trim()}
🏢 *Компания:* $companyText
📞 *Телефон:* ${_phoneController.text.trim()}

📱 *Платформы:* ${platforms.isEmpty ? 'Не выбраны' : platforms.join(', ')}
🎨 *Дизайн:* $designName
💰 *Ориентировочный бюджет:* ${_getFormattedPrice()}

⚙️ *Выбранные функции:*
${selectedFeatures.isEmpty ? 'Без дополнительных функций' : selectedFeatures.join('\n')}
''';
  }

  // Показ модалки с валидацией
  void _showSubmitModal() {
    bool hasAnyFeature = _features.values.contains(true);
    if (!_isIOS &&
        !_isAndroid &&
        _selectedDesignIndex == -1 &&
        !hasAnyFeature) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_txt('selectOptionsAlert')),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF13131A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 24,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _txt('modalTitle'),
                    style: GoogleFonts.notoSerif(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _txt('modalSub'),
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  const SizedBox(height: 20),

                  // ВАЛИДАЦИЯ ИМЕНИ
                  _buildValidatedTextField(
                    controller: _nameController,
                    label: _txt('nameLabel'),
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return _txt('errNameRequired');
                      }
                      if (value.trim().length < 2) {
                        return _txt('errNameShort');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // КОМПАНИЯ (Необязательное поле)
                  _buildValidatedTextField(
                    controller: _companyController,
                    label: _txt('companyLabel'),
                    icon: Icons.business_outlined,
                  ),
                  const SizedBox(height: 12),

                  // ВАЛИДАЦИЯ ТЕЛЕФОНА (Regex)
                  _buildValidatedTextField(
                    controller: _phoneController,
                    label: _txt('phoneLabel'),
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return _txt('errPhoneRequired');
                      }
                      // Регулярное выражение для проверки номера (цифры, +, скобки, дефисы, пробелы)
                      final phoneRegex = RegExp(r'^\+?[0-9\s\-\(\)]{7,20}$');
                      if (!phoneRegex.hasMatch(value.trim())) {
                        return _txt('errPhoneInvalid');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // КНОПКИ ОТПРАВКИ
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final msg = Uri.encodeComponent(
                                _buildOrderMessage(),
                              );
                              _launchURL('https://t.me/996551771108?text=$msg');
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(
                            Icons.telegram,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: Text(
                            _txt('sendTelegram'),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0088CC),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final msg = Uri.encodeComponent(
                                _buildOrderMessage(),
                              );
                              _launchURL(
                                'https://wa.me/996551771108?text=$msg',
                              );
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(
                            Icons.chat_bubble,
                            color: Colors.white,
                            size: 16,
                          ),
                          label: Text(
                            _txt('sendWhatsApp'),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25D366),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Виджет текстового поля с поддержкой ошибки/валидации
  Widget _buildValidatedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54, fontSize: 12),
        prefixIcon: Icon(icon, color: Colors.cyanAccent, size: 18),
        filled: true,
        fillColor: const Color(0xFF1B1B24),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.cyanAccent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 11),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> designOptions = [
      {
        'title': _txt('design0_title'),
        'subtitle': _txt('design0_sub'),
        'priceUSD': 200,
      },
      {
        'title': _txt('design1_title'),
        'subtitle': _txt('design1_sub'),
        'priceUSD': 500,
      },
      {
        'title': _txt('design2_title'),
        'subtitle': _txt('design2_sub'),
        'priceUSD': 900,
      },
    ];

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
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          _txt('title'),
          style: GoogleFonts.notoSerif(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          DropdownButton<String>(
            value: _selectedLang,
            dropdownColor: const Color(0xFF1B1B24),
            underline: const SizedBox(),
            icon: const Icon(
              Icons.language,
              color: Colors.cyanAccent,
              size: 18,
            ),
            items: ['RU', 'KG', 'EN'].map((lang) {
              return DropdownMenuItem(
                value: lang,
                child: Text(
                  lang,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _selectedLang = val;
                });
              }
            },
          ),
          const SizedBox(width: 8),

          DropdownButton<String>(
            value: _selectedCurrency,
            dropdownColor: const Color(0xFF1B1B24),
            underline: const SizedBox(),
            icon: const Icon(
              Icons.attach_money,
              color: Colors.greenAccent,
              size: 18,
            ),
            items: ['KGS', 'USD', 'EUR'].map((curr) {
              return DropdownMenuItem(
                value: curr,
                child: Text(
                  curr,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _selectedCurrency = val;
                });
              }
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. ЦЕЛЕВЫЕ ПЛАТФОРМЫ
              _sectionTitle(_txt('platforms')),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _platformChip(
                      title: 'iOS (App Store)',
                      icon: Icons.apple,
                      isSelected: _isIOS,
                      onTap: () => setState(() => _isIOS = !_isIOS),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _platformChip(
                      title: 'Android (Play Market)',
                      icon: Icons.android,
                      isSelected: _isAndroid,
                      onTap: () => setState(() => _isAndroid = !_isAndroid),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 2. СЛОЖНОСТЬ ДИЗАЙНА
              _sectionTitle(_txt('design')),
              const SizedBox(height: 8),
              Column(
                children: List.generate(designOptions.length, (index) {
                  final option = designOptions[index];
                  final isSelected = _selectedDesignIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedDesignIndex == index) {
                          _selectedDesignIndex = -1;
                        } else {
                          _selectedDesignIndex = index;
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.cyanAccent.withAlpha(25)
                            : const Color(0xFF181820),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.cyanAccent
                              : Colors.white.withAlpha(20),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: isSelected
                                ? Colors.cyanAccent
                                : Colors.white38,
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  option['title'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  option['subtitle'],
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '+\$${option['priceUSD']}',
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.cyanAccent
                                  : Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // 3. НЕОБХОДИМЫЙ ФУНКЦИОНАЛ
              _sectionTitle(_txt('features')),
              const SizedBox(height: 8),
              Column(
                children: _features.keys.map((featureKey) {
                  final isSelected = _features[featureKey]!;
                  final priceUSD = _featurePricesUSD[featureKey];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF181820),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Colors.cyanAccent.withAlpha(100)
                            : Colors.transparent,
                      ),
                    ),
                    child: CheckboxListTile(
                      dense: true,
                      activeColor: Colors.cyanAccent,
                      checkColor: Colors.black,
                      value: isSelected,
                      title: Text(
                        featureKey,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                      secondary: Text(
                        '+\$$priceUSD',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.cyanAccent
                              : Colors.white38,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _features[featureKey] = val ?? false;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // 4. ИТОГОВАЯ КАРТОЧКА
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1F1F2C), Color(0xFF13131A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.cyanAccent.withAlpha(60)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(100),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      _txt('budget'),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '~ ${_getFormattedPrice()}',
                      style: GoogleFonts.notoSerif(
                        color: Colors.cyanAccent,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _txt('deadline'),
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 5. БЛОК СВЯЗИ
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF13131A),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withAlpha(15)),
                ),
                child: Column(
                  children: [
                    Text(
                      _txt('askDev'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _txt('askDevSub'),
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  _launchURL('https://t.me/996551771108'),
                              icon: const Icon(
                                Icons.telegram,
                                color: Colors.white,
                                size: 16,
                              ),
                              label: const Text(
                                'Telegram',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0088CC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  _launchURL('https://wa.me/996551771108'),
                              icon: const Icon(
                                Icons.chat_bubble,
                                color: Colors.white,
                                size: 15,
                              ),
                              label: const Text(
                                'WhatsApp',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF25D366),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 6. ФИНАЛЬНАЯ КНОПКА
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _showSubmitModal,
                  icon: const Icon(
                    Icons.send_rounded,
                    color: Colors.black,
                    size: 18,
                  ),
                  label: Text(
                    _txt('sendBtn'),
                    style: GoogleFonts.notoSerif(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.notoSerif(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _platformChip({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.cyanAccent.withAlpha(30)
              : const Color(0xFF181820),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.cyanAccent : Colors.white10,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.cyanAccent : Colors.white54,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.cyanAccent : Colors.white70,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
