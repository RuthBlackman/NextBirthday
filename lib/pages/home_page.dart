import 'package:flutter/material.dart';
import 'package:next_birthday/components/next_birthday_container.dart';
import 'package:next_birthday/models/birthday.dart';
import 'package:next_birthday/models/birthday_database.dart';
import 'package:provider/provider.dart';

// todo: display upcoming birthdays in separate component
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool birthdayToday = false;

  @override
  void initState() {
    Provider.of<BirthdayDatabase>(context, listen: false).fetchBirthdays();
    super.initState();
  }

  List<Birthday> getNextBirthday() {
    final birthdayDatabase = context.watch<BirthdayDatabase>();
    final allBirthdays = birthdayDatabase.currentBirthdays;
    final today = DateTime.now();

    if (allBirthdays.isEmpty) return [];

    DateTime nextOccurrence(int month, int day) {
      final thisYear = DateTime(today.year, month, day);
      return thisYear.isAfter(today) ||
              (thisYear.day == today.day && thisYear.month == today.month)
          ? thisYear
          : DateTime(today.year + 1, month, day);
    }

    // Find the soonest upcoming birthday date
    final soonest = allBirthdays
        .map((b) => nextOccurrence(b.month, b.day))
        .reduce((a, b) => a.isBefore(b) ? a : b);

    // Check if that birthday is today
    final isToday = soonest.month == today.month && soonest.day == today.day;

    if (isToday) {
      setState(() {
        birthdayToday = true;
      });
    }

    // Return all birthdays matching the soonest date
    return allBirthdays
        .where((b) => nextOccurrence(b.month, b.day) == soonest)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          NextBirthdayContainer(
            nextBirthdays: getNextBirthday(),
            birthdayToday: birthdayToday,
          ),
        ],
      ),
    );
  }
}
