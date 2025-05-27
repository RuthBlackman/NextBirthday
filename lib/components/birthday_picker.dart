import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BirthdayPicker extends StatefulWidget {
  final void Function(int day, int month, int? year) onDateSelected;
  final int day;
  final int month;
  final int? year;

  const BirthdayPicker({
    super.key,
    required this.onDateSelected,
    required this.day,
    required this.month,
    required this.year,
  });

  @override
  State<BirthdayPicker> createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {
  int selectedMonth = 1;
  int selectedDay = 1;
  int? selectedYear;

  final List<String> months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final List<int> days = List.generate(31, (index) => index + 1);

  final List<String> years = [
    '-', // "No Year"
    ...List.generate(100, (i) => (DateTime.now().year - i).toString()),
  ];

  @override
  void initState() {
    super.initState();
    selectedDay = widget.day;
    selectedMonth = widget.month;
    selectedYear = widget.year;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          // Day picker
          Expanded(
            child: CupertinoPicker(
              itemExtent: 32,
              scrollController: FixedExtentScrollController(
                initialItem: selectedDay - 1,
              ),
              onSelectedItemChanged: (index) {
                setState(() => selectedDay = index + 1);
                widget.onDateSelected(selectedDay, selectedMonth, selectedYear);
              },
              children:
                  days.map((d) => Center(child: Text(d.toString()))).toList(),
            ),
          ),

          // Month picker
          Expanded(
            child: CupertinoPicker(
              itemExtent: 32,
              scrollController: FixedExtentScrollController(
                initialItem: selectedMonth - 1,
              ),
              onSelectedItemChanged: (index) {
                setState(() => selectedMonth = index + 1);
                widget.onDateSelected(selectedDay, selectedMonth, selectedYear);
              },
              children: months.map((m) => Center(child: Text(m))).toList(),
            ),
          ),

          // Year picker
          Expanded(
            child: CupertinoPicker(
              itemExtent: 32,
              scrollController: FixedExtentScrollController(
                initialItem:
                    selectedYear == null
                        ? 0
                        : years.indexOf(selectedYear.toString()),
              ),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedYear = index == 0 ? null : int.parse(years[index]);
                });
                widget.onDateSelected(selectedDay, selectedMonth, selectedYear);
              },
              children:
                  years.map((y) {
                    return Center(child: Text(y == '-' ? 'No Year' : y));
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
