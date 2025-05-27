import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameTextfield extends StatefulWidget {
  final String? name;
  final void Function(String) onNameChanged;

  const NameTextfield({
    super.key,
    required this.name,
    required this.onNameChanged,
  });

  @override
  State<NameTextfield> createState() => _NameTextfieldState();
}

class _NameTextfieldState extends State<NameTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 100,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: CupertinoTextField(
        placeholder: widget.name != null ? widget.name : "",
        prefix: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
        decoration: BoxDecoration(),
      ),
    );
  }
}
