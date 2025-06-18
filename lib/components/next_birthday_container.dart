import 'package:flutter/material.dart';
import 'package:next_birthday/components/next_birthday_entry.dart';

class NextBirthdayContainer extends StatefulWidget {
  final String name;
  final int day;
  final int month;
  final int? year;
  final bool isToday;
  const NextBirthdayContainer({
    super.key,
    required this.name,
    required this.day,
    required this.month,
    required this.year,
    required this.isToday,
  });

  @override
  State<NextBirthdayContainer> createState() => _NextBirthdayContainerState();
}

class _NextBirthdayContainerState extends State<NextBirthdayContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.isToday
                    ? Text(
                      "Today's birthday",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                    : Text(
                      'Next Birthday...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                Expanded(
                  child: Image(
                    width: 20,
                    height: 100,
                    image: AssetImage('assets/images/birthday-cake.png'),
                  ),
                ),
              ],
            ),
            NextBirthdayEntry(
              name: widget.name,
              day: widget.day,
              month: widget.month,
              year: widget.year,
            ),
          ],
        ),
      ),
    );
  }
}
