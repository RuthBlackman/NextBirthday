import 'package:flutter/material.dart';
import 'package:next_birthday/components/birthday_picker.dart';
import 'package:next_birthday/components/group_selector.dart';
import 'package:next_birthday/components/name_textfield.dart';
import 'package:next_birthday/models/birthday.dart';
import 'package:next_birthday/models/birthday_database.dart';
import 'package:provider/provider.dart';

class ViewBirthdaysPage extends StatefulWidget {
  const ViewBirthdaysPage({super.key});

  @override
  State<ViewBirthdaysPage> createState() => _ViewBirthdaysPageState();
}

class _ViewBirthdaysPageState extends State<ViewBirthdaysPage> {
  final nameController = TextEditingController();
  int selectedDay = 1;
  int selectedMonth = 1;
  int? selectedYear;

  String selectedName = '';
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    // read birthdays from the database on app startup
    readBirthdays();
  }

  void onNameChanged(String newName) {}

  void onCategoryChanged(String newCategory) {
    selectedCategory = newCategory;
  }

  void onDateSelected(int day, int month, int? year) {
    selectedDay = day;
    selectedMonth = month;
    selectedYear = year;
  }

  void createBirthday() {
    showBirthdayDialog(); // no argument = new birthday
  }

  void updateBirthday(Birthday birthday) {
    showBirthdayDialog(birthday: birthday); // pass in birthday to edit
  }

  void showBirthdayDialog({Birthday? birthday}) {
    // Set initial state based on whether editing or creating
    final isEditing = birthday != null;

    nameController.text = isEditing ? birthday.name : '';
    selectedDay = isEditing ? birthday.day : 1;
    selectedMonth = isEditing ? birthday.month : 1;
    selectedYear = isEditing ? birthday.year : null;
    selectedCategory = isEditing ? birthday.category : '';

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                BirthdayPicker(
                  day: selectedDay,
                  month: selectedMonth,
                  year: selectedYear,
                  onDateSelected: onDateSelected,
                ),
                GroupSelector(
                  group: selectedCategory,
                  onCategoryChanged: onCategoryChanged,
                ),
              ],
            ),
            actions: [
              MaterialButton(
                onPressed: () async {
                  final db = context.read<BirthdayDatabase>();

                  if (nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Name cannot be empty")),
                    );
                    return;
                  }

                  if (isEditing) {
                    await db.updateBirthday(
                      birthday!.id,
                      nameController.text,
                      selectedDay,
                      selectedMonth,
                      selectedYear,
                      selectedCategory,
                    );
                  } else {
                    await db.addBirthday(
                      nameController.text,
                      selectedDay,
                      selectedMonth,
                      selectedYear,
                      selectedCategory,
                    );
                  }

                  Navigator.pop(context);
                },
                child: Text(isEditing ? 'Update' : 'Create'),
              ),
            ],
          ),
    );
  }

  // read birthdays from the database
  void readBirthdays() {
    context.read<BirthdayDatabase>().fetchBirthdays();
  }

  // delete a birthday
  void deleteBirthday(int id) {
    context.read<BirthdayDatabase>().deleteBirthday(id);
  }

  @override
  Widget build(BuildContext context) {
    // birthday database
    final birthdayDatabase = context.watch<BirthdayDatabase>();

    // current birthdays
    List<Birthday> currentBirthdays = birthdayDatabase.currentBirthdays;

    return Scaffold(
      appBar: AppBar(title: Text('All Birthdays')),
      floatingActionButton: FloatingActionButton(
        onPressed: createBirthday,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentBirthdays.length,
        itemBuilder: (context, index) {
          // get individul birthday
          final birthday = currentBirthdays[index];

          // list tile UI
          return ListTile(
            title: Text(birthday.name),
            subtitle: Text(
              '${birthday.day} ${birthday.month} ${birthday.year ?? ''}',
            ),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // edit button
                IconButton(
                  onPressed: () => updateBirthday(birthday),
                  icon: const Icon(Icons.edit),
                ),

                // delete button
                IconButton(
                  onPressed: () => deleteBirthday(birthday.id),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
