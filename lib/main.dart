import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/scan_page.dart';
import 'presentation/pages/members.dart';
import 'presentation/pages/welcome.dart';
import 'presentation/pages/sign_up.dart';
import 'presentation/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://hcnjtkntvkkxfzkgjqaw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhjbmp0a250dmtreGZ6a2dqcWF3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYxNDY0MTIsImV4cCI6MjA1MTcyMjQxMn0.YY7TswIgHhPbTJYjdQw2yc7JNEpmL4aa-XN-w013BRw',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/welcome', // Set the initial route to WelcomeScreen
      routes: {
        '/welcome': (context) => WelcomeScreen(), // Define the /welcome route
        //'/sign_up': (context) => SignUpPage(), // Define the /home route
        '/home': (context) => HomePage(), // Define the /home route
        '/scan': (context) => ScanPage(), // Define the scan route
        '/member': (context) => MembersPage(),
      },
    );
  }
}
