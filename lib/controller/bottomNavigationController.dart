import 'package:flutter/foundation.dart';

import '../views/screens/adhyayPage.dart';
import '../views/screens/favPage.dart';

class BottomNavigationController extends ChangeNotifier {
  int selectedIndex = 0;

  onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  List allScreen = const [
    AdyayPage(),
    favPage(),
  ];
}
