import 'package:flutter/material.dart';
import 'package:scan_attendance_app/presentation/pages/home_page.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // Sample schedule data
  List<Map<String, String>> scheduleData = [
    {
      'time': '09:00 AM',
      'event': 'Team Meeting',
      'location': 'Conference Room A',
    },
    {
      'time': '10:00 AM',
      'event': 'Client Call',
      'location': 'Online (Zoom)',
    },
    {
      'time': '12:00 PM',
      'event': 'Lunch Break',
      'location': 'Cafeteria',
    },
    {
      'time': '02:00 PM',
      'event': 'Project Review',
      'location': 'Conference Room B',
    },
    {
      'time': '04:00 PM',
      'event': 'Training Session',
      'location': 'Training Room',
    },
  ];

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date (today)
      firstDate: DateTime(2000), // Earliest selectable date
      lastDate: DateTime(2100), // Latest selectable date
    );

    if (picked != null) {
      // Handle the selected date
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected Date: ${picked.toLocal()}')),
      );

      // You can update the schedule data based on the selected date here
      // For example, fetch events for the selected date from an API or local data
    }
  }

  // Function to show the "Add New Event" dialog
  void _showAddEventDialog(BuildContext context) {
    final TextEditingController timeController = TextEditingController();
    final TextEditingController eventController = TextEditingController();
    final TextEditingController locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  hintText: 'e.g., 09:00 AM',
                ),
              ),
              TextField(
                controller: eventController,
                decoration: const InputDecoration(
                  labelText: 'Event',
                  hintText: 'e.g., Team Meeting',
                ),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'e.g., Conference Room A',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the new event to the scheduleData list
                setState(() {
                  scheduleData.add({
                    'time': timeController.text,
                    'event': eventController.text,
                    'location': locationController.text,
                  });
                });

                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Event added successfully!')),
                );
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Function to delete an event
  void _deleteEvent(int index) {
    setState(() {
      scheduleData.removeAt(index); // Remove the event at the specified index
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Event deleted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background color
      appBar: AppBar(
        title: const Text('Schedule',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color.fromRGBO(16, 51, 50, 1), // Dark app bar
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {
              // Call the date picker function
              _selectDate(context);
            },
          ),
        ],
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
      body: Column(
        children: [
          // Header Section
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(16, 51, 50, 1), // Dark header background
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_month,
                    color: Colors.white, size: 30.0),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today\'s Schedule',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${scheduleData.length} Events',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Schedule List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: scheduleData.length,
              itemBuilder: (context, index) {
                final event = scheduleData[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.event,
                        color: Colors.blue,
                      ),
                    ),
                    title: Text(
                      event['event']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4.0),
                        Text(
                          'Time: ${event['time']}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Location: ${event['location']}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Call the delete event function
                        _deleteEvent(index);
                      },
                    ),
                    onTap: () {
                      // Add navigation or action when an event is tapped
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${event['event']}'),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the "Add New Event" dialog
          _showAddEventDialog(context);
        },
        backgroundColor: const Color.fromRGBO(16, 51, 50, 1), // Dark FAB color
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
