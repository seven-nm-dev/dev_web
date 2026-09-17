import 'package:dev_web/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class WebCalculatorPage extends StatefulWidget {
  const WebCalculatorPage({super.key});

  @override
  State<WebCalculatorPage> createState() => _WebCalculatorPageState();
}

class _WebCalculatorPageState extends State<WebCalculatorPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedLang = 'RU';
  String _selectedCurrency = 'KGS';

  final Map<String, Map<String, String>> _i18n = {
    'RU': {
      'title': 'Калькулятор Веб-сайта',
      'platforms': '1. Тип веб-ресурса',
      'design': '2. Дизайн & Верстка',
      'features': '3. Функционал & Интеграции',
      'budget': 'Ориентировочный бюджет',
      'deadline': 'Сроки разработки: от 1 до 4 недель',
      'sendBtn': 'Отправить расчёт разработчику',
      'modalTitle': 'Оформление заявки',
      'modalSub': 'Укажите контакты для детальной сметы:',
      'nameLabel': 'Ваше имя *',
      'companyLabel': 'Компания / Проект',
      'phoneLabel': 'Телефон / WhatsApp *',
      'sendTelegram': 'Отправить в Telegram',
      'sendWhatsApp': 'Отправить в WhatsApp',
      'design0_title': 'Шаблонный / Адаптивный',
      'design0_sub': 'Быстрый запуск на готовых компонентах',
      'design1_title': 'Уникальный UX/UI',
      'design1_sub': 'Индивидуальный дизайн в Figma',
      'design2_title': 'Премиум / WebGL 3D',
      'design2_sub': 'Сложная анимация и интерактивность',
      'selectOptionsAlert': 'Выберите хотя бы тип сайта или один модуль!',
      'errNameRequired': 'Введите ваше имя',
      'errNameShort': 'Имя должно быть не короче 2 символов',
      'errPhoneRequired': 'Введите номер телефона',
      'errPhoneInvalid': 'Некорректный номер (напр. +996 550 123 456)',
      'type_landing': 'Landing Page (Одностраничник)',
      'type_corporate': 'Корпоративный сайт',
      'type_ecommerce': 'Интернет-магазин (E-Commerce)',
      'feat_admin': 'Админ-панель (CMS управления контентом)',
      'feat_payment': 'Онлайн-оплата (Оптима, Элкарт, Stripe, Visa)',
      'feat_seo': 'SEO-оптимизация & Подключение аналитики',
      'feat_multilang': 'Мультиязычность сайта (RU / KG / EN)',
      'feat_catalog': 'Каталог с фильтрами и поиском',
      'feat_crm': 'Интеграция с CRM / 1С / МойСклад',
      'feat_forms': 'Формы обратной связи и онлайн-чат',
      'feat_profile': 'Личный кабинет покупателя / профиль',
    },
    'KG': {
      'title': 'Веб-сайт калькулятору',
      'platforms': '1. Веб-ресурс түрү',
      'design': '2. Дизайн & Верстка',
      'features': '3. Функционал & Интеграция',
      'budget': 'Болжолдуу бюджет',
      'deadline': 'Иштеп чыгуу мөөнөтү: 1ден 4 жумага чейин',
      'sendBtn': 'Эсептөөнү жөнөтүү',
      'modalTitle': 'Өтүнмөнү тариздөө',
      'modalSub': 'Байланыш маалыматыңызды калтырыңыз:',
      'nameLabel': 'Атыңыз *',
      'companyLabel': 'Компания / Долбоор',
      'phoneLabel': 'Телефон / WhatsApp *',
      'sendTelegram': 'Telegram аркылуу',
      'sendWhatsApp': 'WhatsApp аркылуу',
      'design0_title': 'Шаблондук / Адаптивдүү',
      'design0_sub': 'Даяр компоненттер менен тез иштетүү',
      'design1_title': 'Уникалдуу UX/UI',
      'design1_sub': 'Figma\'да жеке дизайн',
      'design2_title': 'Премиум / WebGL 3D',
      'design2_sub': 'Татаал анимация жана интерактивдүүлүк',
      'selectOptionsAlert': 'Сураныч, сайтын түрүн же функция тандаңыз!',
      'errNameRequired': 'Атыңызды киргизиңиз',
      'errNameShort': 'Атыңыз кеминде 2 символ болушу керек',
      'errPhoneRequired': 'Телефон номериңизди киргизиңиз',
      'errPhoneInvalid': 'Туура эмес номер (мис. +996 550 123 456)',
      'type_landing': 'Landing Page (Бир беттик сайт)',
      'type_corporate': 'Корпоративдик сайт',
      'type_ecommerce': 'Интернет-дүкөн (E-Commerce)',
      'feat_admin': 'Админ-панель (CMS контентти башкаруу)',
      'feat_payment': 'Онлайн төлөм (Оптима, Элкарт, Stripe, Visa)',
      'feat_seo': 'SEO оптималдаштыруу жана аналитика',
      'feat_multilang': 'Көп тилдүүлүк (RU / KG / EN)',
      'feat_catalog': 'Чыпкалар жана издөө менен каталог',
      'feat_crm': 'CRM / 1С / МойСклад менен интеграция',
      'feat_forms': 'Кайтарым байланыш формалары жана чат',
      'feat_profile': 'Сатып алуучунун жеке кабинети',
    },
    'EN': {
      'title': 'Web Calculator',
      'platforms': '1. Website Type',
      'design': '2. Design & Layout',
      'features': '3. Features & Integrations',
      'budget': 'Estimated Budget',
      'deadline': 'Development time: 1 to 4 weeks',
      'sendBtn': 'Send calculation to dev',
      'modalTitle': 'Submit Request',
      'modalSub': 'Leave contacts for a detailed proposal:',
      'nameLabel': 'Your Name *',
      'companyLabel': 'Company / Project',
      'phoneLabel': 'Phone / WhatsApp *',
      'sendTelegram': 'Send via Telegram',
      'sendWhatsApp': 'Send via WhatsApp',
      'design0_title': 'Template / Responsive',
      'design0_sub': 'Fast launch with ready components',
      'design1_title': 'Custom UX/UI',
      'design1_sub': 'Tailored Figma design',
      'design2_title': 'Premium / WebGL 3D',
      'design2_sub': 'Advanced animations & 3D',
      'selectOptionsAlert': 'Please select at least a type or one feature!',
      'errNameRequired': 'Please enter your name',
      'errNameShort': 'Name must be at least 2 characters',
      'errPhoneRequired': 'Please enter phone number',
      'errPhoneInvalid': 'Invalid number (e.g. +996 550 123 456)',
      'type_landing': 'Landing Page',
      'type_corporate': 'Corporate Website',
      'type_ecommerce': 'E-Commerce Store',
      'feat_admin': 'Admin Panel (CMS)',
      'feat_payment': 'Online Payments (Optima, Elcart, Stripe, Visa)',
      'feat_seo': 'SEO Optimization & Analytics',
      'feat_multilang': 'Multilingual (RU / KG / EN)',
      'feat_catalog': 'Catalog with Filters & Search',
      'feat_crm': 'CRM / 1C / MoySklad Integration',
      'feat_forms': 'Contact Forms & Live Chat',
      'feat_profile': 'Customer Personal Account',
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

  bool _isLanding = false;
  bool _isCorporate = false;
  bool _isECommerce = false;

  int _selectedDesignIndex = -1;

  final List<String> _featureKeys = [
    'admin',
    'payment',
    'seo',
    'multilang',
    'catalog',
    'crm',
    'forms',
    'profile',
  ];

  final Map<String, bool> _features = {
    'admin': false,
    'payment': false,
    'seo': false,
    'multilang': false,
    'catalog': false,
    'crm': false,
    'forms': false,
    'profile': false,
  };

  final Map<String, int> _featurePricesUSD = {
    'admin': 250,
    'payment': 200,
    'seo': 150,
    'multilang': 120,
    'catalog': 200,
    'crm': 300,
    'forms': 80,
    'profile': 220,
  };

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  int _calculateTotalUSD() {
    bool hasType = _isLanding || _isCorporate || _isECommerce;
    bool hasFeature = _features.values.contains(true);
    if (!hasType && _selectedDesignIndex == -1 && !hasFeature) return 0;

    int typePrice = 0;
    if (_isLanding) typePrice += 150;
    if (_isCorporate) typePrice += 350;
    if (_isECommerce) typePrice += 500;

    List<int> designPrices = [100, 300, 600];
    int designPrice = _selectedDesignIndex != -1
        ? designPrices[_selectedDesignIndex]
        : 0;

    int featuresPrice = 0;
    _features.forEach((key, val) {
      if (val) featuresPrice += _featurePricesUSD[key] ?? 0;
    });

    return typePrice + designPrice + featuresPrice;
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
    if (_isLanding) types.add(_txt('type_landing'));
    if (_isCorporate) types.add(_txt('type_corporate'));
    if (_isECommerce) types.add(_txt('type_ecommerce'));

    List<String> designNames = [
      _txt('design0_title'),
      _txt('design1_title'),
      _txt('design2_title'),
    ];
    String designName = _selectedDesignIndex != -1
        ? designNames[_selectedDesignIndex]
        : '—';

    List<String> selectedFeatures = [];
    _features.forEach((key, val) {
      if (val) selectedFeatures.add('• ${_txt('feat_$key')}');
    });

    return '''
🌐 *ЗАЯВКА НА ВЕБ-САЙТ / WEB REQUEST*

👤 *Клиент / Client:* ${_nameController.text.trim()}
🏢 *Компания / Company:* ${_companyController.text.trim().isEmpty ? '—' : _companyController.text.trim()}
📞 *Телефон / Phone:* ${_phoneController.text.trim()}

💻 *Тип сайта / Type:* ${types.isEmpty ? '—' : types.join(', ')}
🎨 *Дизайн / Design:* $designName
💰 *Бюджет / Budget:* ${_getFormattedPrice()}

⚙️ *Функции / Features:*
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
        prefixIcon: Icon(icon, color: Colors.indigoAccent, size: 18),
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
          borderSide: const BorderSide(color: Colors.indigoAccent, width: 1.5),
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

    final designOptions = [
      {
        'title': _txt('design0_title'),
        'subtitle': _txt('design0_sub'),
        'priceUSD': 100,
      },
      {
        'title': _txt('design1_title'),
        'subtitle': _txt('design1_sub'),
        'priceUSD': 300,
      },
      {
        'title': _txt('design2_title'),
        'subtitle': _txt('design2_sub'),
        'priceUSD': 600,
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
            color: Colors.indigoAccent,
            size: 18,
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          ),
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
              color: Colors.indigoAccent,
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
                            _txt('type_landing'),
                            Icons.web,
                            _isLanding,
                            () => setState(() => _isLanding = !_isLanding),
                            150,
                          ),
                          const SizedBox(height: 10),
                          _buildTypeCard(
                            _txt('type_corporate'),
                            Icons.business,
                            _isCorporate,
                            () => setState(() => _isCorporate = !_isCorporate),
                            350,
                          ),
                          const SizedBox(height: 10),
                          _buildTypeCard(
                            _txt('type_ecommerce'),
                            Icons.shopping_cart,
                            _isECommerce,
                            () => setState(() => _isECommerce = !_isECommerce),
                            500,
                          ),

                          const SizedBox(height: 28),
                          _sectionTitle(_txt('design')),
                          const SizedBox(height: 12),
                          ...List.generate(designOptions.length, (index) {
                            final option = designOptions[index];
                            final isSelected = _selectedDesignIndex == index;
                            return _buildDesignCard(
                              option['title'] as String,
                              option['subtitle'] as String,
                              option['priceUSD'] as int,
                              isSelected,
                              () => setState(
                                () => _selectedDesignIndex = isSelected
                                    ? -1
                                    : index,
                              ),
                            );
                          }),

                          const SizedBox(height: 28),
                          _sectionTitle(_txt('features')),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
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
                              color: Colors.indigoAccent.withAlpha(80),
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
                                  color: Colors.indigoAccent,
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
                              color: Colors.white,
                              size: 20,
                            ),
                            label: Text(
                              _txt('sendBtn'),
                              style: GoogleFonts.notoSerif(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
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
                    const SizedBox(height: 8),
                    _buildTypeCard(
                      _txt('type_landing'),
                      Icons.web,
                      _isLanding,
                      () => setState(() => _isLanding = !_isLanding),
                      150,
                    ),
                    const SizedBox(height: 8),
                    _buildTypeCard(
                      _txt('type_corporate'),
                      Icons.business,
                      _isCorporate,
                      () => setState(() => _isCorporate = !_isCorporate),
                      350,
                    ),
                    const SizedBox(height: 8),
                    _buildTypeCard(
                      _txt('type_ecommerce'),
                      Icons.shopping_cart,
                      _isECommerce,
                      () => setState(() => _isECommerce = !_isECommerce),
                      500,
                    ),
                    const SizedBox(height: 20),
                    _sectionTitle(_txt('design')),
                    const SizedBox(height: 8),
                    ...List.generate(designOptions.length, (index) {
                      final option = designOptions[index];
                      final isSelected = _selectedDesignIndex == index;
                      return _buildDesignCard(
                        option['title'] as String,
                        option['subtitle'] as String,
                        option['priceUSD'] as int,
                        isSelected,
                        () => setState(
                          () => _selectedDesignIndex = isSelected ? -1 : index,
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    _sectionTitle(_txt('features')),
                    const SizedBox(height: 8),
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
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1F1F2C), Color(0xFF13131A)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.indigoAccent.withAlpha(80),
                        ),
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
                              color: Colors.indigoAccent,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _showSubmitModal,
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: Text(
                          _txt('sendBtn'),
                          style: GoogleFonts.notoSerif(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
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
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.indigoAccent.withAlpha(30)
              : const Color(0xFF181820),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.indigoAccent : Colors.white10,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? Colors.indigoAccent : Colors.white54,
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
                color: isSelected ? Colors.indigoAccent : Colors.white38,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesignCard(
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
              ? Colors.indigoAccent.withAlpha(30)
              : const Color(0xFF181820),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.indigoAccent : Colors.white10,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.indigoAccent : Colors.white38,
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
                color: isSelected ? Colors.indigoAccent : Colors.white70,
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
      selectedColor: Colors.indigoAccent.withAlpha(40),
      checkmarkColor: Colors.indigoAccent,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '+\$$priceUSD',
            style: TextStyle(
              color: isSelected ? Colors.indigoAccent : Colors.white38,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.indigoAccent : Colors.white10,
        ),
      ),
    );
  }
}
