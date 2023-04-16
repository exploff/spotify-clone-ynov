import 'package:flutter/material.dart';

class CircularProgressorCustom extends StatelessWidget {
  const CircularProgressorCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              Colors.red),
          strokeWidth: 10,
        ),
      ),
    );
  }
}