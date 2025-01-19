import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final SupabaseClient _client = Supabase.instance.client;

  // Insert a scan record
  Future<void> insertScanRecord(
      String scannedData, DateTime scanTime, String status) async {
    await _client.from('scan_records').insert({
      'scanned_data': scannedData,
      'date': scanTime.toIso8601String().split('T')[0], // Extract date
      'time': scanTime
          .toIso8601String()
          .split('T')[1]
          .split('.')[0], // Extract time
      'status': status,
    });
  }

  // Fetch all scan records
  Future<List<Map<String, dynamic>>> fetchScanRecords() async {
    final response = await _client.from('scan_records').select('*');
    return response;
  }
}
