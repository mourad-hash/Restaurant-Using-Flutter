import 'package:flutter/material.dart';

class BlockingScreen extends StatelessWidget {
  final String message;

  const BlockingScreen({
    super.key,
    this.message = 'App is currently disabled by admin',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.block,
                  color: Colors.red,
                  size: 80,
                ),
                const SizedBox(height: 24),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
