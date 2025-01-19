import 'package:flutter/material.dart';
import 'package:scan_attendance_app/presentation/pages/home_page.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<Map<String, String>> attendanceRecords = [
    // January 2025
    {'date': '2025-01-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-01-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-01-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-01-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-01-05', 'time': '09:00 AM', 'status': 'Present'},

    // February 2025
    {'date': '2025-02-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-02-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-02-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-02-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-02-05', 'time': '09:00 AM', 'status': 'Present'},

    // March 2025
    {'date': '2025-03-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-03-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-03-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-03-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-03-05', 'time': '09:00 AM', 'status': 'Present'},

    // April 2025
    {'date': '2025-04-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-04-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-04-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-04-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-04-05', 'time': '09:00 AM', 'status': 'Present'},

    // May 2025
    {'date': '2025-05-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-05-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-05-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-05-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-05-05', 'time': '09:00 AM', 'status': 'Present'},

    // June 2025
    {'date': '2025-06-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-06-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-06-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-06-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-06-05', 'time': '09:00 AM', 'status': 'Present'},

    // July 2025
    {'date': '2025-07-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-07-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-07-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-07-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-07-05', 'time': '09:00 AM', 'status': 'Present'},

    // August 2025
    {'date': '2025-08-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-08-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-08-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-08-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-08-05', 'time': '09:00 AM', 'status': 'Present'},

    // September 2025
    {'date': '2025-09-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-09-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-09-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-09-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-09-05', 'time': '09:00 AM', 'status': 'Present'},

    // October 2025
    {'date': '2025-10-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-10-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-10-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-10-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-10-05', 'time': '09:00 AM', 'status': 'Present'},

    // November 2025
    {'date': '2025-11-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-11-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-11-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-11-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-11-05', 'time': '09:00 AM', 'status': 'Present'},

    // December 2025
    {'date': '2025-12-01', 'time': '09:00 AM', 'status': 'Present'},
    {'date': '2025-12-02', 'time': '09:05 AM', 'status': 'Late'},
    {'date': '2025-12-03', 'time': '09:02 AM', 'status': 'Present'},
    {'date': '2025-12-04', 'time': '09:10 AM', 'status': 'Late'},
    {'date': '2025-12-05', 'time': '09:00 AM', 'status': 'Present'},
  ];

  String? selectedMonth;
  String? selectedStatus; // "Present" or "Late"

  final List<String> months = [
    'All 2025', // Added "All" option
    'January 2025',
    'February 2025',
    'March 2025',
    'April 2025',
    'May 2025',
    'June 2025',
    'July 2025',
    'August 2025',
    'September 2025',
    'October 2025',
    'November 2025',
    'December 2025',
  ];

  List<Map<String, String>> get filteredRecords {
    List<Map<String, String>> filtered = attendanceRecords;

    // Filter by month (skip if 'All' is selected)
    if (selectedMonth != null && selectedMonth!.split(' ')[0] != 'All') {
      final monthNumber = _getMonthNumber(selectedMonth!);
      filtered = filtered
          .where((record) => record['date']!
              .startsWith(selectedMonth!.split(' ')[1] + '-' + monthNumber))
          .toList();
    }

    // Filter by status
    if (selectedStatus != null) {
      filtered = filtered
          .where((record) => record['status'] == selectedStatus)
          .toList();
    }

    return filtered;
  }

  String _getMonthNumber(String month) {
    switch (month.split(' ')[0]) {
      case 'All':
        return '01,02,03,04,05,06,07,08,09,10,11,12'; // Return all months
      case 'January':
        return '01';
      case 'February':
        return '02';
      case 'March':
        return '03';
      case 'April':
        return '04';
      case 'May':
        return '05';
      case 'June':
        return '06';
      case 'July':
        return '07';
      case 'August':
        return '08';
      case 'September':
        return '09';
      case 'October':
        return '10';
      case 'November':
        return '11';
      case 'December':
        return '12';
      default:
        return '01'; // Default to January if no match is found
    }
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
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
            // Month Filter Dropdown and Status Buttons
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, // 5% of screen width
                vertical: screenHeight * 0.02, // 2% of screen height
              ),
              child: Row(
                children: [
                  // Month Dropdown
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedMonth,
                      hint: const Text('Select Month',
                          style: TextStyle(color: Colors.white)),
                      dropdownColor: const Color.fromRGBO(16, 51, 50, 1),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMonth = newValue;
                        });
                      },
                      items:
                          months.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Present Button
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedStatus = 'Present';
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
                        selectedStatus = 'Late';
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
            // Attendance Records List
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecords.length,
                itemBuilder: (context, index) {
                  final record = filteredRecords[index];
                  return Card(
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
                          color: record['status'] == 'Present'
                              ? Colors.green.withOpacity(0.2)
                              : Colors.orange.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          record['status'] == 'Present'
                              ? Icons.check_circle
                              : Icons.warning,
                          color: record['status'] == 'Present'
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                      title: Text(
                        'Date: ${record['date']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04, // 4% of screen width
                        ),
                      ),
                      subtitle: Text(
                        'Time: ${record['time']}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035, // 3.5% of screen width
                          color: const Color.fromARGB(179, 14, 14, 14),
                        ),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03, // 3% of screen width
                          vertical: screenHeight * 0.01, // 1% of screen height
                        ),
                        decoration: BoxDecoration(
                          color: record['status'] == 'Present'
                              ? Colors.green.withOpacity(0.2)
                              : Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          record['status']!,
                          style: TextStyle(
                            color: record['status'] == 'Present'
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                screenWidth * 0.035, // 3.5% of screen width
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
