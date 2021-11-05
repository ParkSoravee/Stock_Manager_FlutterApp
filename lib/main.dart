import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Manager',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF8244),
        backgroundColor: const Color(0xffffeac7),
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: const Color(0xffe26b2d),
            ),
        fontFamily: 'NotoSans',
      ),
      home: const HomeScreen(),
    );
  }
}
