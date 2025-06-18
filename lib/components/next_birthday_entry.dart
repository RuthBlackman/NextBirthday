import 'package:flutter/material.dart';

class NextBirthdayEntry extends StatefulWidget {
  final String name;
  final int day;
  final int month;
  final int? year;
  const NextBirthdayEntry({
    super.key,
    required this.name,
    required this.day,
    required this.month,
    this.year,
  });

  @override
  State<NextBirthdayEntry> createState() => _NextBirthdayEntryState();
}

class _NextBirthdayEntryState extends State<NextBirthdayEntry> {
  final Map<int, String> monthMap = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  late int age;

  @override
  void initState() {
    age = widget.year != null ? 2025 - widget.year! : 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.person_rounded),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.day} ${monthMap[widget.month]}${age != 0 ? ' • $age years' : ''}",
                ),
              ],
            ),
          ),
          Icon(Icons.cake_rounded),
        ],
      ),
    );
  }
}
