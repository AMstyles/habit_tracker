import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Models/colors.dart';
import 'package:habit_tracker/Models/dark_light.dart';
import 'package:habit_tracker/Pages/home.dart';
import 'package:habit_tracker/services/tasks_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'Helpers/boxes.dart';
import 'Models/task.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  tasksBox = await Hive.openBox<Task>('tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeController()),
      ChangeNotifierProvider(create: (context) => TaskProvider(),)
    ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeController>(context);
        return MaterialApp(
          themeMode: themeProvider.currTheme,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
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

          ),

          //!dark mode theme data
          darkTheme: ThemeData.dark().copyWith(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: CupertinoColors.darkBackgroundGray,
              primaryColorDark: CupertinoColors.lightBackgroundGray,
              primaryColorLight: CupertinoColors.black,
              scaffoldBackgroundColor: CupertinoColors.black),
          home: const HomePage(),

        );
      });
}
