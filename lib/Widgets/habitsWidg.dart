import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Models/colors.dart';
import 'package:habit_tracker/Models/habit.dart';
import 'package:habit_tracker/Pages/habit_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:habit_tracker/feedBacks/haptics.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

// ignore: must_be_immutable
class HabitWidg extends StatefulWidget {
  late Habit habit;

  final int ind;

  HabitWidg({
    Key? key,
    required this.habit,
    required this.ind,
  }) : super(key: key);

  @override
  State<HabitWidg> createState() => _HabitWidgState();
}

class _HabitWidgState extends State<HabitWidg> with TickerProviderStateMixin {
  Timer? _timer;
  var customTheme = Theme(
    data: ThemeData(primaryColor: Colors.blue),
    child: const Text("lol"),
  );

  String makeTime(int time) {
    if (time <= 60) {
      return '${time}min';
    } else {
      var ans = time / 60;
      return '${ans.toStringAsFixed(1)}hr';
    }
  }

  String makeAmount(int amount) {
    if (amount <= 500) {
      return '$amount min';
    } else {
      var ans = amount / 1000;
      return '${ans.toStringAsFixed(1)}L';
    }
  }

  late final AnimationController amc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    amc = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    amc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final AnimationController amc = AnimationController(
    //vsync: this, duration: const Duration(milliseconds: 300));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => MainHabitPage(
                    ind: widget.ind,
                  ))));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          curve: Curves.easeInOutCubic,
          padding: const EdgeInsets.all(5),
          width: 170,
          height: 100,
          decoration: BoxDecoration(
            boxShadow: habits[widget.ind].isGoing
                ? [
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 10,
                      color: Colors.green.shade200,
                    )
                  ]
                : [
                    BoxShadow(
                      spreadRadius: 0,
                      //blurRadius: 10,
                      color: Colors.red.shade200,
                    )
                  ],
            color: Theme.of(context).backgroundColor, //CupertinoColors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 66,
                    width: 66,
                    child: widget.habit.isTime
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularPercentIndicator(
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: widget.habit.getPercentD() < 0.4
                                    ? progColors[0]
                                    : widget.habit.getPercentD() < 0.75
                                        ? progColors[2]
                                        : progColors[3],
                                radius: 33,
                                percent: widget.habit.getPercentD(),
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: colors[widget.habit.color],
                              ),
                              Icon(
                                icons[widget.habit.icon],
                                size: 30,
                                color: CupertinoColors.white,
                              )
                            ],
                          )
                        : LiquidCircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.blue,
                            ),
                            value: (widget.habit.prog / widget.habit.goal),
                          ),
                  ),
                  //!Woriking on this one at the moment
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      width: 73,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context)
                              .primaryColorLight), //CupertinoColors.darkBackgroundGray),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            CupertinoIcons.time,
                            color: CupertinoColors.inactiveGray,
                          ),
                          Text(
                            (widget.habit.type == 1)
                                ? makeTime(widget.habit.goal)
                                : makeAmount(widget.habit.goal),
                            style: const TextStyle(
                              color: CupertinoColors.inactiveGray,
                            ),
                          )
                        ],
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.habit.name,
                    style: const TextStyle(
                        //color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  widget.habit.type == 1
                      ? GestureDetector(
                          onTap: () {
                            if (habits[widget.ind].isGoing) {
                              amc.reverse();

                              onpausetHaptic();

                              setState(() {
                                habits[widget.ind].isGoing = false;
                              });

                              stopTimer();
                            } else {
                              amc.forward();

                              onStartHaptic();
                              startTimer();
                              setState(() {
                                habits[widget.ind].isGoing = true;
                              });
                            }
                          },
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            color: habits[widget.ind].isGoing
                                ? CupertinoColors.systemRed
                                : CupertinoColors.activeGreen,
                            size: 28,
                            progress: amc,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              habits[widget.ind].prog += 250;
                            });
                          },
                          child: const Icon(
                            Icons.water,
                            color: Colors.lightBlue,
                          ),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        habits[widget.ind].prog += 1;
      });

      print(habits[widget.ind].prog);
    });
  }

  void stopTimer() {
    _timer!.cancel();
  }
}


