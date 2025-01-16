import '../../data/repositories/attendance_repository.dart';

class ScanAttendance {
  final AttendanceRepository repository;

  ScanAttendance(this.repository);

  Future<void> call(String userId, DateTime timestamp) async {
    await repository.saveAttendance(userId, timestamp);
  }
}
