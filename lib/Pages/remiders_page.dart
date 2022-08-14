import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Models/reminder.dart';
import 'package:habit_tracker/Pages/scheduled.dart';
import 'package:habit_tracker/Pages/today.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({Key? key}) : super(key: key);

  @override
  State<HabitPage> createState() => _RemindersPage();
}

class _RemindersPage extends State<HabitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: CupertinoColors.activeBlue),
          elevation: 0,
          backgroundColor: Colors.grey.shade200,
          actions: [
            CupertinoButton(child: const Text('Edit'), onPressed: () {})
          ]),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 8),
        child: Column(
          children: [
            CupertinoSearchTextField(
              borderRadius: BorderRadius.circular(15),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.count(
                childAspectRatio: 4 / 2.3,
                shrinkWrap: true,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TodayPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: CupertinoColors.activeBlue,
                                child: Icon(
                                  CupertinoIcons.calendar_today,
                                  color: CupertinoColors.white,
                                  //size: 42,
                                ),
                              ),
                              Text(
                                '3',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const Hero(
                            transitionOnUserGestures: true,
                            tag: 'tod',
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                'Today',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: CupertinoColors.inactiveGray),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (contex) => const ScheduledPage())),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                CupertinoIcons.calendar_circle_fill,
                                color: CupertinoColors.systemRed,
                                size: 42,
                              ),
                              Text(
                                '8',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const Hero(
                            transitionOnUserGestures: true,
                            tag: 'sche',
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                'Scheduled',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: CupertinoColors.inactiveGray),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            /*Icon(
                              CupertinoIcons.tray,
                              color: CupertinoColors.systemGrey,
                              size: 42,
                            ),*/
                            CircleAvatar(
                              backgroundColor: CupertinoColors.systemGrey,
                              radius: 19,
                              child: Icon(
                                CupertinoIcons.tray_fill,
                                color: CupertinoColors.white,
                                //size: 42,
                              ),
                            ),
                            Text(
                              '12',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const Hero(
                          tag: 'al',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              'All',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                  color: CupertinoColors.inactiveGray),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              CupertinoIcons.flag_circle_fill,
                              color: CupertinoColors.systemOrange,
                              size: 42,
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const Text(
                          'Flagged',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: CupertinoColors.inactiveGray),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              child: Row(
                children: const [
                  Hero(
                    tag: 'fab',
                    child: Icon(
                      CupertinoIcons.add_circled_solid,
                      size: 29,
                      color: CupertinoColors.activeBlue,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'New Reminder',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.activeBlue),
                  ),
                ],
              ),
              onPressed: () => showModalBottomSheet(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                isScrollControlled: true,
                isDismissible: false,
                context: context,
                builder: (context) => buildSheet(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSheet() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController noteController = TextEditingController();
    String? name;
    String? description;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: ListView(
          controller: scrollController,
          children: [
            AppBar(
              title: const Text(
                'New Task',
                style: TextStyle(color: CupertinoColors.black),
              ),
              iconTheme: const IconThemeData(color: CupertinoColors.activeBlue),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                CupertinoButton(
                    onPressed: () {
                      addNewTask(name);
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: CupertinoColors.activeBlue),
                    ))
              ],
            ),
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  CupertinoTextField(
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    padding: const EdgeInsets.all(8),
                    placeholder: 'Name',
                    controller: nameController,
                  ),
                  CupertinoTextField(
                    expands: true,
                    padding: const EdgeInsets.all(8),
                    controller: noteController,
                    placeholder: 'note to self',
                    minLines: null,
                    maxLines: null,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void addNewTask(String? name) {
    reminders.add(Reminder(name!, false, 1));
    Navigator.pop(context);
  }
}
