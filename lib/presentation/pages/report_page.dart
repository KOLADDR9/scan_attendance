import 'package:flutter/material.dart';
import 'package:scan_attendance_app/data/models/scan_record.dart';
import 'package:scan_attendance_app/core/services/supabase_service.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final SupabaseService _supabaseService = SupabaseService();
  List<ScanRecord> scanRecords = [];
  List<ScanRecord> filteredRecords = [];

  DateTime? selectedDate; // Store the selected date
  String? selectedStatus; // "Present", "Late", or null (All)

  @override
  void initState() {
    super.initState();
    _fetchScanRecords();
  }

  // Fetch scan records from Supabase
  Future<void> _fetchScanRecords() async {
    final records = await _supabaseService.fetchScanRecords();
    setState(() {
      scanRecords = records.map((map) => ScanRecord.fromMap(map)).toList();
      _sortRecordsByTimestamp(); // Sort records by timestamp
      filteredRecords = scanRecords; // Initialize filtered records
    });
  }

  // Sort records by timestamp in descending order (most recent first)
  void _sortRecordsByTimestamp() {
    scanRecords.sort((a, b) {
      // Combine date and time into DateTime objects for comparison
      final dateTimeA = DateTime(
          a.date.year, a.date.month, a.date.day, a.time.hour, a.time.minute);
      final dateTimeB = DateTime(
          b.date.year, b.date.month, b.date.day, b.time.hour, b.time.minute);
      return dateTimeB.compareTo(dateTimeA); // Descending order
    });
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date (today)
      firstDate: DateTime(2000), // Earliest selectable date
      lastDate: DateTime(2100), // Latest selectable date
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked; // Store the selected date
        _filterRecords(); // Apply filters after selecting date
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected Date: ${picked.toLocal()}')),
      );
    }
  }

  // Filter records based on selected date and status
  void _filterRecords() {
    setState(() {
      filteredRecords = scanRecords.where((record) {
        // Filter by date
        if (selectedDate != null) {
          // Compare year, month, and day directly
          if (record.date.year != selectedDate!.year ||
              record.date.month != selectedDate!.month ||
              record.date.day != selectedDate!.day) {
            return false;
          }
        }

        // Filter by status
        if (selectedStatus != null && record.status != selectedStatus) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color.fromRGBO(16, 51, 50, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromRGBO(16, 51, 50, 1),
              const Color.fromRGBO(11, 32, 33, 1),
              const Color.fromRGBO(5, 12, 14, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Date Picker and Status Buttons (Horizontal Scrollable)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, // 5% of screen width
                vertical: screenHeight * 0.02, // 2% of screen height
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Enable horizontal scrolling
                  child: Row(
                    children: [
                      // Date Picker Button
                      ElevatedButton(
                        onPressed: () {
                          _selectDate(context); // Call the date picker method
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 99, 99, 99),
                        ),
                        child: const Text(
                          'Select Date',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // All Button
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedStatus = null; // Reset status filter
                            _filterRecords(); // Apply filters
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedStatus == null
                              ? Colors.blue // Highlight when selected
                              : const Color.fromARGB(255, 99, 99, 99),
                        ),
                        child: const Text('All',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      // Present Button
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Reset selectedStatus if it's already "Present"
                            if (selectedStatus == 'Present') {
                              selectedStatus = null; // Clear the filter
                            } else {
                              selectedStatus = 'Present'; // Set to "Present"
                            }
                            _filterRecords(); // Apply filters
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedStatus == 'Present'
                              ? Colors.green
                              : const Color.fromARGB(255, 99, 99, 99),
                        ),
                        child: const Text('Present',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      // Late Button
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Reset selectedStatus if it's already "Late"
                            if (selectedStatus == 'Late') {
                              selectedStatus = null; // Clear the filter
                            } else {
                              selectedStatus = 'Late'; // Set to "Late"
                            }
                            _filterRecords(); // Apply filters
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedStatus == 'Late'
                              ? Colors.orange
                              : const Color.fromARGB(255, 99, 99, 99),
                        ),
                        child: const Text('Late',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Attendance Records List
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecords.length,
                itemBuilder: (context, index) {
                  final record = filteredRecords[index];
                  return InkWell(
                    onTap: () {
                      // Handle the tap event
                      print('Tapped on record: ${record.date}');
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05, // 5% of screen width
                        vertical: screenHeight * 0.01, // 1% of screen height
                      ),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: record.status == 'Present'
                                ? Colors.green.withOpacity(0.2)
                                : Colors.orange.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            record.status == 'Present'
                                ? Icons.check_circle
                                : Icons.warning,
                            color: record.status == 'Present'
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                        title: Text(
                          'Date: ${record.date}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04, // 4% of screen width
                          ),
                        ),
                        subtitle: Text(
                          'Time: ${record.time}, Status: ${record.status}',
                          style: TextStyle(
                            fontSize:
                                screenWidth * 0.035, // 3.5% of screen width
                            color: const Color.fromARGB(179, 14, 14, 14),
                          ),
                        ),
                        trailing: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                screenWidth * 0.03, // 3% of screen width
                            vertical:
                                screenHeight * 0.01, // 1% of screen height
                          ),
                          decoration: BoxDecoration(
                            color: record.status == 'Present'
                                ? Colors.green.withOpacity(0.2)
                                : Colors.orange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            record.status,
                            style: TextStyle(
                              color: record.status == 'Present'
                                  ? Colors.green
                                  : Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  screenWidth * 0.035, // 3.5% of screen width
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
