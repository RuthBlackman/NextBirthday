import 'package:isar/isar.dart';

part 'birthday.g.dart';

@Collection()
class Birthday {
  Id id = Isar.autoIncrement;

  late String firstName;
  late String? lastName;
  late DateTime birthday;
  late String? imagePath;
  late String? category;
  late int? age;
}
