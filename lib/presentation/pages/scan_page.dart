import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan_attendance_app/core/services/supabase_service.dart';
import 'package:scan_attendance_app/presentation/pages/report_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final MobileScannerController cameraController = MobileScannerController();
  bool isScanning = true;
  bool isDialogOpen = false;

  final SupabaseService _supabaseService = SupabaseService();

  String _determineStatus(DateTime now) {
    final time = DateTime(now.year, now.month, now.day, now.hour, now.minute);

    final morningStart = DateTime(now.year, now.month, now.day, 8, 15);
    final morningEnd = DateTime(now.year, now.month, now.day, 12, 0);

    final afternoonStart = DateTime(now.year, now.month, now.day, 13, 30);
    final afternoonEnd = DateTime(now.year, now.month, now.day, 14, 15);

    if ((time.isAfter(morningStart) || time.isAtSameMomentAs(morningStart)) &&
        time.isBefore(morningEnd)) {
      return 'Present';
    } else if ((time.isAfter(afternoonStart) ||
            time.isAtSameMomentAs(afternoonStart)) &&
        time.isBefore(afternoonEnd)) {
      return 'Present';
    } else {
      return 'Late';
    }
  }

  void _showSuccessDialog(BuildContext context, String scannedData) {
    final now = DateTime.now();
    final status = _determineStatus(now);

    // Insert the scan record into Supabase
    _supabaseService.insertScanRecord(scannedData, now, status).then((_) {
      print('Scan record inserted successfully!');
    }).catchError((error) {
      print('Error inserting scan record: $error');
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text('QR code scanned successfully!\nStatus: $status'),
        actions: [
          // OK Button
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('OK'),
          ),
          // View Report Button
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ReportPage(), // Navigate to ReportPage
                ),
              );
            },
            child: const Text('View Report'),
          ),
        ],
      ),
    ).then((_) {
      setState(() {
        isDialogOpen = false; // Reset dialog state when closed
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              if (!isScanning || isDialogOpen) return;

              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                print('Scanned Data: ${barcode.rawValue}');

                setState(() {
                  isScanning = false;
                  isDialogOpen = true;
                });

                _showSuccessDialog(context, barcode.rawValue ?? '');
              }
            },
          ),
          _buildScanOverlay(context),
        ],
      ),
    );
  }

  Widget _buildScanOverlay(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.6),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(child: Container()),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              'Align the QR code within the frame to scan',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
