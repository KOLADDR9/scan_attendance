import '../../data/repositories/attendance_repository.dart';

class FetchAttendance {
  final AttendanceRepository repository;

  FetchAttendance(this.repository);

  Future<List<Map<String, dynamic>>> call() async {
    return await repository.fetchAttendance();
  }
}
