import 'package:flutter/material.dart';
import 'package:next_birthday/components/upcomingBirthdays/upcoming_birthday_entry.dart';
import 'package:next_birthday/models/birthday.dart';

class UpcomingBirthdayContainer extends StatefulWidget {
  final List<Birthday> birthdays;
  const UpcomingBirthdayContainer({super.key, required this.birthdays});

  @override
  State<UpcomingBirthdayContainer> createState() =>
      _UpcomingBirthdayContainerState();
}

class _UpcomingBirthdayContainerState extends State<UpcomingBirthdayContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 390,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upcoming Birthdays",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Expanded(
              // makes ListView fill remaining vertical space
              child: ListView.separated(
                itemCount: widget.birthdays.length,
                itemBuilder: (context, index) {
                  final birthday = widget.birthdays[index];
                  return UpcomingBirthdayEntry(
                    name: birthday.name,
                    day: birthday.day,
                    month: birthday.month,
                  );
                },
                separatorBuilder:
                    (context, index) => const SizedBox(height: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
