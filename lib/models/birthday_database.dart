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
  Future<void> addBirthday(String firstName, DateTime birthday) async {
    // create a new Birthday object
    final newBirthday =
        Birthday()
          ..firstName = firstName
          ..birthday = birthday;

    // save to db
    await isar.writeTxn(() => isar.birthdays.put(newBirthday));

    // re-read from db
    fetchBirthdays();
  }

  // READ
  Future<void> fetchBirthdays() async {
    // read from db
    List<Birthday> fetchedBirthdays = await isar.birthdays.where().findAll();

    // clear the current list
    currentBirthdays.clear();

    // add to the current list
    currentBirthdays.addAll(fetchedBirthdays);

    notifyListeners();
  }

  // UPDATE
  Future<void> updateBirthday(
    int id,
    String firstName,
    DateTime birthday,
  ) async {
    final existingBirthday = await isar.birthdays.get(id);
    if (existingBirthday != null) {
      existingBirthday.firstName = firstName;
      existingBirthday.birthday = birthday;

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
