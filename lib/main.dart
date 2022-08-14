import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Models/colors.dart';
import 'package:habit_tracker/Models/dark_light.dart';
import 'package:habit_tracker/Pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeController(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeController>(context);
        return MaterialApp(
          themeMode: themeProvider.currTheme,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              iconTheme: IconThemeData(color: Colors.black),
            ),
            backgroundColor: colorCustom,
            primaryColorLight: CupertinoColors.lightBackgroundGray,
            scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray,
            accentColor: Colors.lightBlueAccent,
          ),

          //!dark mode theme data
          darkTheme: ThemeData.dark().copyWith(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: CupertinoColors.darkBackgroundGray,
              primaryColorDark: CupertinoColors.lightBackgroundGray,
              primaryColorLight: CupertinoColors.black,
              accentColor: Colors.grey.shade900,
              scaffoldBackgroundColor: CupertinoColors.black),
          home: const HomePage(),
        );
      });
}
