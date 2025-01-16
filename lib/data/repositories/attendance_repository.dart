import '../datasources/supabase_datasource.dart';

class AttendanceRepository {
  final SupabaseDataSource supabaseDataSource;

  AttendanceRepository(this.supabaseDataSource);

  Future<void> saveAttendance(String userId, DateTime timestamp) async {
    await supabaseDataSource.saveAttendance(userId, timestamp);
  }

  Future<List<Map<String, dynamic>>> fetchAttendance() async {
    return await supabaseDataSource.fetchAttendance();
  }
}
