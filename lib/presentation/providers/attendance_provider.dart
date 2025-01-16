import 'package:flutter/material.dart';
import '../../data/repositories/attendance_repository.dart';

class AttendanceProvider with ChangeNotifier {
  final AttendanceRepository repository;

  AttendanceProvider(this.repository);

  Future<void> saveAttendance(String userId, DateTime timestamp) async {
    await repository.saveAttendance(userId, timestamp);
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> fetchAttendance() async {
    return await repository.fetchAttendance();
  }
}
