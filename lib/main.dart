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
    url: 'https://szwkwilphpddqotouvva.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN6d2t3aWxwaHBkZHFvdG91dnZhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzcyODExNjUsImV4cCI6MjA1Mjg1NzE2NX0.ijtmCC2suV46mrUx-JqdUecqXzUsQL8B--PFknqP-Ao',
  );

  runApp(const MyApp());
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
        '/welcome': (context) =>
            const WelcomeScreen(), // Define the /welcome route
        '/sign_up': (context) => SignUpPage(), // Define the /sign_up route
        '/login': (context) => LoginPage(), // Define the /login route
        '/home': (context) => HomePage(), // Define the /home route
        '/scan': (context) => ScanPage(), // Define the /scan route
        '/member': (context) => MembersPage(), // Define the /member route
      },
    );
  }
}
