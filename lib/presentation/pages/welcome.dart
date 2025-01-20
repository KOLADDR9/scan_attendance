// For platform-specific checks
import 'package:flutter/foundation.dart' show kIsWeb; // For web detection
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

  // Function to request location permission with web fallback
  Future<void> _requestLocationPermission() async {
    // Check for web and skip permission requests
    if (kIsWeb) {
      print('Running on Web: Skipping location permission check.');
      setState(() {
        _isLoading = false;
        _permissionDenied = false; // Assume permissions are granted on web
      });

      // Simulate a delay before navigation
      await Future.delayed(const Duration(seconds: 2));
      print('Navigating to Home Page...');
      Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    // For non-web platforms (mobile and desktop)
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
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
      _isLoading = false;
      _permissionDenied = false;
    });

    // Simulate a delay before navigation
    print('Navigating to Home Page...');
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/home');
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
