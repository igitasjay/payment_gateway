import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  final String message;
  const Success({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade700),
            const SizedBox(height: 12),
            const Text(
              "Payment Successful",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(message),
          ],
        ),
      ),
    );
  }
}
