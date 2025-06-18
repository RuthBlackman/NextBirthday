import 'package:flutter/material.dart';
import 'package:next_birthday/components/next_birthday_container.dart';

// todo: fetch birthdays, and find all birthdays that are today, or the next one
// todo: display upcoming birthdays in separate component
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          NextBirthdayContainer(
            name: "Ruth",
            day: 27,
            month: 6,
            year: 2002,
            isToday: true,
          ),
        ],
      ),
    );
  }
}
