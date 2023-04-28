import 'package:flutter/material.dart';

class CircularProgressorCustom extends StatelessWidget {
  const CircularProgressorCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 202, 205, 255)),
          strokeWidth: 10,
        ),
      ),
    );
  }
}