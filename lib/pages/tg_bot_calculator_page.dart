import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BotCalculatorPage extends StatefulWidget {
  const BotCalculatorPage({super.key});

  @override
  State<BotCalculatorPage> createState() => _BotCalculatorPageState();
}

class _BotCalculatorPageState extends State<BotCalculatorPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedLang = 'RU';
  String _selectedCurrency = 'KGS';

  // ====================== i18n ======================
  final Map<String, Map<String, String>> _i18n = {
    'RU': {
      'title': 'Калькулятор Ботов',
      'platforms': '1. Тип бота',
      'complexity': '2. Сложность & Логика',
      'features': '3. Функционал & Интеграции',
      'budget': 'Ориентировочный бюджет',
      'deadline': 'Сроки разработки: от 5 до 20 дней',
      'sendBtn': 'Отправить расчёт разработчику',
      'modalTitle': 'Оформление заявки',
      'modalSub': 'Укажите контакты для детальной сметы:',
      'nameLabel': 'Ваше имя *',
      'companyLabel': 'Компания / Проект',
      'phoneLabel': 'Телефон / WhatsApp *',
      'sendTelegram': 'Отправить в Telegram',
      'sendWhatsApp': 'Отправить в WhatsApp',
      'selectOptionsAlert': 'Выберите хотя бы тип бота или один модуль!',
      'errNameRequired': 'Введите ваше имя',
      'errNameShort': 'Имя должно быть не короче 2 символов',
      'errPhoneRequired': 'Введите номер телефона',
      'errPhoneInvalid': 'Некорректный номер (напр. +996 550 123 456)',
      'type_telegram': 'Telegram Бот',
      'type_whatsapp': 'WhatsApp Бот',
      'type_ai': 'AI / ChatGPT Бот',
      'type_multi': 'Мультиплатформенный',
      'comp0_title': 'Простой (меню + кнопки)',
      'comp0_sub': 'Готовые сценарии, без сложной логики',
      'comp1_title': 'Средний (логика + БД)',
      'comp1_sub': 'Состояния, база данных, админка',
      'comp2_title': 'Сложный (AI + интеграции)',
      'comp2_sub': 'Нейросеть, CRM, платежи, API',
      'feat_admin': 'Админ-панель управления',
      'feat_payment': 'Онлайн-оплата (Элкарт, Stripe и др.)',
      'feat_crm': 'Интеграция с CRM / 1С',
      'feat_ai': 'Подключение ChatGPT / Claude',
      'feat_broadcast': 'Рассылки и уведомления',
      'feat_booking': 'Система записи / бронирования',
      'feat_catalog': 'Каталог товаров / услуг',
      'feat_analytics': 'Аналитика и статистика',
    },
    'KG': {
      'title': 'Боттор калькулятору',
      'platforms': '1. Боттун түрү',
      'complexity': '2. Татаалдык & Логика',
      'features': '3. Функционал & Интеграция',
      'budget': 'Болжолдуу бюджет',
      'deadline': 'Иштеп чыгуу мөөнөтү: 5тен 20 күнгө чейин',
      'sendBtn': 'Эсептөөнү жөнөтүү',
      'modalTitle': 'Өтүнмөнү тариздөө',
      'modalSub': 'Байланыш маалыматыңызды калтырыңыз:',
      'nameLabel': 'Атыңыз *',
      'companyLabel': 'Компания / Долбоор',
      'phoneLabel': 'Телефон / WhatsApp *',
      'sendTelegram': 'Telegram аркылуу',
      'sendWhatsApp': 'WhatsApp аркылуу',
      'selectOptionsAlert': 'Сураныч, боттун түрүн же функция тандаңыз!',
      'errNameRequired': 'Атыңызды киргизиңиз',
      'errNameShort': 'Атыңыз кеминде 2 символ болушу керек',
      'errPhoneRequired': 'Телефон номериңизди киргизиңиз',
      'errPhoneInvalid': 'Туура эмес номер (мис. +996 550 123 456)',
      'type_telegram': 'Telegram Бот',
      'type_whatsapp': 'WhatsApp Бот',
      'type_ai': 'AI / ChatGPT Бот',
      'type_multi': 'Көп платформалуу',
      'comp0_title': 'Жөнөкөй (меню + баскычтар)',
      'comp0_sub': 'Даяр сценарийлер, татаал логикасыз',
      'comp1_title': 'Орто (логика + БД)',
      'comp1_sub': 'Абалдар, маалымат базасы, админка',
      'comp2_title': 'Татаал (AI + интеграция)',
      'comp2_sub': 'Нейротармак, CRM, төлөмдөр, API',
      'feat_admin': 'Админ-панель',
      'feat_payment': 'Онлайн төлөм',
      'feat_crm': 'CRM / 1С менен интеграция',
      'feat_ai': 'ChatGPT / Claude туташтыруу',
      'feat_broadcast': 'Жөнөтүүлөр жана билдирмелер',
      'feat_booking': 'Жазуу / брондоо системасы',
      'feat_catalog': 'Товарлар / кызматтар каталогу',
      'feat_analytics': 'Аналитика жана статистика',
    },
    'EN': {
      'title': 'Bot Calculator',
      'platforms': '1. Bot Type',
      'complexity': '2. Complexity & Logic',
      'features': '3. Features & Integrations',
      'budget': 'Estimated Budget',
      'deadline': 'Development time: 5 to 20 days',
      'sendBtn': 'Send calculation to dev',
      'modalTitle': 'Submit Request',
      'modalSub': 'Leave contacts for a detailed proposal:',
      'nameLabel': 'Your Name *',
      'companyLabel': 'Company / Project',
      'phoneLabel': 'Phone / WhatsApp *',
      'sendTelegram': 'Send via Telegram',
      'sendWhatsApp': 'Send via WhatsApp',
      'selectOptionsAlert': 'Please select at least a bot type or one feature!',
      'errNameRequired': 'Please enter your name',
      'errNameShort': 'Name must be at least 2 characters',
      'errPhoneRequired': 'Please enter phone number',
      'errPhoneInvalid': 'Invalid number (e.g. +996 550 123 456)',
      'type_telegram': 'Telegram Bot',
      'type_whatsapp': 'WhatsApp Bot',
      'type_ai': 'AI / ChatGPT Bot',
      'type_multi': 'Multi-platform',
      'comp0_title': 'Simple (menu + buttons)',
      'comp0_sub': 'Ready scenarios, no complex logic',
      'comp1_title': 'Medium (logic + DB)',
      'comp1_sub': 'States, database, admin panel',
      'comp2_title': 'Advanced (AI + integrations)',
      'comp2_sub': 'Neural network, CRM, payments, API',
      'feat_admin': 'Admin Panel',
      'feat_payment': 'Online Payments',
      'feat_crm': 'CRM / 1C Integration',
      'feat_ai': 'ChatGPT / Claude Connection',
      'feat_broadcast': 'Broadcasts & Notifications',
      'feat_booking': 'Booking System',
      'feat_catalog': 'Product / Service Catalog',
      'feat_analytics': 'Analytics & Statistics',
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

  // ===== Состояния =====
  bool _isTelegram = false;
  bool _isWhatsApp = false;
  bool _isAI = false;
  bool _isMulti = false;

  int _selectedComplexity = -1;

  final List<String> _featureKeys = [
    'admin',
    'payment',
    'crm',
    'ai',
    'broadcast',
    'booking',
    'catalog',
    'analytics',
  ];

  final Map<String, bool> _features = {
    'admin': false,
    'payment': false,
    'crm': false,
    'ai': false,
    'broadcast': false,
    'booking': false,
    'catalog': false,
    'analytics': false,
  };

  final Map<String, int> _featurePricesUSD = {
    'admin': 120,
    'payment': 150,
    'crm': 180,
    'ai': 250,
    'broadcast': 90,
    'booking': 140,
    'catalog': 130,
    'analytics': 100,
  };

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  int _calculateTotalUSD() {
    bool hasType = _isTelegram || _isWhatsApp || _isAI || _isMulti;
    bool hasFeature = _features.values.contains(true);
    if (!hasType && _selectedComplexity == -1 && !hasFeature) return 0;

    int typePrice = 0;
    if (_isTelegram) typePrice += 180;
    if (_isWhatsApp) typePrice += 220;
    if (_isAI) typePrice += 300;
    if (_isMulti) typePrice += 350;

    List<int> complexityPrices = [80, 200, 400];
    int complexityPrice = _selectedComplexity != -1
        ? complexityPrices[_selectedComplexity]
        : 0;

    int featuresPrice = 0;
    _features.forEach((key, val) {
      if (val) featuresPrice += _featurePricesUSD[key] ?? 0;
    });

    return typePrice + complexityPrice + featuresPrice;
  }

  String _getFormattedPrice() {
    int totalUSD = _calculateTotalUSD();
    double rate = _currencyRates[_selectedCurrency] ?? 1.0;
    int converted = (totalUSD * rate).round();
    String symbol = _currencySymbols[_selectedCurrency] ?? '\$';
    return _selectedCurrency == 'KGS'
        ? '$converted $symbol'
        : '$symbol$converted';
  }

  String _txt(String key) => _i18n[_selectedLang]?[key] ?? _i18n['RU']![key]!;

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  String _buildOrderMessage() {
    List<String> types = [];
    if (_isTelegram) types.add(_txt('type_telegram'));
    if (_isWhatsApp) types.add(_txt('type_whatsapp'));
    if (_isAI) types.add(_txt('type_ai'));
    if (_isMulti) types.add(_txt('type_multi'));

    List<String> complexityNames = [
      _txt('comp0_title'),
      _txt('comp1_title'),
      _txt('comp2_title'),
    ];
    String complexityName = _selectedComplexity != -1
        ? complexityNames[_selectedComplexity]
        : '—';

    List<String> selectedFeatures = [];
    _features.forEach((key, val) {
      if (val) selectedFeatures.add('• ${_txt('feat_$key')}');
    });

    return '''
🤖 *ЗАЯВКА НА БОТА / BOT REQUEST*

👤 *Клиент / Client:* ${_nameController.text.trim()}
🏢 *Компания / Company:* ${_companyController.text.trim().isEmpty ? '—' : _companyController.text.trim()}
📞 *Телефон / Phone:* ${_phoneController.text.trim()}

🤖 *Тип бота / Type:* ${types.isEmpty ? '—' : types.join(', ')}
⚙️ *Сложность / Complexity:* $complexityName
💰 *Бюджет / Budget:* ${_getFormattedPrice()}

📌 *Функции / Features:*
${selectedFeatures.isEmpty ? '—' : selectedFeatures.join('\n')}
''';
  }

  void _showSubmitModal() {
    if (_calculateTotalUSD() == 0) {
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
                  _buildValidatedTextField(
                    controller: _nameController,
                    label: _txt('nameLabel'),
                    icon: Icons.person_outline,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return _txt('errNameRequired');
                      }
                      if (val.trim().length < 2) return _txt('errNameShort');
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildValidatedTextField(
                    controller: _companyController,
                    label: _txt('companyLabel'),
                    icon: Icons.business_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildValidatedTextField(
                    controller: _phoneController,
                    label: _txt('phoneLabel'),
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return _txt('errPhoneRequired');
                      }
                      final regex = RegExp(r'^\+?[0-9\s\-\(\)]{7,20}$');
                      if (!regex.hasMatch(val.trim())) {
                        return _txt('errPhoneInvalid');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
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
    final bool isWide = MediaQuery.of(context).size.width > 900;

    final complexityOptions = [
      {
        'title': _txt('comp0_title'),
        'subtitle': _txt('comp0_sub'),
        'priceUSD': 80,
      },
      {
        'title': _txt('comp1_title'),
        'subtitle': _txt('comp1_sub'),
        'priceUSD': 200,
      },
      {
        'title': _txt('comp2_title'),
        'subtitle': _txt('comp2_sub'),
        'priceUSD': 400,
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
            fontSize: 16,
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
            items: ['RU', 'KG', 'EN']
                .map(
                  (lang) => DropdownMenuItem(
                    value: lang,
                    child: Text(
                      lang,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                )
                .toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedLang = val);
            },
          ),
          const SizedBox(width: 12),
          DropdownButton<String>(
            value: _selectedCurrency,
            dropdownColor: const Color(0xFF1B1B24),
            underline: const SizedBox(),
            icon: const Icon(
              Icons.attach_money,
              color: Colors.greenAccent,
              size: 18,
            ),
            items: ['KGS', 'USD', 'EUR']
                .map(
                  (curr) => DropdownMenuItem(
                    value: curr,
                    child: Text(
                      curr,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                )
                .toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedCurrency = val);
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== ЛЕВАЯ ЧАСТЬ =====
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle(_txt('platforms')),
                          const SizedBox(height: 12),
                          _buildTypeCard(
                            _txt('type_telegram'),
                            Icons.telegram,
                            _isTelegram,
                            () => setState(() => _isTelegram = !_isTelegram),
                            180,
                            const Color(0xFF0088CC),
                          ),
                          const SizedBox(height: 10),
                          _buildTypeCard(
                            _txt('type_whatsapp'),
                            Icons.chat,
                            _isWhatsApp,
                            () => setState(() => _isWhatsApp = !_isWhatsApp),
                            220,
                            const Color(0xFF25D366),
                          ),
                          const SizedBox(height: 10),
                          _buildTypeCard(
                            _txt('type_ai'),
                            Icons.auto_awesome,
                            _isAI,
                            () => setState(() => _isAI = !_isAI),
                            300,
                            Colors.purpleAccent,
                          ),
                          const SizedBox(height: 10),
                          _buildTypeCard(
                            _txt('type_multi'),
                            Icons.hub_outlined,
                            _isMulti,
                            () => setState(() => _isMulti = !_isMulti),
                            350,
                            Colors.deepPurpleAccent,
                          ),

                          const SizedBox(height: 28),
                          _sectionTitle(_txt('complexity')),
                          const SizedBox(height: 12),
                          ...List.generate(complexityOptions.length, (index) {
                            final option = complexityOptions[index];
                            final isSelected = _selectedComplexity == index;
                            return _buildComplexityCard(
                              option['title'] as String,
                              option['subtitle'] as String,
                              option['priceUSD'] as int,
                              isSelected,
                              () => setState(
                                () => _selectedComplexity = isSelected
                                    ? -1
                                    : index,
                              ),
                            );
                          }),

                          const SizedBox(height: 28),
                          _sectionTitle(_txt('features')),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: _featureKeys.map((key) {
                              final isSelected = _features[key]!;
                              return _buildFeatureChip(
                                _txt('feat_$key'),
                                isSelected,
                                _featurePricesUSD[key]!,
                                (val) => setState(
                                  () => _features[key] = val ?? false,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),

                  // ===== ПРАВАЯ ЧАСТЬ (бюджет) =====
                  Container(
                    width: 340,
                    color: const Color(0xFF13131A),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1F1F2C), Color(0xFF13131A)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.cyanAccent.withAlpha(80),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _txt('budget'),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '~ ${_getFormattedPrice()}',
                                style: GoogleFonts.notoSerif(
                                  color: Colors.cyanAccent,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _txt('deadline'),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: _showSubmitModal,
                            icon: const Icon(
                              Icons.send_rounded,
                              color: Colors.black,
                              size: 20,
                            ),
                            label: Text(
                              _txt('sendBtn'),
                              style: GoogleFonts.notoSerif(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
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
                      ],
                    ),
                  ),
                ],
              )
            : // ===== МОБИЛЬНАЯ ВЕРСИЯ =====
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(_txt('platforms')),
                    const SizedBox(height: 10),
                    _buildTypeCard(
                      _txt('type_telegram'),
                      Icons.telegram,
                      _isTelegram,
                      () => setState(() => _isTelegram = !_isTelegram),
                      180,
                      const Color(0xFF0088CC),
                    ),
                    const SizedBox(height: 8),
                    _buildTypeCard(
                      _txt('type_whatsapp'),
                      Icons.chat,
                      _isWhatsApp,
                      () => setState(() => _isWhatsApp = !_isWhatsApp),
                      220,
                      const Color(0xFF25D366),
                    ),
                    const SizedBox(height: 8),
                    _buildTypeCard(
                      _txt('type_ai'),
                      Icons.auto_awesome,
                      _isAI,
                      () => setState(() => _isAI = !_isAI),
                      300,
                      Colors.purpleAccent,
                    ),
                    const SizedBox(height: 8),
                    _buildTypeCard(
                      _txt('type_multi'),
                      Icons.hub_outlined,
                      _isMulti,
                      () => setState(() => _isMulti = !_isMulti),
                      350,
                      Colors.deepPurpleAccent,
                    ),

                    const SizedBox(height: 24),
                    _sectionTitle(_txt('complexity')),
                    const SizedBox(height: 10),
                    ...List.generate(complexityOptions.length, (index) {
                      final option = complexityOptions[index];
                      final isSelected = _selectedComplexity == index;
                      return _buildComplexityCard(
                        option['title'] as String,
                        option['subtitle'] as String,
                        option['priceUSD'] as int,
                        isSelected,
                        () => setState(
                          () => _selectedComplexity = isSelected ? -1 : index,
                        ),
                      );
                    }),

                    const SizedBox(height: 24),
                    _sectionTitle(_txt('features')),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _featureKeys.map((key) {
                        final isSelected = _features[key]!;
                        return _buildFeatureChip(
                          _txt('feat_$key'),
                          isSelected,
                          _featurePricesUSD[key]!,
                          (val) =>
                              setState(() => _features[key] = val ?? false),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 28),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1F1F2C), Color(0xFF13131A)],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.cyanAccent.withAlpha(80),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _txt('budget'),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '~ ${_getFormattedPrice()}',
                            style: GoogleFonts.notoSerif(
                              color: Colors.cyanAccent,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _txt('deadline'),
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: _showSubmitModal,
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                        label: Text(
                          _txt('sendBtn'),
                          style: GoogleFonts.notoSerif(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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

  // ===== UI Helpers =====

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.notoSerif(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTypeCard(
    String title,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
    int priceUSD,
    Color accentColor,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? accentColor.withValues(alpha: .15)
              : const Color(0xFF181820),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? accentColor : Colors.white10,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? accentColor : Colors.white54,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            Text(
              '+\$$priceUSD',
              style: TextStyle(
                color: isSelected ? accentColor : Colors.white38,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplexityCard(
    String title,
    String subtitle,
    int priceUSD,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.cyanAccent.withValues(alpha: .12)
              : const Color(0xFF181820),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.cyanAccent : Colors.white10,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.cyanAccent : Colors.white38,
              size: 20,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              '+\$$priceUSD',
              style: TextStyle(
                color: isSelected ? Colors.cyanAccent : Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureChip(
    String title,
    bool isSelected,
    int priceUSD,
    ValueChanged<bool?> onChanged,
  ) {
    return FilterChip(
      selected: isSelected,
      onSelected: onChanged,
      backgroundColor: const Color(0xFF181820),
      selectedColor: Colors.cyanAccent.withValues(alpha: .18),
      checkmarkColor: Colors.cyanAccent,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 12.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '+\$$priceUSD',
            style: TextStyle(
              color: isSelected ? Colors.cyanAccent : Colors.white38,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.cyanAccent : Colors.white10,
        ),
      ),
    );
  }
}

