import 'package:flutter/material.dart';
import 'package:location/location.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Location location = Location();
  bool _isLoading = true;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  // Function to request location permission
  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Location service is not enabled, show a message or handle it
        print('Location service is not enabled.');
        setState(() {
          _isLoading = false;
          _permissionDenied = true;
        });
        return;
      }
    }

    // Request location permission
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // Location permission is not granted, show a message or handle it
        print('Location permission is not granted.');
        setState(() {
          _isLoading = false;
          _permissionDenied = true;
        });
        return;
      }
    }

    // Location permission is granted
    setState(() {
      _isLoading = true; // Keep loading animation running
      _permissionDenied = false;
    });

    // Show WelcomeScreen for 5 seconds, then navigate to the home page
    print('Showing WelcomeScreen for 5 seconds...');
    await Future.delayed(const Duration(seconds: 2)); // Wait for 5 seconds
    print('Navigating to SignUpPage...');
    Navigator.pushReplacementNamed(context, '/home'); // Navigate to home page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(16, 51, 50, 1), // Dark blue
              Color.fromRGBO(11, 32, 33, 1), // Slightly lighter blue
              Color.fromRGBO(5, 12, 14, 1), // Even lighter blue
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Section with Image Only
              Image.asset(
                'assets/img/logo.png',
                width: 200,
              ),
              const SizedBox(height: 50),

              // Loading Indicator or Message
              if (_isLoading)
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                )
              else if (_permissionDenied)
                Column(
                  children: [
                    const Text(
                      'Location permission is required to use this app.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _requestLocationPermission,
                      child: const Text('Grant Permission'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
