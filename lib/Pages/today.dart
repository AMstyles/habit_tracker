import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodayPage extends StatefulWidget {
  TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: CupertinoColors.activeBlue),
        elevation: 0,
        title: const Hero(
          tag: 'list',
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              'Lists',
              style: TextStyle(color: CupertinoColors.activeBlue),
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade200,
        actions: [
          CupertinoButton(
              child: const Icon(CupertinoIcons.ellipsis_circle),
              onPressed: () {})
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            Hero(
                transitionOnUserGestures: true,
                tag: 'tod',
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    "Today",
                    style: TextStyle(
                        fontSize: 34,
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ))
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
                    Icon(
                      CupertinoIcons.add_circled_solid,
                      size: 29,
                      color: CupertinoColors.activeBlue,
                    ),
                    SizedBox(width: 5),
                    Hero(
                      tag: 'bot',
                      child: Text(
                        'New Reminder',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.activeBlue),
                      ),
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
                    )),
          ],
        ),
      ),
    );
  }

  Widget buildSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: ListView(
          controller: scrollController,
          children: [
            AppBar(
              title: const Hero(
                tag: 'bot',
                child: Text(
                  'New Reminder',
                  style: TextStyle(color: CupertinoColors.black),
                ),
              ),
              iconTheme: const IconThemeData(color: CupertinoColors.activeBlue),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                CupertinoButton(
                  onPressed: () {},
                  child: const Hero(
                    tag: 'List',
                    child: Text(
                      'Add',
                      style: TextStyle(color: CupertinoColors.activeBlue),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
