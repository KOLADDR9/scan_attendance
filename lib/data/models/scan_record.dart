class ScanRecord {
  final String id;
  final String scannedData;
  final DateTime date;
  final DateTime time;
  final String status;

  ScanRecord({
    required this.id,
    required this.scannedData,
    required this.date,
    required this.time,
    required this.status,
  });

  factory ScanRecord.fromMap(Map<String, dynamic> map) {
    return ScanRecord(
      id: map['id'],
      scannedData: map['scanned_data'],
      date: DateTime.parse(map['date']),
      time: DateTime.parse(
          '1970-01-01T${map['time']}Z'), // Convert time to DateTime
      status: map['status'],
    );
  }
}
