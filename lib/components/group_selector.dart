import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupSelector extends StatefulWidget {
  final String group;
  final void Function(String) onCategoryChanged;

  const GroupSelector({
    super.key,
    required this.group,
    required this.onCategoryChanged,
  });

  @override
  State<GroupSelector> createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  final List<String> groups = ["", "School", "University", "Work"];
  String selectedGroup = "";
  int selectedGroupIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Semantics(
        excludeSemantics: true,
        child: CupertinoPicker(
          itemExtent: 32,
          scrollController: FixedExtentScrollController(
            initialItem: groups.indexOf(widget.group),
          ),
          onSelectedItemChanged: (index) {
            setState(() {
              selectedGroupIndex = index;
              selectedGroup = groups[index];
              widget.onCategoryChanged(selectedGroup);
            });
          },
          children: groups.map((group) => Center(child: Text(group))).toList(),
        ),
      ),
    );
  }
}
