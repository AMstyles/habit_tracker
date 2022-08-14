import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduledPage extends StatefulWidget {
  const ScheduledPage({Key? key}) : super(key: key);

  @override
  State<ScheduledPage> createState() => _ScheduledPageState();
}

class _ScheduledPageState extends State<ScheduledPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: CupertinoColors.systemRed),
        elevation: 0,
        title: const Material(
          type: MaterialType.transparency,
          child: Text(
            't i t l e',
            style: TextStyle(color: CupertinoColors.systemRed),
          ),
        ),
        backgroundColor: Colors.grey.shade200,
        actions: [
          CupertinoButton(
              child: const Icon(
                CupertinoIcons.ellipsis_circle,
                color: CupertinoColors.systemRed,
              ),
              onPressed: () {})
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            Hero(
              transitionOnUserGestures: true,
              tag: 'sche',
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  "Scheduled",
                  style: TextStyle(
                      fontSize: 34,
                      color: CupertinoColors.systemRed,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Hero(
                transitionOnUserGestures: true,
                tag: 'tod',
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    "Today",
                    style: TextStyle(
                        fontSize: 25,
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
