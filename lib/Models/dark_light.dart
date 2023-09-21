import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeController extends ChangeNotifier {

  List<ThemeMode> themeModes = [
    ThemeMode.dark,
    ThemeMode.light,
    ThemeMode.system
  ];

  late ThemeMode currTheme;

  late bool isDark;

  ThemeController() {
    currTheme = ThemeMode.system;
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    isDark = isDarkMode;
  }

  void toggleDark() {
    if (isDark) {
      currTheme = themeModes[1];
      isDark = !isDark;
    } else {
      currTheme = themeModes[0];
      isDark = !isDark;
    }
    notifyListeners();
  }
}
