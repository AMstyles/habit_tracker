import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Color> colors = [
  //blues
  CupertinoColors.activeBlue,
  Colors.blue,
  Colors.blueAccent,
  Colors.lightBlue,
  Colors.lightBlueAccent,

  //Greens
  CupertinoColors.activeGreen,
  Colors.green,
  Colors.greenAccent,
  Colors.lightGreen,
  Colors.lightGreenAccent,

  //Yellows
  Colors.orange,
  Colors.orangeAccent,
  CupertinoColors.systemYellow,
  Colors.yellow,
  Colors.yellowAccent,

  //Purples
  Colors.deepPurple,
  Colors.deepPurpleAccent,
  Colors.purple,
  CupertinoColors.systemPurple,
  Colors.purpleAccent,

  //Reds
  CupertinoColors.destructiveRed,
  CupertinoColors.systemRed,
  Colors.redAccent,
  Colors.pink
];

List<Color> progColors = [
  CupertinoColors.systemRed,
  CupertinoColors.activeOrange,
  CupertinoColors.systemYellow,
  CupertinoColors.systemGreen,
];

List<dynamic> icons = [
  CupertinoIcons.heart_fill,
  CupertinoIcons.book_fill,
  CupertinoIcons.tv_fill,
  CupertinoIcons.keyboard,
  CupertinoIcons.headphones,
  Icons.self_improvement_rounded,
  Icons.sports_gymnastics_rounded,
  Icons.directions_bike_rounded,
  Icons.directions_run,
  Icons.water_drop_rounded
];

Map<int, Color> color = {
  50: const Color.fromRGBO(255, 255, 255, .1),
  100: const Color.fromRGBO(255, 255, 255, .2),
  200: const Color.fromRGBO(255, 255, 255, .3),
  300: const Color.fromRGBO(255, 255, 255, .4),
  400: const Color.fromRGBO(255, 255, 255, .5),
  500: const Color.fromRGBO(255, 255, 255, .6),
  600: const Color.fromRGBO(255, 255, 255, .7),
  700: const Color.fromRGBO(255, 255, 255, .8),
  800: const Color.fromRGBO(255, 255, 255, .9),
  900: const Color.fromRGBO(255, 255, 255, 1),
};

MaterialColor colorCustom = MaterialColor(0xFFFFFFFF, color);


 Widget _buildRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: const Icon(
            Icons.apple,
            color: Colors.white,
            size: 50,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          child: const Icon(
            Icons.facebook,
            color: Colors.white,
            size: 50,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.grey.shade200),
          child: Image.asset(
            'lib/assets/googleIcon.png',
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }