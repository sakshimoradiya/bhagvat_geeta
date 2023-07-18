import 'package:bhagvat_geeta/controller/bottomNavigationController.dart';
import 'package:bhagvat_geeta/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bhagvat_geeta/controller/language_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic languageProvider = Provider.of<LanguageController>(context);
    return Consumer<BottomNavigationController>(
        builder: (context, provider, _) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: languageProvider.isHindi ? "घर" : "Home",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border_rounded),
              label: languageProvider.isHindi ? "पसंदीदा" : "Favourite",
            ),
          ],
          currentIndex: provider.selectedIndex,
          onTap: (index) {
            provider.onItemTapped(index);
          },
          selectedItemColor: Provider.of<ThemeController>(context).isDark
              ? Colors.yellow
              : Colors.black,
          unselectedItemColor: Colors.grey,
        ),
        body: provider.allScreen.elementAt(provider.selectedIndex),
      );
    });
  }
}
