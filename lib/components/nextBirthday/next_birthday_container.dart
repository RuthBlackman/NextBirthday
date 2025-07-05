import 'package:flutter/material.dart';
import 'package:next_birthday/components/nextBirthday/next_birthday_entry.dart';
import 'package:next_birthday/models/birthday.dart';

class NextBirthdayContainer extends StatefulWidget {
  final List<Birthday> nextBirthdays;
  final bool birthdayToday;
  const NextBirthdayContainer({
    super.key,
    required this.nextBirthdays,
    required this.birthdayToday,
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
                widget.birthdayToday
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

            // for each birthday in nextBirthdays, create NextBirthdayEntry
            ListView.separated(
              itemCount: widget.nextBirthdays.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final birthday = widget.nextBirthdays[index];
                return NextBirthdayEntry(
                  name: birthday.name,
                  day: birthday.day,
                  month: birthday.month,
                  year: birthday.year,
                );
              },
              separatorBuilder:
                  (context, index) => const SizedBox(height: 12), // Space here
            ),
          ],
        ),
      ),
    );
  }
}
