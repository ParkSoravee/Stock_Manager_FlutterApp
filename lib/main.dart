import 'package:flutter/material.dart';
import 'package:flutter_stock_manager/providers/history.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Histories(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stock Manager',
        theme: ThemeData(
          primaryColor: const Color(0xFFFF8244),
          backgroundColor: const Color(0xffffeac7),
          colorScheme: ThemeData().colorScheme.copyWith(
                secondary: const Color(0xffe26b2d),
              ),
          splashColor: const Color(0xffffd07f),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFF8244),
          ),
          scaffoldBackgroundColor: const Color(0xffffeac7),
          fontFamily: 'NotoSans',
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
