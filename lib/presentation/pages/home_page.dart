import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import the google_fonts package
import 'package:scan_attendance_app/presentation/pages/login.dart';
import 'package:scan_attendance_app/presentation/pages/report_page.dart';
import 'package:scan_attendance_app/presentation/pages/scan_page.dart';
import 'package:scan_attendance_app/presentation/pages/members.dart'; // Import the MembersPage
import 'package:scan_attendance_app/presentation/pages/schedule_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(16, 51, 50, 1),
              Color.fromRGBO(11, 32, 33, 1),
              Color.fromRGBO(5, 12, 14, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          // Wrap the Column with SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0), // Removed vertical padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile Section with Shadow
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0), // Add top padding only
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Kola',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(color: Colors.black, blurRadius: 5)
                                  ])),
                          Text('Officer_IT_Support',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70)),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                            'assets/img/profile.webp'), // Use AssetImage for local images
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Main Image with Border
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    child: Image.asset(
                      'assets/img/headoffice.webp', // Ensure this path is correct
                      width: 100,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Head Office',
                  style: GoogleFonts.khmer(
                    // Use Khmer OS Moul from Google Fonts
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Grid of Options with Colorful Cards
                GridView.builder(
                  shrinkWrap:
                      true, // Add this to make GridView scrollable inside Column
                  physics:
                      NeverScrollableScrollPhysics(), // Disable GridView's internal scrolling
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 boxes per row
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    childAspectRatio:
                        1, // Adjust the aspect ratio for smaller items
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final options = [
                      {'icon': Icons.qr_code, 'label': 'Scan'},
                      {'icon': Icons.group, 'label': 'Members'},
                      {'icon': Icons.bar_chart, 'label': 'Report'},
                      {'icon': Icons.person, 'label': 'Me'},
                      {'icon': Icons.exit_to_app, 'label': 'Leave'},
                      {'icon': Icons.schedule, 'label': 'Schedule'},
                    ];
                    // Define a list of colors for the icons
                    final List<Color> iconColors = [
                      Colors.green, // Color for the first icon
                      Colors.blue, // Color for the second icon
                      Colors.orange, // Color for the third icon
                      Colors.purple, // Color for the fourth icon
                      Colors.red, // Color for the fifth icon
                      Colors.teal, // Color for the sixth icon
                    ];
                    return _buildOptionCard(
                      context,
                      options[index]['icon'] as IconData?,
                      options[index]['label'] as String?,
                      index,
                      iconColors[index], // Pass the icon color
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context,
    IconData? icon,
    String? label,
    int index,
    Color iconColor, // Add iconColor parameter
  ) {
    // Define a list of colors for the grid items
    final List<Color> cardColors = [
      const Color.fromARGB(40, 255, 255, 255),
      const Color.fromARGB(40, 255, 255, 255),
      const Color.fromARGB(40, 255, 255, 255),
      const Color.fromARGB(40, 255, 255, 255),
      const Color.fromARGB(40, 255, 255, 255),
      const Color.fromARGB(40, 255, 255, 255),
    ];

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: cardColors[
          index % cardColors.length], // Assign a color based on index
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          if (label == 'Scan') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScanPage()),
            );
          } else if (label == 'Members') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MembersPage()),
            );
          } else if (label == 'Report') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportPage()),
            );
          } else if (label == 'Leave') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } else if (label == 'Schedule') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SchedulePage()),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30, // Further reduced icon size
                color: iconColor, // Use the passed icon color
              ),
              const SizedBox(height: 6), // Further reduced spacing
              Text(
                label ?? '',
                style: const TextStyle(
                  fontSize: 14, // Further reduced font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for contrast
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
