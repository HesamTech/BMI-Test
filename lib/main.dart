import 'package:bmi/Screens/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'comic',
      ),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              "BMI Calculator",
              style: TextStyle(
                color: Colors.yellow,
              ),
            ),
          ),
          body: const MyBody(),
        ),
      ),
    );
  }
}
