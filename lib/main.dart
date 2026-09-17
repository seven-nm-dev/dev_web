import 'package:dev_web/pages/bots_page.dart';
import 'package:dev_web/pages/home_page.dart';
import 'package:dev_web/pages/mobile_page.dart';
import 'package:dev_web/pages/settings_page.dart';
import 'package:dev_web/pages/web_page.dart';
import 'package:dev_web/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/mobile',
      builder: (context, state) => const MobilePage(),
    ),
    GoRoute(
      path: '/bots',
      builder: (context, state) => const BotPage(),
    ),
    GoRoute(
      path: '/web',
      builder: (context, state) => const WebPage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageProvider(),
      builder: (context, child) {
        return MaterialApp.router(
          title: LanguageProvider().getText('app_title'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF0D0D11),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF02569B),
              secondary: Colors.cyanAccent,
            ),
          ),
          routerConfig: _router,
        );
      },
    );
  }
}