import 'package:flutter/material.dart';
import 'package:scan_attendance_app/presentation/pages/home_page.dart';
import 'package:scan_attendance_app/presentation/pages/scan_page.dart';
import 'package:scan_attendance_app/presentation/pages/members.dart';

class AppRoutes {
  static const String home = '/';
  static const String scan = '/scan';
  static const String attendance = '/attendance';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case scan:
        return MaterialPageRoute(builder: (_) => ScanPage());
      case attendance:
        return MaterialPageRoute(builder: (_) => MembersPage());
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text('Page not found'))));
    }
  }
}
