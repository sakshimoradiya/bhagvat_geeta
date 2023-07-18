import 'package:bhagvat_geeta/controller/bottomNavigationController.dart';
import 'package:bhagvat_geeta/controller/chapter_controller.dart';
import 'package:bhagvat_geeta/controller/favorite_controller.dart';
import 'package:bhagvat_geeta/controller/language_controller.dart';
import 'package:bhagvat_geeta/controller/theme_controller.dart';
import 'package:bhagvat_geeta/controller/verses_controller.dart';
import 'package:bhagvat_geeta/helper/app_theme.dart';
import 'package:bhagvat_geeta/views/screens/detailPage.dart';
import 'package:bhagvat_geeta/views/screens/favPage.dart';
import 'package:bhagvat_geeta/views/screens/homePage.dart';
import 'package:bhagvat_geeta/views/screens/shlokaDetail.dart';
import 'package:bhagvat_geeta/views/screens/splashPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChapterController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavigationController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => VersesController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Provider.of<ThemeController>(context).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: 'splash_screen',
      routes: {
        '/': (context) => const HomePage(),
        'splashPage': (context) => const SplashPage(),
        'detailaPage': (context) => DetailPage(),
        'shlokaDetail': (context) => const ShlokaDetail(),
        'favPage': (context) => const favPage(),
      },
    );
  }
}
