// controllers.dart
import 'package:flutter/material.dart';

class LoginControllers {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Dispose the controllers when no longer needed
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
