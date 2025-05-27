import 'package:flutter/material.dart';
import 'package:next_birthday/models/birthday_database.dart';
import 'package:next_birthday/pages/home_page.dart';
import 'package:next_birthday/pages/view_birthdays_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize birthday database
  WidgetsFlutterBinding.ensureInitialized();
  await BirthdayDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => BirthdayDatabase(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ViewBirthdaysPage(),
      debugShowCheckedModeBanner: false,
      title: 'Next Birthday',
    );
  }
}
