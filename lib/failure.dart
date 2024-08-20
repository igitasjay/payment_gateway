import 'package:flutter/material.dart';

class Failure extends StatelessWidget {
  final String message;
  const Failure({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.clear_outlined, size: MediaQuery.of(context).size.width),
            const SizedBox(height: 12),
            const Text(
              "Failed to make payment",
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
