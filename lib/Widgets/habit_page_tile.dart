import 'package:animated_page_transition/animated_page_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/Models/colors.dart';
import 'package:habit_tracker/Models/habit.dart';
import 'package:habit_tracker/Pages/habit_page.dart';
import 'package:habit_tracker/Pages/weather.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class HabitsPageTile extends StatefulWidget {
  late Habit habit;
  late int ind;
  HabitsPageTile({Key? key, required this.habit, required this.ind})
      : super(key: key);

  @override
  State<HabitsPageTile> createState() => _HabitsPageTileState();
}

class _HabitsPageTileState extends State<HabitsPageTile>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Slidable(
        endActionPane: ActionPane(
          //extentRatio: ,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 1,
              onPressed: ((context) => print("hello")),
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.done,
              label: 'Done',
            ),
            SlidableAction(
              onPressed: ((context) => print("hello")),
              backgroundColor: CupertinoColors.destructiveRed,
              foregroundColor: Colors.white,
              icon: Icons.delete_forever,
              label: 'Delete',
            ),
          ],
        ),
        child: Hero(
          tag: habits[widget.ind].name,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => MainHabitPage(ind: widget.ind))));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              height: 100,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Stack(alignment: Alignment.center, children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: colors[widget.habit.color],
                            ),
                            Icon(
                              icons[widget.habit.icon],
                              color: Colors.white,
                              size: 30,
                            )
                          ]),
                        ],
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.habit.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            Text(
                              '${widget.habit.prog} / ${widget.habit.goal}',
                              style: const TextStyle(
                                  color: CupertinoColors.inactiveGray),
                            ),
                          ],
                        ),
                      ),
                      CupertinoButton(
                          child: const Icon(CupertinoIcons.pen),
                          onPressed: () {})
                    ],
                  ),
                  LinearPercentIndicator(
                    lineHeight: 6,
                    trailing: Text(
                      '${(habits[widget.ind].getPercentD() * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    clipLinearGradient: true,
                    barRadius: const Radius.circular(15),
                    addAutomaticKeepAlive: true,
                    linearGradient: const LinearGradient(
                      colors: <Color>[
                        Colors.red,
                        Colors.amber,
                        Colors.yellow,
                        Colors.lightGreen,
                        Colors.green,
                      ],
                      tileMode: TileMode.mirror,
                    ),
                    //circularStrokeCap: CircularStrokeCap.round,
                    animateFromLastPercent: true,
                    curve: Curves.easeInOutCubic,
                    animationDuration: 3000,
                    animation: true,
                    percent: widget.habit.getPercentD(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
