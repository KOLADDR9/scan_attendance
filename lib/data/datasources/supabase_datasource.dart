import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDataSource {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> saveAttendance(String userId, DateTime timestamp) async {
    await supabase.from('attendance').insert({
      'user_id': userId,
      'timestamp': timestamp.toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> fetchAttendance() async {
    final response = await supabase
        .from('attendance')
        .select('*, users(name, email)')
        .order('timestamp', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }
}
