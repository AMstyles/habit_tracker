import 'package:animated_page_transition/animated_page_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return PageTransitionReceiver(
      scaffold: Scaffold(
        appBar: AppBar(
          title: Text('Arinaho'),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('pop')),
              Icon(
                CupertinoIcons.cloud_sun,
                size: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
