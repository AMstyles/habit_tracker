import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MinutesTile extends StatelessWidget {
  const MinutesTile({Key? key, required this.min}) : super(key: key);

  final int min;

  @override
  Widget build(BuildContext context) {
    final NumberFormat f = NumberFormat('00');

    return Text(f.format(min));
  }
}
