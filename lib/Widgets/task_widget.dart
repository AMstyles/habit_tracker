import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Models/colors.dart';
import 'package:flutter/services.dart';

import '../Models/task.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
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
                  value: widget.task.isCompleted,
                  onChanged: (val) {
                    onTick();
                    setState(() {
                      widget.task.isCompleted = val!;
                    });
                  },
                  checkColor: CupertinoColors.white,
                  fillColor: MaterialStateProperty.all<Color>(
                      colors[widget.task.color]),
                ),
                Text(
                  widget.task.name,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const Spacer(),
                 Text('${widget.task.time.hour}:${widget.task.time.minute}')
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
