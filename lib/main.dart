import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spoticlone/views/home.view.dart';

void main() {
  run();
}

void run() async {
  if (Platform.isAndroid) {
    var versionInfo = Platform.operatingSystemVersion.split(" ");
    if (int.parse(versionInfo[1]) < 13) {
      if (await Permission.storage.request().isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.storage.request().isDenied) {
        await Permission.storage.request();
      }
    } else {
      print("Version Android : " + versionInfo[1]);
    }
  }
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
