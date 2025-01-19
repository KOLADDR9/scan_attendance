import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Save attendance record
  Future<void> saveAttendance(String userId, DateTime timestamp) async {
    await supabase.from('attendance').insert({
      'user_id': userId,
      'timestamp': timestamp.toIso8601String(),
    });
  }

  // Fetch attendance records
  Future<List<Map<String, dynamic>>> fetchAttendance() async {
    final response = await supabase
        .from('attendance')
        .select('*, users(name, email)')
        .order('timestamp', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // Fetch all members from the users table
  Future<List<Map<String, dynamic>>> fetchMembers() async {
    try {
      final response = await supabase.from('users').select('*');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching members: $e');
      throw e; // Rethrow the error to handle it in the UI
    }
  }
}
