import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Widgets/light_night_experiment.dart';
import 'package:provider/provider.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Dark/Light modes'),
          actions: [
            SwitcherMini(
              callback: () {},
            )
          ],
        ),
        drawer: SafeArea(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60),
                  bottomRight: Radius.circular(60)),
            ),
            child: Drawer(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DrawerHeader(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset('lib/Assets/XTlabel.png'),
                          const Text(
                            "E X P E R I M E N T A L",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'ThemeMode',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Switcher(
                        callback: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/Assets/tt.png',
                  height: 70,
                  width: 70,
                ),
                const SizedBox(
                  width: 15,
                ),
                Image.asset(
                  'lib/Assets/ig.png',
                  height: 70,
                  width: 70,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              '@am_stylesrsa',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        )));
  }
}
