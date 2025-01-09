import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skill_test_patch/home.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0XFF7A6EAE)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        //The following theme was based on the provided figma file
        chipTheme: ChipThemeData(
          showCheckmark: false,
          selectedColor: Color(0XFF7A6EAE),
          labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          secondaryLabelStyle: TextStyle(color: Colors.red),
          backgroundColor: Color(0XFFCACACA),
          side: BorderSide(color: Color(0XFFCACACA)),

        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: Color(0XFF7A6EAE),
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: HomePage(),
    );
  }
}
