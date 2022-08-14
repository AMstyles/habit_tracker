import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Models/dark_light.dart';
import 'package:provider/provider.dart';

class Switcher extends StatefulWidget {
  Switcher({Key? key, required this.callback}) : super(key: key);

  VoidCallback callback;

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);
    return DayNightSwitcher(
        isDarkModeEnabled: themeProvider.isDark,
        onStateChanged: (newBool) {
          final provider = Provider.of<ThemeController>(context, listen: false);
          provider.toggleDark();
        });
  }
}

class SwitcherMini extends StatefulWidget {
  const SwitcherMini({Key? key, required this.callback}) : super(key: key);

  final VoidCallback callback;

  @override
  State<SwitcherMini> createState() => _SwitcherMiniState();
}

class _SwitcherMiniState extends State<SwitcherMini> {
  @override
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);
    return DayNightSwitcherIcon(
        isDarkModeEnabled: themeProvider.isDark,
        onStateChanged: (newBool) {
          final provider = Provider.of<ThemeController>(context, listen: false);
          provider.toggleDark();

          widget.callback();
        });
  }
}
