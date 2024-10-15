// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_since_app/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> backgroundImages = [
    "assets/mountain_view1.jpg",
    // "assets/forest_view.jpg",
    // "assets/beach_view.jpg",
    // "assets/desert_view.jpg",
  ];

  late String _currentBackgroundImage = "assets/mountain_view1.jpg";
  Timer? _timer;
  DateTime? _lastChangeDate;

  @override
  void initState() {
    super.initState();
    _loadBackgroundImage(); // Load saved background image

    // Start the timer to change the background image every 24 hours
    _timer = Timer.periodic(Duration(days: 1), (Timer t) {
      setState(() {
        _changeBackgroundImage();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_currentBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: HomePage(),
          ),
        ),
      ),
    );
  }

  void _loadBackgroundImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentBackgroundImage =
          prefs.getString("background_image") ?? backgroundImages[0];
      _lastChangeDate = DateTime.fromMillisecondsSinceEpoch(
          prefs.getInt("last_change_date") ??
              DateTime.now().millisecondsSinceEpoch);

      // If the last change was more than a day ago, change the background immediately
      if (_lastChangeDate != null &&
          DateTime.now().difference(_lastChangeDate!).inDays >= 1) {
        _changeBackgroundImage();
      }
    });
  }

  void _changeBackgroundImage() async {
    final random = Random();
    String newBackground;

    // Ensure the new background is different from the current one
    // do {
    newBackground = backgroundImages[random.nextInt(backgroundImages.length)];
    // } while (newBackground == _currentBackgroundImage);

    setState(() {
      _currentBackgroundImage = newBackground;
      _lastChangeDate = DateTime.now();
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("background_image", _currentBackgroundImage);
    prefs.setInt("last_change_date", _lastChangeDate!.millisecondsSinceEpoch);
  }
}
