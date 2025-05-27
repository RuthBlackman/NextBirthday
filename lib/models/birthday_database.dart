import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:next_birthday/models/birthday.dart';
import 'package:path_provider/path_provider.dart';

class BirthdayDatabase extends ChangeNotifier {
  static late Isar isar;

  // INITIALIZE THE DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([BirthdaySchema], directory: dir.path);
  }

  // list of birthdays
  final List<Birthday> currentBirthdays = [];

  // CREATE
  Future<void> addBirthday(
    String name,
    int day,
    int month,
    int? year,
    String category,
  ) async {
    // create a new Birthday object
    final newBirthday = Birthday()..name = name;
    newBirthday.day = day;
    newBirthday.month = month;
    newBirthday.year = year;
    newBirthday.category = category;

    print(newBirthday.category);

    // save to db
    await isar.writeTxn(() => isar.birthdays.put(newBirthday));

    // re-read from db
    fetchBirthdays();
  }

  // READ
  Future<void> fetchBirthdays() async {
    List<Birthday> fetchedBirthdays = await isar.birthdays.where().findAll();

    currentBirthdays.clear();

    currentBirthdays.addAll(fetchedBirthdays);

    notifyListeners();
  }

  // UPDATE
  Future<void> updateBirthday(
    int id,
    String name,
    int day,
    int month,
    int? year,
    String category,
  ) async {
    final existingBirthday = await isar.birthdays.get(id);
    if (existingBirthday != null) {
      existingBirthday.name = name;
      existingBirthday.day = day;
      existingBirthday.month = month;
      existingBirthday.year = year;
      existingBirthday.category = category;

      await isar.writeTxn(() => isar.birthdays.put(existingBirthday));

      fetchBirthdays();
    }
  }

  // DELETE
  Future<void> deleteBirthday(int id) async {
    await isar.writeTxn(() => isar.birthdays.delete(id));
    fetchBirthdays();
  }
}
