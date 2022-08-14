import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SecondsTile extends StatelessWidget {
  const SecondsTile({Key? key, required this.sec}) : super(key: key);

  final int sec;

  @override
  Widget build(BuildContext context) {
    final NumberFormat f = NumberFormat('00');

    return Text(f.format(sec));
  }
}
