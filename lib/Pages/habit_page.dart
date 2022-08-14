import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_tracker/Models/habit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rive/rive.dart' as Rive;

class MainHabitPage extends StatefulWidget {
  final int ind;
  const MainHabitPage({Key? key, required this.ind}) : super(key: key);

  @override
  State<MainHabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<MainHabitPage> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration(seconds: 8), () {
      setState(() {
        isLoading = true;
      });
    });
  }

  int cheat = 5;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: habits[widget.ind].name,
      child: Scaffold(
        //backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(habits[widget.ind].name),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            isLoading
                ? const Positioned(
                    child: Rive.RiveAnimation.asset(
                      'lib/Assets/milkshake_bomb.riv',
                      fit: BoxFit.cover,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        CircularProgressIndicator.adaptive(),
                        Text('wait for it...'),
                      ],
                    ),
                  ),
            DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0),
                  ])),
              child: ListView(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    center: const Text(
                      '25:41',
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                    addAutomaticKeepAlive: false,
                    linearGradient: const LinearGradient(
                      colors: <Color>[
                        Colors.green,
                        Colors.lightGreen,
                        Colors.yellow,
                        Colors.amber,
                        Colors.red,
                      ],
                      tileMode: TileMode.mirror,
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    animateFromLastPercent: true,
                    curve: Curves.easeInOutCubic,
                    animationDuration: 3000,
                    animation: true,
                    lineWidth: 10,
                    radius: 150,
                    percent: habits[widget.ind].getPercentD(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                      child: Text(
                    'Summary',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createAnimation() {
    bool flag = false;
    Timer timer = Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        if (cheat > 0) {
          cheat--;
        } else {
          flag = true;
          timer.cancel();
        }
      },
    );

    return const Positioned(
      child: Rive.RiveAnimation.asset(
        'lib/Assets/milkshake_bomb.riv',
        fit: BoxFit.cover,
      ),
    );
  }
}
