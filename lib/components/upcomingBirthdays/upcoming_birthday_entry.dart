import 'package:flutter/material.dart';

class UpcomingBirthdayEntry extends StatefulWidget {
  final String name;
  final int day;
  final int month;
  const UpcomingBirthdayEntry({
    super.key,
    required this.name,
    required this.day,
    required this.month,
  });

  @override
  State<UpcomingBirthdayEntry> createState() => _UpcomingBirthdayEntryState();
}

class _UpcomingBirthdayEntryState extends State<UpcomingBirthdayEntry> {
  final Map<int, String> monthMap = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };

  int daysUntil(int month, int day) {
    final today = DateTime.now();
    DateTime eventDate = DateTime(today.year, month, day);

    // If the date has already passed this year, use next year's date
    if (eventDate.isBefore(today) &&
        !(eventDate.day == today.day && eventDate.month == today.month)) {
      eventDate = DateTime(today.year + 1, month, day);
    }

    return eventDate
        .difference(DateTime(today.year, today.month, today.day))
        .inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.person_rounded),
          const SizedBox(width: 16),
          // Name and Date column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${widget.day} ${monthMap[widget.month]}",
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Days remaining
          Text(
            "${daysUntil(widget.month, widget.day)} days",
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
