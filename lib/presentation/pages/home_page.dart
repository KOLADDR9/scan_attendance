import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import the google_fonts package
import 'package:scan_attendance_app/presentation/pages/scan_page.dart';
import 'package:scan_attendance_app/presentation/pages/members.dart'; // Import the MembersPage

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
                            style:
                                TextStyle(fontSize: 18, color: Colors.white70)),
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
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Image.asset(
                    'assets/img/cdc.jpg', // Ensure this path is correct
                    width: 200,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'ក្រុមប្រឹក្សាអភិវឌ្ឍន៏កម្ពុជា',
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
              Expanded(
                child: GridView.builder(
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
                      {'icon': Icons.history, 'label': 'Record'},
                      {'icon': Icons.time_to_leave, 'label': 'Leave'},
                      {'icon': Icons.schedule, 'label': 'Schedule'},
                    ];
                    return _buildOptionCard(
                        context,
                        options[index]['icon'] as IconData?,
                        options[index]['label'] as String?,
                        index); // Pass the index to assign different colors
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      BuildContext context, IconData? icon, String? label, int index) {
    // Define a list of colors for the grid items
    final List<Color> cardColors = [
      const Color.fromARGB(72, 113, 0, 169),
      const Color.fromARGB(255, 0, 147, 76),
      const Color.fromARGB(255, 144, 82, 0),
      const Color.fromARGB(255, 0, 63, 99),
      const Color.fromARGB(255, 164, 0, 0),
      const Color.fromARGB(255, 0, 81, 62),
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
          if (label == 'Scan Attendance') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScanPage()),
            );
          } else if (label == 'Members') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MembersPage()), // Navigate to MembersPage
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 30, // Further reduced icon size
                  color: Colors.white), // White icon for contrast
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
