class AttendanceEntity {
  final String id;
  final String userId;
  final DateTime timestamp;

  AttendanceEntity(
      {required this.id, required this.userId, required this.timestamp});
}
