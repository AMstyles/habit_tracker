import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Models/colors.dart';
import 'package:habit_tracker/Models/reminder.dart';
import 'package:flutter/services.dart';

class HomeTaskTile extends StatefulWidget {
  late int index;
  HomeTaskTile({Key? key, required this.index}) : super(key: key);

  @override
  State<HomeTaskTile> createState() => _HomeTaskTileState();
}

class _HomeTaskTileState extends State<HomeTaskTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
      child: Container(
        padding: const EdgeInsets.only(right: 8),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).backgroundColor,
        ), //Colors.white),
        child: Center(
            child: Row(
          children: [
            Checkbox(
              shape: const CircleBorder(side: BorderSide.none),
              value: reminders[widget.index].isDone,
              onChanged: (val) {
                onTick();
                setState(() {
                  reminders[widget.index].isDone = val!;
                });
              },
              checkColor: CupertinoColors.white,
              fillColor: MaterialStateProperty.all<Color>(
                  colors[reminders[widget.index].color]),
            ),
            Text(
              reminders[widget.index].name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const Spacer(),
            const Text('17:00')
          ],
        )),
      ),
    );
  }

  void onTick() {
    HapticFeedback.lightImpact();
    Future.delayed(const Duration(milliseconds: 200), (() {
      HapticFeedback.selectionClick();
    }));
  }
}
