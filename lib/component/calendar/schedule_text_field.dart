import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScheduleTextField extends StatelessWidget {
  final String label;

  const ScheduleTextField({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextFormField(
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}