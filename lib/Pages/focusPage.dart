import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:habit_tracker/Tiles/minutesTile.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rive/rive.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import '../Models/focus_time.dart';
import 'package:confetti/confetti.dart';

class FocusPage extends StatefulWidget {
  FocusPage({Key? key}) : super(key: key);

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> with TickerProviderStateMixin {
  //! variables and controllers
  late Timer focusTimer;

  late FocusTime currentFocusTme = FocusTime(5, 0, _conController);
  late AnimationController _playPauseContoller;
  late ConfettiController _conController;

//!initial state override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playPauseContoller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _conController =
        ConfettiController(duration: const Duration(milliseconds: 1000));
  }

//!dispose override
  @override
  void dispose() {
    // TODO: implement dispose
    _playPauseContoller.dispose();
    _conController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasStarted = false;
    return Scaffold(
      //!app bar
      appBar: AppBar(
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.bell,
                  )))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        //iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Focus',
          //style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/Assets/Spline.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(alignment: Alignment.center, children: <Widget>[
          const RiveAnimation.asset(
            'lib/Assets/shapes.riv',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 10),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      ValueListenableBuilder(
                        builder: (BuildContext context, value, Widget? child) {
                          return CircularPercentIndicator(
                            animation: true,
                            animateFromLastPercent: true,
                            animationDuration: 1000,
                            radius: MediaQuery.of(context).size.width * 0.45,
                            lineWidth: 10,
                            circularStrokeCap: CircularStrokeCap.round,
                            percent: currentFocusTme.getPercent(),
                            progressColor: Colors.white,
                            center: ConfettiWidget(
                              emissionFrequency: 0.2,
                              colors: const [
                                Colors.white,
                                Colors.red,
                                Colors.blue,
                                Colors.green,
                                Colors.amber,
                                Colors.black
                              ],
                              confettiController: _conController,
                              blastDirection: -pi / 2,
                              maxBlastForce: 30,
                              gravity: 0.02,
                              particleDrag: 0.03,
                              shouldLoop: false,
                            ),
                          );
                        },
                        valueListenable: currentFocusTme.percent,
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.self_improvement_rounded,
                            color: Colors.white,
                            size: 100,
                          ),
                          //!working here now , the text widget
                          ValueListenableBuilder<String>(
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return Text(
                                currentFocusTme.getRemainingTime(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontWeight: FontWeight.normal),
                              );
                            },
                            valueListenable: currentFocusTme.timeRemaining,
                          ),
                        ],
                      )
                    ]),
                    const SizedBox(
                      height: 50,
                    ),
                    //!row of them buttons

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: setTimer,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          width: 75,
                          height: 75,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          //! The button we oon
                          child: GestureDetector(
                            onTap: startFocusTimer,
                            child: AnimatedIcon(
                              color: Colors.black,
                              icon: AnimatedIcons.play_pause,
                              progress: _playPauseContoller,
                              size: 50,
                            ),
                          ),
                        ),
                        //!music button
                        SpeedDial(
                          spacing: 10,
                          //elevation: 0,
                          animationDuration: const Duration(milliseconds: 500),
                          backgroundColor: Colors.white,
                          icon: CupertinoIcons.music_note,
                          iconTheme: const IconThemeData(color: Colors.black),
                          children: [
                            SpeedDialChild(child: const Icon(Icons.wind_power)),
                            SpeedDialChild(child: const Icon(Icons.water)),
                            SpeedDialChild(child: const Icon(Icons.music_off)),
                          ],
                        )
                      ],
                    ),
                  ])),
        ]),
      ),
    );
  }

//!methods
  void startFocusTimer() {
    if (currentFocusTme.isRunning.value) {
      _playPauseContoller.reverse();
    } else {
      _playPauseContoller.forward();
    }
    currentFocusTme.startTimer();
  }

  void setTimer() {
    //_playPauseContoller.reverse();
    startFocusTimer();
    int tempMin = 0;
    int tempSec = 0;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceBetween,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            title: const Text('Set Timer'),
            content: SizedBox(
              height: 120,
              //width: 50,
              child: Row(
                children: [
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                        clipBehavior: Clip.hardEdge,
                        onSelectedItemChanged: ((value) {
                          HapticFeedback.selectionClick();
                          tempMin = value;
                        }),
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 25,
                        childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return MinutesTile(min: index);
                            },
                            childCount: 61)),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'min',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                        onSelectedItemChanged: ((value) {
                          HapticFeedback.selectionClick();
                          tempSec = value;
                        }),
                        physics: const FixedExtentScrollPhysics(),
                        itemExtent: 25,
                        childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return MinutesTile(min: index);
                            },
                            childCount: 61)),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'sec',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //!wierd actions
            actions: [
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                  _playPauseContoller.forward();
                  startFocusTimer();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: CupertinoColors.destructiveRed,
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: (() {
                  setState(() {
                    currentFocusTme = FocusTime(
                        tempMin.toDouble(), tempSec.toDouble(), _conController);
                  });
                  _playPauseContoller.reverse();
                  Navigator.pop(context);
                }),
                child: const Text(
                  'Done',
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
              ),
            ],
          );
        });
  }
}
