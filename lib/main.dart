import 'package:flutter/material.dart';
import 'package:spoticlone/views/home.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpotiClone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        secondaryHeaderColor: Colors.blue,
        primaryColor: Colors.red.shade400,
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      home: const DefaultTabController(
        length: 3,
        child: HomeView()
      ),
    );
  }
}
