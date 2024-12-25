import 'package:flutter/material.dart';
import 'package:my_imdb/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.grey[800],
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          brightness: Brightness.dark),
      home: const Home(),
    );
  }
}
