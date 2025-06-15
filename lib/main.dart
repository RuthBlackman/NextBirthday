import 'package:flutter/material.dart';
import 'package:next_birthday/models/birthday_database.dart';
import 'package:provider/provider.dart';
import 'main_screen.dart';

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
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Next Birthday',
    );
  }
}
