import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FocusTime {
  late NumberFormat f;
  late Timer timer_;
  double minutes;
  double seconds;
  late double goal;
  ConfettiController theController;

//!my listenables
  late ValueNotifier<String> timeRemaining =
      ValueNotifier<String>('${f.format(minutes)}:${f.format(seconds)}');

  late ValueNotifier<double> percent = ValueNotifier<double>(0);

  late ValueNotifier<bool> isRunning = ValueNotifier<bool>(false);

  FocusTime(this.minutes, this.seconds, this.theController) {
    isRunning.value = false;
    f = NumberFormat('00');
    goal = minutes * 60 + seconds;
    percent.value = ((minutes * 60) + seconds) / goal;
  }

  void startTimer() {
    if (!isRunning.value) {
      isRunning.value = true;
      timer_ = Timer.periodic(const Duration(seconds: 1), (timer) {
        updateTimer();
      });
    } else {
      isRunning.value = false;
      timer_.cancel();
    }
  }

  void updateTimer() {
    bool isdone = false;
    if (seconds > 0) {
      seconds--;
      reallyUpdateTimer();
      updatePercent();
    } else {
      if (minutes != 0) {
        minutes--;
        seconds = 59;
        reallyUpdateTimer();
        updatePercent();
      } else {
        timer_.cancel();
        onDoneTimer();
      }
    }
  }

  void onDoneTimer() {
    HapticFeedback.vibrate();
    theController.play();

    /*Future.delayed(
        const Duration(milliseconds: 500), () => HapticFeedback.heavyImpact());
    Future.delayed(
        const Duration(milliseconds: 700), () => HapticFeedback.mediumImpact());
        */
    Future.delayed(
        const Duration(milliseconds: 900), () => HapticFeedback.vibrate());
  }

  void reallyUpdateTimer() {
    timeRemaining.value = '${f.format(minutes)}:${f.format(seconds)}';
  }

  void setGoal(int min, int sec) {
    goal = ((min * 60) + sec).toDouble();
  }

  void updateTimeRemaining() {
    timeRemaining.value = '$minutes : $seconds';
  }

  String getRemainingTime() {
    return timeRemaining.value;
  }

  double getPercent() {
    return percent.value;
  }

  void updatePercent() {
    percent.value = ((minutes * 60) + seconds) / goal;
  }

  void setMinutes(int val) {
    minutes = val.toDouble();
  }

  void setSeconds(int val) {
    minutes = val.toDouble();
  }

  void doSet(int min, int sec) {
    setGoal(min, sec);
    setMinutes(min);
    setSeconds(sec);
    updatePercent();
    updateTimeRemaining();
  }
}
