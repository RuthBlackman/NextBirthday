import 'package:isar/isar.dart';

part 'birthday.g.dart';

@Collection()
class Birthday {
  Id id = Isar.autoIncrement;

  late String name;
  late int day;
  late int month;
  late int? year;
  late String category;

  // late String? lastName;
  // late DateTime? birthday;
  // late String? imagePath;
  // late String? category;
  // late int? age;
}
