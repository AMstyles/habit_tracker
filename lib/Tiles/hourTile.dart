import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourTile extends StatelessWidget {
  const HourTile({Key? key, required this.hr}) : super(key: key);

  final int hr;

  @override
  Widget build(BuildContext context) {
    final NumberFormat f = NumberFormat('00');

    return Text(f.format(hr));
  }
}
