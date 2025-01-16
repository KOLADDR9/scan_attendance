import 'package:flutter/material.dart';

class AttendanceItem extends StatelessWidget {
  final String name;
  final String email;
  final String timestamp;

  const AttendanceItem(
      {super.key,
      required this.name,
      required this.email,
      required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(email),
      trailing: Text(timestamp),
    );
  }
}
